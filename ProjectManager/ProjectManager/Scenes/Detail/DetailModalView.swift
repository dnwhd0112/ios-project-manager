//
//  DetailModalView.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import UIKit

protocol ButtonActionDelegate: AnyObject {
    func cancelButtonClicked()
    func doneButtonClicked()
}

final class DetailModalView: UIView {
    private enum Constant {
        static let buttonTitleColor: UIColor = .systemBlue
        static let textFieldBackgroundColor: UIColor = .white
        static let viewBackgroundColor: UIColor = .white
        static let textFieldShadowColor: CGColor = UIColor.black.cgColor
    }
    
    weak var buttonDelegate: ButtonActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStackView()
        setConsantrait()
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var task: Task {
        let title = titleTextField.text
        let body = bodyTextView.text
        let date = datePicker.date
        
        return Task(title: title, date: date, body: body)
    }
    
    private let topLeftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(Constant.buttonTitleColor, for: .normal)
        return button
    }()
    
    private let topTitleLabel: UILabel = {
        let lable = UILabel()
        lable.text = "TODO"
        lable.textAlignment = .center
        return lable
    }()
    
    private let topRightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(Constant.buttonTitleColor, for: .normal)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.borderStyle = .none
        textField.backgroundColor = Constant.textFieldBackgroundColor
        textField.layer.shadowColor = Constant.textFieldShadowColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 0.3
        textField.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 0)))
        textField.leftViewMode = .always
                                
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = Constant.textFieldBackgroundColor
        textView.layer.shadowColor = Constant.textFieldShadowColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 4)
        textView.layer.shadowRadius = 5
        textView.layer.shadowOpacity = 0.3
        textView.layer.masksToBounds = false
        return textView
    }()
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()
    
    private func setConsantrait() {
        backgroundColor = Constant.viewBackgroundColor
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    private func setUpStackView() {
        stackView.addSubViews(buttonStackView, titleTextField, datePicker, bodyTextView)
        buttonStackView.addSubViews(topLeftButton, topTitleLabel, topRightButton)
    }
    
    @objc
    private func cancelButtonClicked() {
        buttonDelegate?.cancelButtonClicked()
    }
    @objc
    private func doneButtonClicked() {
        buttonDelegate?.doneButtonClicked()
    }
    
    private func setButton() {
        topLeftButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        topRightButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    func setButtonDelegate(_ delegate: ButtonActionDelegate) {
        buttonDelegate = delegate
    }
    
    func setLabel(task: Task) {
        titleTextField.text = task.title
        bodyTextView.text = task.body
        datePicker.date = task.date
    }
}