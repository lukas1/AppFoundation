import Foundation

public protocol Exception : Error {
    var message: String { get }
}

public enum CoreExceptions: Exception {
    case errorUnexpected(String)

    public var message: String {
        switch self {
        case let .errorUnexpected(err): return err
        }
    }
}
