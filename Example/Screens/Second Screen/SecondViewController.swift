import UIKit
import RxSwift
import RxCocoa
import AppFoundation

final class SecondViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!
}

extension SecondViewController: Screen {
    var intents: SecondIntents {
        return SecondIntents(buttonClicks: button!.rx.tap.asObservable())
    }

    func render(state: String) {
        testLabel.text = state
    }
}
