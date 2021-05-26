//
//  ContentView.swift
//  SwiftUIToDo
//
//  Created by wickedRun on 2021/05/25.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var userData: UserData
    @State var draftTitle: String = ""
    @State var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                TextField("Create a New Task...", text: $draftTitle, onCommit: createTask)
                ForEach(userData.tasks) { task in
                    TaskItemView(task: task, isEditing: $isEditing)
                }
            }
            .navigationBarTitle(Text("Task 👀"))
            .navigationBarItems(trailing: Button(action: { isEditing.toggle() }) {
                if !self.isEditing {
                    Text("Edit")
                } else {
                    Text("Done")
                        .bold()
                }
            })
        }
    }
    
    private func createTask() {
        let newTask = Task(title: self.draftTitle, isDone: false)
        userData.tasks.insert(newTask, at: 0)
        draftTitle = ""
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environmentObject(UserData())
    }
}
