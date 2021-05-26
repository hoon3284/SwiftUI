//
//  ItemResponse.swift
//  GitHubSearchWithSwiftUI
//
//  Created by wickedRun on 2021/05/26.
//

import Foundation

struct ItemResponse<T: Decodable>: Decodable {
    let items: [T]
}
