//
//  NavigationCoordinator.swift
//  Coinstat
//
//  Created by Patrick Fischer on 29.11.18.
//  Copyright © 2018 Patrick Fischer. All rights reserved.
//

import Foundation
import UIKit

/**
 NavigationController holds several Coordinators, has standard implementation of addChild and removeChild
 */
public protocol Navigation: class, Coordinator, UINavigationControllerDelegate {
//    var childCoordinators: [String: Coordinator] { get set}
    var appCoordinatorStack: CoordinatorStack? { get }
    func addChild(coordinator: Coordinator, vcThatPops: UIViewController?)
    func removeChild(child: String?)
}


