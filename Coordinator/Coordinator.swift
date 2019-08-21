//
//  Coordinator.swift
//  Coinstat
//
//  Created by Patrick Fischer on 19.11.18.
//  Copyright © 2018 Patrick Fischer. All rights reserved.
//

import Foundation
import UIKit.UINavigationController

/**
Coordinator manages a UINavigationController, with start the start UIViewController gets loaded
 */
public protocol Coordinator: class {
    var navigationController: UINavigationController { get }
    var parentCoordinator: Navigation? { get set }
    /// if you use more than one of the same Coordinators in one NavigationController than implement identifier in your Coordinator class
    func identifier() -> String
    func start()
}

public extension Coordinator {
    func identifier() -> String {
        
        return String(describing: self)
    }
}


