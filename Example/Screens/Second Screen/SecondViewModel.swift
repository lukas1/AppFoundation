import RxSwift
import AppFoundation
import RxCocoa

struct SecondViewModel {
    fileprivate let dependency: SecDep
    let events: PublishRelay<FoundationEvent> = PublishRelay<FoundationEvent>()
    let state: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}

extension SecondViewModel : ViewModel {
    func collectIntents(intents: SecondIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            intents.buttonClicks.subscribe(onNext: { self.navigatePerformSegue(segueIdentifier: SecondCoordinatorSegues.second) }),
            Single.just(dependency.dependencyValue).subscribe(onSuccess: { self.state.accept($0) })
        ])
    }
}

extension SecondCoordinator : ViewModelProvider, SecDepProvider {
    func provide() -> SecondViewModel {
        return SecondViewModel(dependency: secDep)
    }
}
