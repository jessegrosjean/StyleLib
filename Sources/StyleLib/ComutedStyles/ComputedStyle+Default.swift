import CoreGraphics
import Foundation
import CoreFoundation
import CoreText

func computeDefault(properties: [String : Any]) -> [String : Any] {
    var properties = properties
    
    if let fontDescriptor = properties[.fontDescriptor], properties[.font] == nil {
        properties[.font] = Font(descriptor: fontDescriptor, size: fontDescriptor.pointSize)
    }
    
    let attributes: NSMutableDictionary = NSMutableDictionary()
    
    if let font = properties[.font] {
        attributes[NSAttributedString.Key.font] = font
    }
    
    if let color = properties[.color] {
        attributes[NSAttributedString.Key.foregroundColor] = color
    }
    
    if let textDecoration = properties[.textDecoration], let line = textDecoration.underline {
        attributes[NSAttributedString.Key.underlineColor] = line.color
        if line.width > 1.0 {
            attributes[NSAttributedString.Key.underlineStyle] = CTUnderlineStyle.thick.rawValue as CFNumber
        } else {
            attributes[NSAttributedString.Key.underlineStyle] = CTUnderlineStyle.single.rawValue as CFNumber
        }
    }
    
    properties[.ctAttributes] = attributes as CFDictionary
    return properties
}

extension ComputedStyle.Key where Value == Font {
    public static let font = Self<Value>("font")
}

extension ComputedStyle.Key where Value == FontDescriptor {
    public static let fontDescriptor = Self<Value>("font-descriptor")
}

extension ComputedStyle.Key where Value == CGColor {
    public static let accentColor = Self<Value>("accent-color")
    public static let caretColor = Self<Value>("caret-color")
    public static let color = Self<Value>("color")
}

extension ComputedStyle.Key where Value == CFDictionary {
    public static let ctAttributes = Self<Value>("ctAttributes")
}
