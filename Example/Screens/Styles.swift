import AppFoundation

struct AppLabelStyles: LabelStyles {
    let title = LabelStyle(
        color: UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
        font: UIFont.preferredFont(forTextStyle: .title1)
    )
    let subtitle = LabelStyle(
        color: UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0),
        font: UIFont.preferredFont(forTextStyle: .title3)
    )
}

struct AppButtonStyles: ButtonStyles {
    let basic = ButtonStyle(
        color: UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
        font: UIFont.preferredFont(forTextStyle: .title1)
    )
}

@IBDesignable class AppLabel: StyledLabel<AppLabelStyles> {}

@IBDesignable class AppButton: StyledButton<AppButtonStyles> {}
