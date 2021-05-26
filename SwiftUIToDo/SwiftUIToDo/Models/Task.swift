//
//  Task.swift
//  SwiftUIToDo
//
//  Created by wickedRun on 2021/05/25.
//

import Foundation

struct Task: Equatable, Hashable, Codable, Identifiable {
    let id: UUID
    var title: String
    var isDone: Bool
    
    init(title: String, isDone: Bool) {
        self.id = UUID()
        self.title = title
        self.isDone = isDone
    }
}
