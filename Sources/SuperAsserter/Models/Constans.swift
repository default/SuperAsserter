//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 26.09.2021.
//

import UIKit

struct Constant { }

// MARK: - Colors
typealias Color = Constant.Color
extension Constant {
    struct Color {
        static var grayText: UIColor { UIColor(hex: 0xA8ABBA) }
        static var mainText: UIColor { UIColor(hex: 0x000A1F) }
        
        static var criticalRed: UIColor { UIColor(hex: 0xE53217) }
        static var importantOrange: UIColor { UIColor(hex: 0xE58F17) }
        static var handledBlue: UIColor { UIColor(hex: 0x176DE5) }
    }
}

// MARK: - Fonts
typealias Font = Constant.Font
extension Constant {
    struct Font {
        static func menlo(_ size: CGFloat) -> UIFont {
            UIFont(name: "Menlo-Bold", size: size)!
        }
    }
}
