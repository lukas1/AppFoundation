import AppFoundation
import RxCocoa
import RxSwift

struct FifthViewModel {
    let events: PublishRelay<FoundationEvent> = PublishRelay<FoundationEvent>()
    let state: BehaviorRelay<String> = BehaviorRelay(value: "")
}

extension FifthViewModel: ViewModel {
    func collectIntents(intents: FifthIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            intents.dismiss
                .do(onNext: { self.dismiss() })
                .drive()
        ])
    }
}
