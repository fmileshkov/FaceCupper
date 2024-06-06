//
//  MainViewController.swift
//  FaceCupper
//
//  Created by Admin on 6.05.24.
//

import UIKit

class PhotoMainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet private weak var choosePhotoFromGalleryButton: CustomButton!
    @IBOutlet private weak var takePhotoButton: CustomButton!

    var viewModel: PhotoMainViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo"
        choosePhotoFromGalleryButton.customTitle = "Choose Photo From Gallery"
        takePhotoButton.customTitle = "Take a photo with camera"
    }

    @IBAction func choosePhotoFromGalleryButtonTap(_ sender: UIButton) {
        let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                present(picker, animated: true, completion: nil)
    }
    
    @IBAction func takePhotoButtonTap(_ sender: UIButton) {
        let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                present(picker, animated: true, completion: nil)
    }
    
    private func showPhotoGallery() {
            let photoGalleryView = AppPhotoGalleryView()
            self.presentCustomView(photoGalleryView)
        }
}
