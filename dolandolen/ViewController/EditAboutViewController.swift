//
//  EditAboutViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 26/08/21.
//

import UIKit

class EditAboutViewController: UIViewController {
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Masukkan nama"
        textField.center = self.view.center
        textField.borderStyle = UITextField.BorderStyle.line
//        textField.text = "Terisi otomatis"
        return textField
    }()
    private lazy var descField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Masukkan Deskripsi"
        textField.center = self.view.center
        textField.borderStyle = UITextField.BorderStyle.line
//        textField.text = "Terisi otomatis"
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit"
        view.backgroundColor = .white
    }
    override func viewWillLayoutSubviews() {
        addSaveNavigationItem()
    }
    private func addSaveNavigationItem() {
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save,
                                             target: self, action: #selector(saveEdit(_:)))
        navigationItem.rightBarButtonItem = editButtonItem
    }
    @objc func saveEdit(_ sender: UIBarButtonItem!) {
        print("saving...")
    }
}
