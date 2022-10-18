//
//  ViewController.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 5.10.22.
//

import UIKit
import SnapKit

class UserViewController: UIViewController {

    weak var appCoordinator: AppCoordinator?
    var networkManager = NetwrokManager()
    
    private let downloadIndicator: UIActivityIndicatorView = {
        let downloadIndicator = UIActivityIndicatorView()
        downloadIndicator.startAnimating()
        downloadIndicator.color = .white
        downloadIndicator.translatesAutoresizingMaskIntoConstraints = false
        return downloadIndicator
    }()
    
    private let userIconImageView: UIImageView = {
        let userIconImageView = UIImageView()
        userIconImageView.layer.masksToBounds = true
        userIconImageView.layer.cornerRadius = 20
        userIconImageView.translatesAutoresizingMaskIntoConstraints = false
        return userIconImageView
    }()
    
    private let userInfoView: UserInfoView = {
        let userInfoView = UserInfoView(frame: CGRect.zero)
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        return userInfoView
    }()
    
    private let gameInfoView: GameInfoView = {
        let gameInfoView = GameInfoView(frame: CGRect.zero)
        gameInfoView.translatesAutoresizingMaskIntoConstraints = false
        return gameInfoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDownloading()
        setupView()
        addSubviews()
        addSubviewsConstraints()
    }


}

extension UserViewController {
    private func setupView() {
        view.backgroundColor = .black
        userIconImageView.isHidden = true
        userInfoView.isHidden = true
        gameInfoView.isHidden = true
    }
    
    private func addSubviews() {
        view.addSubview(downloadIndicator)
        view.addSubview(userIconImageView)
        view.addSubview(userInfoView)
        view.addSubview(gameInfoView)
    }
    
    private func addSubviewsConstraints() {
        downloadIndicator.snp.makeConstraints() {
            element in
            element.center.equalToSuperview()
        }
        
        userIconImageView.snp.makeConstraints() {
            element in
            element.top.equalTo(view.safeAreaLayoutGuide)
            element.left.equalToSuperview().inset(20)
            element.height.width.equalTo(view.snp.width).multipliedBy(0.3)
        }
        
        userInfoView.snp.makeConstraints() {
            element in
            element.top.equalTo(view.safeAreaLayoutGuide)
            element.left.equalTo(userIconImageView.snp.right).offset(5)
            element.width.equalToSuperview().multipliedBy(0.6)
            element.height.equalTo(userIconImageView.snp.height)
        }
        
        gameInfoView.snp.makeConstraints() {
            element in
            element.top.equalTo(userInfoView.snp.bottom).offset(40)
            element.centerX.equalToSuperview()
            element.width.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    private func startDownloading() {
        networkManager.getFaceitPlayerData(nickname: (appCoordinator?.userNickname)!, completition: setupViewsAfterDownloading(userData:userImage:game:), errorHandler: gotError)
    }
    
    private func gotError() {
        let alert = UIAlertController(title: "Ошибка!", message: "Такой никнейм не найден!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ввести заново", style: .default) {
            _ in
            self.appCoordinator?.navigationController.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func setupViewsAfterDownloading(userData: UserData, userImage: UIImage, game: Game?) {
        self.downloadIndicator.stopAnimating()
        self.userIconImageView.image = userImage
        if game != nil {
            self.gameInfoView.set(gameInfo: game!)
        }
        self.downloadIndicator.isHidden = true
        self.userInfoView.set(name: userData.nickname, country: userData.country, steamID64: userData.steamID64, memberships: userData.memberships)
        self.userInfoView.isHidden = false
        self.userIconImageView.isHidden = false
        self.gameInfoView.isHidden = false
    }
}

