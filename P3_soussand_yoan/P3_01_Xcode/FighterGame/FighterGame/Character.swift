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
    /// - Parameter index: index of character for selection
    func introduceCharacter(index: Int) {
        var characteristic = "- \(index + 1) - \(name)"
                            + "\n❤️: \(lifePoint)"
                            + "\n⚔️: \(weapon.name)(\(weapon.damage))"
        
        if healing > 0 {
            characteristic +=  "\n❤️‍🩹: \(healing)"
        }
        
        characteristic += "\n**********************"
        
        print(characteristic)
    }

    /// print doctors alive
    /// - Parameter index: index of character for selection
    func introduceDoctor(index: Int) {
        guard healing > 0 && lifePoint > 0 else {
            return
        }
        
        print("\(index + 1) - \(name)"
                + "\n❤️‍🩹\(healing)")
    }

    func doAttack(target: Character, weaponBonus: Weapon?) {
        if let bonusWeapon = weaponBonus {
            target.lifePoint -= bonusWeapon.damage
        } else {
            target.lifePoint -= weapon.damage
        }
        if target.lifePoint < 0 {
            target.lifePoint = 0
        }
        print("\(target.name): ❤️\(target.lifePoint) - ")
    }

    func doHealing(target: Character) {
        target.lifePoint += healing
        print("\(target.name) was treated: \n❤️ \(target.lifePoint)")
    }
}
