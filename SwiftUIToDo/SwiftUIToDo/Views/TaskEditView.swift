//
//  TaskEditView.swift
//  SwiftUIToDo
//
//  Created by wickedRun on 2021/05/25.
//

import SwiftUI

struct TaskEditView: View {
    @EnvironmentObject var userData: UserData
    private var task: Task
    private var draftTitle: State<String>
//    private var draftTitle: Binding<String
    
    init(task: Task) {
        self.task = task
        self.draftTitle = .init(initialValue: task.title)
    }
    
    var body: some View {
        let inset = EdgeInsets(top: -8, leading: -10, bottom: -7, trailing: -10)
        return VStack(alignment: .leading, spacing: 0) {
            TextField(
                "Enter New Title...",
                text: draftTitle.projectedValue,
                onEditingChanged: { _ in self.updateTask() },
                onCommit: {}
            )
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.clear)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(red: 0.7, green: 0.7, blue: 0.7), lineWidth: 1 / UIScreen.main.scale))
                    .padding(inset)
            )
            .padding(EdgeInsets(
                top: 15 - inset.top,
                leading: 20 - inset.leading,
                bottom: 15 - inset.bottom,
                trailing: 20 - inset.trailing
            ))
            
            Spacer()
        }
        .navigationBarTitle(Text("Edit Task 📝"))
    }
    
    private func updateTask() {
        guard let index = userData.tasks.firstIndex(of: task) else { return }
        userData.tasks[index].title = draftTitle.wrappedValue
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(task: Task(title: "Read SwiftUI Documentation 📚", isDone: false))
            .environmentObject(UserData())
    }
}
