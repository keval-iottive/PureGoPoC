//
//  Utilites.swift
//  IotApp
//
//  Created by Dipti Rami on 30/05/24.
//

import Foundation
import SwiftUI

protocol ViewStyle { }
extension UIView: ViewStyle { }

struct FontUtilities {
    static let kAvenirRoman = "Avenir-Roman"
    static let kAvenirBlack = "Avenir-Black"
    static let kAvenirBook = "Avenir-Book"
    static let kAvenirMedium = "Avenir-Medium"
    static let kAvenirLight = "Avenir-Light"
    static let kAvenirHeavy = "Avenir-Heavy"
}

struct ImageUtilites {
    static let ksettings = "settings"
}

struct ColorUtilities {
    static let kButtonBG = "4A5BDC"
}

func writeTotalUsage() -> Data {
    var data = Data.init()
    data = Data(hexString: BLEConstants.kGenericAccessCommand) ?? data
    return data
}

func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

extension Color {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


func openAppOrSystemSettingsAlert(title: String, message: String) {
    let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    alertController.addAction(settingsAction)
    DispatchQueue.main.async {
        Constants.key?.rootViewController?.present(alertController, animated: true)
    }
}


extension ViewStyle where Self: UIView {
    
    @discardableResult func setRound() -> Self {
        self.layer.cornerRadius = self.frame.size.height / 2.0
        self.clipsToBounds = true
        return self
    }
    
    @discardableResult func cornerRadius(cornerRadius: CGFloat,clips: Bool = true) -> Self {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clips
        return self
    }
    
    
    @discardableResult func borderColor(color: UIColor, borderWidth: CGFloat = 1.0) -> Self {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult func shadow(color: UIColor = UIColor.black, shadowOffset : CGSize = CGSize(width: 1.0, height: 1.0) , shadowOpacity : Float = 0.7, shadowRadious : CGFloat = 2) -> Self {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = false
        return self
    }
    
    @discardableResult func backGroundColor(color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
}

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat, text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: self.textColor ?? UIColor.black, // Use the label's text color
            .font: self.font ?? UIFont.systemFont(ofSize: 17) // Use the label's font
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.addSubview(paddingView)
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: self.frame.size.width - amount, y: 0, width: amount, height: self.frame.size.height))
        self.addSubview(paddingView)
    }
    
    func setBothPadding(_ label: UILabel, left: CGFloat, right: CGFloat) {
        label.setLeftPaddingPoints(left)
        label.setRightPaddingPoints(right)
    }
}
