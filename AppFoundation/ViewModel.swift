import UIKit
import RxSwift

public protocol ViewModel {
    associatedtype State
    associatedtype Intents
    var events: PublishSubject<FoundationEvent> { get }
    var state: BehaviorSubject<State> { get }
    func colectIntents(intents: Intents) -> CompositeDisposable
}

public extension ViewModel {
    func nextState(_ stateModification: (inout State) -> ()) {
        var modifiableState = try! state.value()
        stateModification(&modifiableState)
        state.onNext(modifiableState)
    }

    func navigatePerformSegue<T: RawRepresentable>(segueIdentifier: T) where T.RawValue == String {
        events.onNext(performSegueNavigationEvent(segueIdentifier))
    }

    fileprivate func performSegueNavigationEvent<T: RawRepresentable>(_ segueIdentifier: T) -> NavigationEvent where T.RawValue == String {
        return NavigationEvent.performSegue(segueIdentifier.rawValue)
    }

    func navigateBack() {
        events.onNext(NavigationEvent.pop(true))
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

public struct None : FoundationEvent {}
