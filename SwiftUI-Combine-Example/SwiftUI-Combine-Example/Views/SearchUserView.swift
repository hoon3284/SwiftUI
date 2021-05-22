//
//  ContentView.swift
//  SwiftUI-Combine-Example
//
//  Created by wickedRun on 2021/05/21.
//

import SwiftUI

struct SearchUserView: View {
    @EnvironmentObject var viewModel: SearchUserViewModel
    @State var text = "ra1028"
    
    var body: some View {
        NavigationView {
            VStack {
                SearchUserBar(text: $text) {
                    viewModel.search(name: text)
                }
                
                List(viewModel.users) { user in
                    SearchUserRow(user: user)
                        .onTapGesture { print(user) }
                }
            }
            .navigationBarTitle(Text("Users"))
        }
    }
}

struct SearchUserView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserView()
            .environmentObject(SearchUserViewModel())
    }
}
