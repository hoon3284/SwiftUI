//
//  Currency_SwiftUIApp.swift
//  Currency SwiftUI
//
//  Created by wickedRun on 2021/05/24.
//

import SwiftUI

@main
struct Currency_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ConverterView()
                .environmentObject(UserData())
        }
    }
}
