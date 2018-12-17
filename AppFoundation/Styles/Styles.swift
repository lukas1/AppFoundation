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

    public init(color: UIColor, font: UIFont) {
        self.color = color
        self.font = font
    }
}

public struct ButtonStyle {
    public let color: UIColor
    public let font: UIFont

    public init(color: UIColor, font: UIFont) {
        self.color = color
        self.font = font
    }
}
