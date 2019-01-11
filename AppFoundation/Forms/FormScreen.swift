import RxCocoa
import RxSwift

public protocol FormScreen {
    var form: Form { get }
}

public extension FormScreen {
    public func handleFormErrors(event: FoundationEvent) {
        (event as? FormErrorEvent).map { form.renderErrors(errors: $0.formErrors) }
    }

    public func submitObservable<T>(_ controlEvent: ControlEvent<T>) -> Observable<FormInput> {
        return submitObservable(controlEvent.asObservable())
    }

    public func submitObservable<T>(_ observable: Observable<T>) -> Observable<FormInput> {
        return observable.map { _ in self.form }
    }
}
