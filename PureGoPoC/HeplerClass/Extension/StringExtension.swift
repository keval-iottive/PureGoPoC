//
//  StringExtension.swift
//  Product360
//
//  Created by hb on 5/29/21.
//

import UIKit
//import BugfenderSDK

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        //text = prospectiveText.substring(to: maxCharIndex)
        text = String(prospectiveText.prefix(upTo: maxCharIndex))
        selectedTextRange = selection
    }
    func validZipCode()->Bool{
        let postalcodeRegex = "^[0-9]{5}(-[0-9]{4})?$"
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", postalcodeRegex)
        let bool = pinPredicate.evaluate(with: self.text) as Bool
        return bool
    }
//    static let emailRegex = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    func addLeftTextPadding(_ blankSize: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    func addLeftIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.frame = frame
        let imgView = UIImageView()
        imgView.frame = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imgView.image = image
        leftView.addSubview(imgView)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    func validateEmail() -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", UITextField.emailRegex)
        return emailTest.evaluate(with: self.text)
    }
    func validateDigits() -> Bool {
        let digitsRegEx = "[0-9]*"
        let digitsTest = NSPredicate(format:"SELF MATCHES %@", digitsRegEx)
        return digitsTest.evaluate(with: self.text)
    }
    
    
    /// Check if text field is empty.
    public var isEmpty: Bool {
        return trimmedText?.isEmpty == true
    }
    
    ///  Return text with no spaces or new lines in beginning and end.
    public var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func checkMinAndMaxLength(withMinLimit minLen: Int, withMaxLimit maxLen: Int) -> Bool {
        if (self.text!.count ) >= minLen && (self.text!.count ) <= maxLen {
            return true
        }
        return false
    }
    enum Direction
    {
        case Left
        case Right
    }
    
    func addImage(direction:Direction,image:UIImage,Frame:CGRect,backgroundColor:UIColor)
    {
        let View = UIView(frame: Frame)
        View.backgroundColor = backgroundColor
        
        let imageView = UIImageView(frame: Frame)
        imageView.image = image
        imageView.contentMode = .center
        View.addSubview(imageView)
        
        if Direction.Left == direction
        {
            self.leftViewMode = .always
            self.leftView = View
        }
        else
        {
            self.rightViewMode = .always
            self.rightView = View
        }
    }

    @IBInspectable var paddingLeftView: CGFloat {
        get {
            //return leftView!.frame.size.width
            //            if (self.isMember(of:UISearchBar.self)) {
            //                return self.leftView?.frame.width ?? 0
            //            }
            return self.leftView?.frame.width ?? 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRightView: CGFloat {
        get {
            //            return rightView!.frame.size.width
            return self.leftView?.frame.width ?? 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

extension CharacterSet {
    static let alphabatsSpace = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ' ")
    static let alphabats = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ")
    static let numbers = CharacterSet(charactersIn: "0123456789")
}


extension String {
    
    func dataToImage() -> UIImage{
        if let decodedData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: decodedData) ?? UIImage()
        }
        return UIImage()
    }
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    func removeFormatAmount() -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.decimalSeparator = ","
        return formatter.number(from: self) as! Double? ?? 0
    }
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        var number: NSNumber!
         
        let formatter = NumberFormatter()
            formatter.numberStyle = .currencyAccounting
            formatter.currencySymbol = "$"
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2

           var amountWithPrefix = self

           // remove from String: "$", ".", ","
           let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
           amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

           let double = (amountWithPrefix as NSString).doubleValue
           number = NSNumber(value: (double / 100))

           // if first number is 0 or all numbers were deleted
           guard number != 0 as NSNumber else {
               return ""
           }

           return formatter.string(from: number)!
    }
    
    var isEmailPhoneNum: Bool {
        return (self.isValidEmail || self.isPhoneNumber)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = self.range(of: emailRegEx, options:.regularExpression)
        return range != nil ? true : false
    }
    
    var isPhoneNumber: Bool {
           return isValidLoginPhone()
       }
    
    func isValidLoginPhone() -> Bool {
            if !isAllDigits { return false}
           // if self.hasPrefix("0") && self.count == 11 { return true }
            return self.count == 10 ||  self.count == 14 || self.count == 12
        }
    
    var isAllDigits: Bool {
            return CharacterSet(charactersIn: self).isSubset(of: CharacterSet.numbers)
        }
    var isAllChar: Bool {
            return CharacterSet(charactersIn: self).isSubset(of: CharacterSet.alphabatsSpace)
        }
    var isPasswordValid: Bool {
//        let passWordRegEx = "^.{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$")
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^.{8,}$")
        return passwordTest.evaluate(with: self)
    }
    
    var isUserNameValid: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count > 5 ? true : false
    }
    var isNameValid: Bool {
        return isAllChar &&  (self.count > 0 ? true : false)
    }
