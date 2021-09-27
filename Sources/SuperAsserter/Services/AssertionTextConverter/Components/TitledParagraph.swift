//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 26.09.2021.
//

import Foundation

extension AssertionTextConverter {
    struct TitledParagraph: AttributedStringRepresentable {
        // MARK: Properties
        let title: String
        let body: String
        
        var attributedString: NSAttributedString {
            let attributedTitle = NSMutableAttributedString(string: title)
            attributedTitle.setAttributes([
                .font: Font.menlo(14),
                .foregroundColor: Color.grayText
            ])
            
            let attributedBody = NSMutableAttributedString(string: body)
            attributedBody.setAttributes([
                .font: Font.menlo(18),
                .foregroundColor: Color.mainText
            ])
            
            let output = attributedTitle
            output.append(newLine)
            output.append(attributedBody)
            
            return output
        }
        
        // MARK: Support
        private var newLine: NSMutableAttributedString {
            NSMutableAttributedString(string: "\n")
        }
    }
}
