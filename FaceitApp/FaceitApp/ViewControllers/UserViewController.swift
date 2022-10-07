//
//  ViewController.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 5.10.22.
//

import UIKit

class UserViewController: UIViewController {

    weak var appCoordinator: AppCoordinator?
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSizeMake(UIScreen.main.bounds.width, 2300)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let viewForScroll: UIView = {
        let viewForScroll = UIView()
        viewForScroll.translatesAutoresizingMaskIntoConstraints = false
        return viewForScroll
    }()
    
    let downloadIndicator: UIActivityIndicatorView = {
        let downloadIndicator = UIActivityIndicatorView()
        downloadIndicator.startAnimating()
        downloadIndicator.color = .white
        downloadIndicator.translatesAutoresizingMaskIntoConstraints = false
        return downloadIndicator
    }()
    
    let userIconImageView: UIImageView = {
        let userIconImageView = UIImageView()
        userIconImageView.translatesAutoresizingMaskIntoConstraints = false
        return userIconImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        addSubviewsConstraints()
        startDownloading()
    }


}

extension UserViewController {
    func setupView() {
        view.backgroundColor = .black
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewForScroll)
        viewForScroll.addSubview(downloadIndicator)
        viewForScroll.addSubview(userIconImageView)
    }
    
    func addSubviewsConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        viewForScroll.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        viewForScroll.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        viewForScroll.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        viewForScroll.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        downloadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        userIconImageView.topAnchor.constraint(equalTo: viewForScroll.topAnchor).isActive = true
        userIconImageView.centerXAnchor.constraint(equalTo: viewForScroll.centerXAnchor).isActive = true
        userIconImageView.widthAnchor.constraint(equalTo: viewForScroll.widthAnchor, multiplier: 0.6).isActive = true
        userIconImageView.heightAnchor.constraint(equalTo: userIconImageView.widthAnchor).isActive = true
    }
    
    func startDownloading() {
        guard let url = URL(string: "https://open.faceit.com/data/v4/players?nickname=\(appCoordinator!.userNickname!)") else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer 772962de-f07c-4c28-8561-57713b79a0b1", forHTTPHeaderField: "Authorization")
        let queue = DispatchQueue.global(qos: .utility)
        let urlSession = URLSession.shared.dataTask(with: request) {
            data, _, _ in
            let userData: UserData? = try? JSONDecoder().decode(UserData.self, from: data!)
            print(userData)
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
            DispatchQueue.main.async {
                self.downloadIndicator.stopAnimating()
                self.downloadIndicator.isHidden = true
            }
        }
        queue.async {
            urlSession.resume()
        }
    }
    
    func gotError() {
        let alert = UIAlertController(title: "Ошибка!", message: "Такой никнейм не найден!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ввести заново", style: .default) {
            _ in
            self.appCoordinator?.navigationController.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

