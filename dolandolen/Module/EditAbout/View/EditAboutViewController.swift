//
//  EditAboutViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 26/08/21.
//

import UIKit
import Toast_Swift
import Core

class EditAboutViewController: UIViewController {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 130/255, green: 131/255, blue: 134/255, alpha: 1)
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "name_label".localized()
        return label
    }()
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textContentType = .name
        textField.autocapitalizationType = .none
        textField.placeholder = "name_hint".localized()
        return textField
    }()
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 130/255, green: 131/255, blue: 134/255, alpha: 1)
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "description_label".localized()
        return label
    }()
    private lazy var descField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textContentType = .name
        textField.autocapitalizationType = .none
        textField.placeholder = "description_hint".localized()
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "edit_label".localized()
        view.backgroundColor = .white
        view.addSubview(nameField)
        view.addSubview(descField)
        view.addSubview(nameLabel)
        view.addSubview(descLabel)
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        nameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        descLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20).isActive = true
        descLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        descField.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10).isActive = true
        descField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        descField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        descField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        UserProfile.synchronize()
        nameField.text = UserProfile.name
        descField.text = UserProfile.desc
    }
    override func viewWillLayoutSubviews() {
        addSaveNavigationItem()
    }
    private func addSaveNavigationItem() {
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save,
                                             target: self, action: #selector(confirmEdit(_:)))
        let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel,
                                               target: self, action: #selector(cancelEdit(_:)))
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = cancelButtonItem
    }
    private func emptyText(field: String) {
        self.view.makeToast("\(field) \("field_empty".localized())")
    }
    @objc func confirmEdit(_ sender: UIBarButtonItem!) {
        if let name = nameField.text, let desc = descField.text {
            if name.isEmpty {
                emptyText(field: "name_label".localized())
            } else if desc.isEmpty {
                emptyText(field: "description_label".localized())
            } else {
                saveEdit(name, desc)
                DataManager.shared.aboutVC.loadUserModel()
                self.dismiss(animated: true)
            }
        }
    }
    @objc func cancelEdit(_ sender: UIBarButtonItem!) {
        self.dismiss(animated: true)
    }
    private func saveEdit(_ name: String, _ desc: String) {
        UserProfile.name = name
        UserProfile.desc = desc
        self.view.makeToast("success_save".localized())
    }
}
