//
//  UserInfoView.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 7.10.22.
//

import UIKit

class UserInfoView: UIView {
    
    private let userNameLabel: UILabel = {
       let userNameLabel = UILabel()
        userNameLabel.text = "Ник: "
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        userNameLabel.textColor = .white
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return userNameLabel
    }()
    
    private let countryLabel: UILabel = {
       let country = UILabel()
        country.text = "Страна: "
        country.font = UIFont.systemFont(ofSize: 15)
        country.textColor = .white
        country.translatesAutoresizingMaskIntoConstraints = false
        return country
    }()
    
    private let steamID64Label: UILabel = {
       let steamID64Label = UILabel()
        steamID64Label.text = "SteamID64: "
        steamID64Label.font = UIFont.systemFont(ofSize: 15)
        steamID64Label.textColor = .white
        steamID64Label.translatesAutoresizingMaskIntoConstraints = false
        return steamID64Label
    }()
    
    private let membershipsLabel: UILabel = {
        let membershipsLabel = UILabel()
        membershipsLabel.text = "Подписки: "
        membershipsLabel.font = UIFont.systemFont(ofSize: 15)
        membershipsLabel.textColor = .white
        membershipsLabel.translatesAutoresizingMaskIntoConstraints = false
        return membershipsLabel
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
    private func addSubviews() {
        addSubview(userNameLabel)
        addSubview(countryLabel)
        addSubview(steamID64Label)
        addSubview(membershipsLabel)
    }
    
    private func addViewConstraints() {
        userNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        userNameLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23).isActive = true
        
        countryLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor).isActive = true
        countryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        countryLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        countryLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23).isActive = true
        
        steamID64Label.topAnchor.constraint(equalTo: countryLabel.bottomAnchor).isActive = true
        steamID64Label.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        steamID64Label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        steamID64Label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23).isActive = true
        
        membershipsLabel.topAnchor.constraint(equalTo: steamID64Label.bottomAnchor).isActive = true
        membershipsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        membershipsLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        membershipsLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23).isActive = true
    }
    
    public func set(name: String, country: String, steamID64: String, memberships: [String]) {
        userNameLabel.text! += name
        countryLabel.text! += country
        steamID64Label.text! += steamID64
        for membership in memberships {
            membershipsLabel.text! += membership
        }
    }
}
