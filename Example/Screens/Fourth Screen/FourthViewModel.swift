import AppFoundation
import RxCocoa
import RxSwift

enum FourthSegues: String {
    case nextScreen
    case modal
}

struct FourthViewModel {
    let events: PublishRelay<FoundationEvent> = PublishRelay<FoundationEvent>()
    let state: BehaviorRelay<FourthState> = BehaviorRelay(value: FourthState(labelValue: "Fourth"))
}

extension FourthViewModel: ViewModel {
    func collectIntents(intents: FourthIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            Observable.just("Fourth state").subscribe(onNext: { value in
                self.nextState { oldState in oldState.labelValue = value }
            }),
            intents.next.subscribe(onNext: {
                self.navigatePerformSegue(segueIdentifier: FourthSegues.nextScreen)
            }),
            intents.present
                .do(onNext: { self.navigatePerformSegue(segueIdentifier: FourthSegues.modal) })
                .drive()
        ])
    }
}
