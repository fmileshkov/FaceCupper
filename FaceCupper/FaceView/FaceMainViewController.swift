import UIKit
import PhotosUI

class FaceMainViewController: UIViewController, CustomImagePickerDelegate {
    
    @IBOutlet private weak var pickFaceFromGallery: CustomButton!
    
    var viewModel: FaceMainViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.faceMainControllerTitle
        pickFaceFromGallery.customTitle = Constants.pickPhotoFromGalleryButtonTitle
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
    
    func customImagePicker(_ picker: CustomImagePickerViewController, didSelectImage item: CuttedFaceImageModel) {
        print(item.displayTitle)
    }

}
