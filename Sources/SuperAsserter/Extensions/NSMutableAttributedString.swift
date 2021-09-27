//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 26.09.2021.
//

import Foundation
import CoreData

extension NSMutableAttributedString {
    func setAttributes(_ attributes: [NSAttributedString.Key : Any]?) {
        let nsString = NSString(string: string)
        let range = NSRange(location: 0, length: nsString.length)
        setAttributes(attributes, range: range)
    }
}
