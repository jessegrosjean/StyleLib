#if os(OSX)

import AppKit
public typealias Color = NSColor

extension NSColor {
    
    public static var label: NSColor {
        .labelColor
    }

    public static var secondaryLabel: NSColor {
        .secondaryLabelColor
    }

    public static var tertiaryLabel: NSColor {
        .tertiaryLabelColor
    }

    public static var quaternaryLabel: NSColor {
        .quaternaryLabelColor
    }

    public static var textBackground: NSColor {
        .textBackgroundColor
    }

    public static var selectedTextBackground: NSColor {
        .selectedTextBackgroundColor
    }

    public static var selectedContentBackground: NSColor {
        .selectedContentBackgroundColor
    }
    
    public static let bikeForeground = NSColor(named: "bikeForeground") ?? .textColor
    
    public static let bikeBackground = NSColor(named: "bikeBackground") ?? .textBackground

    public var freeze: Self {
        Self(cgColor: cgColor)!
    }
    
}

#else

import UIKit
typealias Color = UIColor

extension UIColor {
    
    var alphaComponent: CGFloat {
        1.0
    }

    static var textBackground: UIColor {
        .white
    }

    static var selectedTextBackground: UIColor {
        .blue
    }

    static var selectedContentBackground: UIColor {
        .blue
    }

}

#endif
