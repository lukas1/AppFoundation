@IBDesignable
open class StyledButton<S: ButtonStyles>: UIButton, StyledUIElement, XIBLocalizable {
    public var style: ButtonStyle? {
        didSet {
            updateStyle()
        }
    }

    @IBInspectable public var xibStyleName: String? {
        didSet {
            style = xibStyleName.flatMap { S.init().member(from: $0) }
        }
    }

    @IBInspectable public var xibLocKey: String? {
        didSet {
            setTitle(
                xibLocKey?.localized(usingBundleForInstance: self) ?? "",
                for: .normal
            )
        }
    }

    private func updateStyle() {
        if let style = style {
            titleLabel?.font = style.font
            tintColor = style.color
            backgroundColor = style.backgroundColor
            contentEdgeInsets = style.contentEdgeInsets
            layer.cornerRadius = style.cornerRadius
            if let borderColor = style.borderColor {
                layer.borderWidth = style.borderWidth
                layer.borderColor = borderColor.cgColor
            }
            updateCustomStyle(style: style.customStyle)
        }
    }

    open func updateCustomStyle(style: CustomStyle) {}
}
