//
//  UIAlertController+TextAlignment.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 29/06/2024.
//

import UIKit

public extension UIAlertController {

    func setMessageAlignment(_ alignment : NSTextAlignment, textColor: UIColor = .gray, font: UIFont = UIFont.systemFont(ofSize: 14)) {
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = alignment

        let messageText = NSMutableAttributedString(
            string: self.message ?? "",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: textColor
            ]
        )

        self.setValue(messageText, forKey: "attributedMessage")
    }
}
