import AppFoundation

struct FourthCoordinator: VMMCoordinator {
    let viewController: Weak<FourthViewController>

    init(viewController: FourthViewController) {
        self.viewController = asWeak(value: viewController)
    }
}

extension FourthCoordinator: SegueHandler {
    func coordinator(for segue: UIStoryboardSegue, sender: Any?) -> Coordinator? {
        switch segue.identifier {
        case FourthSegues.modal.rawValue:
            return FifthCoordinator(viewController: segue.destination())
        default: return nil
        }
    }
}

extension FourthCoordinator: ViewModelProvider {
    func provide() -> FourthViewModel {
        return FourthViewModel()
    }
}
