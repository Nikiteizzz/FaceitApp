//
//  UserInfoView.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 7.10.22.
//

import UIKit

class UserInfoView: UIView {
    
    private lazy var userNameLabel: UILabel = {
       let userNameLabel = UILabel()
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        userNameLabel.textColor = .white
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return userNameLabel
    }()
    
    private lazy var countryLabel: UILabel = {
       let country = UILabel()
        country.font = UIFont.systemFont(ofSize: 15)
        country.textColor = .white
        country.translatesAutoresizingMaskIntoConstraints = false
        return country
    }()
    
    private lazy var steamID64Label: UILabel = {
       let steamID64Label = UILabel()
        steamID64Label.font = UIFont.systemFont(ofSize: 15)
        steamID64Label.textColor = .white
        steamID64Label.translatesAutoresizingMaskIntoConstraints = false
        return steamID64Label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserInfoView {
    func addSubviews() {
        addSubview(userNameLabel)
        addSubview(countryLabel)
        addSubview(steamID64Label)
    }
    
    func addViewConstraints() {
        userNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        userNameLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        countryLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor).isActive = true
        countryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        countryLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        countryLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        steamID64Label.topAnchor.constraint(equalTo: countryLabel.bottomAnchor).isActive = true
        steamID64Label.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        steamID64Label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        steamID64Label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func set(name: String, country: String, steamID64: String) {
        userNameLabel.text = "Ник: " + name
        countryLabel.text = "Страна: " + country
        steamID64Label.text = "SteamID64: " + steamID64
    }
}
