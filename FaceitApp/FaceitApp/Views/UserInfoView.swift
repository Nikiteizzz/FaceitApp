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
        userNameLabel.snp.makeConstraints() {
            element in
            element.top.equalToSuperview()
            element.left.equalToSuperview().inset(5)
            element.width.equalToSuperview()
            element.height.equalToSuperview().multipliedBy(0.23)
        }
        
        countryLabel.snp.makeConstraints() {
            element in
            element.top.equalTo(userNameLabel.snp.bottom)
            element.left.equalToSuperview().inset(5)
            element.width.equalToSuperview()
            element.height.equalToSuperview().multipliedBy(0.23)
        }
        
        steamID64Label.snp.makeConstraints() {
            element in
            element.top.equalTo(countryLabel.snp.bottom)
            element.left.equalToSuperview().inset(5)
            element.width.equalToSuperview()
            element.height.equalToSuperview().multipliedBy(0.23)
        }

        membershipsLabel.snp.makeConstraints() {
            element in
            element.top.equalTo(steamID64Label.snp.bottom)
            element.left.equalToSuperview().inset(5)
            element.width.equalToSuperview()
            element.height.equalToSuperview().multipliedBy(0.23)
        }
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
