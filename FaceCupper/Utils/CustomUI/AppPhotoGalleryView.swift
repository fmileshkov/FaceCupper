//
//  PhotoGalleryView.swift
//  FaceCupper
//
//  Created by Admin on 4.06.24.
//

import UIKit

struct CuttedFaceImageModel {
    var displayTitle: String
    let image: UIImage?
    let dateUploaded: Date
    let url: URL
}

protocol CustomCollectionViewCellProtocol {
    
    associatedtype cellItem
    func configure(with model: CuttedFaceImageModel)
    func selectedImage() -> UIImage
}

class CustomCollectionViewCell: UICollectionViewCell, CustomCollectionViewCellProtocol {
    
    typealias cellItem = CuttedFaceImageModel
    
    static let identifier = "CustomCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func selectedImage() -> UIImage {
        guard let image = imageView.image else {
            return UIImage()
        }
        
        return image
    }

    func configure(with model: CuttedFaceImageModel) {
        URLSession.shared.dataTask(with: model.url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
        .resume()
        
        titleLabel.text = model.displayTitle
    }
    
}
