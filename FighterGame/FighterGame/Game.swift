//
//  Game.swift
//  FighterGame
//
//  Created by Yoan on 22/06/2021.
//

import Foundation

class Game {
    var playerOne: Player
    var playerTwo: Player
    var index = 1
    var numberRound : Int = 0
    var numberBonus: [Weapon] = []
    var bonus: Weapon?

    init() {
        playerOne = Player(name: "Player 1")
        playerTwo = Player(name: "Player 2")
    }
    
    /// launch game
    func startNewGame() {
        gameCreateTeam(player: playerOne)
        gameCreateTeam(player: playerTwo)
        roundByRound()
        presentStatistic()
    }
    
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
    
    private func listBonusUsed() {
        if numberBonus.count > 0 {
           print("\nYou have used \(numberBonus.count) bonus: it's")
            for bonus in numberBonus {
                print("\(bonus.name)(\(bonus.damage))")
            }
        }
    }
    
}

extension Game {
    
    /// Create team for player
    /// - Parameter player: it's player  should create team
    func gameCreateTeam(player: Player) {
        print("-----\(player.name) your turn ----")
        for index in 1...3 {
            print("Enter name of personage \(index)")
           var newName = InputReadLine.getStringUserInput()
            
            while characterNameNotExist(newName: newName) == false {
            newName = InputReadLine.getStringUserInput()
            }
            
            let newPerson = Character(newName: newName)
            newPerson.name = newName
            print("\(newPerson.name) has added in your team ")
            player.team.append(newPerson)
        }
        
        print("Successful! \n your team is create")
        print("-------\(player.name) your team is: -----------")
        player.listAllCharacters()
    }
    
    /// check if name doesn't ever exist
    /// - Parameter newName: it's new name for comparaison
    /// - Returns: if true newName doesn't exist in all teams if return false newName is not good.
    func characterNameNotExist(newName: String) ->Bool {
      if  playerOne.checkNameAlreadyExist(newName: newName) || playerTwo.checkNameAlreadyExist(newName: newName) {
            print("This name already exist in a teams. \nTry again please.")
            return false
        } else {
            return true
        }
    }
}

// fight round by round
extension Game {
    
    /// it's game of round by round until they are no hero alive in a team
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
    
    /// manage attack or heal. ask player want to do.
    /// - Parameters:
    ///   - attackingPlayer: player do game
    ///   - defendingPlayer: player in case receive attack
    func attackOrHealing(for attackingPlayer: Player, defendingPlayer: Player) {
        print("\(attackingPlayer.name) it's your turn !")
        print("What do you want do: "
                + "\n- 1 - Attack"
                + "\n- 2 - Healing")
        
        let choice = InputReadLine.getIntegerUserInput()
        
        switch choice {
        case 1:
            let randomBonus = Bonus.createRandomBonus()
            stockBonus(bonusCreate: randomBonus)
            attackingPlayer.attack(playerDefense: defendingPlayer, weaponBonus: randomBonus)
        case 2:
            attackingPlayer.healing()
        default:
            print("I don't understand your response. \nTry again please")
            attackOrHealing(for: attackingPlayer, defendingPlayer: defendingPlayer)
        }
    }
    
    /// for count number and stock bonus are used
    /// - Parameter bonusCreate: it's bonus create
    private func stockBonus(bonusCreate: Weapon?) {
        if let weapon = bonusCreate {
            numberBonus.append(weapon)
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
