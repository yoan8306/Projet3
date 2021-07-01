//
//  Weapons.swift
//  FighterGame
//
//  Created by Yoan on 15/06/2021.
//

import Foundation

protocol Weapons {
    var damages: Int { get }
}

struct Knife: Weapons {
    var damages = Int.random(in: 1...5)
}

struct Gun: Weapons {
    var damages = Int.random(in: 10...14)
}

struct Rocket: Weapons {
    var damages = Int.random(in: 15...25)
}

struct Boomerang: Weapons {
    var damages = Int.random(in: 1...9)
}

struct Flamethrower: Weapons {
    var damages = Int.random(in: 10...20)
}

struct Rifle: Weapons {
    var damages = Int.random(in: 10...20)
}

struct Grenade: Weapons {
    var damages = Int.random(in: 1...20)
}
