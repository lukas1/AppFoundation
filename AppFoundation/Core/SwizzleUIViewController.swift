import UIKit

fileprivate let swizzling: (UIViewController.Type) -> () = { viewController in
    let originalPrepareForSegue = class_getInstanceMethod(viewController, #selector(viewController.prepare(for:sender:)))!
    let swizzledPrepareForSegue = class_getInstanceMethod(viewController, #selector(viewController.swizzledPrepare(for:sender:)))!
    
    method_exchangeImplementations(originalPrepareForSegue, swizzledPrepareForSegue)
}

public extension UIViewController {
    
    static func swizzle() throws {
        guard self === UIViewController.self else { throw CoreExceptions.errorUnexpected("Calling swizzle() only allowed on UIViewController. Calling from \(self).") }
        swizzling(self)
    }
    
    // MARK: - Method Swizzling
    
    @objc func swizzledPrepare(for segue: UIStoryboardSegue, sender: Any?) {
        swizzledPrepare(for: segue, sender: sender)
        
        if let vc = self as? PrepareForSegue {
            vc.segueHandler?.prepare(for: segue, sender: sender)
        }
    }
}
