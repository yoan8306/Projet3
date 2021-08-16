//
//  InputReadLine.swift
//  FighterGame
//
//  Created by Yoan on 05/08/2021.
//

import Foundation

class InputReadLine {
    /// manage input of player and convert string to integer
    /// - Returns: return choice player if is it an integer
    static func getIntegerUserInput() -> Int {
        if let choice = readLine(), choice.isEmpty == false, let intChoice = Int(choice) {
            return intChoice
        } else {
            print("I don't understand" + "\nTry again please")
            return getIntegerUserInput()
        }
    }

    /// manage input of player and check if they are an input
    /// - Returns: returns string if player press one touch
    static func getStringUserInput() -> String {
        if let response = readLine(), response.isEmpty == false, response != ""{
            return response
        } else {
            print("I don't understand" + "\nTry again please")
            return getStringUserInput()
        }
    }
}
