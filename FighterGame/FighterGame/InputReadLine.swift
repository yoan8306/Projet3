//
//  InputReadLine.swift
//  FighterGame
//
//  Created by Yoan on 05/08/2021.
//

import Foundation

class InputReadLine {
    static func getIntegerUserInput() -> Int {
        if let choice = readLine(), choice.isEmpty == false, let intChoice = Int(choice) {
            return intChoice
        } else {
            print("I don't understand" + "\nTry again please")
            return getIntegerUserInput()
        }
    }
    
    static func getStringUserInput() -> String {
        if let response = readLine(), response.isEmpty == false, response != ""{
            return response
        } else {
            print("I don't understand" + "\nTry again please")
            return getStringUserInput()
        }
    }
}