//    var isPhoneNumber: Bool {
//        return self.count > 9 ? true : false
//    }
    func isValidUsername() -> Bool {
            //let userNameRegEx = ".*[^A-Za-z0-9].*"
            let userNameRegEx = "\\w{3,18}"
            let predicate = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
        return predicate.evaluate(with: self)
        }
    func nsRange(from range: Range<Index>) -> NSRange {
        let nsRange = NSRange(range, in: self)
        return nsRange
    }
    
    var dashIfBlank: String {
        return self.isEmpty ? "-" : self
    }
    func setStringAsCardNumberWithSartNumber(Number:Int,withString str:String) -> String{
        let arr = str
        var CrediteCard : String = ""
        let len = str.count-4
        if arr.count > (Number + len) {
            for (index, element ) in arr.enumerated(){
                if index >= Number && index < (Number + len) && element != "-" && element != " " {
                    CrediteCard = CrediteCard + String("X")
                }else{
                    CrediteCard = CrediteCard + String(element)
                }
            }
            return CrediteCard
        }else{
            print("\(Number) plus \(len) are grether than strings chatarter \(arr.count)")
        }
        print("\(CrediteCard)")
        return str
    }
    var withoutSpecialCharacters: String {
        let okayChars = CharacterSet(charactersIn: "1234567890 ")
               return String(self.unicodeScalars.filter { okayChars.contains($0)})
//           return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
       }
    
    func UpdatePriorityViewColor()->UIColor {
        var priorityViewColor = UIColor.black
        if self == "0" {
            priorityViewColor = UIColor.red
            
        } else if self == "1" {
            priorityViewColor = UIColor.yellow
            
        } else if self == "2" {
            priorityViewColor = UIColor.green
        }
        return priorityViewColor
    }
    
   
    
}

extension Collection {
    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence,Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: maxLength, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return self[start..<end]
        }
    }

    func every(n: Int) -> UnfoldSequence<Element,Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer { index = self.index(index, offsetBy: n, limitedBy: endIndex) ?? endIndex }
            return self[index]
        }
    }

    var pairs: [SubSequence] { .init(unfoldSubSequences(limitedTo: 2)) }
}

extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let hexDigits = options.contains(.upperCase) ? "0123456789ABCDEF" : "0123456789abcdef"
        if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            let utf8Digits = Array(hexDigits.utf8)
            return String(unsafeUninitializedCapacity: 2 * self.count) { (ptr) -> Int in
                var p = ptr.baseAddress!
                for byte in self {
                    p[0] = utf8Digits[Int(byte / 16)]
                    p[1] = utf8Digits[Int(byte % 16)]
                    p += 2
                }
                return 2 * self.count
            }
        } else {
            let utf16Digits = Array(hexDigits.utf16)
            var chars: [unichar] = []
            chars.reserveCapacity(2 * self.count)
            for byte in self {
                chars.append(utf16Digits[Int(byte / 16)])
                chars.append(utf16Digits[Int(byte % 16)])
            }
            return String(utf16CodeUnits: chars, count: chars.count)
        }
    }
}


extension StringProtocol {
    var byte: UInt8? { UInt8(self, radix: 16) }
    var hexaToBytes: [UInt8] { unfoldSubSequences(limitedTo: 2).compactMap(\.byte) }
    var hexaToData: Data { .init(hexaToBytes) }
}
extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

extension UIButton {
//    func imageWith(color:UIColor, for: UIControl.State) {
//        if let imageForState = self.image(for: state) {
//            self.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
//            let colorizedImage = imageForState.image(withTintColor: color)
//            self.setImage(colorizedImage, for: state)
//        }
//    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
