//
//  PexesoThemeChooserViewController.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 28/07/2025.
//

import UIKit

class PexesoThemeChooserViewController: UIViewController {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🏓⛷️🏏⛳️",
        "Animals": "🐶🦑🐠🪼🦉🐭🦊🐻🐼🐻‍❄️🐨🐯🦁",
        "Faces": "🙂😉😍🤓😎😇🧐😟😢🥶😱"
    ]
    
     // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // check which segue we're doing - we have 1 here for choosing theme
        if segue.identifier == "Choose Theme" {
            // can we find pexeso MVC, and prepare it to telling him its 'theme'
            // is Any? type actually UIButton
            if let button = sender as? UIButton {
                if let themeName = button.currentTitle {
                    if let theme = themes[themeName] {
                        // segue.destinatin - is UIViewController
                        if let pexesoVC = segue.destination as? PexesoViewController {
                            pexesoVC.theme = theme
                        } // cannot write like this: segue.destination.theme = theme, doesn't have theme UIViewC
                    }
                }
            }
        }
    }

}

// segue creates always new MVC, destroy old one when going back in navigation
