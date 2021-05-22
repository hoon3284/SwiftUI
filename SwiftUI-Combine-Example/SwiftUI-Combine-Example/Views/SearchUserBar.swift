//
//  SearchUserBar.swift
//  SwiftUI-Combine-Example
//
//  Created by wickedRun on 2021/05/22.
//

import SwiftUI

struct SearchUserBar: View {
    @Binding var text: String
    @State var action: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                TextField(
                    "Search User", text: $text
                )
                .padding([.leading, .trailing], 8)
                .frame(height: 32)
                .background(Color.white.opacity(0.4))
                .cornerRadius(8)
                
                Button(action: action,
                       label: { Text("Search") }
                )
                .foregroundColor(.white)
            }
            .padding()
        }
        .frame(height: 64)
        .background(Color.yellow)
    }
}
