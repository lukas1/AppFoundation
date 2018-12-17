public extension UIStoryboardSegue {
    public func destination<T: UIViewController>() -> T {
        return destination as! T
    }
}
