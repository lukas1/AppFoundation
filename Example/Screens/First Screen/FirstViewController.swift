import UIKit
import RxSwift
import RxCocoa
import AppFoundation

final class FirstViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var random: UIButton!
    @IBOutlet weak var randomLabel: UILabel!
    
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!
}

extension FirstViewController : Screen {
    var intents: FirstIntents { return FirstIntents(buttonClicks: button.rx.tap.asObservable(), randomClicks: random.rx.tap.asObservable()) }

    func render(state: FirstState) {
        testLabel.text = state.label
        randomLabel.text = state.random
    }
}
