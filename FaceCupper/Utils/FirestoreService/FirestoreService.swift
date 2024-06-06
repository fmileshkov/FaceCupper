//
//  FirestoreService.swift
//  FaceCupper
//
//  Created by Admin on 24.04.24.
//

import UIKit
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
}

struct User: Codable {
    var userName: String
    var email: String
    var uid: String = UUID().uuidString
}

class FirestoreService: FirestoreServiceProtocol {
    
    //MARK: - Properties
    static let shared = FirestoreService()
    private let firebaseAuth = Auth.auth()
    private let db = Firestore.firestore()
    private var pics = [String]()
    private var images = [UIImage]()
    private var userSesion: FirebaseAuth.User?
    var currentUser: User?
    
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
}


