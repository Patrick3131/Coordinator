//
//  NavigationCoordinator.swift
//  Coordinator
//
//  Created by Patrick Fischer on 16.08.19.
//  Copyright © 2019 Patrick Fischer. All rights reserved.
//

import Foundation
import UIKit

class NavigationCoordinator: NSObject, Navigation {
    var navigationController: UINavigationController
    var childCoordinators = [String : Coordinator]()
    var appCoordinatorStack: CoordinatorStack
    
     
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.appCoordinatorStack = AppCoordinatorStack(navigationController: navigationController)
    }
    
    func start() {
        
    }
    
   
    
    
}
