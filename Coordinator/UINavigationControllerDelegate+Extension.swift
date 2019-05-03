//
//  UINavigationControllerDelegate+Extension.swift
//  Coinstat
//
//  Created by Patrick Fischer on 29.11.18.
//  Copyright © 2018 Patrick Fischer. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationControllerDelegate where Self: NavigationCoordinator {
    
    ///Removes Coordinator from childCoordinators if ViewController is popping from UINavigationController
    func removeCoordinator<T:UIViewController>(register: String, viewController: T.Type) {
        var registerToDelete: String?
        
        // checks if Viewcontroller is popping
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(fromViewController) else {
            return
        }
        // checks if Viewcontroller is the right type
        if fromViewController is T {
            registerToDelete = register
        } else { return }
        
        //removes Coordinator
        removeChild(child: registerToDelete)
    }
}
