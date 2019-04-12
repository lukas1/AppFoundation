public protocol StyledUIElement {
    var xibStyleName: String? { get set }
}

public protocol LabelStyles: StringConvertibleMembers {
    init()
}

public protocol ButtonStyles: StringConvertibleMembers {
    init()
}

public struct LabelStyle {
    public let color: UIColor
    public let font: UIFont
    public let customStyle: CustomStyle

    public init(color: UIColor, font: UIFont, customStyle: CustomStyle = CustomStyles.empty) {
        self.color = color
        self.font = font
        self.customStyle = customStyle
    }
}

public protocol CustomStyle {}

public enum CustomStyles: CustomStyle {
    case empty
}

public struct ButtonStyle {
    public let color: UIColor
    public let font: UIFont
    public let contentEdgeInsets: UIEdgeInsets
    public let backgroundColor: UIColor?
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let borderColor: UIColor?
    public let customStyle: CustomStyle

    public init(
        color: UIColor,
        font: UIFont,
        contentEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero,
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat = 0.0,
        borderWidth: CGFloat = 1.0,
        borderColor: UIColor? = nil,
        customStyle: CustomStyle = CustomStyles.empty
    ) {
        self.color = color
        self.font = font
        self.contentEdgeInsets = contentEdgeInsets
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.customStyle = customStyle
    }
}
