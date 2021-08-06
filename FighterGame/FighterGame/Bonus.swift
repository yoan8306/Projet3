//
//  Bonus.swift
//  FighterGame
//
//  Created by Yoan on 28/07/2021.
//

import Foundation

struct Bonus {
    
    static func createRandomBonus() -> Weapon? {
        let randomValue = Int.random(in: 0...5)
        
        guard randomValue == 0 else {
            return nil
        }
        
        let max = Weapon.allWeapons.count - 1
        print("You have bonus")
        
        let bonus = Weapon.allWeapons[Int.random(in: 0...max)]
        print("Congratulation! \nTap 1- for use \(bonus.name)(\(bonus.damage)) \nTap 2- you select your hero")

        return Bonus().askToUseBonus(weapon: bonus)
    }
    
     func askToUseBonus(weapon: Weapon) -> Weapon? {
        let choice = InputReadLine.getIntegerUserInput()
            
            switch choice {
            case 1:
                print("you choose a present")
                return weapon
            case 2:
                print("You choose your hero")
                return nil
            default:
           print("I don't understand" + "n/Try again please")
                return askToUseBonus(weapon: weapon)
            }
    }
}
