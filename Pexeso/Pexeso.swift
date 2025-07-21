//
//  Pexeso.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import Foundation

class Pexeso {
    
    private(set) var cards: [Card] = [] // cards = Array<Card>() or [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?

    //    is used by outside world incl. initializer to create a game -> public
    // assert - cannot have for instance have negative or huge number of index -> if someone try to change it
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Pexeso.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            // Initial stage indexOfOneAndOnlyFaceUpCard is nil,
            // After 1st card is clicked the value is stored into OfOneAndOnlyFaceUpCard, after 2nd is assigned into matchIndex
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, !cards[index].isFacedUp, matchIndex != index { // There is one faced-up card, and it's not the same tapped
                
                if cards[matchIndex].identifier == cards[index].identifier { // Match is found
                    cards[matchIndex].isMatched = true // 1st card
                    cards[index].isMatched = true      // 2nd card
                }
                
                // 2nd card doesn't match with 1st so assign nil to indexOfOneAndOnlyFaceUpCard
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = nil

            // Either no cards were touched initially or two cards already are faced up
            // After 1st click jumps here -> 1 card is up
            } else {
                // Turned down both cards facing up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func resetCards() {
        for index in cards.indices {
//            Reset works if all are matched 
            if cards[index].isMatched {
                cards[index].isFacedUp = false
                cards[index].isMatched = false
            } else {
                return
            }
            
        }
    }
    
    init(numberOfCards: Int) {
        assert(numberOfCards > 0, "Pexeso.init(\(numberOfCards) you must have at least one pair of cards")
        for _ in 1...numberOfCards {  //
            let card = Card()  // assignment operator makes a copy of the card as it's Struct
            let matchingCard = card // making pairs of cards as it's still another copy of card *
            cards += [card, matchingCard] // [card, card], or use append
        }
        
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}

//    Pexeso has a "free" init as all vars (here 1) are initialized
//    from 0..<numberOfCArds to the end excluded, or from 1...numberOfCards (included)
//   * no need to create copy of another card like this: Card(), assign the card creates new again
