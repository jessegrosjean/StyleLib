public struct Selector {
    
    public let matches: [Match]
    public let specificity: Specificity
    
    public init(matches: [Match] = [], specificity: Specificity = Specificity()) {
        self.matches = matches
        self.specificity = specificity
    }

    public func isMatch<E>(_ element: E) -> Bool where E: Element {
        guard matches.count > 0 else {
            return false
        }
        return isMatch(element, index: matches.count - 1)
    }

    private func isMatch<E>(_ element: E, index: Int) -> Bool where E: Element {
        var index = index
        while index >= 0 {
            let match = matches[index]
            switch match {
            case .id(let id):
                if !(element.id == id) { return false }
            case .tag(let tagName):
                if !(tagName == "*" || element.tagName == tagName) { return false }
            case .clazz(let clazz):
                if !(element.classNames?.contains(clazz) ?? false) { return false }
            case .pseudoClass:
                fatalError()
            case .attribute(let attributeMatch):
                let attributes = element.attributes
                
                switch attributeMatch {
                case .name(let name):
                    if (attributes?[name] == nil) { return false }
                case .exact(let name, let value):
                    if attributes?[name] != value { return false }
                }
            case .child:
                guard let parent = element.parentElement, index > 0 else {
                    return false
                }
                return isMatch(parent, index: index - 1)
            case .descendant:
                var ancestor = element.parentElement
                while let currentAncestor = ancestor, index > 0 {
                    if isMatch(currentAncestor, index: index - 1) {
                        return true
                    }
                    ancestor = currentAncestor.parentElement
                }
                return false
            case .closure(let closure):
                return closure(element)
            }
            
            index -= 1
        }

        return true
    }
    
}

extension Selector {
    
    public struct Specificity: Equatable, Comparable {
        
        public var id: Int
        public var clazz: Int
        public var type: Int
        
        public init(id: Int = 0, clazz: Int = 0, type: Int = 0) {
            self.id = id
            self.clazz = clazz
            self.type = type
        }

        public init(array: [Int]) throws {
            self.init(id: array[0], clazz: array[1], type: array[2])
        }

        public static func < (lhs: Specificity, rhs: Specificity) -> Bool {
            if lhs.id < rhs.id {
                return true
            } else if lhs.clazz > rhs.clazz {
                return false
            } else {
                return lhs.type < rhs.type
            }
        }
    }
    
}
