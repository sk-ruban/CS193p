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
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"].shuffled()
        return MemoryGame<String>(numberOfPairs: Int.random(in: 2...5)) { index in
            return emojis[index]
        }
    }
    
    // Mark: Access to the model because its private var
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards.shuffled()
    }
    
    // Mark: Intent
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

