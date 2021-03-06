//
//  Bonus.swift
//  FighterGame
//
//  Created by Yoan on 28/07/2021.
//

import Foundation

class Bonus {
    var bonusUsed: [Weapon] = []

    ///  if var randomValue isn't 0 then we can purpose a random weapon and ask if player want use new weapon.
    /// - Returns: return a weapon if
    func createRandomBonus() -> Weapon? {
        let randomValue = Int.random(in: 0...5)
        let max = Weapon.allWeapons.count - 1
        let bonus = Weapon.allWeapons[Int.random(in: 0...max)]

        guard randomValue == 0 else {
            return nil
        }

        print("\nCongratulation, you have bonus!")
        print("\nTap 1- for use \(bonus.name)(\(bonus.damage)) \nTap 2- you select your hero")
        return askToUseBonus(weapon: bonus)
    }

    /// Ask if player want use bonus or not.
    /// - Parameter weapon: it's weapon bonus create above this.
    /// - Returns: return weapon create above or nil if player don't want use bonus
    private func askToUseBonus(weapon: Weapon) -> Weapon? {
        let choice = InputReadLine.getIntegerUserInput()

        switch choice {
        case 1:
            print("you choose a present\n")
            bonusUsed.append(weapon)
            return weapon
        case 2:
            print("You choose your hero\n")
            return nil
        default:
            print("I don't understand" + "n/Try again please")
            return askToUseBonus(weapon: weapon)
        }
    }
}
