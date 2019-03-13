import UIKit
import RxCocoa
import RxSwift

public protocol ViewModel {
    associatedtype State
    associatedtype Intents
    var events: PublishRelay<FoundationEvent> { get }
    var state: BehaviorRelay<State> { get }
    func collectIntents(intents: Intents) -> CompositeDisposable
}

public extension ViewModel {
    func nextState(_ stateModification: (inout State) -> ()) {
        var modifiableState = state.value
        stateModification(&modifiableState)
        state.accept(modifiableState)
    }

    func navigatePerformSegue<T: RawRepresentable>(
        segueIdentifier: T,
        parameter: SegueParameter? = nil
    ) where T.RawValue == SegueIdentifier {
        events.accept(performSegueNavigationEvent(segueIdentifier, parameter: parameter))
    }

    fileprivate func performSegueNavigationEvent<T: RawRepresentable>(
        _ segueIdentifier: T,
        parameter: SegueParameter?
    ) -> NavigationEvent where T.RawValue == SegueIdentifier {
        return NavigationEvent.performSegue(segueIdentifier.rawValue, parameter)
    }

    func dismiss(animated: Animated = true) {
        events.accept(NavigationEvent.dismiss(animated))
    }

    func navigateBack(animated: Animated = true, popDepth: PopDepth = 1) {
        events.accept(NavigationEvent.pop(animated, popDepth))
    }

    func switchStoryboard(
        storyboardName: StoryboardName,
        viewControllerId: ViewControllerId,
        parameter: SegueParameter? = nil
    ) {
        events.accept(
            NavigationEvent.switchStoryboard(storyboardName, viewControllerId, parameter)
        )
    }
}

public protocol ViewModelProvider {
    associatedtype VM: ViewModel
    func provide() -> VM
}

public protocol Screen : PrepareForSegue {
    associatedtype State
    associatedtype Intents
    var disposeBag: DisposeBag { get }
    var coordinator: Coordinator! { get set }
    var intents: Intents { get }
    func render(state: State)
    func handleEvent(event: FoundationEvent)
}

public extension Screen {
    var segueHandler: SegueHandler? { return coordinator }

    func handleEvent(event: FoundationEvent) {}
}

public protocol FoundationEvent {}

public struct None : FoundationEvent, Equatable {}
