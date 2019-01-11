public struct NotEmptyValidationRule: FormValidationRule {
    public let errorMessage: String
    
    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    public func isValid(value: String) -> Bool {
        return !value.isEmpty
    }
}
