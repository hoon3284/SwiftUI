//
//  UserData.swift
//  SwiftUIToDo
//
//  Created by wickedRun on 2021/05/25.
//

import Foundation
import Combine

private let defaultTask: [Task] = [
    Task(title: "Read SwiftUI Documentation 📚", isDone: false),
    Task(title: "Watch WWDC19 Keynote 🎉", isDone: true)
]

final class UserData: ObservableObject {
    let objectWillChange = PassthroughSubject<UserData, Never>()
    
    @UserDefaultValue(key: "Tasks", defaultValue: defaultTask)
    var tasks: [Task] {
        didSet {
            objectWillChange.send(self)
        }
    }
}
