import UIKit

public protocol SegueHandler {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func coordinator(for segue: UIStoryboardSegue, sender: Any?) -> Coordinator?
    func coordinator(for viewController: UIViewController, sender: Any?) -> Coordinator?
}

public extension SegueHandler {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        coordinator(for: segue, sender: sender)?.setup()
    }

    func coordinator(for viewController: UIViewController, sender: Any?) -> Coordinator? {
        return nil
    }
}

public protocol PrepareForSegue {
    var segueHandler: SegueHandler? { get }
}

public enum NavigationEvent: FoundationEvent, Equatable {
    case performSegue(String) // identifier
    case pop(Bool) // animated
    case switchStoryboard(String, String) // storyboard name, ViewController's storyboard ID
}

public protocol NavigationEventHandler {
    func handleNavigationEvent(navigationEvent: NavigationEvent, viewController: UIViewController)
}
