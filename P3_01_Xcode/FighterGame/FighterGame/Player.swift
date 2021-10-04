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
}

// In roundByRound
extension Player {
    /// Choose his character attack and choose character receive attack and impose damage
    /// - Parameters:
    ///   - playerDefense: hero receive attack
    ///   - weaponBonus: if player choose bonus weaponBonus impose damage if not player choose his hero
    func makeAction(playerDefense: Player, weaponBonus: Weapon?, actionChoose: ActionEnum) {
        var playingCharacter: Character = team[0]
        var target: Character

        switch actionChoose {
        case .attack:
            if weaponBonus == nil {
                playingCharacter = choiceCharacter(for: .attacking)
            }
            target = playerDefense.choiceCharacter(for: .defending)
            playingCharacter.doAttack(target: target, weaponBonus: weaponBonus)
        case .heal:
            playingCharacter = choiceCharacter(for: .doctor)
            target = choiceCharacter(for: .healing)
            playingCharacter.doHealing(target: target)
        }
    }

    ///  selection hero and check selection is good
    /// - Returns: hero choice by player
    private func choiceCharacter(for action: ActionType) -> Character {
        var character = team[0]

        introduceTeam(action: action)

        var choice = InputReadLine.getIntegerUserInput()

        if [1, 2, 3].contains(choice) {
            choice -= 1

            if team[choice].lifePoint > 0 {
                character = team[choice]
            } else {
                print("\(team[choice].name) is died. \nSelect another character please.\n")
                return choiceCharacter(for: action)
            }
        } else {
            print("I don't understand your response"
                    + "\nTry again please\n")
            return choiceCharacter(for: action)
        }
        return character
    }

    /// list character still alive and can healing or list only character still alive
    /// - Parameter action: inform what action is pending
    private func introduceTeam(action: ActionType) {
        print("\(introduceAction(action: action))")

        if action == .doctor {
            for indexOfCharacter in (0...team.count - 1) {
                team[indexOfCharacter].introduceDoctor(index: indexOfCharacter)
            }
        } else {
            for indexOfCharacter in (0...team.count - 1) where team[indexOfCharacter].lifePoint > 0 {
                team[indexOfCharacter].introduceCharacter(index: indexOfCharacter)
            }
        }
    }

    /// stock phrase in pending action
    /// - Parameter action: is pending action
    private func introduceAction(action: ActionType) -> String {
        switch action {
        case .attacking:
            return "\nSelect your character for attack.\n"
        case .defending:
            return "\nSelect character receiving attack.\n"
        case .healing:
            return "\nSelect your hero to be treating\n"
        case .doctor:
            return "\nSelect your doctor\n"
        }
    }

    /// list all characters with statistics in a team
    func listAllCharacters() {
        for indexOfCharacter in (0...team.count - 1) {
            team[indexOfCharacter].introduceCharacter(index: indexOfCharacter)
        }
    }

    /// check if one of characters again alive
    /// - Returns: if one character is alive return true and game continue.
    ///           if all character in team are died return false and game is finish
    func characterStillAlive() -> Bool {
        for character in team where character.lifePoint > 0 {
            return true
        }
        return false
    }
}
