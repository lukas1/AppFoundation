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

public typealias Animated = Bool
public typealias SegueIdentifier = String
public typealias SegueParameter = AnyEquatable
public typealias StoryboardName = String
public typealias ViewControllerId = String

public enum NavigationEvent: FoundationEvent, Equatable {
    case performSegue(SegueIdentifier, SegueParameter?)
    case dismiss(Animated)
    case pop(Animated)
    case switchStoryboard(StoryboardName, ViewControllerId)
}

public protocol NavigationEventHandler {
    func handleNavigationEvent(navigationEvent: NavigationEvent, viewController: UIViewController)
}
