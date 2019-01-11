import UIKit
import RxSwift
import RxCocoa
import AppFoundation

final class FirstViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var random: UIButton!
    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var formButton: UIButton!
    
    let disposeBag: DisposeBag = DisposeBag()
    var coordinator: Coordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.dismissOnReturn()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textField.resignFirstResponder()
    }
}

extension FirstViewController : Screen {
    var intents: FirstIntents {
        return FirstIntents(
            buttonClicks: button.rx.tap.asObservable(),
            randomClicks: random.rx.tap.asObservable(),
            submit: submitObservable(formButton.rx.tap)
        )
    }

    func render(state: FirstState) {
        testLabel.text = state.label
        randomLabel.text = state.random
    }

    func handleEvent(event: FoundationEvent) {
        switch event {
        case is FormErrorEvent: handleFormErrors(event: event)
        default: break
        }
    }
}

extension FirstViewController: FormScreen {
    var form: Form {
        return Form(
            inputMap: [FormInputIds.formInput.rawValue: textField],
            renderErrorForField: { [weak self] _, message in
                let alertController = UIAlertController(
                    title: "Error", message: message, preferredStyle: .alert
                )
                
                alertController.addAction(
                    UIAlertAction(
                        title: "OK",
                        style: .default,
                        handler: nil
                    )
                )
                self?.present(alertController, animated: true, completion: nil)
            }
        )
    }
}
