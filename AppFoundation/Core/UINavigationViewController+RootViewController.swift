import UIKit

public extension UINavigationController {
    var rootViewController: UIViewController? {
        return self.viewControllers.first
    }

    func typedRootViewController<T: UIViewController>() -> T? {
        return rootViewController as? T
    }
}
