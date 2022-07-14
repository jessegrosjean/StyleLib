import Foundation

public struct ComputedStyle {

    public struct Key<Value> {
        public let name: String
        public init(_ name: String) {
            self.name = name
        }
    }

    let propertiesHash: Int
    let properties: [String : AnyHashable]
    let computedProperties: [String : Any]?

    public init(properties: [String : AnyHashable] = [:], compute: ([String : AnyHashable]) -> [String : Any]) {
        self.propertiesHash = properties.hashValue
        self.properties = properties
        self.computedProperties = compute(properties)
    }

    public subscript<V>(key: Key<V>) -> V? {
        computedProperties?[key]
    }
    
}

extension Dictionary where Key == String, Value == Any {

    public subscript<V>(key: ComputedStyle.Key<V>) -> V? {
        get {
            self[key.name] as? V
        }
        set {
            if let newValue = newValue {
                self[key.name] = newValue
            } else {
                removeValue(forKey: key.name)
            }
        }
    }
    
}
