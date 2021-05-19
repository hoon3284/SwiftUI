//
//  FunctionalUtils.swift
//  SwiftUI2048
//
//  Created by wickedRun on 2021/05/18.
//

import Foundation

func bind<T, U>(_ x: T, _ closure: (T) -> U) -> U {
    return closure(x)
}
