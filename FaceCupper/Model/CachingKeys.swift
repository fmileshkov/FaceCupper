import Foundation

enum CachingKeys {
    case imageUrlKey
    
    func receiveUrlKeyString() -> String {
        switch self {
        case .imageUrlKey:
            return "imageUrlKey"
        }
    }
}
