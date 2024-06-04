//
//  ControllerExtension.swift
//  Product360
//
//  Created by hb on 5/29/21.
//

import UIKit
//import BugfenderSDK
import Photos
import CoreBluetooth

extension UIViewController {
    
    /// A helper function to add child view controller.
    func add(childViewController: UIViewController) {
        childViewController.willMove(toParent: self)
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    class func loadController(fromStoryboard storyboard: UIStoryboard = .main) -> Self {
        return instantiateViewControllerFromStoryBoard(storyboard: storyboard)
    }
    
    private class func instantiateViewControllerFromStoryBoard<T>(storyboard: UIStoryboard) -> T {
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
    
    var isPresented: Bool {
        if self.presentingViewController != nil {
            return true
        } else if self.navigationController?.presentingViewController != nil {
            return true
        } else if self.tabBarController?.presentingViewController != nil {
            return true
        }
        return false
    }
    var isDarkMode:Bool{
        if self.traitCollection.userInterfaceStyle == .dark {
            return true
        } else {
            return false
        }
    }
    
    func showAlert(alertTitle: String, message: String) {
        debugPrint("Show Alert:- \(message)")
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { act in
            guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
            let settingsUrlString = "App-Prefs:root=\(bundleIdentifier)"
            if let settingsUrl = URL(string: settingsUrlString) {
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                }
            }
        })
        alertController.addAction(defaultAction)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            }
        }
        if !self.isPresented{
            self.navigationController?.present(alertController, animated: true)
        }
    }
    
    func repeatAlertEveryTwoSeconds(appDelegate: AppDelegate) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [self] in 
            // Check if Bluetooth alert is already showing or Bluetooth is powered on
            if appDelegate.centralManagerActor.centralManager?.state == CBManagerState.poweredOn {
                // Stop repeating alerts if Bluetooth is powered on
                return
            }
            
            // Show repeating alert
            self.showAlert(alertTitle: BleConstants.kVZBELWantsToTurnOnBluetooth , message: "")
            // Repeat every 2 seconds
            repeatAlertEveryTwoSeconds(appDelegate: appDelegate)
        }
    }
    
//    @IBAction func onTapBack(_ sender: Any) {
//        self.popVC()
//    }
    
    @objc func popVC() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}

public extension UIViewController {
    
    /// : Assign as listener to notification.
    ///
    /// - Parameters:
    ///   - name: notification name.
    ///   - selector: selector to run with notified.
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    /// : Unassign as listener to notification.
    ///
    /// - Parameter name: notification name.
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    /// : Unassign as listener from all notifications.
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
}


public extension UIAlertController {
   
}

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension PHAsset{
    func getAssetThumbnail() -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: self, targetSize: CGSize(width: 300.0, height: 300.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
extension UIImage{
    
    func imageEncodeToData()->String{
        let imageData: Data? = self.jpegData(compressionQuality: 0.4)
        return imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
    }
    
    func saveImageToDocumentDirectory(_ name:String) -> String {
        let directoryPath =  NSHomeDirectory().appending("/Documents/")
        if !FileManager.default.fileExists(atPath: directoryPath) {
            do {
                try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
        let filepath = directoryPath.appending(name)
        let url = NSURL.fileURL(withPath: filepath)
        do {
            try self.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
            return String.init("/Documents/\(name)")
            
        } catch {
            print(error)
            print("file cant not be save at path \(filepath), with error : \(error)");
            return filepath
        }
    }
    
}
enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}


@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.darkGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
//    @IBInspectable var borderWidthtf: CGFloat = 0.0{
//        didSet{
//            self.layer.borderWidth = borderWidthtf
//        }
//    }
//    @IBInspectable var borderColortf: UIColor = UIColor.clear{
//        didSet{
//            self.layer.borderColor = borderColortf.cgColor
//        }
//    }
}
