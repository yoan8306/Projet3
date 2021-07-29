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
        let max = CataloguesWeapons().all.count - 1
        
        // on sélectionne aléatoirement une arme
        return CataloguesWeapons().all[Int.random(in: 0...max)]
    }
    
}
