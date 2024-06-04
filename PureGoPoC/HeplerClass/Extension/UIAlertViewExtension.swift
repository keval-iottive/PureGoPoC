//
//  UIAlertViewExtension.swift
//  Cool up
//
//  Created by Iottive Macbook Pro on 06/07/22.
//

import UIKit
//import BugfenderSDK
let AppName:String = "Vzbel"

func showAlert( title: String? = AppName, message: String?, cancelButtonTitle: String? = nil, OkButtonTitle: String? = "OK", completionHandler: ((Int) -> Void)? = nil) {
    let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    if let cancelTitle = cancelButtonTitle {
        alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: { (_) in
            if let completion = completionHandler {
                completion(0)
            }
        }))
    }
    if let okTitle = OkButtonTitle {
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (_) in
            if let completion = completionHandler {

                completion(1)
            }
        }))
    }

    DispatchQueue.main.async {
        Constants.key?.rootViewController?.present(alert, animated: true)
    }
 
}


extension UIAlertController {
    @discardableResult
    class func showAlertC( title: String? = AppName, message: String?, cancelButtonTitle: String? = nil, OkButtonTitle: String? = "OK", completionHandler: ((Int) -> Void)? = nil) -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let cancelTitle = cancelButtonTitle {
            alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: { (_) in
                if let completion = completionHandler {
                    completion(0)
                }
            }))
        }
        if let okTitle = OkButtonTitle {
            alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (_) in
                if let completion = completionHandler {
                    
                    completion(1)
                }
            }))
        }
        DispatchQueue.main.async {
            Constants.key?.rootViewController?.present(alert, animated: true)
        }
        
     
        return alert
    }
    
    class func showActionSheetFor(_ viewcontroller: UIViewController, sender: UIButton? = nil, _ title: String?, _ alertActions: [String], and cancelButtonTitle: String, completionHandler: ((Int) -> Void)? = nil) {
        viewcontroller.view.endEditing(true)
        let optionMenu = UIAlertController(title: nil, message: title, preferredStyle: .actionSheet)
        for strOption in alertActions {
            let action = UIAlertAction(title: strOption, style: .default, handler: { (_ alert: UIAlertAction!) -> Void in
                completionHandler!(alertActions.firstIndex(of: strOption)!)
            })
            optionMenu.addAction(action)
        }
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { (_ alert: UIAlertAction!) -> Void in
            completionHandler!(-1)
        })
        optionMenu.addAction(cancelAction)
        if let popoverController = optionMenu.popoverPresentationController, let sender = sender {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        viewcontroller.present(optionMenu, animated: true, completion: nil)
    }
}
