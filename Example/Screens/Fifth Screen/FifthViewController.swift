import AppFoundation
import RxSwift
import UIKit

class FifthViewController: UIViewController {
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!
    var resultListener: ResultListener!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var dismissWithResultButton: UIButton!
}

extension FifthViewController: Screen {
    var intents: FifthIntents {
        return FifthIntents(
            dismiss: dismissButton.rx.tap.asDriver(),
            dismissWithResult: dismissWithResultButton.rx.tap.asDriver()
        )
    }

    func render(state: String) {}
}

extension FifthViewController: ResultProviderViewController {}
