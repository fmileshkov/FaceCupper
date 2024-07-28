import Foundation

struct Constants {
    static let usernameLabelText: String = "Username"
    static let passwordLabelText: String = "Password"
    static let usernameTextFieldPlaceholder: String = "Place your username"
    static let passwordTextFieldPlaceholder: String = "Please enter your password"
    static let customCollectionViewCellIdentifier: String = "CustomCollectionViewCell"
    static let tabBarControllerTitle: String = "Tabbar"
    static let photoMainControllerTitle: String = "Photo"
    static let choosePhotoFromGalleryTitle: String = "Choose Photo From Gallery"
    static let takePhotoWithCameraButtonTitle: String = "Take a photo with camera"
    static let faceMainControllerTitle: String = "Face"
    static let pickPhotoFromGalleryButtonTitle: String = "Choose a face from gallery"
    static let firestoreFetchImagesFolderPath: String = "images"
    
    //MARK: - Coordinator Constants
    static let appCoordinatorIdentifier: String = "AppCoordinator"
    static let loginCoordinatorIdentifier: String = "loginCoordinatorId"
    static let tabBarCoordinatorIdentifier: String = "tabBarCoordinatorId"
    
    //MARK: - Tabbar Page Constants
    static let facePageTitle: String = "Face"
    static let photosPageTitle: String = "Photos"
    static let profilePageTitle: String = "Profile"
    
}

struct ConstrainsAndAutolayConstants {
    
    //MARK: - InputView
    static let inputViewTextLabelTopAnch: CGFloat = 20
    static let inputViewTextLabelLeadingAnch: CGFloat = 20
    static let inputViewTextLabelTrailingAnch: CGFloat = -20
    static let inputViewtitleTextFieldTopAnch: CGFloat = 10
    static let inputViewtitleTextFieldLeadingAnch: CGFloat = 20
    static let inputViewtitleTextFieldTrailingAnch: CGFloat = -20
    static let inputViewtitleTextFieldBottomAnch: CGFloat = -20
    
    //MARK: - CustomCollectionViewCell
    static let customCellTitleLabelFont: CGFloat = 14
    static let customCellImageViewHeightAnchMultiplier: CGFloat = 0.75
    static let customCellTleLabelTopAnch: CGFloat = 4
    static let customCellTitleLabelBottomAnch: CGFloat = -2
    
    //MARK: - CustomButton
    static let customButtonCornerRadius: CGFloat = 10.0
    static let customButtonTitleLabelFontOfSize: CGFloat = 18
    
    //MARK: - CustomImagePickerViewController
    static let layoutMinimumInteritemSpacing: CGFloat = 10
    static let layoutMinimumLineSpacing: CGFloat = 10
    static let sectionInset: CGFloat = 10
    static let collectionViewFrameWidthDevider: CGFloat = 3
    static let collectionViewFrameWidthExtracter: CGFloat = 20
}
