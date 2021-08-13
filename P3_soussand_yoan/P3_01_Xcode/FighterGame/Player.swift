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
}

// in start game
extension Player {
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
}

// In roundByRound
extension Player {
    /// Choose his character attack and choose character receive attack and impose damage
    /// - Parameters:
    ///   - playerDefense: hero receive attack
    ///   - weaponBonus: if player choose bonus weaponBonus impose damage if not player choose his hero
    func makeAction(playerDefense: Player, weaponBonus: Weapon?, actionChoose: Int) {
        var principalCharacter: Character = team[0]
        var receptor: Character

        switch actionChoose {
        case 1:
            if weaponBonus == nil {
                principalCharacter = choiceCharacter(for: .attacking)
            }

            receptor = playerDefense.choiceCharacter(for: .defending)

            if weaponBonus == nil {
                receptor.lifePoint -=  principalCharacter.weapon.damage
            } else if let bonusWeapon = weaponBonus {
                receptor.lifePoint -= bonusWeapon.damage
            }
            if receptor.lifePoint < 0 {
                receptor.lifePoint = 0
            }

            print("\(receptor.name): ❤️\(receptor.lifePoint) - ")
        case 2:
            principalCharacter = choiceCharacter(for: .doctor)
            receptor = choiceCharacter(for: .healing)
            receptor.lifePoint += principalCharacter.healing
            print("\(receptor.name) was treated: \n❤️ \(receptor.lifePoint)")
        default:
            Game().attackOrHealing(for: self, defendingPlayer: playerDefense)
        }
    }

    ///  selection hero and check selection is good
    /// - Returns: hero choice by player
    private func choiceCharacter(for action: CaseIntroduce) -> Character {
        var character = team[0]

        introduceAction(action: action)

        var choice = InputReadLine.getIntegerUserInput()

        if [1, 2, 3].contains(choice) {
            choice -= 1

            if team[choice].lifePoint > 0 {
                character = team[choice]
            } else {
                print("\(team[choice].name) is died. \nSelect another character please.")
                return choiceCharacter(for: action)
            }

        } else {
            print("I don't understand your response"
                    + "\nTry again please")
            return choiceCharacter(for: action)
        }
        return character
    }

    /// different action of play
    private enum CaseIntroduce {
        case attacking, defending, doctor, healing
    }

    /// print and show team  in pending action
    /// - Parameter action: is pending action
    private func introduceAction(action: CaseIntroduce) {
        var introduce = ""

        switch action {
        case .attacking:
            introduce = "Select your character for attack."
        case .defending:
            introduce = "Select character receiving attack."
        case .healing:
            introduce = "Select your hero to be treating"
        case .doctor:
            introduce = "Select your doctor"
        }

        print("\(introduce)")
        showTeam(action: action)
    }

    /// list character still alive and can healing
    /// - Parameter healing: select if show just still alive or can healing
    private func showTeam(action: CaseIntroduce) {
        if action == .doctor {
            for indexOfCharacter in (0...team.count - 1) {
                team[indexOfCharacter].introduceDoctor(index: indexOfCharacter)
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
        for character in team where character.lifePoint > 0 {
            return true
        }
        return false
    }
}