import AppFoundation
import RxSwift

enum FirstCoordinatorSegues : String {
    case first = "FirstSegue"
}

struct FirstState {
    var label: String
    var random: String
}

struct FirstIntents: FormIntents {
    let buttonClicks: Observable<Void>
    let randomClicks: Observable<Void>
    let submit: Observable<FormInput>
}

enum SecondCoordinatorSegues : String {
    case second = "SecondSegue"
}

struct SecondIntents {
    let buttonClicks: Observable<Void>
}

struct ThirdIntents {
    let buttonClicks: Observable<Void>
    let back: Observable<Void>
}

struct FourthIntents {
    let next: Observable<Void>
}

struct FourthState {
    var labelValue: String
}

enum OtherStoryboard {
    static let name = "OtherStoryboard"
    static let viewControllerId = "otherInitial"
}
