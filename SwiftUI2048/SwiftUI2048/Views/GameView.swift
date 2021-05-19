//
//  ContentView.swift
//  SwiftUI2048
//
//  Created by wickedRun on 2021/05/18.
//

import SwiftUI

extension Edge {
    static func from(_ from: GameLogic.Direction) -> Self {
        switch from {
        case .down:
            return .top
        case .up:
            return .bottom
        case .left:
            return .trailing
        case .right:
            return .leading
        }
    }
}

struct GameView: View {
    @State var gestureStartLocation: CGPoint = .zero
    @State var lastGestureDirection: GameLogic.Direction = .up
    @EnvironmentObject var gameLogic: GameLogic
    
    fileprivate struct LayoutTraits {
        let bannerOffset: CGSize
        let containAlignment: Alignment
    }
    
    fileprivate func layoutTraits(`for` proxy: GeometryProxy) -> LayoutTraits {
        let landscape = proxy.size.width > proxy.size.height
        
        return LayoutTraits(
            bannerOffset: landscape
                ? .init(width: proxy.safeAreaInsets.leading + 32, height: 0)
                : .init(width: 0, height: proxy.safeAreaInsets.top + 32),
            containAlignment: landscape ? .leading : .top
        )
    }
    
    var gesture: some Gesture {
        let threshold: CGFloat = 44
        let drag = DragGesture()
            .onChanged { v in
                guard gestureStartLocation != v.startLocation else { return }
                
                withTransaction(Transaction()) {
                    gestureStartLocation = v.startLocation
                    
                    if v.translation.width > threshold {
                        // Move right
                        gameLogic.move(.right)
                        lastGestureDirection = .right
                    } else if v.translation.width < -threshold {
                        // Move left
                        gameLogic.move(.left)
                        lastGestureDirection = .left
                    } else if v.translation.height > threshold {
                        // Move down
                        gameLogic.move(.down)
                        lastGestureDirection = .down
                    } else if v.translation.height < -threshold {
                        gameLogic.move(.up)
                        lastGestureDirection = .up
                    } else {
                        self.gestureStartLocation = .zero
                    }
                }
                
                // After the scene is updated, reset the last gesture direction
                // to make sure the animation is right when user starts a new game.
                OperationQueue.main.addOperation {
                    lastGestureDirection = .up
                }
            }
        return drag
    }
    
    var body: some View {
        GeometryReader { proxy in
            bind(self.layoutTraits(for: proxy)) { layoutTraits in
                ZStack(alignment: layoutTraits.containAlignment) {
                    Text("2048")
                        .font(Font.system(size: 48).weight(.black))
                        .foregroundColor(Color(red: 0.47, green: 0.43, blue: 0.40))
                        .offset(layoutTraits.bannerOffset)
                    
                    ZStack(alignment: .top) {
                        BlockGridView(
                            matrix: gameLogic.blockMatrix,
                            blockEnterEdge: .from(lastGestureDirection)
                        ).gesture(gesture)
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background(
                    Rectangle().fill(Color(red: 0.96, green: 0.94, blue: 0.90))
                )
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameLogic())
    }
}
