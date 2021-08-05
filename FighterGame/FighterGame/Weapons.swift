//
//  Weapons.swift
//  FighterGame
//
//  Created by Yoan on 15/06/2021.
//

import Foundation

class Weapon {
    var damage: Int
    var name: String
    
    static var allWeapons: [Weapon] {
        [Knife(damage: 0, name: "Knife"),
         Gun(damage: 0, name: "Gun"),
         Rocket(damage: 0, name: "Rocket"),
         Boomerang(damage: 0, name: "Boomerang"),
         Flamethrower(damage: 0, name: "Flamethrower"),
         Rifle(damage: 0, name: "Rifle"),
         Grenade(damage: 0, name: "Grenade") ]
    }
    
    init(damage: Int, name: String) {
        self.damage = damage
        self.name = name
    }
}

class Knife: Weapon {
    override init(damage: Int, name: String) {
        super.init(damage: Int.random(in: 1...5), name: "Knife")
    }
}

class Gun: Weapon {
    override init(damage: Int, name: String) {
        super.init(damage: Int.random(in: 10...14), name: "Gun")
    }
}

class Rocket: Weapon {
    override init(damage: Int, name: String) {
        super.init(damage: Int.random(in: 15...25), name: "Rocket")
    }
}

class Boomerang: Weapon {
    override init(damage: Int, name: String) {
        super.init(damage: Int.random(in: 1...10), name: "Boomerang")
    }
}

class Flamethrower: Weapon {
    override init(damage: Int, name: String) {
        super.init(damage: Int.random(in: 10...20), name: "Flamethrower")
    }
}

class Rifle: Weapon {
    override init(damage: Int, name: String) {
        super.init(damage: Int.random(in: 10...20), name: "Rifle")
    }
}

class Grenade: Weapon {
    override init(damage: Int, name: String) {
        super.init(damage: Int.random(in: 1...20), name: "Grenade")
    }
}
