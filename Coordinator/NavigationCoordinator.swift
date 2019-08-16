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
    public var appCoordinatorStack: CoordinatorStack
    
    public init(navigationController: UINavigationController, appCoordinatorStack: CoordinatorStack) {
        self.navigationController = navigationController
        self.appCoordinatorStack = appCoordinatorStack
    }
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.appCoordinatorStack = AppCoordinatorStack(navigationController: navigationController)
    }
    
    open func start() {
        
    }
    
    deinit {
        print(self.description, "deallocated")
    }
    
    public func addChild(coordinator: Coordinator, vcThatPops: UIViewController? = nil) {
        childCoordinators.append(CoordinatorStorage(coordinator: coordinator, identifier: coordinator.identifier(), vc: vcThatPops))
        appCoordinatorStack.addCoordinator(coordinator: coordinator)
    }
    
    public func removeChild(child: String?) {
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


