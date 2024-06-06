//
//  TabBarPages.swift
//  FaceCupper
//
//  Created by Admin on 12.05.24.
//

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
            return "Face"
        case .photos:
            return "Photos"
        case .profile:
            return "Profile"
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
