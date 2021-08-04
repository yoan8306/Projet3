//
//  main.swift
//  FighterGame
//
//  Created by Yoan on 15/06/2021.
//

import Foundation

var newGame: Game = Game()

newGame.launchGame()


class InputReadLine {
    static func getIntegerUserInput() -> Int {
        
        if let choice = readLine(), choice.isEmpty == false, let intChoice = Int(choice) {
            
            return intChoice
        } else {
            print("I don't understand")
         return getIntegerUserInput()
        }
    }
}

