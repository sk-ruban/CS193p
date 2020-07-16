//
//  MemoryGame.swift
//  Memorize
//
//  Created by SK Ruban on 10/6/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import Foundation

// This is the Model

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var score = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card){
        print("Card Chosen: \(card)")
        // chosenIndex is the Index of the card chosen, which is still Face Down and isn't Matched
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            // potential Match Index checks for the match of chosenIndex
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                cards[chosenIndex].hasBeenFlipped += 1
                cards[potentialMatchIndex].hasBeenFlipped += 1
                // Match Case
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                // Mismatch Case after card has been seen before
                } else if cards[chosenIndex].hasBeenFlipped > 1 || cards[potentialMatchIndex].hasBeenFlipped > 1{
                    score -= 1
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                // First time seeing a card
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairs {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var hasBeenFlipped: Int = 0
    }
}
