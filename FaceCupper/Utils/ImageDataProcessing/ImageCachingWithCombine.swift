import UIKit
import Combine

class ImageCachingWithCombine {
    
    static let shared = ImageCachingWithCombine()
    private let defaults = UserDefaults.standard
    private let cache = NSCache<NSString, NSData>()
    
    private init() {}

    func saveImageOffline(images: [CuttedFaceImageModel]) {
        guard let encoded = try? JSONEncoder().encode(images) else {
            return
        }

        defaults.setValue(encoded, forKey: CachingKeys.imageUrlKey.receiveUrlKeyString())
        print("Saved images = \(encoded.count)")
    }
    
    func receiveImagesOffline() -> AnyPublisher<[CuttedFaceImageModel], Error> {
        do {
            guard let data = defaults.object(forKey: CachingKeys.imageUrlKey.receiveUrlKeyString()) as? Data else {
                return Just([])
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            
            let decoded = try JSONDecoder().decode([CuttedFaceImageModel].self, from: data)
            
            return Just(decoded)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    func getCachedImageData(for url: URL) -> Data? {
        return cache.object(forKey: url.absoluteString as NSString) as Data?
    }

    func cacheImageData(_ data: Data, for url: URL) {
        cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
    }
}
