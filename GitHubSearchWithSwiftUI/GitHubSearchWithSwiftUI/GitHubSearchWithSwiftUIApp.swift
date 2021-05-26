//
//  GitHubSearchWithSwiftUIApp.swift
//  GitHubSearchWithSwiftUI
//
//  Created by wickedRun on 2021/05/26.
//

import SwiftUI

@main
struct GitHubSearchWithSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            RepositoryListView(viewModel: RepositoryListViewModel(mainScheduler: DispatchQueue.main))
        }
    }
}
