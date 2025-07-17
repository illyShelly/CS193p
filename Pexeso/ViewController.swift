//
//  ViewController.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 17/07/2025.
//

import UIKit

class ViewController: UIViewController {
    var flipCount = 0 {
        didSet {        // property observer
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
        
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func pressButton(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            print("cardNumber: \(cardNumber)")
        } else {
            print("chosen card not found in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        let attributes: [NSAttributedString.Key: Any] = [
                 .font: UIFont.systemFont(ofSize: 50)
             ] // 👈 Keep the font big
        var attributedEmoji = NSAttributedString(string: "", attributes: attributes)
        
        // Showing emoji, flip down
        if button.currentTitle == emoji {
            //          button.setTitle("", for: UIControl.State.normal)
            //          button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
            attributedEmoji = NSAttributedString(string: "", attributes: attributes)
            button.setAttributedTitle(attributedEmoji, for: .normal)
            button.backgroundColor = .systemOrange
        } else {
            // Using setAttributedTitle(...) bypasses UIKit's buggy font inheritance or layout pass, and gives total control over the font rendering regardless of what UIKit's internal layout engine does
            attributedEmoji = NSAttributedString(string: emoji, attributes: attributes)
            button.setAttributedTitle(attributedEmoji, for: .normal)
            button.backgroundColor = .white
            
            // Force re-layout if needed
             button.setNeedsLayout()
             button.layoutIfNeeded()
            
//             print("Font after setting: \(button.titleLabel?.font.debugDescription ?? "nil")")
        }
    }

}

