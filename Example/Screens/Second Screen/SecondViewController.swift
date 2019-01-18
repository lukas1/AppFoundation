import UIKit
import RxSwift
import RxCocoa
import AppFoundation

final class SecondViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var loadingCallButton: UIButton!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var safeAsyncCallButton: UIButton!
    
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!
    var callCount: Int = 0
}

extension SecondViewController: Screen {
    var intents: SecondIntents {
        return SecondIntents(
            buttonClicks: button!.rx.tap.asObservable(),
            loadingCallClicks: loadingCallButton.rx.tap.asDriver(),
            safeAsyncClicks: safeAsyncCallButton.rx.tap.asDriver()
        )
    }

    func render(state: String) {
        testLabel.text = state
    }

    func handleEvent(event: FoundationEvent) {
        handleLoadingEvent(event: event)
        handleErrorEvent(event: event)
    }
}

extension SecondViewController: SupportsLoading {
    func showLoading() {
        loadingLabel.isHidden = false
    }

    func hideLoading() {
        loadingLabel.isHidden = true
    }
}

extension SecondViewController: SupportsErrors {}
