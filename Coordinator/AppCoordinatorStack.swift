//
//  AppCoordinatorStack.swift
//  JournalRecognition
//
//  Created by Patrick Fischer on 12.04.19.
//  Copyright © 2019 Patrick Fischer. All rights reserved.
//

import UIKit.UINavigationController

/** handles delegatezuweisung für navigationController
 Problem: Delegate des UINavigationController muss immer dem korrekten NavigationCoordinator zugewiesen werden, ansonsten werden die Coordinatoren nicht korrekt entfernt sobald der entsprechende ViewController vom NavigationStack des UINavigationController popped. Daher AppCoordinatorStack.
 */
open class AppCoordinatorStack: CoordinatorStack {
    public var coodinators = [Navigation]()
    public var navigationController: UINavigationController
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func updateNavigationDelegate() {
        let howManyCoordinators = coodinators.count
        if howManyCoordinators > 1 {
            if let lastCoordinator = coodinators.last {
                if lastCoordinator.childCoordinators.count == 0 {
                    let secondLastCoordinator = coodinators[howManyCoordinators - 2]
                    navigationController.delegate = secondLastCoordinator
                } else {
                    navigationController.delegate = lastCoordinator
                }
            }
        } else if howManyCoordinators == 1 {
            let coordinator = coodinators[0]
            navigationController.delegate = coordinator
        }
    }
    
    public func addCoordinator(coordinator: Coordinator) {
        if let navigationCoordinator = coordinator as? Navigation {
            coodinators.append(navigationCoordinator)
        }
        updateNavigationDelegate()
    }
    
    public func removeCoordinator(coordinator: Coordinator) {
        if let navigationCoordinator = coordinator as? Navigation {
            var index = 0
            for y in coodinators {
                if y === navigationCoordinator {
                    coodinators.remove(at: index)
                }
                index = index + 1
            }
        }
        updateNavigationDelegate()
    }
    
    
}


