//
//  AssertionLevel.swift
//  
//
//  Created by Nikita Mikheev on 24.09.2021.
//

import Foundation

public enum AssertionLevel  {
    
    case critical
    case important
    case handled
    
    var name: String {
        String(describing: self).capitalized
    }
}
