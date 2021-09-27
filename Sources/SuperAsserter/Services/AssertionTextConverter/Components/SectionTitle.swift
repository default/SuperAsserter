//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 26.09.2021.
//

import Foundation

extension AssertionTextConverter {
    struct SectionTitle: AttributedStringRepresentable {
        // MARK: Properties
        let title: String
        
        var attributedString: NSAttributedString {
            let attributedTitle = NSMutableAttributedString(string: title.uppercased())
            attributedTitle.setAttributes([
                .font: Font.menlo(20),
                .foregroundColor: Color.grayText
            ])
            
            let output = newLine
            output.append(attributedTitle)
            
            return output
        }
        
        // MARK: Support
        private var newLine: NSMutableAttributedString {
            NSMutableAttributedString(string: "\n")
        }
    }
}
