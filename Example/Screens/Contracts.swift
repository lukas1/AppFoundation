import RxSwift

enum FirstCoordinatorSegues : String {
    case first = "FirstSegue"
}

struct FirstState {
    var label: String
    var random: String
}

struct FirstIntents {
    let buttonClicks: Observable<Void>
    let randomClicks: Observable<Void>
}

enum SecondCoordinatorSegues : String {
    case second = "SecondSegue"
}

struct SecondIntents {
    let buttonClicks: Observable<Void>
}

struct ThirdIntents {
    let buttonClicks: Observable<Void>
}