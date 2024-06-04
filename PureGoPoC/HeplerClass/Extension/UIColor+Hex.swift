import UIKit
//import BugfenderSDK

extension UIColor {
    
    /// Creates a color from the given hex value.
    ///
    /// - parameter hex: A 6-digit hex value, e.g. 0xff0000.
    ///
    /// - returns: The color corresponding to the given hex value
    convenience init(hex: Int) {
        let r = CGFloat((hex >> 16) & 0xff) / 255.0
        let g = CGFloat((hex >>  8) & 0xff) / 255.0
        let b = CGFloat((hex >>  0) & 0xff) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    convenience init(hexString: String, alpha:CGFloat = 1.0) {
        
        // Convert hex string to an integer
        let hexint = Int().intFromHexString(hexStr: hexString)
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

   
}
extension Int{
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
