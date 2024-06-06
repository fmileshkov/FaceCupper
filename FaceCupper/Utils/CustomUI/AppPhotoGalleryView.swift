//
//  PhotoGalleryView.swift
//  FaceCupper
//
//  Created by Admin on 4.06.24.
//

import UIKit

extension UIViewController {
    func presentCustomView(_ customView: UIView, withBackgroundDim dim: Bool = true) {
        // Add a dimmed background if required
        var dimmedView: UIView?
        if dim {
            dimmedView = UIView(frame: self.view.bounds)
            dimmedView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            dimmedView?.alpha = 0
            self.view.addSubview(dimmedView!)
        }
        
        // Set up the custom view
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.alpha = 0
        customView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.view.addSubview(customView)
        
        // Constraints for the custom view to be centered
        NSLayoutConstraint.activate([
            customView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            customView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            customView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8)
        ])
        
        // Animate the appearance
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            dimmedView?.alpha = 1
            customView.alpha = 1
            customView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func dismissCustomView(_ customView: UIView, withBackgroundDim dimmedView: UIView?) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            dimmedView?.alpha = 0
            customView.alpha = 0
            customView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { _ in
            customView.removeFromSuperview()
            dimmedView?.removeFromSuperview()
        })
    }
}

class AppPhotoGalleryView: UIView {
    
    // Label for the title
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    // CollectionView for the photos
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100) // Adjust item size as needed
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Adding subviews
        addSubview(titleLabel)
        addSubview(collectionView)
        
        // Disable autoresizing mask
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding constraints
        NSLayoutConstraint.activate([
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            // CollectionView constraints
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        // Setting collectionView delegate and dataSource
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AppPhotoGalleryView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 // Number of items, replace with your data source count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .lightGray // Placeholder color, replace with your image
        return cell
    }
}
