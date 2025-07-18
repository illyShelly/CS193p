//
//  Pexeso.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import Foundation

class Pexeso {
    //    Pexeso has a "free" init as all vars (here 1) are initialized
    var cards: [Card] = [] // cards = Array<Card>() or [Card]()
    
    func chooseCard(at index: Int) {
        
    }
    
    init(numberOfCards: Int) {
        for identifier in 1...numberOfCards {
            let card = Card(identifier: identifier)
            
            let matchingCard = card // assignment operator makes copy of the card as it's Struct
            // making pairs of cards as it's still another copy of card
            cards += [card, matchingCard] // [card, card], or use append
        }
    }
}
