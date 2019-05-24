import RxCocoa
import RxSwift

public protocol FormScreen: AnyObject {
    var form: Form { get }
}

public extension FormScreen {
    func handleFormErrors(event: FoundationEvent) {
        (event as? FormErrorEvent).map { form.renderErrors(errors: $0.formErrors) }
    }

    func submitObservable<T>(_ controlEvent: ControlEvent<T>) -> Observable<FormInput> {
        return submitObservable(controlEvent.asObservable())
    }

    func submitObservable<T>(_ observable: Observable<T>) -> Observable<FormInput> {
        return observable.map { [weak self] _ in self?.form ?? Form.empty }
    }
}
