//
//  ErrorResponse.swift
//  GitHubSearchWithSwiftUI
//
//  Created by wickedRun on 2021/05/26.
//

import Foundation

struct ErrorResponse: Decodable, Error {
    let message: String
}
