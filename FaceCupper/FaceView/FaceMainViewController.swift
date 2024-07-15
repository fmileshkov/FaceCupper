//
//  FaceMainViewController.swift
//  FaceCupper
//
//  Created by Admin on 6.05.24.
//

import UIKit
import PhotosUI

class FaceMainViewController: UIViewController, CustomImagePickerDelegate {
    func customImagePicker(_ picker: CustomImagePickerViewController, didSelectImage item: CuttedFaceImageModel) {
        print(item.displayTitle)
    }
    
    @IBOutlet private weak var pickFaceFromGallery: CustomButton!
    
    var viewModel: FaceMainViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Face"
        pickFaceFromGallery.customTitle = "Choose a face from gallery"
    }
    
    @IBAction func pickFaceButtonTap(_ sender: UIButton) {
        callCustomPicker()
    }
    
    //MARK: - CustomViewController
    private func callCustomPicker() {
            let customPicker = CustomImagePickerViewController()
            customPicker.delegate = self
            present(customPicker, animated: true)
        }

}


//MARK: - CUSTOM IMAGE PICKER VIEWCONTROLLER

protocol CustomImagePickerDelegate: AnyObject {
    func customImagePicker(_ picker: CustomImagePickerViewController, didSelectImage item: CuttedFaceImageModel)
}

class CustomImagePickerViewController: UIViewController {
    var collectionView: UICollectionView!
    weak var delegate: CustomImagePickerDelegate?
    let firestore: FirestoreServiceProtocol = FirestoreService()
    private var images: [CuttedFaceImageModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        Task {
            await fetchImages()
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        view.addSubview(collectionView)
    }
    
    private func fetchImages() {
        Task {
            do {
                let fetchedImages = try await firestore.fetchImages(folderPath: "images")
                images = firestore.sortImagesByDate(fetchedImages)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Failed to fetch images: \(error)")
            }
        }
    }
    
}

extension CustomImagePickerViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? (any CustomCollectionViewCellProtocol) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: images[indexPath.row])
        
        return cell as? CustomCollectionViewCell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 20
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.customImagePicker(self, didSelectImage: images[indexPath.item])
    }
}
