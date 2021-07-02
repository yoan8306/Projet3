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
    var weapon: Weapons
    var healing = 0
   
    // on créée un personnages avec une arme aux hasard et une valeur de soins aléatoire
    init (newName: String) {
        
        // on créée un catalogue d'arme disponible pour le choix du personnage
        let cataloguesWeapons: [Weapons] = [Knife(), Gun(), Rocket(), Boomerang(), Flamethrower(), Rifle(), Grenade()]
        
        // on récupère la valeur max du tableau
        let max = cataloguesWeapons.count - 1
        
        // on attribut les caractéristiques du personnage
        name = newName
        weapon = cataloguesWeapons[Int.random(in: 0...max)]
        healing = Int.random(in: 0...8)
    }
    
    
    
}
