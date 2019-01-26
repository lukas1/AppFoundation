import UIKit
import AppFoundation

struct ThirdCoordinator : VMMCoordinator {
    let viewController: Weak<ThirdViewController>
    let thirdScreenText: String
    
    init(viewController: ThirdViewController, thirdScreenText: String) {
        self.viewController = asWeak(value: viewController)
        self.thirdScreenText = thirdScreenText
    }
}

extension ThirdCoordinator : SegueHandler {
    func coordinator(for segue: UIStoryboardSegue, sender: Any?) -> Coordinator? { return nil }

    func coordinator(for viewController: UIViewController, sender: Any?) -> Coordinator? {
        switch viewController {
        case is UINavigationController:
            return ((viewController as? UINavigationController)?
                .rootViewController as? FourthViewController
            ).map { FourthCoordinator(viewController: $0) }
        default:
            return nil
        }
    }
}

extension String: IsAnyEquatable {}
