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
   
    // on créée un personnages avec une arme aux hasard et une valeur de soins aléatoire
    init (newName: String) {
        
        // on récupère la valeur max du catalogues d'armes
        let max = Weapon.allWeapons.count - 1
        
        // on attribut les caractéristiques du personnage
        name = newName
        weapon = Weapon.allWeapons[Int.random(in: 0...max)]
        healing = Int.random(in: 0...8)
    }

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
    
    
    
}
