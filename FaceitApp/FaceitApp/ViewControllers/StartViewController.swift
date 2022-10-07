//
//  StartViewController.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 6.10.22.
//

import UIKit
import Foundation

class StartViewController: UIViewController {
    
    weak var appCoordinator: AppCoordinator?
    
    let logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: UIImage(named: "faceit-logo-bright"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    let playerNameTextField: UITextField = {
        let playerNameTextField = UITextField()
        playerNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: playerNameTextField.frame.height))
        playerNameTextField.leftViewMode = .always
        playerNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите никнейм", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        playerNameTextField.backgroundColor = .darkGray
        playerNameTextField.textColor = .systemGray6
        playerNameTextField.layer.cornerRadius = 17
        playerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return playerNameTextField
    }()
    
    let searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.setTitle("Поиск...", for: .normal)
        searchButton.backgroundColor = .orange
        searchButton.setTitleColor(UIColor.white, for: .normal)
        searchButton.layer.cornerRadius = 15
        searchButton.addTarget(nil, action: #selector(search), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        return searchButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        addSubviewsConstraints()
    }

}

extension StartViewController {
    func setupView() {
        view.backgroundColor = .black
    }
    
    func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(playerNameTextField)
        view.addSubview(searchButton)
    }
    
    func addSubviewsConstraints() {
        logoImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor).isActive = true
        
        playerNameTextField.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        playerNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        playerNameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: playerNameTextField.bottomAnchor, constant: 30).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        searchButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    @objc func search() {
        if playerNameTextField.text == "" {
            let alert = UIAlertController(title: "Ошибка", message: "Не введено имя!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Хорошо", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Успешно", message: "Имя введено, давайте искать!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Поехали!", style: .default) {
                _ in
                self.appCoordinator?.userNickname = self.playerNameTextField.text!
                self.appCoordinator?.goToUserViewController()
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}

