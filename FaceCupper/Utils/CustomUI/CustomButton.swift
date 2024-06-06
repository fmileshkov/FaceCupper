//
//  CustomButton.swift
//  FaceCupper
//
//  Created by Admin on 4.06.24.
//

import UIKit

class CustomButton: UIButton {
    
    // Custom properties for corner radius and background color
    var cornerRadius: CGFloat = 10.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    var customBackgroundColor: UIColor = UIColor.systemBlue {
        didSet {
            self.backgroundColor = customBackgroundColor
        }
    }
    
    var customTitle: String = "Button" {
        didSet {
            self.setTitle(customTitle, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = customBackgroundColor
        self.setTitle(customTitle, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupButton()
    }
}
