import AppFoundation
import RxSwift
import UIKit

class SixthViewController: UIViewController {
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!
    var resultListener: ResultListener!
    @IBOutlet weak var popWithResultButton: UIButton!
}

extension SixthViewController: Screen {
    var intents: SixthIntents {
        return SixthIntents(
            popWithResult: popWithResultButton.rx.tap.asDriver()
        )
    }

    func render(state: String) {}
}

extension SixthViewController: ResultProviderViewController {}
