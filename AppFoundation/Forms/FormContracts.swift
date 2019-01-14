import RxSwift
import RxCocoa

public typealias FormInputId = Int

public typealias FormErrorMessage = String

public typealias FormErrors = [FormInputId: FormErrorMessage]

public typealias FormValidations = [FormInputId: [FormValidationRule]]

public struct FormErrorEvent: FoundationEvent {
    public let formErrors: FormErrors
    
    public init (formErrors: FormErrors) {
        self.formErrors = formErrors
    }
}

public protocol FormValidationRule {
    var errorMessage: String { get }
    func isValid(value: String) -> Bool
}

public protocol FormInput {
    var inputs: [FormInputId: String] { get }
}

public extension FormInput {
    public func validate(validations: FormValidations, relay: PublishRelay<FoundationEvent>) -> Bool {
        do {
            let errors = validations.reduce([FormInputId: FormErrorMessage](), { result, touple in
                var mutableResult = result
                let inputId = touple.0
                let validationRules = touple.1
                guard let value = inputs[inputId] else { return mutableResult }
                if let failedRule = validationRules.first(where: { !$0.isValid(value: value) }) {
                    mutableResult[inputId] = failedRule.errorMessage
                }
                return mutableResult
            })
            if !errors.isEmpty {
                relay.accept(FormErrorEvent(formErrors: errors))
            }
            return errors.isEmpty
        }
    }
}

public protocol FormIntents {
    var submit: Observable<FormInput> { get }
}
