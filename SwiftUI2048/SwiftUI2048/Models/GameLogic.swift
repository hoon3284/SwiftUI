//
//  GameLogic.swift
//  SwiftUI2048
//
//  Created by wickedRun on 2021/05/18.
//

import Foundation
import SwiftUI
import Combine

final class GameLogic: ObservableObject {
    
    enum Direction {
        case left
        case right
        case up
        case down
    }
    
    typealias BlockMatrixType = BlockMatrix<IdentifiedBlock>
        
    @Published private(set) var blockMatrix: BlockMatrixType
    
//    fileprivate var globalID: Int {
//
//    }
    
    private var globalID = 0
    private var newGlobalID: Int {
        globalID += 1
        return globalID
    }
    
    init() {
        blockMatrix = BlockMatrixType()
        generateNewBlocks()
    }
        
    func move(_ direction: Direction) {
        
        var moved = false
        
        let axis = direction == .left || direction == .right
        for row in 0..<4 {
            var rowSnapshot = [IdentifiedBlock?]()
            var compactRow = [IdentifiedBlock]()
            for col in 0..<4 {
                // Transpose if necessary.
                if let block = blockMatrix[axis ? (col, row) : (row, col)] {
                    rowSnapshot.append(block)
                    compactRow.append(block)
                }
                rowSnapshot.append(nil)
            }
            
            merge(blocks: &compactRow, reverse: direction == .down || direction == .right)
            
            var newRow = [IdentifiedBlock?]()
            compactRow.forEach { newRow.append($0) }
            if compactRow.count < 4 {
                for _ in 0..<(4 - compactRow.count) {
                    if direction == .left || direction == .up {
                        newRow.append(nil)
                    } else {
                        newRow.insert(nil, at: 0)
                    }
                }
            }
            
            newRow.enumerated().forEach {
                if rowSnapshot[$0]?.number != $1?.number {
                    moved = true
                }
                blockMatrix.place($1, to: axis ? ($0, row) : (row, $0))
            }
        }
        
        if moved {
            generateNewBlocks()
        }
    }
    
    fileprivate func merge(blocks: inout [IdentifiedBlock], reverse: Bool) {
        if reverse {
            blocks = blocks.reversed()
        }
        
        blocks = blocks
            .map { (false, $0) }
            .reduce([(Bool, IdentifiedBlock)]()) { acc, item in
                if acc.last?.0 == false && acc.last?.1.number == item.1.number {
                    var accPrefix = Array(acc.dropLast())
                    var mergedBlock = item.1
                    mergedBlock.number *= 2
                    accPrefix.append((true, mergedBlock))
                    return accPrefix
                } else {
                    var accTmp = acc
                    accTmp.append((false, item.1))
                    return accTmp
                }
            }
            .map { $0.1 }
        
        if reverse {
            blocks = blocks.reversed()
        }
    }
    
    @discardableResult fileprivate func generateNewBlocks() -> Bool {
        var blankLocations = [BlockMatrixType.Index]()
        for rowIndex in 0..<4 {
            for colIndex in 0..<4 {
                let index = (colIndex, rowIndex)
                if blockMatrix[index] == nil {
                    blankLocations.append(index)
                }
            }
        }
        
        guard blankLocations.count >= 2 else {
            return false
        }
        
        // Don't forget to sync data.
//        defer {
//            objectWillChange.send(self)
//        }
        
        // Place the first block.
        var placeLocIndex = Int.random(in: 0..<blankLocations.count)
        blockMatrix.place(IdentifiedBlock(id: newGlobalID, number: 2), to: blankLocations[placeLocIndex])
        
        // Place the second block.
        guard let lastLoc = blankLocations.last else {
            return false
        }
        blankLocations[placeLocIndex] = lastLoc
        placeLocIndex = Int.random(in: 0..<(blankLocations.count - 1))
        blockMatrix.place(IdentifiedBlock(id: newGlobalID, number: 2), to: blankLocations[placeLocIndex])
        
        return true
    }
}
