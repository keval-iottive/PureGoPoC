//
//  AppDelegateExtension.swift
//  Product360
//
//  Created by hb on 5/29/21.
//

import UIKit
//import BugfenderSDK

extension UIApplication {
  
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension AppDelegate {
    class var sharedInstance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

}
