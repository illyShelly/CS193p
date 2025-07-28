//
//  PexesoViewController.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import UIKit

class PexesoViewController: UIViewController {
    
    private lazy var game: Pexeso = Pexeso(numberOfCards: (numberOfPairsOfCards))
    //* e.x.: 5 buttons -> (5+1)/2 = 3 -> double them 6 (1 card more for odd)
    //    we need the number of cards -> add property into Pexeso class
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
                                           
    private(set) var flipCount = 0 {
        didSet {        // property observer
            updateFlipCounLabel()
        }
    }
    
    // those NS attributes take effect after because of the initialization = 0 if it's in didSet.
    //    Sepsarate fce, as well the IBOutlet (has initial setup)
    private func updateFlipCounLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 4.0,
            .strokeColor: UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet { // set it for initial state of the UILabel
            updateFlipCounLabel()
        }
    }
    
    @IBAction private func resetButton(_ sender: UIButton) {
        game.resetCards()
        updateViewFromModel()
        flipCount = 0
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
        
    @IBAction func pressButton(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber) // say model to choose btn/card
            updateViewFromModel()
        } else {
            print("chosen card not found in cardButtons")
        }
    }
    
    //    Go through all Card buttons and set it up propertly
    //    & check each card instance in the cards
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices { // 0..<cardButtons.count
                let button = cardButtons[index]
                let card = game.cards[index]
                let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 40)]
                
                // clicked button matches the card (that which is UP)
                if card.isFacedUp { // white face, not about btn title anymore
                    let attributedString = NSAttributedString(string: emoji(for: card), attributes: attributes)
                    button.setAttributedTitle(attributedString, for: .normal)
                    button.backgroundColor = .systemGray6
                } else { // orange background
                    // when the card is "matched" I still want to still when clicking on the second card as it's turned down
                    let attributedString = NSAttributedString(string: "", attributes: attributes)
                    button.setAttributedTitle(attributedString, for: .normal)
                    button.backgroundColor = card.isMatched ? UIColor.systemOrange.withAlphaComponent(0.3) : UIColor.systemOrange
                }
            }
        }
    }
    
//    Theme using the 'segue', but emojiChoices gets initialized before theme is set here :( and emojiChoices updated with didSet
    var theme: String? {
        didSet {
            emojiChoices = theme ?? "" // starts as nil
            emojiDictionary = [:] // reset emojis could be from different theme; Swift infer type of k,v - Card:String
            updateViewFromModel()
        }
    }
    
//    private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"

//    Want to compare "directly Card to Card" not their identifier
    private var emojiDictionary: [Card:String] = [:]   // [Int:String]()
    
    //    Using string instead of array of emojis
    private func emoji(for card: Card) -> String {
        if emojiDictionary[card] == nil, !emojiChoices.isEmpty {
            //            Cannot use Integer index as it doesn't work in String'
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.randomInt)
            //            Add key-value pair into dictionary and remove it from the array as well
            emojiDictionary[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emojiDictionary[card] ?? "?" // if dictionary is not empty return, if so then "?"
    }
    
//    private func emoji(for card: Card) -> String {
//        // optional - firstly empty, then can be unwrapped
//        // adding emoji when someone touch the screen at random
//        // Once emojiChoices.count == 0, the range becomes 0..<0, which is empty, and Swift will crash at runtime
//        
//        if emojiDictionary[card.identifier] == nil, !emojiChoices.isEmpty { // no need to embeded another "if statements"
//            // add key-value pair into dictionary and remove it from the array as well
//            emojiDictionary[card.identifier] = emojiChoices.remove(at: emojiChoices.count.randomInt)
//        }
//        return emojiDictionary[card.identifier] ?? "?" // if dictionary is not empty return, if so then "?"
//    }
}

//Native Swift version
extension Int {
    var randomInt: Int {
        if self > 0 {
            return Int.random(in: 0..<self)
        } else if self < 0 {
            return -Int.random(in: 0..<abs(self))
        } else {
            return 0
        }
    }
}

// C-based version
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

// Using setAttributedTitle(...) bypasses UIKit's buggy font inheritance or layout pass, and gives total control over the font rendering regardless of what UIKit's internal layout engine does
//          button.setTitle("", for: UIControl.State.normal)
//          button.titleLabel?.font = UIFont.systemFont(ofSize: 50)

//          print("Font after setting: \(button.titleLabel?.font.debugDescription ?? "nil")")

// lazy -> it doesn't initialize until someone wants to use it (and is used once it is fully initialize :)
// with lazy var cannot use property observer didSet

// * to ensure you have enough pairs for the number of cards, even when the total number of buttons (cards) is odd.
// (cardButtons.count + 1) / 2) -> 5 / 2 = 2  → only 2 pairs = 4 cards (but you have 5 buttons!)
// cardButtons.indices -> is countable range of Int

// let randomIndex = Int.random(in: 0..<emojiChoices.count) - removed using extension
