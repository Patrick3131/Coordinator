//
//  UINavigationController+Extensions.swift
//  Coordinator
//
//  Created by Patrick Fischer on 18.08.19.
//  Copyright © 2019 Patrick Fischer. All rights reserved.
//

import UIKit


public extension UINavigationController {
    
   
    
    func pushTransition(_ subType: CATransitionSubtype, vc: UIViewController, leftButton: UIBarButtonItem? = nil, rightButton: UIBarButtonItem? = nil) {
        self.view.layer.add(createTransition(subType, type: .push), forKey: kCATransition)
        self.pushViewController(vc, animated: false)
        if leftButton != nil {
            vc.navigationItem.leftBarButtonItem = leftButton
        }
        if rightButton != nil {
            vc.navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    func addCloseButton(_ vc: UIViewController, button: UIBarButtonItem) {
        button.target = vc
        button.action = #selector(touchedToDismissVC(vc:))
        vc.navigationItem.leftBarButtonItem = button
    }
    
    func popTransition(_ subType: CATransitionSubtype) {
        self.view.layer.add(createTransition(subType, type: .reveal), forKey: kCATransition)
        self.popViewController(animated: false)
    }
    
    private func createTransition(_ subType: CATransitionSubtype, type: CATransitionType) -> CATransition {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = type
        transition.subtype = subType
        return transition
    }
    
    @objc func touchedToDismissVC(vc: UIViewController) {
        popTransition(.fromBottom)
    }
}


