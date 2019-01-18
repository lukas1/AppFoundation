import RxSwift

public enum Schedulers {
    public static var defaultConcurrentScheduler: SchedulerType {
        return ConcurrentDispatchQueueScheduler(qos: .default)
    }
}
