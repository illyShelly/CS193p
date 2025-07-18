//
//  Card.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import Foundation

// Model is UI independent - > so no emoji/jpeg... here
// How the card behave / the game works - not displayed

struct Card {

    var isFacedUP: Bool = false
    var isMatched: Bool = false
    var identifier: Int // be able to uniquely compare
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
        // static relate to the type, here Card, can be without Card.
    }
    
    //    To make initializer shorter in VC than Card(isFacedUP: False, identifier: 3) -> we initilize the identifier like so:
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    
}
