//
//  RepositoryView.swift
//  GitHubSearchWithSwiftUI
//
//  Created by wickedRun on 2021/05/26.
//

import SwiftUI

struct RepositoryView: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "doc.text")
                Text(repository.fullName)
                    .bold()
            }
            
            // Show text if description exists
            repository.description
                .map(Text.init)?
                .lineLimit(nil)
            
            HStack {
                Image(systemName: "star")
                Text("\(repository.stargazersCount)")
            }
        }
    }
}
