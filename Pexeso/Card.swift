//
//  Card.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import Foundation

// Model is UI independent - > so no emoji/jpeg... here
// How the card behave / the game works - not displayed

struct Card: Hashable {

//    Depricated hashValue for newer Swift
//    var hashValue: Int { return identifier }
    
    static func == (leftHandSite: Card, righHandSite: Card) -> Bool { // Equatable protocol for using ==
        return leftHandSite.identifier == righHandSite.identifier
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(identifier)
    }
    
    var isFacedUp: Bool = false
    var isMatched: Bool = false
    private var identifier: Int // be able to uniquely compare
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    //    To make initializer shorter in VC than Card(isFacedUP: False, identifier: 3) -> we initilize the identifier like so:
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    
}

// static relate to the type, here Card, not to any individual instance of the struct. It can be without Card.identifierFactory, just identifierFactory += 1 etc.
