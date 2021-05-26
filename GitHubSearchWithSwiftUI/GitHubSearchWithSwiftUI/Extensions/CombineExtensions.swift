//
//  CombineExtensions.swift
//  GitHubSearchWithSwiftUI
//
//  Created by wickedRun on 2021/05/26.
//

import Foundation

struct CombineExtension<Base> {
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

protocol CombineCompatible {
    associatedtype CombineExtensionBase
    
    static var combine: CombineExtension<CombineExtensionBase>.Type { get set }
    var combine: CombineExtension<CombineExtensionBase> { get set }
}

extension CombineCompatible {
    static var combine: CombineExtension<Self>.Type {
        get {
            return CombineExtension<Self>.self
        }
        set {}
    }
    
    var combine: CombineExtension<Self> {
        get {
            return CombineExtension<Self>(self)
        }
        set {}
    }
}
