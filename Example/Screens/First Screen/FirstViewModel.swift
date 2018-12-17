import RxSwift
import AppFoundation

struct FirstViewModel {
    fileprivate let dependency: Dependency
    let events: PublishSubject<FoundationEvent> = PublishSubject<FoundationEvent>()
    let state: BehaviorSubject<FirstState> = BehaviorSubject<FirstState>(value: FirstState(label: "", random: ""))
}

extension FirstViewModel : ViewModel {
    func collectIntents(intents: FirstIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            Single.just(try! state.value()).subscribe(onSuccess: { prevState in
                self.nextState {
                    $0.label = self.dependency.dependencyValue
                }
            }),
            intents.buttonClicks.subscribe(onNext: { self.navigatePerformSegue(segueIdentifier: FirstCoordinatorSegues.first) }),
            intents.randomClicks
                .map { "\(Int.random(in: 0...10))" }
                .subscribe(onNext: { random in
                    self.nextState { $0.random = random }
                })
        ])
    }
}

extension FirstCoordinator : ViewModelProvider, DependencyProvider {
    func provide() -> FirstViewModel { return FirstViewModel(dependency: dependency) }
}
