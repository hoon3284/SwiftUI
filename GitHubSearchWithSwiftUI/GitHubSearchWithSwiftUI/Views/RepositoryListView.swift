//
//  ContentView.swift
//  GitHubSearchWithSwiftUI
//
//  Created by wickedRun on 2021/05/26.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject private(set) var viewModel: RepositoryListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search repositories...", text: $viewModel.text,
                              onCommit: {viewModel.search() })
                        .frame(height: 40)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray, lineWidth: 2))
                    
                    Button(action: { viewModel.search() }) {
                        Text("Search")
                    }
                    .frame(height: 40)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.blue, lineWidth: 2))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                }
                
                List {
                    viewModel.errorMessage.map(Text.init)?
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                    ForEach(viewModel.repositories, id: \.id) { repository in
                        NavigationLink(destination: WebView(url: repository.htmlUrl)
                                        .navigationBarTitle(Text(repository.fullName))
                        ) {
                            RepositoryView(repository: repository)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Search🔍"))
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(viewModel: RepositoryListViewModel(mainScheduler: DispatchQueue.main))
    }
}
