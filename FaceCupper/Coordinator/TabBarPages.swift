import UIKit

enum TabBarPage {
    case face
    case photos
    case profile

    init?(index: Int) {
        switch index {
        case 0:
            self = .face
        case 1:
            self = .photos
        case 2:
            self = .profile
        default:
            return nil
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .face:
            return Constants.facePageTitle
        case .photos:
            return Constants.photosPageTitle
        case .profile:
            return Constants.profilePageTitle
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .face:
            return 0
        case .photos:
            return 1
        case .profile:
            return 2
        }
    }

    func pageIcon() -> UIImage {
        switch self {
        case .face:
            return UIImage(systemName: "face.smiling.fill")!
        case .photos:
            return UIImage(systemName: "photo.on.rectangle.angled")!
        case .profile:
            return UIImage(systemName: "person.crop.rectangle.fill")!
        }
    }

}
