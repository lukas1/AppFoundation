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

    func navigatePerformSegue<T: RawRepresentable>(segueIdentifier: T) where T.RawValue == String {
        events.accept(performSegueNavigationEvent(segueIdentifier))
    }

    fileprivate func performSegueNavigationEvent<T: RawRepresentable>(_ segueIdentifier: T) -> NavigationEvent where T.RawValue == String {
        return NavigationEvent.performSegue(segueIdentifier.rawValue)
    }

    func navigateBack() {
        events.accept(NavigationEvent.pop(true))
    }

    func switchStoryboard(storyboardName: String, viewControllerId: String) {
        events.accept(NavigationEvent.switchStoryboard(storyboardName, viewControllerId))
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
