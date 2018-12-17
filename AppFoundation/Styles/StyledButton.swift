@IBDesignable
open class StyledButton<S: ButtonStyles>: UIButton, StyledUIElement {
    private var style: ButtonStyle? {
        didSet {
            updateStyle()
        }
    }

    @IBInspectable public var xibStyleName: String? {
        didSet {
            style = xibStyleName.flatMap { S.init().member(from: $0) }
        }
    }

    private func updateStyle() {
        if let style = style {
            titleLabel?.font = style.font
            tintColor = style.color
        }
    }
}
