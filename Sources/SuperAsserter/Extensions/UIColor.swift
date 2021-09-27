//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 26.09.2021.
//

import UIKit

extension UIColor {
    convenience init(hex rgbValue: Int) {
        self.init(
            red: CGFloat((Float((rgbValue & 0xff0000) >> 16)) / 255.0),
            green: CGFloat((Float((rgbValue & 0x00ff00) >> 8)) / 255.0),
            blue: CGFloat((Float((rgbValue & 0x0000ff) >> 0)) / 255.0),
            alpha: 1.0
        )
    }
}
