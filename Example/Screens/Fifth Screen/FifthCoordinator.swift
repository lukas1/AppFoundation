import AppFoundation

struct FifthCoordinator: VMMCoordinator {
    let viewController: Weak<FifthViewController>

    init(viewController: FifthViewController) {
        self.viewController = asWeak(value: viewController)
    }
}

extension FifthCoordinator: SegueHandler {
    func coordinator(for segue: UIStoryboardSegue, sender: Any?) -> Coordinator? {
        return nil
    }
}

extension FifthCoordinator: ViewModelProvider {
    func provide() -> FifthViewModel {
        return FifthViewModel()
    }
}
