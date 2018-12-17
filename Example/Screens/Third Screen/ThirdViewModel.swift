import UIKit
import AppFoundation
import RxSwift

struct ThirdViewModel {
    fileprivate let thirdScreenText: String
    let events: PublishSubject<FoundationEvent> = PublishSubject<FoundationEvent>()
    let state: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
}

extension ThirdViewModel : ViewModel {
    func collectIntents(intents: ThirdIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            intents.buttonClicks.subscribe(onNext: { self.navigateBack() }),
            Single.just(thirdScreenText).subscribe(onSuccess: { self.state.onNext($0) })
        ])
    }
}

extension ThirdCoordinator : ViewModelProvider {
    func provide() -> ThirdViewModel {
        return ThirdViewModel(thirdScreenText: thirdScreenText)
    }
}
