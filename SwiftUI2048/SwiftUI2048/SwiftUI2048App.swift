//
//  SwiftUI2048App.swift
//  SwiftUI2048
//
//  Created by wickedRun on 2021/05/18.
//

import SwiftUI

@main
struct SwiftUI2048App: App {
    let gameLogic: GameLogic = GameLogic()
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(gameLogic)
        }
    }
}
