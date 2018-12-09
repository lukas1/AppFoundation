struct Dependency {
    let dependencyValue = "dependency"
}

protocol DependencyProvider {
    var dependency: Dependency { get }
}

extension DependencyProvider {
    var dependency: Dependency { return Dependency() }
}

struct SecDep {
    let dependencyValue: String = "sec dec"
}

protocol SecDepProvider {
    var secDep: SecDep { get }
}

extension SecDepProvider {
    var secDep: SecDep { return SecDep() }
}
