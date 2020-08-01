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
                        // Explicit for ViewModel Intents
                        withAnimation(.linear(duration: 0.7)){
                            self.viewModel.choose(card: card)
                        }
                    }
                    .padding(5)
                    
                }
                .foregroundColor(viewModel.theme.color)
                .padding()
                
                Text("Score: \(viewModel.score)")
            }
            .navigationBarTitle(viewModel.theme.name)
            .navigationBarItems(trailing: Button("New Game"){
                withAnimation(.easeInOut){
                    self.viewModel.newGame()
                }
            })
        }
        // To allow for rotation in large Devices
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)){
            animatedBonusRemaining = 0
        }
    }
    
    // function @ViewBuilder to handle if / else case
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                        .onAppear {
                            self.startBonusAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                .transition(.scale)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    // Need to check whether card.isMatched as Animation is reused
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constants
    private func fontSize(for size: CGSize)-> CGFloat {
        min(size.width, size.height ) * 0.7
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
