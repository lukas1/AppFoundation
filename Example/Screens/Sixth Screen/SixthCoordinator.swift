import AppFoundation

struct SixthCoordinator: VMMCoordinator {
    let viewController: Weak<SixthViewController>

    init(viewController: SixthViewController) {
        self.viewController = asWeak(value: viewController)
    }
}

extension SixthCoordinator: SegueHandler {
    func coordinator(for segue: UIStoryboardSegue, sender: Any?) -> Coordinator? {
        return nil
    }
}

extension SixthCoordinator: ViewModelProvider {
    func provide() -> SixthViewModel {
        return SixthViewModel()
    }
}
