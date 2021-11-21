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
    
    let items: [Item]
    let aspectRatio: Double
    let minimumWidth: Double?
    let interitemSpacing: Double
    let bottomEdgeInset: Double?
    let horizontalPadding: Double?
    let verticalPadding: Double?
    let content: (Item) -> ItemView
    
    // MARK: Initializer

    init(items: [Item],
         aspectRatio: Double,
         minimumWidth: Double? = nil,
         interitemSpacing: Double = 0,
         bottomEdgeInset: Double? = nil,
         horizontalPadding: Double? = nil,
         verticalPadding: Double? = nil,
         @ViewBuilder content: @escaping (Item) -> ItemView
    ) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.minimumWidth = minimumWidth
        self.interitemSpacing = interitemSpacing
        self.bottomEdgeInset = bottomEdgeInset
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.content = content
    }
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width = widthThatFits(
                    itemCount: items.count,
                    in: geometry.size,
                    itemAspectRatio: aspectRatio
                )
                
                ScrollView {
                    LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: interitemSpacing) {
                        ForEach(items) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        }
                    }
                    .padding(.horizontal, horizontalPadding ?? interitemSpacing)
                    .padding(.vertical, verticalPadding ?? interitemSpacing)
                    
                    if let bottomEdgeInset = bottomEdgeInset {
                        Spacer()
                            .frame(height: bottomEdgeInset)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    // MARK: Internal methods
    
    private func adaptiveGridItem(width: Double) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = interitemSpacing
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: Double) -> Double {
        var columnCount = 1
        var rowCount = itemCount
        
        var viewWidth: Double {
            let interitemSpacingWidth = Double(columnCount - 1) * interitemSpacing
            let padding = (horizontalPadding ?? interitemSpacing) * 2
            return size.width - interitemSpacingWidth - padding
        }
        var viewHeight: Double {
            let interitemSpacingHeight = Double(rowCount - 1) * interitemSpacing
            let padding = (verticalPadding ?? interitemSpacing) * 2
            return size.height - interitemSpacingHeight - padding - (bottomEdgeInset ?? 0)
        }
        
        repeat {
            let itemWidth = viewWidth / Double(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            
            if CGFloat(rowCount) * itemHeight < viewHeight {
                break
            }
            
            if let minimumWidth = minimumWidth, minimumWidth > itemWidth {
                break
            }
            
            columnCount += 1
            rowCount = itemCount / columnCount + ((itemCount % columnCount) > 0 ? 1 : 0)
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        
        return floor(viewWidth / Double(columnCount))
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
