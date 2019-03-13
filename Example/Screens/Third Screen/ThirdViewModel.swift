import UIKit
import AppFoundation
import RxSwift
import RxCocoa

struct ThirdViewModel {
    fileprivate let thirdScreenText: String
    let events: PublishRelay<FoundationEvent> = PublishRelay<FoundationEvent>()
    let state: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}

extension ThirdViewModel : ViewModel {
    func collectIntents(intents: ThirdIntents) -> CompositeDisposable {
        return CompositeDisposable(disposables: [
            intents.buttonClicks.subscribe(onNext: {
                self.switchStoryboard(
                    storyboardName: OtherStoryboard.name,
                    viewControllerId: OtherStoryboard.viewControllerId
                )
            }),
            intents.back.subscribe(onNext: { self.navigateBack() }),
            intents.back2.subscribe(onNext: { self.navigateBack(popDepth: 2) }),
            Single.just(thirdScreenText).subscribe(onSuccess: { self.state.accept($0) })
        ])
    }
}

extension ThirdCoordinator : ViewModelProvider {
    func provide() -> ThirdViewModel {
        return ThirdViewModel(thirdScreenText: thirdScreenText)
    }
}
