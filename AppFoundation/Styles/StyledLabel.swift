@IBDesignable
open class StyledLabel<S: LabelStyles>: UILabel, StyledUIElement, XIBLocalizable {
    private var style: LabelStyle? {
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
        }
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        self.preferredMaxLayoutWidth = self.frame.size.width
        self.layoutIfNeeded()
    }
}
