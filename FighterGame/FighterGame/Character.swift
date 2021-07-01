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
   
    
    init (newName: String) {
        let cataloguesWeapons: [Weapons] = [Knife(), Gun(), Rocket(), Boomerang(), Flamethrower(), Rifle(), Grenade()]
        let max = cataloguesWeapons.count - 1
        name = newName
        weapon = cataloguesWeapons[Int.random(in: 0...max)]
        healing = Int.random(in: 0...8)
    }
    
    
    
}
