import AppFoundation
import RxSwift

enum FourthSegues: String {
    case nextScreen
}

struct FourthViewModel {
    let events: PublishSubject<FoundationEvent> = PublishSubject<FoundationEvent>()
    let state: BehaviorSubject<FourthState> = BehaviorSubject(value: FourthState(labelValue: "Fourth"))
}

extension FourthViewModel: ViewModel {
    func collectIntents(intents: FourthIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            Observable.just("Fourth state").subscribe(onNext: { value in
                self.nextState { oldState in oldState.labelValue = value }
            }),
            intents.next.subscribe(onNext: {
                self.navigatePerformSegue(segueIdentifier: FourthSegues.nextScreen)
            })
        ])
    }
}
