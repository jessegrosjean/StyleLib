import CoreGraphics

extension CGColor {
    
    public func blended(withFraction fraction: CGFloat, of color: CGColor) -> CGColor? {
        guard let selfColor = Color(cgColor: self), let color = Color(cgColor: color) else {
            return nil
        }
        return selfColor.blended(withFraction: fraction, of: color)?.cgColor
    }
    
}
