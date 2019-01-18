import RxSwift
import RxCocoa

public struct LoadingCallStarted: FoundationEvent, Equatable {
    public init() {}
}
public struct LoadingCallEnded: FoundationEvent, Equatable {
    public init() {}
}

public typealias PerformsDefaultErrorHandling = (Error) -> Bool

public extension PrimitiveSequence where Trait == SingleTrait {
    func withLoading(events: PublishRelay<FoundationEvent>) -> Single<Element> {
        return self
            .do(
                onSuccess: nil,
                onError: nil,
                onSubscribe: nil,
                onSubscribed: { events.accept(LoadingCallStarted()) },
                onDispose: { events.accept(LoadingCallEnded()) }
        )
    }

    func withErrorHandling<DefaultErrorEvent>(
        events: PublishRelay<FoundationEvent>,
        errorToDefaultEventTransformer: @escaping (Error) -> DefaultErrorEvent,
        performsDefaultErrorHandling: @escaping PerformsDefaultErrorHandling = { _ in true }
    ) -> Driver<Element> where DefaultErrorEvent: FoundationEvent {
        return self.do(onSuccess: nil, onError: { error in
            if performsDefaultErrorHandling(error) {
                events.accept(errorToDefaultEventTransformer(error))
            }
        }).asDriver(onErrorRecover: { _ in Driver.never() })
    }

    func safeAsync<DefaultErrorEvent>(
        events: PublishRelay<FoundationEvent>,
        errorToDefaultEventTransformer: @escaping (Error) -> DefaultErrorEvent,
        performsDefaultErrorHandling: @escaping PerformsDefaultErrorHandling = { _ in true }
    ) -> Driver<Element> where DefaultErrorEvent: FoundationEvent {
        return withLoading(events: events)
            .withErrorHandling(
                events: events,
                errorToDefaultEventTransformer: errorToDefaultEventTransformer,
                performsDefaultErrorHandling: performsDefaultErrorHandling
            )
    }
}
