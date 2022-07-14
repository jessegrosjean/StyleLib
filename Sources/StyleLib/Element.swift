public protocol Element {
    var id: String? { get }
    var tagName: String? { get }
    var classNames: [String]? { get }
    var attributes: [String : String]? { get }
    var parentElement: Self? { get }
    var isFocused: Bool { get }
    var isEnabled: Bool { get }
    var isActive: Bool { get }
}
