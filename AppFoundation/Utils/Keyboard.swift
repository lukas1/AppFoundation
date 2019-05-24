public extension UITextField {
    func dismissOnReturn() {
        addTarget(self, action: #selector(dismiss(_:)), for: .editingDidEndOnExit)
    }

    @objc private func dismiss(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
