import UIKit

public extension UINavigationController {
    var rootViewController : UIViewController? {
        return self.viewControllers.first
    }
}
