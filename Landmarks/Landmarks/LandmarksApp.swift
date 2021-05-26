//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by wickedRun on 2021/05/11.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
