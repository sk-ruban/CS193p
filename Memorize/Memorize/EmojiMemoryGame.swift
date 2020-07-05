//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by SK Ruban on 10/6/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

// This is the ViewModel

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    var theme = themes.randomElement()!
        
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis: Array<String> = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairs: theme.noOfPairs ?? Int.random(in: 4...6)) { index in
            return emojis[index]
        }
    }
    
    init(){
        model =  EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // Mark: Access to the model because its private var
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // Mark: Intent
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

