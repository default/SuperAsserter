//
//  AssertionManager.swift
//  
//
//  Created by Nikita Mikheev on 24.09.2021.
//

import UIKit
import WindowInstanceManager

protocol AssertionManaging {
    func launch()
}

protocol AssertionManagerDelegate: AnyObject {
    func didFinish(_ manager: AssertionManager)
}

final class AssertionManager {
    // MARK: Delegate
    weak var delegate: AssertionManagerDelegate?
    
    // MARK: Properties
    private let assertion: Assertion
    private var window: ManagedWindowReference?
    
    // MARK: Dependencies
    private let windowManager: WindowInstanceManaging
    
    // MARK: Initializers
    init(
        assertion: Assertion,
        windowManager: WindowInstanceManaging
    ) {
        self.assertion = assertion
        self.windowManager = windowManager
    }
}

// MARK: - AssertionManaging
extension AssertionManager: AssertionManaging {
    func launch() {
        let controller = AssertionController(assertion: assertion)
        controller.delegate = self
        
        let window = windowManager.instance(withRoot: controller)
        windowManager.makeKey(window)
        self.window = window
    }
}

// MARK: - AssertionControllerDelegate
extension AssertionManager: AssertionControllerDelegate {
    func didUserProceed() {
        guard let window = window else {
            return
        }
        
        windowManager.resign(window)
        self.window = nil
        
        delegate?.didFinish(self)
    }
}
