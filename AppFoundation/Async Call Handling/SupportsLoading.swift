public protocol SupportsLoading: AnyObject {
    var callCount: Int { get set }
    func showLoading()
    func hideLoading()
}

public extension SupportsLoading {
    func handleLoadingEvent(event: FoundationEvent) {
        switch event {
        case is LoadingCallStarted:
            self.callCount += 1
            if callCount > 0 {
                showLoading()
            }
        case is LoadingCallEnded:
            self.callCount -= 1
            if callCount == 0 {
                hideLoading()
            }
        default: break
        }
    }
}
