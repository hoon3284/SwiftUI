//
//  SwiftUI_Combine_ExampleApp.swift
//  SwiftUI-Combine-Example
//
//  Created by wickedRun on 2021/05/21.
//

import SwiftUI

@main
struct SwiftUI_Combine_ExampleApp: App {
    let searchUserViewModel = SearchUserViewModel()
    
    var body: some Scene {
        WindowGroup {
            SearchUserView()
                .environmentObject(searchUserViewModel)
        }
    }
}
