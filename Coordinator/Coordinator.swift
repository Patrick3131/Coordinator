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
public protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}


