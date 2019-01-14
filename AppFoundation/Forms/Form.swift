import UIKit

public struct Form {
    public let inputMap: [FormInputId: UITextField]
    public let renderErrorForField: (UITextField, FormErrorMessage) -> Void

    public init(
        inputMap: [FormInputId: UITextField],
        renderErrorForField: @escaping (UITextField, FormErrorMessage) -> Void
    ) {
        self.inputMap = inputMap
        self.renderErrorForField = renderErrorForField
    }
}

extension Form: FormInput {
    public var inputs: [FormInputId: String] {
        return inputMap.mapValues { $0.text ?? "" }
    }
}

extension Form {
    public static let empty: Form = Form(inputMap: [:], renderErrorForField: {_,_ in })

    public func renderErrors(errors: FormErrors) {
        errors.forEach { (key, value) in
            inputMap[key].map { renderErrorForField($0, value) }
        }
    }
}
