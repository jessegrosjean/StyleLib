import Foundation
import CoreGraphics

extension ComputedStyle {
    
    public struct TextDecoration: Hashable {
        
        public var overline: Line?
        public var lineThrough: Line?
        public var underline: Line?

        public struct Line: Hashable {

            public enum Style: Hashable {
                case solid
                case dotted
                case dashed
                case wavy
            }

            public var style: Style
            public var color: CGColor?
            public var width: Double
            
            public init(style: Style = .solid, color: CGColor? = nil, width: Double = 1.0) {
                self.style = style
                self.color = color
                self.width = width
            }
        }
        
        public init() {
        }

    }

}

extension ComputedStyle.Key where Value == ComputedStyle.TextDecoration {
    public static let textDecoration = Self<Value>("text-decoration")
}
