//
//  CoordinatorProtocol.swift
//  FaceitApp
//
//  Created by Никита Хорошко on 6.10.22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
