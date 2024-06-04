//
//  DateExtension.swift
//  Product360
//
//  Created by hb on 6/2/21.
//

import UIKit
//import BugfenderSDK

struct DateFormat {
    static let date = "dd-MMM-yyyy"
    static let DateOfBirth = "dd MMM yyyy"
    static let DateOfBirthSort = "dd MMM"
    static let filterDate = "dd/MMM/yyyy"
    static let GameTime = "dd.MMM.yyyy, HH:mm"
}

extension Date {
    
    func getDateInUtcFormate(_ formate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let myStringafd = formatter.string(from: self)
        print(myStringafd)
        return myStringafd
    }
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    func dateToString( format: String = "yyyy-MM-dd HH:mm") -> String? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.timeZone = TimeZone.current
       // dateFormat.locale = Locale.current
        return dateFormat.string(from: self)
    }
    
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    func monthName() -> String {
              let df = DateFormatter()
              df.setLocalizedDateFormatFromTemplate("MMMM")
              return df.string(from: self)
      }
    
    func getMonth()->Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return Int(dateFormatter.string(from: self))!
    }
    
    func getYear()->Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return Int(dateFormatter.string(from: self))!
    }
    
    func getDate()->Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return Int(dateFormatter.string(from: self))!
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
   
}
extension String{
    func StringToDate(format: String = "yyyy-MM-dd") -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.timeZone = TimeZone.current
    //    dateFormat.locale = Locale.current
        return dateFormat.date(from: self) ?? Date()
    }
}
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
