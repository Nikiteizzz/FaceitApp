//
//  GameInfoView.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 9.10.22.
//

import UIKit

class GameInfoView: UIView {
    
    private let cellReuseIdentifier = "cell"
    
    private let gameIconImageView: UIImageView = {
        let gameIconImageView = UIImageView()
        gameIconImageView.image = UIImage(named: "CSGO-logo")
        gameIconImageView.layer.masksToBounds = true
        gameIconImageView.layer.cornerRadius = 5
        gameIconImageView.translatesAutoresizingMaskIntoConstraints = false
        return gameIconImageView
    }()
    
    private let gameNameLabel: UILabel = {
        let gameNameLabel = UILabel()
        gameNameLabel.text = "CS:GO"
        gameNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        gameNameLabel.textColor = .white
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return gameNameLabel
    }()
    
    private let ifNoGamesLabel: UILabel = {
        let ifNoGamesLabel = UILabel()
        ifNoGamesLabel.textAlignment = .center
        ifNoGamesLabel.text = "Информации про эту игру нет!"
        ifNoGamesLabel.textColor = .systemGray5
        ifNoGamesLabel.font = UIFont.boldSystemFont(ofSize: 15)
        ifNoGamesLabel.translatesAutoresizingMaskIntoConstraints = false
        return ifNoGamesLabel
    }()
    
    private let gameInfoLabel: UILabel = {
        let gameInfoLabel = UILabel()
        gameInfoLabel.numberOfLines = 5
        gameInfoLabel.font = UIFont.systemFont(ofSize: 18)
        gameInfoLabel.textColor = .white
        gameInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        gameInfoLabel.isHidden = true
        return gameInfoLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addSubviewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameInfoView {
    private func addSubviews() {
        addSubview(gameIconImageView)
        addSubview(gameNameLabel)
        addSubview(ifNoGamesLabel)
        addSubview(gameInfoLabel)
    }
    
    private func addSubviewsConstraints() {
        
        gameIconImageView.snp.makeConstraints() {
            element in
            element.top.equalToSuperview()
            element.left.equalToSuperview()
            element.width.equalToSuperview().multipliedBy(0.2)
            element.height.equalTo(snp.width).multipliedBy(0.2)
        }

        gameNameLabel.snp.makeConstraints() {
            element in
            element.top.equalToSuperview()
            element.left.equalTo(gameIconImageView.snp.right).offset(10)
            element.height.equalTo(gameIconImageView.snp.height)
            element.width.equalToSuperview().multipliedBy(0.5)
        }

        ifNoGamesLabel.snp.makeConstraints() {
            element in
            element.top.equalTo(gameNameLabel.snp.bottom).offset(50)
            element.centerX.equalToSuperview()
            element.width.equalToSuperview().multipliedBy(0.8)
            element.height.equalToSuperview().multipliedBy(0.3)
        }

        gameInfoLabel.snp.makeConstraints() {
            element in
            element.top.equalTo(gameIconImageView.snp.bottom).offset(10)
            element.left.equalTo(gameIconImageView.snp.centerX)
            element.width.equalToSuperview()
            element.height.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    public func set(gameInfo: Game) {
        ifNoGamesLabel.isHidden = true
        gameInfoLabel.text = """
                            Ник: \(gameInfo.gamePlayerName)
                            Регион: \(gameInfo.region)
                            Очки ello: \(gameInfo.faceitElo)
                            ID игрока: \(gameInfo.gamePlayerId)
                            Уровень FaceIT: \(gameInfo.skillLevel)
                            """
        gameInfoLabel.isHidden = false
    }
}

