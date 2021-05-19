//
//  BlockGridView.swift
//  SwiftUI2048
//
//  Created by wickedRun on 2021/05/18.
//

import SwiftUI

fileprivate struct IdentifiableIndexedBlock: Identifiable {
    typealias ID = String
    typealias IdentifiedValue = IndexedBlock<IdentifiedBlock>
    
    static var uniqueBlankId = 0
    
    let indexedBlock: IndexedBlock<IdentifiedBlock> // IndetifiedValue
    
    var id: Self.ID {
        if let id = indexedBlock.item?.id {
            return "\(id)"
        }
        
        IdentifiableIndexedBlock.uniqueBlankId += 1
        return "Blank_\(IdentifiableIndexedBlock.uniqueBlankId)"
    }
    
    var identifiedValue: Self.IdentifiedValue {
        return indexedBlock
    }
}

extension AnyTransition {
    static func blockAppear(from: Edge) -> AnyTransition {
        return .asymmetric(
            insertion: .opacity.combined(with: .move(edge: from)),
            removal: .identity)
    }
}

struct BlockGridView: View {
    typealias SupportingMatrix = BlockMatrix<IdentifiedBlock>
    
    let matrix: Self.SupportingMatrix
    let blockEnterEdge: Edge
    
    let mulOffset: CGFloat = 65 + 12
    let plusOffset: CGFloat = 32.5 + 12
    
    func createBlock(_ block: IdentifiedBlock?) -> some View {
        if let block = block {
            return BlockView(number: block.number)
        }
        return BlockView.blank()
    }
    
    func zIndex(_ block: IdentifiedBlock?) -> Double {
        if block == nil {
            return 1
        }
        return 1000
    }
    
    var body: some View {
        ZStack {
            ForEach(matrix.flatten.map { IdentifiableIndexedBlock(indexedBlock: $0) }) { block in
                createBlock(block.indexedBlock.item)
                    .frame(width: 65, height: 65, alignment: .center)
                    .position(x: CGFloat(block.indexedBlock.index.0) * mulOffset + plusOffset,
                              y: CGFloat(block.indexedBlock.index.1) * mulOffset + plusOffset
                    )
                    .zIndex(zIndex(block.indexedBlock.item))
                    .transition(.blockAppear(from: blockEnterEdge))
            }
        }
        .frame(width: 320, height: 320, alignment: .center)
        .background(
            Rectangle()
                .fill(Color(red: 0.72, green: 0.66, blue: 0.63))
        )
        .clipped()
        .cornerRadius(6)
    }
}

struct BlockGridView_Previews: PreviewProvider {
    static var matrix: BlockGridView.SupportingMatrix {
        var _matrix = BlockGridView.SupportingMatrix()
        _matrix.place(IdentifiedBlock(id: 1, number: 2), to: (2, 0))
        _matrix.place(IdentifiedBlock(id: 2, number: 2), to: (3, 0))
        _matrix.place(IdentifiedBlock(id: 3, number: 8), to: (1, 1))
        _matrix.place(IdentifiedBlock(id: 4, number: 4), to: (2, 1))
        _matrix.place(IdentifiedBlock(id: 5, number: 512), to: (3, 3))
        _matrix.place(IdentifiedBlock(id: 6, number: 1024), to: (2, 3))
        _matrix.place(IdentifiedBlock(id: 7, number: 16), to: (0, 3))
        _matrix.place(IdentifiedBlock(id: 8, number: 8), to: (1, 3))
        return _matrix
    }
    
    static var previews: some View {
        BlockGridView(matrix: matrix, blockEnterEdge: .top)
    }
}
