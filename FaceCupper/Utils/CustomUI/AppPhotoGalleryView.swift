//
//  PhotoGalleryView.swift
//  FaceCupper
//
//  Created by Admin on 4.06.24.
//

import UIKit

extension UIViewController {
    
    func presentCustomView(_ customView: UIView, withBackgroundDim dim: Bool = true) {
        let wrapperView = UIView(frame: self.view.bounds)
        
        if dim {
            let dimmedView = UIView(frame: wrapperView.bounds)
            dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            dimmedView.alpha = 0
            
            wrapperView.addSubview(dimmedView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
            dimmedView.addGestureRecognizer(tapGesture)
        }
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.alpha = 0
        customView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        wrapperView.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            customView.widthAnchor.constraint(equalTo: wrapperView.widthAnchor, multiplier: 0.8),
            customView.heightAnchor.constraint(equalTo: wrapperView.heightAnchor, multiplier: 0.8)
        ])
        
        self.view.addSubview(wrapperView)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            if dim {
                wrapperView.subviews.first?.alpha = 1
            }
            customView.alpha = 1
            customView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        if let wrapperView = sender.view?.superview {
            dismissCustomView(wrapperView)
        }
    }
    
    private func dismissCustomView(_ wrapperView: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            wrapperView.subviews.forEach { subview in
                subview.alpha = 0
                if subview != wrapperView.subviews.first {
                    subview.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }
            }
        }, completion: { _ in
            wrapperView.removeFromSuperview()
        })
    }
}

class AppPhotoGalleryView: UIView {
    
    // TO DO: Make this look like a uiimagePIckerVIew
    
    private var cuttedFaces: [CuttedFace]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        return collectionView
    }()

    init(frame: CGRect, cuttedFaces: [CuttedFace]) {
        self.cuttedFaces = cuttedFaces
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        self.cuttedFaces = []
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(collectionView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AppPhotoGalleryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cuttedFaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewListCell()
        }
        
        cell.backgroundColor = .lightGray
        cell.configure(cuttedFace: cuttedFaces[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item.hashValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        let itemsPerRow: CGFloat = 4
        let paddingSpace = layout.sectionInset.left + layout.sectionInset.right + (layout.minimumInteritemSpacing * (itemsPerRow - 1))
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
}

struct CuttedFace {
    var title: String
    var image: UIImage?
    var dateUploaded: Date
}

protocol CustomCollectionViewCellProtocol {
    
    associatedtype cellItem
    
    func configure(cuttedFace: cellItem)
}

class CustomCollectionViewCell: UICollectionViewCell, CustomCollectionViewCellProtocol {
    
    typealias cellItem = CuttedFace
    
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

    func configure(cuttedFace: CuttedFace) {
        imageView.image = cuttedFace.image
        titleLabel.text = cuttedFace.title
    }
}
