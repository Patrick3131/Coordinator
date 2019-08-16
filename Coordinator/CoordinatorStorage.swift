//
//  CoordinatorStorage.swift
//  Coordinator
//
//  Created by Patrick Fischer on 16.08.19.
//  Copyright © 2019 Patrick Fischer. All rights reserved.
//

import UIKit

struct CoordinatorStorage {
    var coordinator: Coordinator
    var identifier: String
    /// associated Viewcontroller that pops when coordinator should disallocated
    var vc: UIViewController?
}
