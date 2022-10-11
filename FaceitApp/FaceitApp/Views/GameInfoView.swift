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
        gameIconImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gameIconImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        gameIconImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
        gameIconImageView.heightAnchor.constraint(equalTo: gameIconImageView.widthAnchor).isActive = true
        
        gameNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gameNameLabel.leftAnchor.constraint(equalTo: gameIconImageView.rightAnchor, constant: 10).isActive = true
        gameNameLabel.heightAnchor.constraint(equalTo: gameIconImageView.heightAnchor).isActive = true
        gameNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        
        ifNoGamesLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ifNoGamesLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ifNoGamesLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        ifNoGamesLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        gameInfoLabel.topAnchor.constraint(equalTo: gameIconImageView.bottomAnchor).isActive = true
        gameInfoLabel.leftAnchor.constraint(equalTo: gameIconImageView.centerXAnchor).isActive = true
        gameInfoLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        gameInfoLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }
    
    public func set(gameInfo: Game) {
        ifNoGamesLabel.isHidden = true
        gameInfoLabel.text = """
                            Ник: \(gameInfo.game_player_name)
                            Регион: \(gameInfo.region)
                            Очки ello: \(gameInfo.faceit_elo)
                            ID игрока: \(gameInfo.game_player_id)
                            Уровень FaceIT: \(gameInfo.skill_level)
                            """
        gameInfoLabel.isHidden = false
    }
}

