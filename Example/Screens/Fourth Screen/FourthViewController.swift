import AppFoundation
import RxCocoa
import RxSwift
import UIKit

class FourthViewController: UIViewController {
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!
    var resultEvent: ResultSingleEvent?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var presentButton: UIButton!
}

extension FourthViewController: Screen {
    var intents: FourthIntents {
        return FourthIntents(
            next: nextButton.rx.tap.asObservable(),
            present: presentButton.rx.tap.asDriver(),
            result: typedResult()
        )
    }

    func render(state: FourthState) {
        label.text = state.labelValue
    }
}

extension FourthViewController: ResultListener {}
