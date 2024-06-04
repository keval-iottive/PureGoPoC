//
//  GFunction.swift
//  PureGo
//
//  Created by admin on 6/4/24.
//

import UIKit

class GFunction: UIViewController {
    
    static let shared :GFunction = GFunction()
     func setRootController(for rootController: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            // Set the new rootViewController of the window.
            
            window.rootViewController = rootController
            window.makeKeyAndVisible()
            
            // A mask of options indicating how you want to perform the animations.
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            
            // The duration of the transition animation, measured in seconds.
            let duration: TimeInterval = 0.3
            
            // Creates a transition animation.
            // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: { completed in
                // Do something on completion here
            })
        }
    }
}
