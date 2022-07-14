public enum Match: CustomDebugStringConvertible {
    
    case id(String)
    case tag(String)
    case clazz(String)
    case pseudoClass(String)
    case attribute(Attribute)
    case closure((Element) -> Bool)
    case child
    case descendant

    public var debugDescription: String {
        switch self {
        case .id(let id):
            return "#\(id)"
        case .tag(let tagName):
            return "\(tagName)"
        case .clazz(let clazz):
            return ".\(clazz)"
        case .pseudoClass(let pseudoClass):
            return ":\(pseudoClass)"
        case .attribute(let attribute):
            switch attribute {
            case .name(name: let name):
                return "[\(name)]"
            case .exact(name: let name, value: let value):
                return "[\(name)=\(value)]"
            }
        case .closure:
            return "closure()"
        case .child:
            return " > "
        case .descendant:
            return " "
        }
    }
    
}

extension Match {
    
    public enum Attribute {
        case name(name: String)
        case exact(name: String, value: String)
    }

}

