//
//  Game.swift
//  FighterGame
//
//  Created by Yoan on 22/06/2021.
//

import Foundation

class Game {
    private var playerOne: Player
    private var playerTwo: Player
    private var numberRound = 0
    private let bonus = Bonus()

    init() {
        playerOne = Player(name: "Player 1")
        playerTwo = Player(name: "Player 2")
    }

    /// evolution of the game
    func startNewGame() {
        gameCreateTeam(player: playerOne)
        gameCreateTeam(player: playerTwo)
        roundByRound()
        presentStatistic()
    }
}

// For start game
extension Game {

    /// Create team for player
    /// - Parameter player: it's player who should create team
    private func gameCreateTeam(player: Player) {
        print("-----\(player.name) it's your turn ----")
        for index in 1...3 {
            print("Enter the name of character \(index)")
            var newName = InputReadLine.getStringUserInput()

            while characterNameAlreadyExist(newName: newName) {
                newName = InputReadLine.getStringUserInput()
            }

            player.team.append(Character(newName: newName))
            print("\n\(newName) has added in your team\n")
        }

        print("Successful ! \nYour team is created\n")
        print("-------\(player.name) your team is: -----------\n")
        player.listAllCharacters()
    }

    /// check if name doesn't exist
    /// - Parameter newName: it's new name for comparaison
    /// - Returns: if false newName doesn't exist in all teams / return  true if newName already exist.
    private func characterNameAlreadyExist(newName: String) -> Bool {
        if  playerOne.checkNameAlreadyExist(newName: newName) || playerTwo.checkNameAlreadyExist(newName: newName) {
            print("This name already exist in a team. \nTry again please.")
            return true
        } else {
            return false
        }
    }
}

// fight round by round
extension Game {
    /// it's game of round by round until they are no character alive in a team
    private func roundByRound() {
        var attackingPlayer = playerOne
        var defendingPlayer = playerTwo

        while attackingPlayer.characterStillAlive() {
            numberRound += 1
            attackOrHealing(for: attackingPlayer, defendingPlayer: defendingPlayer)
            attackingPlayer = changePlayer(player: attackingPlayer)
            defendingPlayer = changePlayer(player: defendingPlayer)
        }
        print("\(defendingPlayer.name) win")
    }

    /// manage attack or heal. ask player what he want to do.
    /// randomBonus is optional
    /// - Parameters:
    ///   - attackingPlayer: player playing
    ///   - defendingPlayer: player in case receive attack
    private func attackOrHealing(for attackingPlayer: Player, defendingPlayer: Player) {
        print("\(attackingPlayer.name) it's your turn !")
        print("What do you want to do: "
                + "\n- 1 - Attacking"
                + "\n- 2 - Healing")
        let choice = InputReadLine.getIntegerUserInput()
        switch choice {
        case 1, 2:
            let randomBonus = bonus.createRandomBonus()
            let action: ActionEnum = choice == 1 ? .attack : .heal
            attackingPlayer.makeAction(playerDefense: defendingPlayer, weaponBonus: randomBonus, actionChoose: action)

        default:
            print("I don't understand your response. \nTry again please")
            attackOrHealing(for: attackingPlayer, defendingPlayer: defendingPlayer)
        }
    }

    /// change turn player
    /// - Parameter player: player went playing
    /// - Returns: player will play
    private func changePlayer(player: Player) -> Player {
        if player.name == playerOne.name {
            return playerTwo
        } else {
            return playerOne
        }
    }
}

// End game
extension Game {
    /// present statistic at the end game
    private func presentStatistic() {
        print("\nYou have played \(numberRound) round")
        listBonusUsed()
        print("\n############ \(playerOne.name) your team was: ")
        playerOne.listAllCharacters()
        print("\n############ \(playerTwo.name) your team was: ")
        playerTwo.listAllCharacters()
        print("Game Over")
    }

    /// indicate number bonus used and list them
    private func listBonusUsed() {
        guard !bonus.bonusUsed.isEmpty else {
            return
        }

        print("\nYou have used \(bonus.bonusUsed.count) bonus: it's")
        for bonus in bonus.bonusUsed {
            print("\(bonus.name)(\(bonus.damage))")
        }
    }
}
