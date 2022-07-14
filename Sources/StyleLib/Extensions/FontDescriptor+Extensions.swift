extension FontDescriptor {
    
    public func withUnionSymbolicTraits(_ newTraits: FontDescriptor.SymbolicTraits) -> FontDescriptor {
        withSymbolicTraits(symbolicTraits.union(newTraits))
    }
    
}
