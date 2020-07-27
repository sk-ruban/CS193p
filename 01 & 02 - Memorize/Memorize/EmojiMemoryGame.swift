//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by SK Ruban on 10/6/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

// This is the ViewModel

class EmojiMemoryGame {
    // Access the Model
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    // Function to initialise the model
    // Is static as is it is universal for all instances
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"].shuffled()
        return MemoryGame<String>(numberOfPairs: Int.random(in: 2...5)) { index in
            return emojis[index]
        }
    }
    
    // MARK: - Access to the model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards.shuffled()
    }
    
    // MARK: - Intent(s) Functions to access the model
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

