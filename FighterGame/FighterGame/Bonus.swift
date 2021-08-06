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
        
//             on récupère la valeur max du catalogue d'armes
        let max = Weapon.allWeapons.count - 1
        print("You have bonus")
//            on sélectionne aléatoirement une arme
        let bonus = Weapon.allWeapons[Int.random(in: 0...max)]
        
        print("Congratulation! \nTap 1- for use \(bonus.name)(\(bonus.damage)) \nTap 2- you select your hero")
        
        
        while choice == "" {
            choice = readLine() ?? ""
            switch choice {
            case "1":
                
                // on passe la variable à true si on utilise le bonus
                print("you choose a present")
                return true
            case "2" :
                
                // on passe la variable à false si on utilise pas le bonus
                print("You choose your hero")
                return false
            default:
            choice = ""
            }
        }
    }
    
}
