@IBDesignable
open class StyledLabel<S: LabelStyles>: UILabel, StyledUIElement, XIBLocalizable {
    public var style: LabelStyle? {
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
            text = xibLocKey?.localized(usingBundleForInstance: self)
        }
    }
    
    private func updateStyle() {
        if let style = style {
            font = style.font
            textColor = style.color
            updateCustomStyle(style: style.customStyle)
        }
    }

    open func updateCustomStyle(style: CustomStyle) {}

    override open func layoutSubviews() {
        super.layoutSubviews()
        self.preferredMaxLayoutWidth = self.frame.size.width
        self.layoutIfNeeded()
    }
}
