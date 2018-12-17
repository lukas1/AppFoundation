import UIKit
import AppFoundation

struct SecondCoordinator: VMMCoordinator {
    let viewController: Weak<SecondViewController>
    
    init(viewController: SecondViewController) {
        self.viewController = asWeak(value: viewController)
    }
}

extension SecondCoordinator : SegueHandler {
    func coordinator(for segue: UIStoryboardSegue, sender: Any?) -> Coordinator? {
        switch segue.identifier ?? "" {
        case SecondCoordinatorSegues.second.rawValue: return ThirdCoordinator(viewController: segue.destination(), thirdScreenText: "From Parameter")
        default: return nil
        }
    }
}
