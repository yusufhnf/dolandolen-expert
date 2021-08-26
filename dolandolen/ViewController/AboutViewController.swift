//
//  AboutViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 11/08/21.
//

import UIKit

class AboutViewController: UIViewController {

    private lazy var accountImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "author")
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    private lazy var authorNameText: UILabel = {
        let authorText = UILabel()
        authorText.text = "Yusuf Umar Hanafi"
        authorText.textAlignment = .center
        authorText.font = .systemFont(ofSize: 18, weight: .bold)
        authorText.translatesAutoresizingMaskIntoConstraints = false
        authorText.textColor = UIColor(red: 130/255, green: 131/255, blue: 134/255, alpha: 1)
        return authorText
    }()
    private lazy var authorInfoText: UILabel = {
        let authorText = UILabel()
        authorText.text = "iOS Developer | Apple Developer Academy"
        authorText.textAlignment = .center
        authorText.font = .systemFont(ofSize: 14, weight: .regular)
        authorText.textColor = UIColor(red: 130/255, green: 131/255, blue: 134/255, alpha: 1)
        authorText.translatesAutoresizingMaskIntoConstraints = false
        return authorText
    }()
    override func loadView() {
        super.loadView()
        view.addSubview(accountImage)
        view.addSubview(authorNameText)
        view.addSubview(authorInfoText)
        accountImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        accountImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        accountImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        accountImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        authorNameText.topAnchor.constraint(equalTo: accountImage.bottomAnchor, constant: 20).isActive = true
        authorNameText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        authorNameText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        authorInfoText.topAnchor.constraint(equalTo: authorNameText.bottomAnchor, constant: 10).isActive = true
        authorInfoText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        authorInfoText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Tentang"
    }
    override func viewWillLayoutSubviews() {
        addEditNavigationItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    private func addEditNavigationItem() {
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit,
                                             target: self, action: #selector(navigateToEdit(_:)))
        navigationItem.rightBarButtonItem = editButtonItem
    }
    @objc func navigateToEdit(_ sender: UIBarButtonItem!) {
        let editAboutVC = EditAboutViewController()
        let navigationController = UINavigationController(rootViewController: editAboutVC)
        navigationController.modalPresentationStyle = .automatic
        present(navigationController, animated: true)
    }
}
