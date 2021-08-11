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

    init(damage: Int, name: String) {
        self.damage = damage
        self.name = name
    }

    static var allWeapons: [Weapon] {
        [Knife(),
         Gun(),
         Rocket(),
         Boomerang(),
         Flamethrower(),
         Rifle(),
         Grenade()]
    }
}

class Knife: Weapon {
    init() {
        super.init(damage: Int.random(in: 1...5), name: "Knife")
    }
}

class Gun: Weapon {
    init() {
        super.init(damage: Int.random(in: 10...14), name: "Gun")
    }
}

class Rocket: Weapon {
    init() {
        super.init(damage: Int.random(in: 15...25), name: "Rocket")
    }
}

class Boomerang: Weapon {
    init() {
        super.init(damage: Int.random(in: 1...10), name: "Boomerang")
    }
}

class Flamethrower: Weapon {
    init() {
        super.init(damage: Int.random(in: 10...20), name: "Flamethrower")
    }
}

class Rifle: Weapon {
    init() {
        super.init(damage: Int.random(in: 10...20), name: "Rifle")
    }
}

class Grenade: Weapon {
    init() {
        super.init(damage: Int.random(in: 1...20), name: "Grenade")
    }
}
