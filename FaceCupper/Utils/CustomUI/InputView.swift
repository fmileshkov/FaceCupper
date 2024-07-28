import UIKit

class InputView: UIView {
    
    //MARK: - Label creation
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Public priorities
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var labelText: String? {
        didSet {
            textLabel.text = labelText
        }
    }
    
    var textFieldPlaceholder: String? {
        didSet {
            titleTextField.placeholder = textFieldPlaceholder
        }
    }
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: - Private setUp
    private func setupView() {
        addSubview(textLabel)
        addSubview(titleTextField)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ConstrainsAndAutolayConstants.inputViewTextLabelTopAnch),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ConstrainsAndAutolayConstants.inputViewTextLabelLeadingAnch),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ConstrainsAndAutolayConstants.inputViewTextLabelTrailingAnch)
        ])

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: ConstrainsAndAutolayConstants.inputViewtitleTextFieldTopAnch),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ConstrainsAndAutolayConstants.inputViewtitleTextFieldLeadingAnch),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ConstrainsAndAutolayConstants.inputViewtitleTextFieldTrailingAnch),
            titleTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ConstrainsAndAutolayConstants.inputViewtitleTextFieldBottomAnch)
        ])
    }
    
}
