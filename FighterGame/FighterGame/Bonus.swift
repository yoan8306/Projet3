//
//  Bonus.swift
//  FighterGame
//
//  Created by Yoan on 28/07/2021.
//

import Foundation

struct Bonus {
    
    func createBonus() ->Weapon {
        //on récupère la valeur max du catalogue d'armes
        let max = Weapon.allWeapons.count - 1
        
        // on sélectionne aléatoirement une arme
        return Weapon.allWeapons[Int.random(in: 0...max)]
    }
    
}
