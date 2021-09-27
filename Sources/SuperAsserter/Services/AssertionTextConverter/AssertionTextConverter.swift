//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 25.09.2021.
//

import Foundation

protocol AssertionTextConverting {
    func getDisplayMessage() -> NSAttributedString
}

protocol AttributedStringRepresentable {
    var attributedString: NSAttributedString { get }
}

final class AssertionTextConverter {
    // MARK: Properties
    private let assertion: Assertion
    private lazy var convertedPayload: [String: String]? = {
         convertPayload()
    }()
    private lazy var components: [AttributedStringRepresentable] = {
        makeRepresentableComponents()
    }()
    
    private var newLine: NSMutableAttributedString {
        NSMutableAttributedString(string: "\n")
    }
    
    // MARK: Dependencies
    private lazy var encoder: JSONEncoder = {
        JSONEncoder()
    }()
    
    // MARK: Initializers
    init(
        assertion: Assertion
    ) {
        self.assertion = assertion
    }
    
    // MARK: Support
    private func convertPayload() -> [String: String]? {
        guard let payload = assertion.payload else {
            return nil
        }
        
        var output = [String: String]()
        for (key, value) in payload {
            if let string = value as? String {
                output[key] = "\"" + string + "\""
            } else if let int = value as? Int {
                output[key] = String(int)
            } else if let strArray = value as? [String] {
                output[key] = strArray
                    .joined(separator: ",\n")
            } else if let intArray = value as? [Int] {
                output[key] = intArray
                    .map { String($0) }
                    .joined(separator: ",\n")
            } else if let bool = value as? Bool {
                output[key] = bool.description
            } else {
                assertionFailure("Unsupported payload value type")
            }
        }
        
        return output
    }
    private func makeRepresentableComponents() -> [AttributedStringRepresentable] {
        var components = [AttributedStringRepresentable]()
        
        // Identity
        components.append(
            SectionSeparator()
        )
        
        components.append(
            TitledParagraph(
                title: "label",
                body: assertion.label
            )
        )
        if let message = assertion.message {
            components.append(
                TitledParagraph(
                    title: "message",
                    body: message
                )
            )
        }
        
        // Location
        components.append(
            SectionSeparator()
        )
        
        components.append(
            TitledParagraph(
                title: "function",
                body: assertion.function
            )
        )
        components.append(
            TitledParagraph(
                title: "file",
                body: assertion.fileID
            )
        )
        components.append(
            TitledParagraph(
                title: "line",
                body: String(assertion.line)
            )
        )
        
        guard let payload = convertedPayload else {
            return components
        }
        
        // Payload
        components.append(
            SectionSeparator()
        )
        
        let sortedKeys = payload.keys.sorted()
        for key in sortedKeys {
            components.append(
                TitledParagraph(
                    title: key,
                    body: payload[key]!
                )
            )
        }
        
        return components
    }
}

// MARK: - AssertionTextConverting
extension AssertionTextConverter: AssertionTextConverting {
    // MARK: Interface
    func getDisplayMessage() -> NSAttributedString {
        let output = NSMutableAttributedString()
        
        for component in components {
            output.append(component.attributedString)
            output.append(newLine)
            output.append(newLine)
        }
        
        return output
    }
}
