import UIKit

protocol CustomCollectionViewCellProtocol {
    
    associatedtype cellItem
    func configure(with model: CuttedFaceImageModel)
    func setUpImage(with image: UIImage)
    func setUpTitle(for title: String)
    func fetchImage(with url: URL) -> UIImage
}

class CustomCollectionViewCell: UICollectionViewCell, CustomCollectionViewCellProtocol {
    
    typealias cellItem = CuttedFaceImageModel

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: ConstrainsAndAutolayConstants.customCellTitleLabelFont)
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
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: ConstrainsAndAutolayConstants.customCellImageViewHeightAnchMultiplier),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ConstrainsAndAutolayConstants.customCellTleLabelTopAnch),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ConstrainsAndAutolayConstants.customCellTitleLabelBottomAnch)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpImage(with image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func setUpTitle(for title: String) {
        titleLabel.text = title
    }
    
    func fetchImage(with url: URL) -> UIImage {
        guard let image = imageView.image else { return UIImage() }
        
        return image
    }
    
    func configure(with model: CuttedFaceImageModel) {
        if let cachedData = ImageCachingWithCombine.shared.getCachedImageData(for: model.url) {
            self.imageView.image = UIImage(data: cachedData)
        } else {
            URLSession.shared.dataTask(with: model.url) { [weak self] data, response, error in
                guard let self = self, let data = data, error == nil else {
                    return
                }

                // Cache the downloaded data
                ImageCachingWithCombine.shared.cacheImageData(data, for: model.url)
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
            .resume()
        }

        titleLabel.text = model.displayTitle
    }
    
}
