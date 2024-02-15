//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Ruban on 2024-02-10.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(set) allows for read-only public access
    // private means that only this struct can modify the value vs fileprivate (scoped by any code in the same file)
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    // the cardContentFactory is a closure defined in the ViewModel
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // return the index of the card if only one card is face up
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        // returns the index of the chosen card by matching its id
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched = false
        let content: CardContent
        var id: String
        
        var debugDescription: String {
            "\(id): \(content)"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
