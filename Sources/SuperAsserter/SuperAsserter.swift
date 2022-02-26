import UIKit
import WindowInstanceManager

public protocol SuperAsserterProtocol {
    func display(assertion: Assertion, in app: UIApplication)
}

public final class SuperAsserter {
    // MARK: Singleton
    public static var shared: SuperAsserterProtocol = {
        SuperAsserter()
    }()
    
    // MARK: Properties
    private var managers = [AssertionManager]()
    
    // MARK: Initializers
    private init() { }
    
    // MARK: Internal
    private func windowManager(for app: UIApplication) -> WindowInstanceManaging {
        WindowInstanceManager.shared(for: app)
    }
}

// MARK: - SuperAsserterProtocol
extension SuperAsserter: SuperAsserterProtocol {
    public func display(assertion: Assertion, in app: UIApplication) {
        let manager = AssertionManager(
            assertion: assertion,
            windowManager: windowManager(for: app)
        )
        managers.append(manager)
        manager.launch()
    }
}

// MARK: - AssertionManagerDelegate
extension SuperAsserter: AssertionManagerDelegate {
    func didFinish(_ manager: AssertionManager) {
        for index in 0..<managers.count {
            if managers[index] === manager {
                managers.remove(at: index)
                return
            }
        }
    }
}
