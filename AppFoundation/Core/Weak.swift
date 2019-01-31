import Foundation
import UIKit

public struct Weak<T: AnyObject> {
    private(set) public weak var value: T?
}

public func asWeak<T: AnyObject>(value: T) -> Weak<T> { return Weak(value: value) }
