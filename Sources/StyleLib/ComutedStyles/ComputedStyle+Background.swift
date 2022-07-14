import Foundation
import CoreGraphics

extension ComputedStyle {
    
    public struct Background: Hashable {
        
        /*
        public struct Edge {
            public enum Style {
                case solid
                case dotted
                case dashed
            }

            public let style: Style
            public let width: Double
            public let color: Color
        }*/

        public var color: CGColor?
        public var borderColor: CGColor?
        public var borderWidth: Double

        /*
        public var top: Edge?
        public var right: Edge?
        public var bottom: Edge?
        public var left: Edge?

        public var topRightRadius: Double = 0
        public var bottomRightRadius: Double = 0
        public var bottomLeftRadius: Double = 0
        public var topLeftRadius: Double = 0
        */
        public init(color: CGColor? = nil, borderColor: CGColor? = nil, borderWidth: Double = 1) {
            self.color = color
            self.borderColor = borderColor
            self.borderWidth = borderWidth
        }
    }
    
}

extension ComputedStyle.Key where Value == ComputedStyle.Background {
    public static let background = Self<Value>("background")
}

/*
extension ComputedStyle.Key where Value == CGColor {
    public static let backgroundColor = Self<Value>("background-color")
    public static let borderColor = Self<Value>("border-color")
    public static let topBorderColor = Self<Value>("top-border-color")
    public static let rightBorderColor = Self<Value>("right-border-color")
    public static let bottomBorderColor = Self<Value>("bottom-border-color")
    public static let leftpBorderColor = Self<Value>("left-border-color")
    public static let backgroundColor = Self<Value>("background-color")
}

extension ComputedStyle.Key where Value == Double {
    public static let borderWidth = Self<Value>("border-width")
    public static let borderRadius = Self<Value>("border-radius")
}
*/
