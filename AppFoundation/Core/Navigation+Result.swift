import RxCocoa
import RxSwift

public typealias ResultSingleEvent = (SingleEvent<AnyEquatable>) -> Void
public protocol ResultListener: AnyObject {
    var resultEvent: ResultSingleEvent? { get set }
}

public extension ResultListener {
    private func result() -> Single<AnyEquatable> {
        return Single.create { [weak self] single in
            self?.resultEvent = single
            return Disposables.create()
        }
    }

    func publishResult(_ result: AnyEquatable) {
        resultEvent?(.success(result))
    }

    func typedResult<T: Equatable>() -> Single<T> {
        return result()
            .map {
                guard let result: T = $0.asValue()
                else { throw CoreExceptions.errorUnexpected("Unexpected nil when type casting result") }
                return result
            }
    }
}

public protocol ResultProviderViewController: AnyObject {
    var resultListener: ResultListener! { get set }
}

public extension ViewModel {
    func navigatePerformSegueForResult<T: RawRepresentable, Result: Equatable>(
        resultObservable: Single<Result>,
        segueIdentifier: T,
        parameter: SegueParameter? = nil
    ) -> Single<Result> where T.RawValue == SegueIdentifier {
        navigatePerformSegue(segueIdentifier: segueIdentifier, parameter: parameter)
        return resultObservable
    }

    func dismissReturningResult<T: IsAnyEquatable & Equatable>(animated: Animated, result: T) {
        events.accept(NavigationEvent.dismissWithResult(animated, result.asAnyEquatable()))
    }

    func popReturningResult<T: IsAnyEquatable & Equatable>(animated: Animated, result: T) {
        events.accept(NavigationEvent.popWithResult(animated, result.asAnyEquatable()))
    }
}
