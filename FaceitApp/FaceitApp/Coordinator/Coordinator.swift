//
//  Coordinator.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 6.10.22.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var userNickname: String?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = StartViewController()
        startViewController.appCoordinator = self
        navigationController.pushViewController(startViewController, animated: true)
    }
    
    func goToUserViewController() {
        let viewController = UserViewController()
        viewController.appCoordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
