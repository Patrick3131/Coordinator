//
//  CoordinatorStack.swift
//  JournalRecognition
//
//  Created by Patrick Fischer on 12.04.19.
//  Copyright © 2019 Patrick Fischer. All rights reserved.
//

import UIKit.UINavigationController


/** handles delegatezuweisung für navigationController
 Problem: Delegate des UINavigationController muss immer dem korrekten NavigationCoordinator zugewiesen werden, ansonsten werden die Coordinatoren nicht korrekt entfernt sobald der entsprechende ViewController vom NavigationStack des UINavigationController popped. Daher oordinatorStack.
 */
public protocol CoordinatorStack {
    var coordinators: [NavigationCoordinator] {get set}
    var navigationController: UINavigationController { get }
    func updateNavigationDelegate()
    func addCoordinator(coordinator: Coordinator)
    func removeCoordinator(coordinator: Coordinator)
    func popToRootStack()
}
