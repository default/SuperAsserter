//
//  AssertionManager.swift
//  
//
//  Created by Nikita Mikheev on 24.09.2021.
//

import UIKit

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
    private let application: UIApplication
    
    private var resignedKeyWidnow: UIWindow!
    private var presentedWidnow: UIWindow!
    
    // MARK: Initializers
    init(
        assertion: Assertion,
        app: UIApplication
    ) {
        self.assertion = assertion
        self.application = app
    }
}

// MARK: - WindowManaging
extension AssertionManager: AssertionManaging {
    func launch() {
        guard let applicationWidnow = application.keyWindow else {
            assertionFailure("Asserted application does not have a keyWindow!")
            return
        }
        resignedKeyWidnow = applicationWidnow
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let controller = AssertionController(assertion: assertion)
        controller.delegate = self
        window.rootViewController = controller
        window.makeKeyAndVisible()
        presentedWidnow = window
    }
}

// MARK: - AssertionControllerDelegate
extension AssertionManager: AssertionControllerDelegate {
    func didUserProceed() {
        guard let window = presentedWidnow else {
            return
        }
        
        resignedKeyWidnow?.makeKeyAndVisible()
        
        window.resignKey()
        window.isHidden = true
        
        self.resignedKeyWidnow = nil
        self.presentedWidnow = nil
    }
}
