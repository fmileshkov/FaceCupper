import UIKit

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    var cachedImage: UIImage?
    
    private init() {}

    func cacheDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    private func cachedImageURL(for url: String) -> URL {
        return cacheDirectory().appendingPathComponent((url as NSString).lastPathComponent)
    }

    func saveImage(_ image: UIImage, for url: String) {
        let data = image.pngData()
        let fileURL = cachedImageURL(for: url)
        do {
            try data?.write(to: fileURL)
            print("Image saved to cache: \(fileURL.path)")
            cachedImage = UIImage(contentsOfFile: fileURL.path)
        } catch {
            print("Error saving image to cache: \(error)")
        }
    }

    func loadImage(for url: String) {
        let fileURL = cachedImageURL(for: url)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            print("Loading image from cache: \(fileURL.path)")
            cachedImage = UIImage(contentsOfFile: fileURL.path)
        }
        print("No cached image found for URL: \(url)")
    }
}
