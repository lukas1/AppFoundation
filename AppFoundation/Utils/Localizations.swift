extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

public protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
