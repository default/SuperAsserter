//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 26.09.2021.
//

import Foundation

extension AssertionTextConverter {
    struct SectionSeparator: AttributedStringRepresentable {
        // MARK: Properties
        var attributedString: NSAttributedString {
            NSMutableAttributedString(string: "")
        }
    }
}
