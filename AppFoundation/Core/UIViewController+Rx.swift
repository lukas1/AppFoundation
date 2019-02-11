import UIKit
import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {
    public var viewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }

    public var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }

    public var viewDidAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear(_:)))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}
