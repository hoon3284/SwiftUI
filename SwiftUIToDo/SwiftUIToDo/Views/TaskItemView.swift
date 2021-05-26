//
//  TaskItemView.swift
//  SwiftUIToDo
//
//  Created by wickedRun on 2021/05/25.
//

import SwiftUI

struct TaskItemView: View {
    @EnvironmentObject var userData: UserData
    
    let task: Task
    @Binding var isEditing: Bool
    
    var body: some View {
        return HStack {
            if isEditing {
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
                    .onTapGesture {
                        delete()
                    }
                NavigationLink(destination: TaskEditView(task: task).environmentObject(userData)) {
                    Text(task.title)
                }
            } else {
                Button(action: { toggleDone() }) {
                    Text(task.title)
                }
                Spacer()
                if task.isDone {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                }
            }
        }
    }
    
    private func toggleDone() {
        guard !isEditing else { return }
        guard let index = userData.tasks.firstIndex(where: { $0.id == task.id }) else { return }
        userData.tasks[index].isDone.toggle()
    }
    
    private func delete() {
        userData.tasks.removeAll(where: { $0.id == task.id })
        if userData.tasks.isEmpty {
            isEditing = false
        }
    }
}

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(task: Task(title: "Read SwiftUI Documentation 📚", isDone: false), isEditing: .constant(false))
            .environmentObject(UserData())
    }
}
