//
//  Assertion.swift
//  
//
//  Created by Nikita Mikheev on 24.09.2021.
//

import Foundation

public struct Assertion {
    // MARK: Properties
    public let level: AssertionLevel
    public let label: String
    public let message: String?
    
    public let function: String
    public let fileID: String
    public let line: Int

    public let payload: [String: Any]?
    
    // MARK: Initializers
    public init(
        level: AssertionLevel,
        label: String,
        message: String? = nil,
        
        function: String,
        fileID: String,
        line: Int,
        
        payload: [String: Any]? = nil
    ) {
        self.level = level
        self.label = label
        self.message = message
        
        self.function = function
        self.fileID = fileID
        self.line = line
        
        self.payload = payload
    }
}
