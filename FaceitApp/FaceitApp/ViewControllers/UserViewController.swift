//
//  ViewController.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 5.10.22.
//

import UIKit

class UserViewController: UIViewController {

    weak var appCoordinator: AppCoordinator?
    
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
        downloadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        userIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userIconImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        userIconImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        userIconImageView.heightAnchor.constraint(equalTo: userIconImageView.widthAnchor).isActive = true
        
        userInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userInfoView.leftAnchor.constraint(equalTo: userIconImageView.rightAnchor, constant: 5).isActive = true
        userInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        userInfoView.heightAnchor.constraint(equalTo: userIconImageView.heightAnchor).isActive = true
        
        gameInfoView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 60).isActive = true
        gameInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gameInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        gameInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func startDownloading() {
        guard let url = URL(string: "https://open.faceit.com/data/v4/players?nickname=\(appCoordinator!.userNickname!)") else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer 772962de-f07c-4c28-8561-57713b79a0b1", forHTTPHeaderField: "Authorization")
        let queue = DispatchQueue.global(qos: .utility)
        let urlSession = URLSession.shared.dataTask(with: request) {
            data, _, _ in
            if data == nil {
                DispatchQueue.main.async {
                    self.gotError()
                }
                return
            }
            let userData: UserData? = try? JSONDecoder().decode(UserData.self, from: data!)
            if userData == nil {
                DispatchQueue.main.async {
                    self.gotError()
                }
                return
            }
    
            if (userData!.avatar != "") {
                let userImageData = try! Data(contentsOf: URL(string: userData!.avatar)!)
                DispatchQueue.main.async {
                    self.userIconImageView.image = UIImage(data: userImageData)
                }
            } else {
                DispatchQueue.main.async {
                    self.userIconImageView.image = UIImage(named: "no-photo-avatar")
                }
            }
            if ((userData?.games["csgo"]) != nil) {
                DispatchQueue.main.async {
                    self.gameInfoView.set(gameInfo: (userData?.games["csgo"])!)
                }
            }
            DispatchQueue.main.async {
                self.downloadIndicator.stopAnimating()
                self.downloadIndicator.isHidden = true
                self.userInfoView.set(name: userData!.nickname, country: userData!.country, steamID64: userData!.steam_id_64, memberships: userData!.memberships)
                self.userInfoView.isHidden = false
                self.userIconImageView.isHidden = false
                self.gameInfoView.isHidden = false
            }
        }
        queue.async {
            urlSession.resume()
        }
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
}

