import AppFoundation
import RxCocoa
import RxSwift

struct SixthViewModel {
    let events: PublishRelay<FoundationEvent> = PublishRelay<FoundationEvent>()
    let state: BehaviorRelay<String> = BehaviorRelay(value: "")
}

extension SixthViewModel: ViewModel {
    func collectIntents(intents: SixthIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            intents.popWithResult
                .do(onNext: { self.popReturningResult(animated: true, result: "Sixth popped") })
                .drive()
            ])
    }
}
