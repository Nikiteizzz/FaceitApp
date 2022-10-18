//
//  NetworkManager.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 15.10.22.
//

import Foundation
import UIKit
import SnapKit

class NetwrokManager {
    private var userData: Data?
    public var userDataObj: UserData?
    
    init() {
        self.userData = nil
    }
    
    public func getFaceitPlayerData(nickname: String, completition: @escaping (UserData, UIImage, Game?) -> Void, errorHandler: @escaping () -> Void) {
        guard let url = URL(string: String.faceitPlayerSearchURL + nickname) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer 772962de-f07c-4c28-8561-57713b79a0b1", forHTTPHeaderField: "Authorization")
        let queue = DispatchQueue.global(qos: .utility)
        let urlSession = URLSession.shared.dataTask(with: request) {
            data, _, _ in
            self.userData = data
            if self.userData == nil {
                DispatchQueue.main.async {
                    errorHandler()
                }
            } else {
                self.userDataObj = self.getPlayerStruct()
                let image = self.getPlayerImage()
                let game = self.userDataObj?.games["csgo"]
                DispatchQueue.main.async {
                    completition(self.userDataObj!, image, game)
                }
                print(self.userDataObj)
            }
        }
        queue.sync {
            urlSession.resume()
        }
    }
    
    private func getPlayerStruct() -> UserData? {
        guard let unwrappedUserData = self.userData else { return nil }
        self.userDataObj = try? JSONDecoder().decode(UserData.self, from: unwrappedUserData)
        return userDataObj
    }
    
    private func getPlayerImage() -> UIImage {
        guard let noPhotoImage = UIImage(named: "no-photo-avatar") else { return UIImage() }
        guard let iconUrl = URL(string: userDataObj!.avatar) else { return noPhotoImage }
        guard let imageData = try? Data(contentsOf: iconUrl) else { return noPhotoImage }
        guard let image = UIImage(data: imageData) else { return noPhotoImage }
        return image
    }
}

extension String {
    static let faceitPlayerSearchURL = "https://open.faceit.com/data/v4/players?nickname="
}
