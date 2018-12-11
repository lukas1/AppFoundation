import UIKit

public protocol Coordinator : SegueHandler, NavigationEventHandler {
    func setup()
}

public extension Coordinator {
    func handleNavigationEvent(navigationEvent: NavigationEvent, viewController: UIViewController) {
        switch navigationEvent {
        case let .performSegue(segueIdentifier): viewController.performSegue(withIdentifier: segueIdentifier, sender: viewController)
        case let .pop(animated): viewController.navigationController?.popViewController(animated: animated)
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
                    .subscribe(onNext: { [weak myViewController] event in
                        if let navigation = event as? NavigationEvent {
                            myViewController.map { self.handleNavigationEvent(navigationEvent: navigation, viewController: $0) }
                        } else {
                            myViewController?.handleEvent(event: event)
                        }
                    })
                    .disposed(by: vc.disposeBag)
                model.state.subscribe(onNext: { [weak myViewController] in myViewController?.render(state: $0) }).disposed(by: vc.disposeBag)
                model.colectIntents(intents: vc.intents).disposed(by: vc.disposeBag)
            })
            .disposed(by: myViewController.disposeBag)

        myViewController.coordinator = self
    }
}
