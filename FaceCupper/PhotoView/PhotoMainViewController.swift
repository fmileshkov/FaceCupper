import UIKit

class PhotoMainViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet private weak var choosePhotoFromGalleryButton: CustomButton!
    @IBOutlet private weak var takePhotoButton: CustomButton!

    var viewModel: PhotoMainViewModelProtocol?
    private var picker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.photoMainControllerTitle
        choosePhotoFromGalleryButton.customTitle = Constants.choosePhotoFromGalleryTitle
        takePhotoButton.customTitle = Constants.takePhotoWithCameraButtonTitle
    }

    @IBAction func choosePhotoFromGalleryButtonTap(_ sender: UIButton) {
        picker = UIImagePickerController()
        picker?.sourceType = .photoLibrary
        picker?.delegate = self
        present(picker ?? UIImagePickerController(), animated: true, completion: nil)
    }
    
    @IBAction func takePhotoButtonTap(_ sender: UIButton) {
        picker = UIImagePickerController()
        picker?.sourceType = .camera
        picker?.delegate = self
        present(picker ?? UIImagePickerController(), animated: true, completion: nil)
    }

}
