import RxSwift
import AppFoundation
import RxCocoa

enum FormInputIds: Int {
    case formInput
}

struct FirstViewModel {
    fileprivate let dependency: Dependency
    let events: PublishRelay<FoundationEvent> = PublishRelay<FoundationEvent>()
    let state: BehaviorRelay<FirstState> = BehaviorRelay<FirstState>(value: FirstState(label: "", random: ""))
}

extension FirstViewModel : ViewModel {
    func collectIntents(intents: FirstIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            Single.just(state.value)
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                .subscribe(onSuccess: { prevState in
                    self.nextState {
                        $0.label = self.dependency.dependencyValue
                    }
                }),
            intents.buttonClicks.subscribe(onNext: { self.navigatePerformSegue(segueIdentifier: FirstCoordinatorSegues.first) }),
            intents.randomClicks
                .map { "\(Int.random(in: 0...10))" }
                .subscribe(onNext: { random in
                    self.nextState { $0.random = random }
                }),
            intents.submit
                .filter {
                    $0.validate(
                        validations: [
                            FormInputIds.formInput.rawValue: [
                                NotEmptyValidationRule(errorMessage: "Field cannot be empty")]
                        ],
                        relay: self.events
                    )
                }
                .do(onNext: { _ in
                    self.navigatePerformSegue(segueIdentifier: FirstCoordinatorSegues.first)
                })
                .subscribe()
        ])
    }
}

extension FirstCoordinator : ViewModelProvider, DependencyProvider {
    func provide() -> FirstViewModel { return FirstViewModel(dependency: dependency) }
}
