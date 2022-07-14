public struct Rule {
    
    var id: Int = 0
    
    public let selectors: [Selector]
    public let transforms: [Transform]

    public init(selectors: [Selector], transforms: [Transform]) {
        self.selectors = selectors
        self.transforms = transforms
    }

    public func matches<E>(_ element: E) -> Selector.Specificity? where E: Element {
        var specificity = Selector.Specificity()
        var matched = false
        
        for selector in selectors {
            if selector.isMatch(element) {
                matched = true
                specificity = max(specificity, selector.specificity)
            }
        }
        
        return matched ? specificity : nil
    }
    
    func transform(properties: inout [String : AnyHashable]) {
        for each in transforms {
            each.apply(&properties)
        }
    }
    
}

extension Rule {
    
    public struct Transform {
        
        fileprivate let apply: (inout [String : AnyHashable]) -> ()
        
        public static func set<V>(
            _ key: ComputedStyle.Key<V>,
            _ value: V
        ) -> Transform where V: Hashable {
            Transform { properties in
                properties[key.name] = value
            }
        }

        public static func calc<V>(
            _ key: ComputedStyle.Key<V>,
            _ fn: @escaping (V?) -> V?
        ) -> Transform where V: Hashable {
            Transform { properties in
                if let value = fn(properties[key.name] as? V) {
                    properties[key.name] = value
                } else {
                    properties.removeValue(forKey: key.name)
                }
            }
        }
        
        public static func calc<V, R>(
            _ key: ComputedStyle.Key<V>,
            _ readKey: ComputedStyle.Key<R>,
            _ fn: @escaping (V?, R?) -> V?
        ) -> Transform where V: Hashable {
            Transform { properties in
                if let value = fn(properties[key.name] as? V, properties[readKey.name] as? R) {
                    properties[key.name] = value
                } else {
                    properties.removeValue(forKey: key.name)
                }
            }
        }

    }
    
}
