//
//  ScrollableAspectVGrid.swift
//  Set
//
//  Originally created by CS193p Instructor on 4/14/21.
//  Copyright Stanford University 2021
//

import SwiftUI

// MARK: - ScrollableAspectVGrid

struct ScrollableAspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    
    // MARK: Properties
    
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    // MARK: Initializer
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(
                    itemCount: items.count,
                    in: geometry.size,
                    itemAspectRatio: aspectRatio
                )
            
                ScrollView {
                    LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                        ForEach(items) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        }
                    }
                }
                
                Spacer(minLength: 0)
            }
        }
    }
    
    // MARK: Internal methods
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}

// MARK: - Preview

struct AspectVGrid_Previews: PreviewProvider {
    
    static let cards = SetGameViewModel().cards
    
    static var previews: some View {
        ScrollableAspectVGrid(
            items: cards,
            aspectRatio: 3/4
        ) { card in
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                
                Text("\(card.color.description)")
                    .foregroundColor(card.color)
            }
        }.padding()
    }
}
