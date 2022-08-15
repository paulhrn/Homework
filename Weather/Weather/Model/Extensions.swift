//
//  Extensions.swift
//  Simple Weather
//
//  Created by p h on 10.08.2022.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
        func capitalizingFirstLetter() -> String {
          return prefix(1).uppercased() + self.lowercased().dropFirst()
        }

        mutating func capitalizeFirstLetter() {
          self = self.capitalizingFirstLetter()
        }
}

extension UILabel {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}
extension UIButton {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
   }
}
