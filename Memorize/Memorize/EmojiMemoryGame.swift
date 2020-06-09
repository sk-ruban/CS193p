//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by SK Ruban on 10/6/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻","🎃","🕷"]
        return MemoryGame<String>(numberOfPairs: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // Mark: Access to the model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // Mark: Intent
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
