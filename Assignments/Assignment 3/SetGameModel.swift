//
//  SetGameModel.swift
//  SetGame
//
//  Created by SK Ruban on 18/7/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import Foundation

// This is a model

struct SetGameModel {
    private(set) var cards: Array<Card>
    
    // Returns a deck of cards with all 81 cases
    func createCards() -> Array<Card> {
        var cards = [Card]()
        
        for number in Card.Number.allCases {
            for shape in Card.Shape.allCases {
                for color in Card.Color.allCases {
                    for shading in Card.Shading.allCases {
                        cards.append(Card(id: cards.count, number: number, shape: shape, color: color, shading: shading))
                    }
                }
            }
        }
        
        return cards
    }
    
    struct Card {
        let id: Int
        let number: Number
        let shape: Shape
        let color: Color
        let shading: Shading
        
        var matched = false
        
        enum Number: Int, CaseIterable {
            case one = 1, two, three
        }
        
        enum Shape: CaseIterable {
            case diamond, rectangle, oval
        }
        
        enum Color: CaseIterable {
            case red, purple, green
        }
        
        enum Shading: CaseIterable {
            case solid, striped, outlined
        }
    }
}
