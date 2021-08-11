//
//  Player.swift
//  FighterGame
//
//  Created by Yoan on 25/06/2021.
//

import Foundation

class Player {
    var name: String
    var team: [Character] = []

    init(name: String) {
        self.name = name
    }

    /// Check if name exist in the team
    /// - Parameter name: it's name of comparaison
    /// - Returns: true if name exist and false if name doesn't exist
    func checkNameAlreadyExist(newName name: String) -> Bool {
        for character in team where character.name == name {
            return true
        }
        return false
    }

    /// list all characters with statistics in a team
    func listAllCharacters() {
        for indexOfCharacter in (0...team.count - 1) {
            team[indexOfCharacter].introduceCharacter(index: indexOfCharacter, filterAgainAlive: false)
        }
    }

    /// list character still alive
    /// - Parameter attacking: if attacking is true show print for introduce attack,
    ///  if false show introduce receive attack
    func showTeam(attacking: Bool) {
        let introduction = attacking ? "Select your character for attack." : "Select character receiving attack."
        print("--------- \(introduction) --------------")

        for indexOfCharacter in (0...team.count - 1) {
            team[indexOfCharacter].introduceCharacter(index: indexOfCharacter, filterAgainAlive: true)
        }
    }

    /// list character still alive and can healing
    /// - Parameter healing: select if show just still alive or can healing
    func showTeam(healing: Bool) {
        let introduction = healing ? "Select your doctor": "Select your hero to be treating"
        print("--------- \(introduction) ---------")

        if healing {
            for indexOfCharacter in (0...team.count - 1) {
                if team[indexOfCharacter].healing > 0 && team[indexOfCharacter].lifePoint > 0 {
                    print("\(indexOfCharacter + 1) - \(team[indexOfCharacter].name)"
                            + "\n❤️‍🩹\(team[indexOfCharacter].healing)")
                }
            }
        } else {

            for indexOfCharacter in (0...team.count - 1) {
                team[indexOfCharacter].introduceCharacter(index: indexOfCharacter, filterAgainAlive: true)
            }
        }
    }

    /// check if one of characters again alive
    /// - Returns: if one character is alive return true else return false. all character in team are died
    func characterStillAlive() -> Bool {
        for character in self.team where character.lifePoint > 0 {
                return true
        }
        return false
    }
}

// Attack
extension Player {

    /// Choose his character attack and choose character receive attack and impose damage
    /// - Parameters:
    ///   - playerDefense: hero receive attack
    ///   - weaponBonus: if player choose bonus weaponBonus impose damage if not player choose his hero
    func attack(playerDefense: Player, weaponBonus: Weapon?) {
        var heroAttack: Character = team[0]
        var heroDefense: Character

        if weaponBonus == nil {
            showTeam(attacking: true)
            heroAttack = choiceCharacter()
        }

        playerDefense.showTeam(attacking: false)

        heroDefense = playerDefense.choiceCharacter()

        if weaponBonus == nil {
            heroDefense.lifePoint -=  heroAttack.weapon.damage
        } else if let bonusWeapon = weaponBonus {
            heroDefense.lifePoint -= bonusWeapon.damage
        }
        if heroDefense.lifePoint < 0 {
            heroDefense.lifePoint = 0
        }

        print("\(heroDefense.name): ❤️\(heroDefense.lifePoint) - ")
    }

    ///  selection hero and check selection is good
    /// - Returns: hero choice by player
    private func choiceCharacter() -> Character {
        var character = team[0]
        var choice = InputReadLine.getIntegerUserInput()

            if [1, 2, 3].contains(choice) {
                choice -= 1

                if team[choice].lifePoint > 0 {
                    character = team[choice]
                } else {
                    print("\(team[choice].name) is died. \nSelect another hero please.")
                    return choiceCharacter()
                }

            } else {
                print("I don't understand your response"
                        + "\nTry again please")
                return choiceCharacter()
            }
        return character
    }
}

// Healing
extension Player {

    /// player see team, he select a doctor and select wounded
    func healing() {
        var doctor = team[0]
        var characterWounded = team[0]

        showTeam(healing: true)

        doctor = chooseDoctor()

        showTeam(healing: false)

        characterWounded = choiceCharacter()
        characterWounded.lifePoint += doctor.healing

        print("\(characterWounded.name) was treated: \n❤️ \(characterWounded.lifePoint)")
    }

    /// get choice player. this fonction check if character choice is alive and healing is > 0
    /// - Returns: if ok return character choice
    private func chooseDoctor() -> Character {
        var doctor = team[0]
        var choice = InputReadLine.getIntegerUserInput()

            if [1, 2, 3].contains(choice) {
                choice -= 1

                if team[choice].healing > 0 && team[choice].lifePoint > 0 {
                    doctor = team[choice]
                } else {
                    print("\(team[choice].name) can't healing")
                    return chooseDoctor()
                }
            }
        return doctor
    }
}
