//
//  EditAboutViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 26/08/21.
//

import UIKit
import Toast

class EditAboutViewController: UIViewController {
    lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor(red: 130/255, green: 131/255, blue: 134/255, alpha: 1)
            label.font = .systemFont(ofSize: 17, weight: .medium)
            label.text = "Nama"
            return label
    }()
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textContentType = .name
        textField.autocapitalizationType = .none
        textField.placeholder = "Masukkan Nama"
        return textField
    }()
    lazy var descLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor(red: 130/255, green: 131/255, blue: 134/255, alpha: 1)
            label.font = .systemFont(ofSize: 17, weight: .medium)
            label.text = "Deskripsi"
            return label
    }()
    private lazy var descField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textContentType = .name
        textField.autocapitalizationType = .none
        textField.placeholder = "Masukkan Deskripsi"
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit"
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
        UserModel.synchronize()
        nameField.text = UserModel.name
        descField.text = UserModel.desc
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
        self.view.makeToast("\(field) tidak boleh kosong")
    }
    @objc func confirmEdit(_ sender: UIBarButtonItem!) {
        if let name = nameField.text, let desc = descField.text {
            if name.isEmpty {
                emptyText(field: "Nama")
            } else if desc.isEmpty {
                emptyText(field: "Deskripsi")
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
        UserModel.name = name
        UserModel.desc = desc
        self.view.makeToast("Berhasil tersimpan")
    }
}
