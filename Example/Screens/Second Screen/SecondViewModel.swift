import RxSwift
import AppFoundation

struct SecondViewModel {
    fileprivate let dependency: SecDep
    let events: PublishSubject<FoundationEvent> = PublishSubject<FoundationEvent>()
    let state: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
}

extension SecondViewModel : ViewModel {
    func collectIntents(intents: SecondIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            intents.buttonClicks.subscribe(onNext: { self.navigatePerformSegue(segueIdentifier: SecondCoordinatorSegues.second) }),
            Single.just(dependency.dependencyValue).subscribe(onSuccess: { self.state.onNext($0) })
        ])
    }
}

extension SecondCoordinator : ViewModelProvider, SecDepProvider {
    func provide() -> SecondViewModel {
        return SecondViewModel(dependency: secDep)
    }
}
