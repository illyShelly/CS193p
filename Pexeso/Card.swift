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
}
