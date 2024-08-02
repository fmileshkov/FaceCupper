import UIKit
import Photos

class ImageSaver: NSObject {
    
    var albumPlaceholder: PHObjectPlaceholder?
    
    func saveImageToAlbum(image: UIImage, albumName: String) {
        PHPhotoLibrary.shared().performChanges({
            // Create a new album if it doesn't exist
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
            let album = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)

            if let album = album.firstObject {
                self.addImage(image: image, to: album)
            } else {
                let albumChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
                self.albumPlaceholder = albumChangeRequest.placeholderForCreatedAssetCollection
            }
        }, completionHandler: { success, error in
            if success {
                if let albumPlaceholder = self.albumPlaceholder {
                    let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [albumPlaceholder.localIdentifier], options: nil)
                    if let album = fetchResult.firstObject {
                        self.addImage(image: image, to: album)
                    }
                }
            } else {
                print("Error creating album: \(String(describing: error))")
            }
        })
    }

    private func addImage(image: UIImage, to album: PHAssetCollection) {
        PHPhotoLibrary.shared().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            if let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset {
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
                let fastEnumeration = NSArray(array: [assetPlaceholder])
                albumChangeRequest?.addAssets(fastEnumeration)
            }
        }, completionHandler: { success, error in
            if success {
                print("Image added to album successfully!")
            } else {
                print("Error adding image to album: \(String(describing: error))")
            }
        })
    }
}
