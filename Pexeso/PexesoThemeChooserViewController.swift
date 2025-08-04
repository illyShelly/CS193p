//
//  PexesoThemeChooserViewController.swift
//  Pexeso
//
//  Created by Ilona Sellenberkova on 28/07/2025.
//

import UIKit

class PexesoThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    // Needs to add UISplitViewControllerDelegate
//    override func awakeFromNib() {
//        splitViewController?.delegate = self
//    }
    
    // without this func iPhone will enter game screen directly
//    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
//        if let pexesoVC = secondaryViewController as? PexesoViewController {
//            if pexesoVC.theme == nil {  // not chose yet
//                return true // show the theme screen default in iPhone
//            }
//        }
//        return false  // after chosen, enter the game screen in iPhone
//    }

//    Skip default 'haloween theme' when starting the game/app it will show directly themes to choose from as the initial screen
//    PexesoThemeChooserVC make itself delegate of the splitViewController that it's in (even not show it on iPhone)
//    On iPad still appears after click on theme the 'sidebar' with game - we control the collaps with the detail
    
    
    var themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🥏🎱🏓⛷️🏏⛳️",
        "Animals": "🐶🦑🐠🪼🦉🐭🦧🦊🐣🐻🪲🦁",
        "Faces": "🙂😉😍🤓😎😇🧐😟😢🥶😱"
    ]
    
    // Use 'target action' to make segues instead of manually in Storyboard
    // Generic segue from PexesoThemeChooser VC to PexesoVC, not from each buttons anymore
    // And drag Control from MVC - yellow button on top and choose Show Detail (for iPad splitView)
    
    @IBAction func changeTheme(_ sender: Any) {
        // For iPad
        //    Change the theme, not start a new game when choosing a theme
        //    then I do not segue, because segue always creates a new MVC, remember the state
        if let pvc = splitViewDetailPexesoViewController { // my var
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                pvc.theme = theme
            }
            //    for iPhone - push it to the navigation Stack from the heap
        } else if let pvc = lastSeguedToPexesoViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                pvc.theme = theme
            } // push it back without segueing
            navigationController?.pushViewController(pvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)        // use segue from code
        }
    }

    private var splitViewDetailPexesoViewController: PexesoViewController? {    // return current splitVC if I am in any?
        return splitViewController?.viewControllers.last as? PexesoViewController
        // in its VCs which is a master in array, and has a detail VC (just iPad not iPhone solution)
    }
   
    // MARK: - Navigation
    
        // *** normal var keeping in the heap even though when hit "back" button "on iPhone" and throw off the NavStack
    private var lastSeguedToPexesoViewController: PexesoViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            // **
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let pexesoVC = segue.destination as? PexesoViewController {
                    pexesoVC.theme = theme
                    print("prepareForSegue: setting theme = \(themeName)")
                    lastSeguedToPexesoViewController = pexesoVC
                }
            }
        }
    }
}

// *
// connect each button from storyboard to this method
// create segue from one MVC to another - not manually from buttons only
// change themes in the middle of the game

// **
// (Bad design): We are getting the theme from the button's title
// check which segue we're doing - we have 1 here for choosing theme
// can we find pexeso MVC, and prepare it to telling him its 'theme'
// is Any? type actually UIButton
// (sender as? UIButton)? - can return nil -> needs optional chain it
    
// ***
// as we want to hit 'back' button to choose different theme on iPhone (doesn't have splitVC), it throws away MVC from Navigation Stack but pointing to this var
// Grab a hold the MVC we segue to and hold with strong pointer, when it gets thrown off of navigation stack doesn't leave a heap. Next time, put it straight into Nav controller (not segue as a new) and push it right out there.
