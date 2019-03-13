import UIKit
import RxSwift
import RxCocoa
import AppFoundation

final class ThirdViewController : UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var back2: UIButton!
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!
}

extension ThirdViewController : Screen {
    var intents: ThirdIntents {
        return ThirdIntents(
            buttonClicks: button.rx.tap.asObservable(),
            back: back.rx.tap.asObservable(),
            back2: back2.rx.tap.asObservable()
        )
    }
    func render(state: String) {
        label.text = state
    }
}
