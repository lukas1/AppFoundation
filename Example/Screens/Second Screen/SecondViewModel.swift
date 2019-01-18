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
        let asyncSingle = Single.just(())
            .delay(5, scheduler: Schedulers.defaultConcurrentScheduler)
        return CompositeDisposable(disposables: [
            intents.buttonClicks.subscribe(onNext: { self.navigatePerformSegue(segueIdentifier: SecondCoordinatorSegues.second) }),
            intents.loadingCallClicks
                .flatMap { _ in
                    asyncSingle
                        .withLoading(events: self.events)
                        .asDriver(onErrorJustReturn: ())
                }.drive(),
            intents.safeAsyncClicks
                .flatMap { _ in
                    asyncSingle
                        .map { _ in throw CoreExceptions.errorUnexpected("test") }
                        .safeAsync(events: self.events)
                }.drive(),
            Single.just(dependency.dependencyValue).subscribe(onSuccess: { self.state.accept($0) })
        ])
    }
}

extension SecondCoordinator : ViewModelProvider, SecDepProvider {
    func provide() -> SecondViewModel {
        return SecondViewModel(dependency: secDep)
    }
}
