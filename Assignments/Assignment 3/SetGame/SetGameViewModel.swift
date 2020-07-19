//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by SK Ruban on 18/7/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

// This is a ViewModel

class SetGameViewModel: ObservableObject {
    
    @Published var model: SetGameModel
    
    init() {
        model = SetGameModel.createCards()
    }
    
    // Mark: Access to the model
    
    var cards: Array<Card> { model.cards }
    
    
    
    
    // Mark: Intent
    
}

