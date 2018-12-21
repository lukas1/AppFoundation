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

    let blueBackground = ButtonStyle(
        color: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        font: UIFont.preferredFont(forTextStyle: .body),
        contentEdgeInsets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15),
        backgroundColor: UIColor.blue,
        cornerRadius: 5.0
    )

    let blueBorder = ButtonStyle(
        color: UIColor.blue,
        font: UIFont.preferredFont(forTextStyle: .body),
        contentEdgeInsets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15),
        backgroundColor: nil,
        cornerRadius: 5.0,
        borderWidth: 1.0,
        borderColor: UIColor.blue
    )
}

@IBDesignable class AppLabel: StyledLabel<AppLabelStyles> {}

@IBDesignable class AppButton: StyledButton<AppButtonStyles> {}
