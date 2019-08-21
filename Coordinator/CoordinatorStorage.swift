//
//  CoordinatorStorage.swift
//  Coordinator
//
//  Created by Patrick Fischer on 16.08.19.
//  Copyright © 2019 Patrick Fischer. All rights reserved.
//

import UIKit

public struct CoordinatorStorage {
    public var coordinator: Coordinator
    public var identifier: String
    /// associated Viewcontroller that pops when coordinator should disallocated
    public var vc: UIViewController?
}
