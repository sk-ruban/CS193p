//
//  EmojiMemoryView.swift
//  Memorize
//
//  Created by SK Ruban on 9/6/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

// This is the View

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationView{
            VStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                            self.viewModel.choose(card: card)
                    }
                    .padding(5)
                    
                }
                .foregroundColor(viewModel.theme.color)
                .padding()
                
                Text("Score: \(viewModel.score)")
            }
            .navigationBarTitle(viewModel.theme.name)
            .navigationBarItems(trailing: Button("New Game"){
                self.viewModel.newGame() })
        }
        // To allow for rotation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched{
                    RoundedRectangle(cornerRadius: cornerRadius)
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize)-> CGFloat {
        min(size.width, size.height ) * 0.75
    }
}


