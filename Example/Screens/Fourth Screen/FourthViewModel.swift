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
            intents.next.flatMap { _ in
                self.navigatePerformSegueForResult(
                    resultObservable: intents.result, segueIdentifier: FourthSegues.nextScreen
                ).do(onSuccess: { value in
                    self.nextState { newState in
                        newState.labelValue = "Result: \(value)"
                    }
                })
            }.subscribe(),
            intents.present
                .flatMap { _ in
                    self.navigatePerformSegueForResult(
                        resultObservable: intents.result, segueIdentifier: FourthSegues.modal
                    ).do(onSuccess: { value in
                        self.nextState { newState in
                            newState.labelValue = "Result: \(value)"
                        }
                    })
                    .map { _ in () }
                    .asDriver(onErrorJustReturn: ())
                }
                .drive()
        ])
    }
}
