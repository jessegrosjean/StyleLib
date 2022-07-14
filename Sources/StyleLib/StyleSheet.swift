public class StyleSheet {
    
    public let rules: [Rule]
    
    private let inherited: Set<String>
    private var computeStyle: ([String : AnyHashable]) -> [String : Any]
    private var computedStyleByElementIdCache: [String : ComputedStyle] = [:]
    private var computedStyleByInputsHashCache: [Int : ComputedStyle] = [:]
    
    public init(
        rules: [Rule] = [],
        inherited: Set<String>? = nil,
        computeStyle: (([String : AnyHashable]) -> [String : Any])? = nil
    ) {
        var rules = rules
        for i in rules.indices {
            rules[i].id = i
        }
        self.rules = rules
        
        self.inherited = inherited ?? [
            ComputedStyle.Key.color.name,
            ComputedStyle.Key.fontDescriptor.name,
        ]
        
        self.computeStyle = computeStyle ?? { properties in
            var properties: [String : Any] = properties

            properties = computeDefault(properties: properties)
            
            return properties
        }
    }
        
    public func matches<E>(_ element: E) -> [Rule] where E: Element {
        return rules.compactMap { rule -> (Selector.Specificity, Rule)? in
            if let specificity = rule.matches(element) {
                return (specificity, rule)
            } else {
                return nil
            }
        }.sorted { a, b in
            a.0 < b.0
        }.map {
            $0.1
        }
    }
    
    public func computedStyle<E>(_ element: E) -> ComputedStyle where E: Element {
        if let id = element.id, let computedStyle = computedStyleByElementIdCache[id] {
            return computedStyle
        }

        let rules = matches(element)
        let parentStyle = element.parentElement.map { self.computedStyle($0) }
        let computedStyle = computeStyle(rules: rules, parentStyle: parentStyle)
        
        if let id = element.id {
            computedStyleByElementIdCache[id] = computedStyle
        }
        
        return computedStyle
    }

    private func computeStyle(rules: [Rule], parentStyle: ComputedStyle?) -> ComputedStyle {
        var hasher = Hasher()
        hasher.combine(parentStyle?.propertiesHash ?? 0)
        rules.forEach { hasher.combine($0.id) }
        
        let inputsHash = hasher.finalize()
        if let computedStyle = computedStyleByInputsHashCache[inputsHash] {
            return computedStyle
        }

        var properties = parentStyle?.properties ?? [:]
        for rule in rules {
            rule.transform(properties: &properties)
        }

        let computedStyle = ComputedStyle(properties: properties, compute: computeStyle)
        computedStyleByInputsHashCache[inputsHash] = computedStyle
        return computedStyle
    }
    
    public func clearElementIdCache() {
        computedStyleByElementIdCache = [:]
    }

}
