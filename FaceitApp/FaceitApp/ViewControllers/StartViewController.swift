//
//  StartViewController.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 6.10.22.
//

import UIKit
import Foundation
import SnapKit

class StartViewController: UIViewController {
    
    weak var appCoordinator: AppCoordinator?
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: UIImage(named: "faceit-logo-bright"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    private let playerNameTextField: UITextField = {
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
    
    private let searchButton: UIButton = {
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
    private func setupView() {
        view.backgroundColor = .black
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(playerNameTextField)
        view.addSubview(searchButton)
    }
    
    private func addSubviewsConstraints() {
        logoImageView.snp.makeConstraints() {
            element in
            element.centerX.equalToSuperview()
            element.bottom.equalTo(view.snp.centerY)
            element.width.equalToSuperview().multipliedBy(0.6)
        }

        playerNameTextField.snp.makeConstraints() {
            element in
            element.center.equalTo(view.snp.center)
            element.width.equalToSuperview().multipliedBy(0.7)
            element.height.equalToSuperview().multipliedBy(0.06)
        }
        
        searchButton.snp.makeConstraints() {
            element in
            element.top.equalTo(playerNameTextField.snp.bottom).offset(30)
            element.centerX.equalToSuperview()
            element.width.equalToSuperview().multipliedBy(0.5)
            element.height.equalToSuperview().multipliedBy(0.05)
        }
    }
    
    @objc private func search() {
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

