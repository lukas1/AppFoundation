import UIKit

public protocol SegueHandler {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func coordinator(for segue: UIStoryboardSegue, sender: Any?) -> Coordinator?
}

public extension SegueHandler {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        coordinator(for: segue, sender: sender)?.setup()
    }
}

public protocol PrepareForSegue {
    var segueHandler: SegueHandler? { get }
}

public enum NavigationEvent: FoundationEvent, Equatable {
    case performSegue(String) // identifier
    case pop(Bool) // animated
}

public protocol NavigationEventHandler {
    func handleNavigationEvent(navigationEvent: NavigationEvent, viewController: UIViewController)
}
