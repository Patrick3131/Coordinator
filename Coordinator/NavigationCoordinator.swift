//
//  NavigationCoordinator.swift
//  Coordinator
//
//  Created by Patrick Fischer on 16.08.19.
//  Copyright © 2019 Patrick Fischer. All rights reserved.
//

import Foundation
import UIKit



open class NavigationCoordinator: NSObject, UINavigationControllerDelegate {
    public var navigationController: UINavigationController
    var childCoordinators = [CoordinatorStorage]()
    var appCoordinatorStack: CoordinatorStack
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.appCoordinatorStack = AppCoordinatorStack(navigationController: navigationController)
    }
    
    open func start() {
        
    }
    
    func addChild(coordinator: Coordinator, vcThatPops: UIViewController? = nil) {
        childCoordinators.append(CoordinatorStorage(coordinator: coordinator, identifier: coordinator.identifier(), vc: vcThatPops))
        appCoordinatorStack.addCoordinator(coordinator: coordinator)
    }
    
    func removeChild(child: String?) {
        if child != nil {
            if let coordinator = childCoordinators.first(where: { $0.identifier == child!})  {
                appCoordinatorStack.removeCoordinator(coordinator: coordinator.coordinator)
                let index = childCoordinators.firstIndex(where: { $0.identifier == child})
                childCoordinators.remove(at: index!)
                appCoordinatorStack.updateNavigationDelegate()
            }
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        removeCoordinator()
    }
    
    func removeCoordinator() {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(fromViewController) else { return }
        
        let element = childCoordinators.first(where: { $0.vc === fromViewController})
        removeChild(child: element?.identifier)
        
    }
}


