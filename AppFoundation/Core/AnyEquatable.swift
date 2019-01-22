public struct AnyEquatable {
    public let value: Any
    private let equals: (Any) -> Bool

    public init<T: Equatable>(value: T) {
        self.value = value
        self.equals = { ($0 as? T) == value }
    }

    public func asValue<T>() -> T? { return value as? T }
}

extension AnyEquatable: Equatable {
    public static func == (lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
        return lhs.equals(rhs.value)
    }
}

public protocol IsAnyEquatable {}

public extension IsAnyEquatable where Self: Equatable {
    func asAnyEquatable() -> AnyEquatable {
        return AnyEquatable(value: self)
    }
}

public extension Optional where Wrapped == Any {
    func asAnyEquatableValue<T>() -> T? {
        return (self as? AnyEquatable)?.asValue()
    }
}
