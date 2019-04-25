public struct BooleanValidationRule: FormValidationRule {
    public let isValid: Bool
    public let errorMessage: String

    public init(isValid: Bool, errorMessage: String) {
        self.isValid = isValid
        self.errorMessage = errorMessage
    }
    
    public func isValid(value: String) -> Bool {
        return isValid
    }
}
