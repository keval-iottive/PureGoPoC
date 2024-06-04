//
//  File.swift
//  AlertifyreApp
//
//  Created by Prachi on 21/02/24.
//

import Foundation
import UIKit

extension UIFont {
    
    enum FontType: String {
        case light                   = "AirbnbCerealWLt"
        case medium                  = "AirbnbCerealWMd"
        case extraBold               = "AirbnbCerealWXBd"
        case bold                    = "AirbnbCerealWBd"
        case boldItalic              = "AirbnbCerealWBlk"
        case regular                 = "AirbnbCerealWBk"
    }
    
    /// Set custom font
    /// - Parameters:
    ///   - type: Font type.
    ///   - size: Size of font.
    ///   - isRatio: Whether set font size ratio or not. Default true.
    /// - Returns: Return font.
    class func customFont(ofType type: FontType, withSize size: CGFloat, enableAspectRatio isRatio: Bool = true) -> UIFont {
        return UIFont(name: type.rawValue, size: isRatio ? size * ScreenSize.fontAspectRatio : size) ?? UIFont.systemFont(ofSize: size)
    }
}


//MARK: - screensize
struct ScreenSize {
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var heightAspectRatio: CGFloat {
        return UIScreen.main.bounds.size.height / 667
    }
    
    static var widthAspectRatio: CGFloat {
        return UIScreen.main.bounds.size.width / 375
    }
    
    static var fontAspectRatio : CGFloat {
        if UIDevice().userInterfaceIdiom == .pad {
            return UIScreen.main.bounds.size.height / 667
        }
        
        let size = UIScreen.main.bounds.size
        
        if UIApplication.shared.statusBarOrientation.isPortrait {//Potrait
            return UIScreen.main.bounds.size.width / 375
            
        } else {//Landscape
            return UIScreen.main.bounds.size.height / 375
        }
    }
    
    static var cornerRadious: CGFloat {
        return 10
    }
}
