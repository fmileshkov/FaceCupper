import UIKit
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

protocol FirestoreServiceProtocol {
    
    func registerNewUser(_ userName: String, _ password: String, _ email: String) async throws
    func signIn(_ email: String, _ password: String) async throws
    func fetchUser() async
    func uploadImage(image: UIImage)
    var currentUser: User? { get }
//    func fetchImages(folderPath: String) async throws -> [CuttedFaceImageModel]
//    func sortImagesByDate(_ images: [CuttedFaceImageModel]) -> [CuttedFaceImageModel]
    func fetchImagesWithCombine(folderPath: String) -> AnyPublisher<[CuttedFaceImageModel], Error>
}

struct User: Codable {
    var userName: String
    var email: String
    var uid: String = UUID().uuidString
}

class FirestoreService: FirestoreServiceProtocol {
    
    //MARK: - Properties
    static let shared: FirestoreServiceProtocol = FirestoreService()
    private let firebaseAuth = Auth.auth()
    private let db = Firestore.firestore()
    private var images = [UIImage]()
    private var userSesion: FirebaseAuth.User?
    private var imageUrls: [String] = []
    private var cancellables = Set<AnyCancellable>()
    var currentUser: User?
    private let lastSyncKey = "lastSync"
    
    init() {
        
    }
    
    func uploadImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        let storageRef = Storage.storage().reference()
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        let upload = fileRef.putData(imageData, metadata: nil) { [weak self] metaData, error in
            guard error == nil && metaData != nil else {
                return
            }
            
            self?.db.collection("userImages").document().setData(["url":path])
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await db.collection("users").document(uid).getDocument() else { return }
        
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func signIn(_ email: String, _ password: String) async throws {
        do {
            let result = try await firebaseAuth.signIn(withEmail: email, password: password)
            self.userSesion = result.user
            await fetchUser()
        } catch {
            print("FAILED TO SIGNIN !!!")
        }
    }
    
    func registerNewUser(_ userName: String, _ password: String, _ email: String) async throws {
        do {
            let result = try await firebaseAuth.createUser(withEmail: email, password: password)
            self.userSesion = result.user
            let user = User(userName: userName, email: email, uid: result.user.uid)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await db.collection("users").document(user.uid).setData(encodedUser)
        } catch {
            print("User cant be created")
        }
    }
    
    func fetchImagesWithCombine(folderPath: String) -> AnyPublisher<[CuttedFaceImageModel], Error> {
        let folderRef = Storage.storage().reference().child(folderPath)

        return Future<[CuttedFaceImageModel], Error> { promise in
            folderRef.listAll { result, error in
                guard error == nil, let result else {
                    return promise(.failure(error!))
                }

                let publishers = result.items.enumerated().map { index, item in
                    self.downloadAndRenameImageWithCombine(item: item, currentCount: index)
                }

                Publishers.MergeMany(publishers)
                    .collect()
                    .sink(receiveCompletion: { completion in
                        if case let .failure(error) = completion {
                            promise(.failure(error))
                        }
                    }, receiveValue: { imageModels in
                        promise(.success(imageModels))
                    })
                    .store(in: &self.cancellables)

            }
        }
        .eraseToAnyPublisher()
    }

    private func downloadAndRenameImageWithCombine(item: StorageReference, currentCount: Int) -> AnyPublisher<CuttedFaceImageModel, Error> {
        return Future<CuttedFaceImageModel, Error> { promise in
            item.getMetadata { metadata, error in
                if let error = error {
                    promise(.failure(error))
                } else if let metadata = metadata, let dateAdded = metadata.timeCreated {
                    item.downloadURL { url, error in
                        if let error = error {
                            promise(.failure(error))
                        } else if let url = url {
                            let displayName = "Picture #\(currentCount + 1)"
                            let model = CuttedFaceImageModel(displayTitle: displayName, dateUploaded: dateAdded, url: url)
                            promise(.success(model))
                        }
                    }
                } else {
                    promise(.failure(NSError(domain: "No metadata", code: -1, userInfo: nil)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
//    func fetchImages(folderPath: String) async throws -> [CuttedFaceImageModel] {
//        let result = try await Storage.storage().reference().child(folderPath).listAll()
//        var imageModels = [CuttedFaceImageModel]()
//        for (index, item) in result.items.enumerated() {
//            let imageModel = try await item.downloadAndRenameImage(currentCount: index)
//            imageModels.append(imageModel)
//        }
//        return imageModels
//    }
//
//    func sortImagesByDate(_ images: [CuttedFaceImageModel]) -> [CuttedFaceImageModel] {
//        return images.sorted(by: { $0.dateUploaded < $1.dateUploaded })
//    }
}

//private extension StorageReference {
//
//    func downloadAndRenameImage(currentCount: Int) async throws -> CuttedFaceImageModel {
//        let metadata = try await self.getMetadata()
//        guard let dateAdded = metadata.timeCreated else {
//            throw NSError(domain: "No metadata", code: -1, userInfo: nil)
//        }
//
//        let url = try await self.downloadURL()
//        let displayName = "Face #\(currentCount + 1)"
//        return CuttedFaceImageModel(displayTitle: displayName, dateUploaded: dateAdded, url: url)
//    }
//}
//
//extension StorageReference {
//    func getMetadata() async throws -> StorageMetadata {
//        try await withCheckedThrowingContinuation { continuation in
//            self.getMetadata { metadata, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                } else if let metadata = metadata {
//                    continuation.resume(returning: metadata)
//                } else {
//                    continuation.resume(throwing: NSError(domain: "Unknown error", code: -1, userInfo: nil))
//                }
//            }
//        }
//    }
//
//    func downloadURL() async throws -> URL {
//        try await withCheckedThrowingContinuation { continuation in
//            self.downloadURL { url, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                } else if let url = url {
//                    continuation.resume(returning: url)
//                } else {
//                    continuation.resume(throwing: NSError(domain: "Unknown error", code: -1, userInfo: nil))
//                }
//            }
//        }
//    }
//
//}
