//
//  Weapons.swift
//  FighterGame
//
//  Created by Yoan on 15/06/2021.
//

import Foundation

protocol Weapon {
    // valeur de l'arme en lecture seul != elle ne peut pas être modifié une fois que l'arme à été créée
    var damages: Int { get }
}


// j'utilise des structures car il n'y a pas de logique à gérer.
struct Knife: Weapon {
    var damages = Int.random(in: 1...5)
}

struct Gun: Weapon {
    var damages = Int.random(in: 10...14)
}

struct Rocket: Weapon {
    var damages = Int.random(in: 15...25)
}

struct Boomerang: Weapon {
    var damages = Int.random(in: 1...9)
}

struct Flamethrower: Weapon {
    var damages = Int.random(in: 10...20)
}

struct Rifle: Weapon {
    var damages = Int.random(in: 10...20)
}

struct Grenade: Weapon {
    var damages = Int.random(in: 1...20)
}

struct CataloguesWeapons {
    let all: [Weapon] =  [Knife(), Gun(), Rocket(), Boomerang(), Flamethrower(), Rifle(), Grenade()]
}
