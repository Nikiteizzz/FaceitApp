//
//  AppDelegate.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 5.10.22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeKeyboard)))
        window?.rootViewController = navigationController
        
        return true
    }
    
    @objc func closeKeyboard() {
        window?.endEditing(true)
    }
}

