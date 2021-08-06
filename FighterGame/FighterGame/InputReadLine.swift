//
//  InputReadLine.swift
//  FighterGame
//
//  Created by Yoan on 05/08/2021.
//

import Foundation

class InputReadLine {
    static func getIntegerUserInput(switchCase: [Int]) -> Int {
//        on vérifie que choice contienne quelques chose et que choice puisse être convertie en un entier
        if let choice = readLine(), choice.isEmpty == false, let intChoice = Int(choice), switchCase.contains(intChoice) {
//           si oui en renvoie intChoice
            return intChoice
        } else {
//            sinon on renvoie la fonction
            print("I don't understand" + "n/Try again please")
         return getIntegerUserInput(switchCase: switchCase)
        }
    }
}
