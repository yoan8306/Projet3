//
//  main.swift
//  FighterGame
//
//  Created by Yoan on 15/06/2021.
//

import Foundation

Main.launchGame()

class Main {
    /// player select if want launch game or exit the program
    static func launchGame() {
        print("Tap 1 for start new game of FighterGame"
                + "\nTap 2 for exit")

        let choice = InputReadLine.getIntegerUserInput()

        switch choice {
        case 1:
            print("Start new game")
            Game().startNewGame()
            launchGame()
        case 2:
            break
        default:
            print("I don't understand." + "n/Try again please.")
            launchGame()
        }
    }
}
