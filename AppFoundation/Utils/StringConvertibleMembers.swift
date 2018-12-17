private func propertiesAndValues(of item: Any) -> [String: Any] {
    let type = Mirror(reflecting: item)
    var properties = [String: Any]()
    for child in type.children {
        if let key = child.label {
            properties[key] = child.value
        }
    }

    return properties
}

public protocol StringConvertibleMembers {
    func member<MemberType>(from string: String) -> MemberType?
}

public extension StringConvertibleMembers {
    func member<MemberType>(from string: String) -> MemberType? {
        let keyValues = propertiesAndValues(of: self)
        return keyValues[string] as? MemberType
    }
}
