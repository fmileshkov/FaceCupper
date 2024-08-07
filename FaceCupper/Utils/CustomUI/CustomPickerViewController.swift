import UIKit
import Combine

protocol CustomImagePickerDelegate: AnyObject {
    func customImagePicker(_ picker: CustomImagePickerViewController, didSelectImage item: CuttedFaceImageModel)
}

class CustomImagePickerViewController: UIViewController {
    
    var collectionView: UICollectionView!
    weak var delegate: CustomImagePickerDelegate?
//    let firestore: FirestoreServiceProtocol = FirestoreService()
    private var images: [CuttedFaceImageModel] = []
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchImages()
    }
    
    private func fetchImages() {
        FirestoreService.shared.fetchImages(folderPath: "images")
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(">>> weve got and error - \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageModels in
                print("get image \(imageModels[0].displayTitle)")
                self?.images = imageModels
                self?.collectionView.reloadData()
            }.store(in: &cancellables)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = ConstrainsAndAutolayConstants.layoutMinimumInteritemSpacing
        layout.minimumLineSpacing = ConstrainsAndAutolayConstants.layoutMinimumLineSpacing
        layout.sectionInset = UIEdgeInsets(top: ConstrainsAndAutolayConstants.sectionInset,
                                           left: ConstrainsAndAutolayConstants.sectionInset,
                                           bottom: ConstrainsAndAutolayConstants.sectionInset,
                                           right: ConstrainsAndAutolayConstants.sectionInset)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: Constants.customCollectionViewCellIdentifier)
        view.addSubview(collectionView)
    }
    
//    private func fetchImages() {
//        Task {
//            do {
//                let fetchedImages = try await firestore.fetchImages(folderPath: Constants.firestoreFetchImagesFolderPath)
//                images = firestore.sortImagesByDate(fetchedImages)
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            } catch {
//                print("Failed to fetch images: \(error)")
//            }
//        }
//    }
    
}

extension CustomImagePickerViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.customCollectionViewCellIdentifier, for: indexPath) as? (any CustomCollectionViewCellProtocol) else {
            return UICollectionViewCell()
        }
        
//        guard let cachedImage = ImageCacheManager.shared.cachedImage else {
//            cell.configure(with: images[indexPath.row])
//            ImageCacheManager.shared.saveImage(cell.fetchImage(with: images[indexPath.row].url), for: images[indexPath.row].url.absoluteString)
//            
//            return cell as? CustomCollectionViewCell ?? UICollectionViewCell()
//        }

        cell.configure(with: images[indexPath.row])
//        cell.setUpImage(with: cachedImage)
//        cell.setUpTitle(for: images[indexPath.row].displayTitle)
        
        return cell as? CustomCollectionViewCell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =
        (collectionView.frame.width / ConstrainsAndAutolayConstants.collectionViewFrameWidthDevider) - ConstrainsAndAutolayConstants.collectionViewFrameWidthExtracter
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else {
            return
        }
        
        let imageSaver = ImageSaver()
        let image = cell.fetchImage(with: images[indexPath.item].url)
        imageSaver.saveImageToAlbum(image: image, albumName: "FaceCupper")
        delegate?.customImagePicker(self, didSelectImage: images[indexPath.item])
    }
}
