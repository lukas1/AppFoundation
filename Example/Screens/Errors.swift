import AppFoundation
import RxCocoa
import RxSwift

struct ErrorEvent: FoundationEvent {
    let message: String
}

extension PrimitiveSequence where Trait == SingleTrait {
    func safeAsync(events: PublishRelay<FoundationEvent>) -> Driver<Element> {
        return safeAsync(events: events, errorToDefaultEventTransformer: { error in
            return ErrorEvent(message: "\(error)")
        })
    }
}

protocol SupportsErrors {}

extension SupportsErrors where Self: UIViewController {
    func handleErrorEvent(event: FoundationEvent) {
        (event as? ErrorEvent).map(handleError)
    }
    
    private func handleError(error: ErrorEvent) {
        let alertController = UIAlertController(
            title: "Error", message: error.message, preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        self.present(alertController, animated: true, completion: nil)
    }
}
