//
//  FaceMainViewController.swift
//  FaceCupper
//
//  Created by Admin on 6.05.24.
//

import UIKit

class FaceMainViewController: UIViewController {
    
    @IBOutlet private weak var pickFaceFromGallery: CustomButton!
    
    var viewModel: FaceMainViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Face"
        pickFaceFromGallery.customTitle = "Choose a face from gallery"
    }
    
    @IBAction func pickFaceButtonTap(_ sender: UIButton) {
        showPhotoGallery()
    }
    
    private func showPhotoGallery() {
        let photoGalleryView = AppPhotoGalleryView(frame: .zero, cuttedFaces: [CuttedFace(title: "Face 1", dateUploaded: Date.now),
                                                                               CuttedFace(title: "Face 2", dateUploaded: Date.now),
                                                                               CuttedFace(title: "Face 3", dateUploaded: Date.now),
                                                                               CuttedFace(title: "Face 4", dateUploaded: Date.now),
                                                                               CuttedFace(title: "Face 5", dateUploaded: Date.now)])
        self.presentCustomView(photoGalleryView)
        }

}
