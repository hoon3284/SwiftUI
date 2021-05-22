//
//  User.swift
//  SwiftUI-Combine-Example
//
//  Created by wickedRun on 2021/05/21.
//

import Foundation
import SwiftUI

struct User: Hashable, Identifiable, Decodable {
    var id: Int64
    var login: String
    var avatar_url: URL
}
