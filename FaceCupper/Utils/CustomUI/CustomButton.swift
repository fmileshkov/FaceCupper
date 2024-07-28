import UIKit

class CustomButton: UIButton {

    var cornerRadius: CGFloat = ConstrainsAndAutolayConstants.customButtonCornerRadius {
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
        self.titleLabel?.font = UIFont.systemFont(ofSize: ConstrainsAndAutolayConstants.customButtonTitleLabelFontOfSize, weight: .semibold)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupButton()
    }
}
