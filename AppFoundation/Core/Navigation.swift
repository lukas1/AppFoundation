import UIKit

public protocol SegueHandler {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func coordinator(for segue: UIStoryboardSegue, sender: Any?) -> Coordinator?
    func coordinator(for viewController: UIViewController, sender: Any?) -> Coordinator?
}

public extension SegueHandler {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultListener = segue.source as? ResultListener {
            (segue.destination as? ResultProviderViewController)?
                .resultListener = resultListener
        }
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
public typealias PopDepth = Int
public typealias SegueIdentifier = String
public typealias SegueParameter = AnyEquatable
public typealias StoryboardName = String
public typealias ViewControllerId = String

public enum NavigationEvent: FoundationEvent, Equatable {
    case performSegue(SegueIdentifier, SegueParameter?)
    case dismiss(Animated)
    case dismissWithResult(Animated, SegueParameter)
    case pop(Animated, PopDepth)
    case switchStoryboard(StoryboardName, ViewControllerId, SegueParameter?)
}

public protocol NavigationEventHandler {
    func handleNavigationEvent(navigationEvent: NavigationEvent, viewController: UIViewController)
}
