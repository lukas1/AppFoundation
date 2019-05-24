public extension UIStoryboardSegue {
    func destination<T: UIViewController>() -> T {
        return destination as! T
    }
}
