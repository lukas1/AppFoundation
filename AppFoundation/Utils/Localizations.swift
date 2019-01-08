extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    public func localized<T: AnyObject>(usingBundleForInstance instance: T) -> String {
        return Bundle(for: type(of: instance)).localizedString(forKey: self, value: "", table: nil)
    }
}

public protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
