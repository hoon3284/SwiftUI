//
//  Repository.swift
//  GitHubSearchWithSwiftUI
//
//  Created by wickedRun on 2021/05/26.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let fullName: String
    let description: String?
    let stargazersCount: Int
    let htmlUrl: URL
}
