import RxSwift
import UIKit

public protocol Coordinator : SegueHandler, NavigationEventHandler {
    func setup()
}

public extension Coordinator {
    func handleNavigationEvent(navigationEvent: NavigationEvent, viewController: UIViewController) {
        switch navigationEvent {
        case let .performSegue(segueIdentifier, parameter):
            viewController.performSegue(
                withIdentifier: segueIdentifier, sender: parameter ?? viewController
            )
        case let .dismiss(animated): viewController.dismiss(animated: animated)
        case let .dismissWithResult(animated, result):
            viewController.dismiss(animated: animated) {
                (viewController as? ResultProviderViewController)?
                    .resultListener
                    .publishResult(result)
            }
        case let .pop(animated): viewController.navigationController?.popViewController(animated: animated)
        case let .switchStoryboard(name, storyboardId, parameter):
            let storyboard = UIStoryboard(name: name, bundle: nil)
            let initialViewController = storyboard.instantiateViewController(
                withIdentifier: storyboardId
            )
            coordinator(for: initialViewController, sender: parameter ?? viewController)?.setup()
            UIView.transition(
                with: UIApplication.shared.keyWindow!,
                duration: 0.25, options: .transitionCrossDissolve,
                animations: {
                    UIApplication.shared.keyWindow?.rootViewController = initialViewController
                }
            )
        }
    }
}

public protocol VMMCoordinator : Coordinator, ViewModelProvider {
    associatedtype VC where VC: UIViewController, VC: Screen, VC.State == VM.State, VC.Intents == VM.Intents

    var viewController: Weak<VC> { get }
}

public extension VMMCoordinator {
    func setup() {
        guard var myViewController = viewController.value else { return nil! }
        let model = provide()

        myViewController.rx.viewDidLoad.asObservable()
            .subscribe(onNext: { [weak myViewController, model] in
                guard let vc = myViewController else { return }
                model.events
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { [weak myViewController] event in
                        if let navigation = event as? NavigationEvent {
                            myViewController.map { self.handleNavigationEvent(navigationEvent: navigation, viewController: $0) }
                        } else {
                            myViewController?.handleEvent(event: event)
                        }
                    })
                    .disposed(by: vc.disposeBag)
                model.state
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { [weak myViewController] in myViewController?.render(state: $0) }).disposed(by: vc.disposeBag)
                model.collectIntents(intents: vc.intents).disposed(by: vc.disposeBag)
            })
            .disposed(by: myViewController.disposeBag)

        myViewController.coordinator = self
    }
}
