//
//  NavigationCoordinator.swift
//  Coordinator
//
//  Created by Patrick Fischer on 16.08.19.
//  Copyright © 2019 Patrick Fischer. All rights reserved.
//

import Foundation
import UIKit



open class NavigationCoordinator: NSObject, UINavigationControllerDelegate, Navigation {
    weak public var parentCoordinator: Navigation?
    public var navigationController: UINavigationController
    public var childCoordinators = [CoordinatorStorage]()
    public var appCoordinatorStack: CoordinatorStack?
    
    /// used to initialise very first NavigationCoordinator, then coordinatorstack gets passed around in addChild funtion
    public init(navigationController: UINavigationController, appCoordinatorStack: CoordinatorStack) {
        self.navigationController = navigationController
        self.appCoordinatorStack = appCoordinatorStack
    }
    
    /// used for navigationCoordinator that are nested in other NavigationCoordinators
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    open func start() {
        
    }
    
    deinit {
        print(self.description, "deallocated")
    }
    
    public func addChild(coordinator: Coordinator, vcThatPops: UIViewController? = nil) {
        if parentCoordinator != nil {
            coordinator.parentCoordinator = parentCoordinator
        } else {
            coordinator.parentCoordinator = self
        }
        childCoordinators.append(CoordinatorStorage(coordinator: coordinator, identifier: coordinator.identifier(), vc: vcThatPops))
        if let appCoordinatorStack = appCoordinatorStack {
            appCoordinatorStack.addCoordinator(coordinator: coordinator)
                if let navigationCoordinator = coordinator as? NavigationCoordinator {
                    navigationCoordinator.appCoordinatorStack = self.appCoordinatorStack
                }
        } else {
            fatalError("appCoordinatorStack is not initialised, please make sure your first NavigationController is initialised with a CoordinatorStack")
        }
    }
    
    public func removeChild(child: String?) {
        if child != nil {
            if let coordinator = childCoordinators.first(where: { $0.identifier == child!})  {
                if let appCoordinatorStack = appCoordinatorStack {
                    appCoordinatorStack.removeCoordinator(coordinator: coordinator.coordinator)
                    let index = childCoordinators.firstIndex(where: { $0.identifier == child})
                    childCoordinators.remove(at: index!)
                    appCoordinatorStack.updateNavigationDelegate()
                } else {
                    fatalError("appCoordinatorStack is not initialised, please make sure your first NavigationController is initialised with a CoordinatorStack")
                }
            }
        }
    }
    
    open func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        removeCoordinator()
    }
    
    func removeCoordinator() {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(fromViewController) else { return }
        let element = childCoordinators.first(where: { $0.vc === fromViewController})
        
        removeChild(child: element?.identifier)
        
    }
    
    public func removeAllChildsBut(coordinator: Coordinator?) {
        let storageUnit = childCoordinators.first {$0.identifier == coordinator?.identifier() }
        childCoordinators.removeAll()
        
        if let storageUnit = storageUnit {
            childCoordinators.append(storageUnit)
            if let navigation = storageUnit.coordinator as? Navigation {
                navigation.childCoordinators.removeAll()
                appCoordinatorStack?.popToStack(coordinator: navigation)
            } else {
                appCoordinatorStack?.coordinators.removeAll()
            }
        }

    }
    
    

    
    public func removeAllChilds() {
        childCoordinators.removeAll()
        appCoordinatorStack?.popToStack(coordinator: self)
    }
    
    
    public func setThisCoordinatorAsParent(_ navigationCoordinator: Navigation? = nil) {
        if navigationCoordinator != nil {
            self.parentCoordinator = navigationCoordinator
        } else {
            self.parentCoordinator = self
        }
    }
    
}


