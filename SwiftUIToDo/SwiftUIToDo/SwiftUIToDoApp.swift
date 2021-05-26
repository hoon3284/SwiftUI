//
//  SwiftUIToDoApp.swift
//  SwiftUIToDo
//
//  Created by wickedRun on 2021/05/25.
//

import SwiftUI

@main
struct SwiftUIToDoApp: App {
    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environmentObject(UserData())
        }
    }
}
