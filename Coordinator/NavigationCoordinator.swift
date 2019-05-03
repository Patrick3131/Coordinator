//
//  NavigationCoordinator.swift
//  Coinstat
//
//  Created by Patrick Fischer on 29.11.18.
//  Copyright © 2018 Patrick Fischer. All rights reserved.
//

import Foundation
import UIKit


public protocol NavigationCoordinator: class, Coordinator, UINavigationControllerDelegate {
    var navigationController: UINavigationController { get }
    var childCoordinators: [String: Coordinator] { get set}
    var appCoordinatorStack: CoordinatorStack { get }
    func addChild(coordinator: Coordinator, key: String)
    func removeChild(child: String?)
}

extension NavigationCoordinator {
    public func removeChild(child: String?) {
        
        if child != nil {
            if childCoordinators[child!] != nil {
                //removes Coordinator from AppCoordinatorStack
                appCoordinatorStack.removeCoordinator(coordinator: childCoordinators[child!]!)
                //removes Coordinator from ChildCoordinator
                childCoordinators.removeValue(forKey: child!)
                appCoordinatorStack.updateNavigationDelegate()
            }
        }
    }
    
    public func addChild(coordinator: Coordinator, key: String) {
        childCoordinators[key] = coordinator
        appCoordinatorStack.addCoordinator(coordinator: coordinator)
    }
}
