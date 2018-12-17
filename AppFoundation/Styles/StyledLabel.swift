@IBDesignable
open class StyledLabel<S: LabelStyles>: UILabel, StyledUIElement {
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
    
    private func updateStyle() {
        if let style = style {
            font = style.font
            textColor = style.color
        }
    }
}
