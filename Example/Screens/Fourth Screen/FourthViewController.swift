import AppFoundation
import RxSwift
import UIKit

class FourthViewController: UIViewController {
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backButton: UIButton!
}

extension FourthViewController: Screen {
    var intents: FourthIntents {
        return FourthIntents(next: backButton.rx.tap.asObservable())
    }

    func render(state: FourthState) {
        label.text = state.labelValue
    }
}
