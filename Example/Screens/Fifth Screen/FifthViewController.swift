import AppFoundation
import RxSwift
import UIKit

class FifthViewController: UIViewController {
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!
    @IBOutlet weak var dismissButton: UIButton!
}

extension FifthViewController: Screen {
    var intents: FifthIntents {
        return FifthIntents(dismiss: dismissButton.rx.tap.asDriver())
    }

    func render(state: String) {}
}
