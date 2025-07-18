//
//  Pexeso.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import Foundation

class Pexeso {
    
    var cards: [Card] = [] // cards = Array<Card>() or [Card]()
    
    func chooseCard(at index: Int) {
        
    }
    
    init(numberOfCards: Int) {
        for _ in 1...numberOfCards {
            let card = Card()  // assignment operator makes a copy of the card as it's Struct
            let matchingCard = card // making pairs of cards as it's still another copy of card

            cards += [card, matchingCard] // [card, card], or use append
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
    
    
}

//    Pexeso has a "free" init as all vars (here 1) are initialized
