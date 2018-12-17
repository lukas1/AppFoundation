import UIKit
import AppFoundation

struct FirstCoordinator: VMMCoordinator {
    let viewController: Weak<FirstViewController>
    
    init(viewController: FirstViewController) {
        self.viewController = asWeak(value: viewController)
    }
}

extension FirstCoordinator : SegueHandler {
    func coordinator(for segue: UIStoryboardSegue, sender: Any?) -> Coordinator? {
        switch segue.identifier ?? "" {
        case FirstCoordinatorSegues.first.rawValue: return SecondCoordinator(viewController: segue.destination())
        default: return nil
        }
    }
}
