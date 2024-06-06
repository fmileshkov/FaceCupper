//
//  InputView.swift
//  FaceCupper
//
//  Created by Admin on 30.05.24.
//

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
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
}
