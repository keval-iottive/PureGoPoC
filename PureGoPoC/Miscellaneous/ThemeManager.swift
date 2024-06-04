//
//  ThemeManager.swift
//  PureGo
//
//  Created by admin on 6/4/24.
//

import UIKit

class ThemeManager {
    
    static let sharedInstance = ThemeManager()
    
    var backgroundColor: UIColor {
        get {
            return .white
        }
    }
    
    var blueGradient: [UIColor] {
        get {
            return [UIColor(hexString: "4A5BDC", alpha: 1.0),
                    UIColor(hexString: "1D2A8E", alpha: 1.0)]
        }
    }
    
    var textColor: UIColor {
        get {
            return UIColor.black
        }
    }
}
