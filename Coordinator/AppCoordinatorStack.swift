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
    public var coordinators = [Navigation]()
    public var navigationController: UINavigationController
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func updateNavigationDelegate() {
        let howManyCoordinators = coordinators.count
        if howManyCoordinators > 1 {
            if let lastCoordinator = coordinators.last {
                if lastCoordinator.childCoordinators.count == 0 {
                    let secondLastCoordinator = coordinators[howManyCoordinators - 2]
                    navigationController.delegate = secondLastCoordinator
                } else {
                    navigationController.delegate = lastCoordinator
                }
            }
        } else if howManyCoordinators == 1 {
            let coordinator = coordinators[0]
            navigationController.delegate = coordinator
        }
    }
    
    public func addCoordinator(coordinator: Coordinator) {
        if let navigationCoordinator = coordinator as? NavigationCoordinator {
            coordinators.append(navigationCoordinator)
        }
        updateNavigationDelegate()
    }
    
    public func removeCoordinator(coordinator: Coordinator) {
        if let navigationCoordinator = coordinator as? Navigation {
            var index = 0
            for y in coordinators {
                if y === navigationCoordinator {
                    coordinators.remove(at: index)
                }
                index = index + 1
            }
        }
        updateNavigationDelegate()
    }
    
    public func popToRootStack(rootCoordinator: Navigation) {
        let root = coordinators.first {$0.identifier() == rootCoordinator.identifier() }
        coordinators.removeAll()
        if let coordinator = root {
            coordinators.append(coordinator)
        }
        updateNavigationDelegate()
    }
    
    public func popToStack(coordinator: Navigation) {
        let index = coordinators.firstIndex(where: { $0.identifier() == coordinator.identifier()})
        if let index = index {
            let count = coordinators.count
            coordinators.removeSubrange((index + 1)..<count)
            updateNavigationDelegate()
        }
    }
}


extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0..<self).makeIterator()
    }
}


