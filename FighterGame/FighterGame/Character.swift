//
//  Personages.swift
//  FighterGame
//
//  Created by Yoan on 15/06/2021.
//

import Foundation

class Character {
    var name: String
    var lifePoint = 5
    var weapon: Weapon
    var healing = 0

    init (newName: String) {
        let max = Weapon.allWeapons.count - 1
        name = newName
        weapon = Weapon.allWeapons[Int.random(in: 0...max)]
        healing = Int.random(in: 0...8)
    }

    /// print characteristic of character
    /// - Parameter index: it's number position in the team
    func introduceCharacter(index: Int, filterAgainAlive: Bool) {
        var characteristic = "- \(index + 1) - \(name)"
            + "\n❤️: \(lifePoint)"
            + "\n⚔️: \(weapon.name)(\(weapon.damage))"

        if filterAgainAlive {
            guard lifePoint > 0 else {
                print("- \(index + 1) - \(name) is died")
                return
            }
        }

        if healing > 0 {
            characteristic +=  "\n❤️‍🩹: \(healing)"
        }
        characteristic += "\n**********************"

        print(characteristic)
    }
}
