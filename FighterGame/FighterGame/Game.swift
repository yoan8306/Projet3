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
    var numberBonus: Int = 0
    var bonus: Weapon?

    
    //on initialise le nom des joueurs par défaut
    init() {
        playerOne = Player(name: "Player 1")
        playerTwo = Player(name: "Player 2")
    }
    
    
//  static func launchGame() {
//
//
//    print("Tap 1 for start new game"
//            + "\nTap 2 for exit")
//
//    // on boucle à l'infinie pour recommencer une nouvelle partie
//    //        while choice == "" {
//    //            choice = readLine() ?? ""
//    var choice = InputReadLine.getIntegerUserInput(switchCase: [1, 2])
//    switch choice {
//    case 1:
//
//        // on sélectionne 1 pour commencer une nouvelle partie et on remet gameContinue sur true pour une nouvelle partie
//        print("Start new game")
//        Game().startNewGame()
//        Game.launchGame()
//
//    case 2:
//
//        //pour sortir du while et quitter l'application
//        break
//
//    default:
//        choice = InputReadLine.getIntegerUserInput(switchCase: [1, 2])
//    }
//    //        }
//    }
    
    private func startNewGame() {
        // on créée les équipes des joueurs 1 et 2
        gameCreateTeam(player: playerOne)
        gameCreateTeam(player: playerTwo)
    
        //combat tour par tour jusqu'a la sortie de la fonction
        roundByRound()

        // les caractéristiques du jeux
        presentStatistic()
    }
    
    private func presentStatistic() {
        print("\nYou have played \(numberRound) round"
                + "\nYou have \(numberBonus) bonus"
                + "\n############ \(playerOne.name) your team was: ")
        playerOne.listAllCharacters()
        print("\n############ \(playerTwo.name) your team was: ")
        playerTwo.listAllCharacters()
        print("Game Over")
    }
}




// check character name already exist
extension Game {
    
    func gameCreateTeam(player: Player) {
        print("-----\(player.name) begin----")
        
        // on boucle tant que nous n'avons pas nos 3 personnages
        for index in 1...3 {
            print("Enter name of personage \(index)")
            
            // on récupère le nom du joueur inscrit par l'utilisateur
            var newName = readLine()
            
            // on boucle tant que characterNameNotExist n'est pas different de faux
            while characterNameNotExist(newName: newName ?? "") == false {
                
                //sinon on demande un nouveau nom
                newName = readLine()
            }
            
            // créée une nouvelle personne
            let newPerson: Character = Character(newName: newName ?? "")
            newPerson.name = newName ?? ""
            print("\(newPerson.name) has added in your team ")
            player.team.append(newPerson)
        }
        print("Successful! \n your team is create")
        print("-------\(player.name) your team is: -----------")
        
        // on liste l'équipe créée
        player.listAllCharacters()
    }
    
    func characterNameNotExist(newName: String) ->Bool {
        // on vérifie que le paramètre soit bien renseigné sinon la fonction renvoie la valeur faux avec le message associé.
        if newName == "" {
            print("I don't understand your response. \nTry again please.")
            return false
            
            // on vérifie que le nom ne soit pas présent dans une des deux équipes
        } else if  playerOne.checkNameAlreadyExist(newName: newName) || playerTwo.checkNameAlreadyExist(newName: newName) {
            print("This name already exist in a teams. \nTry again please.")
            return false
        } else {
            return true
        }
    }
}


// fight round by round
extension Game {
    
    private func roundByRound() {
        var gameContinue = true
        var attackingPlayer = playerOne
        var defendingPlayer = playerTwo
        
        // on vérifie que gameContinue ne soit pas faux
        while attackingPlayer.characterStillAlive() {
            attackOrHealing(for: attackingPlayer, defendingPlayer: defendingPlayer)
            // on vérifie si la partie doit continuer ou s'arrêter
           // gameContinue = checkGameContinue(playerDefense: defendingPlayer, playerAttack: attackingPlayer)
            attackingPlayer = changePlayer(player: attackingPlayer)
            defendingPlayer = changePlayer(player: defendingPlayer)
        }
        
        print("\(defendingPlayer.name) win")

    }

    func attackOrHealing(for attackingPlayer: Player, defendingPlayer: Player) {
        print("\(attackingPlayer.name) it's your turn !")
        print("What do you want do: "
                + "\n- 1 - Attack"
                + "\n- 2 - Healing")
        
        let choice = InputReadLine.getIntegerUserInput(switchCase: [1, 2])
        switch choice {
        case 1:
            let randomBonus = Bonus.createRandomBonus()
            attackingPlayer.attack(playerDefense: defendingPlayer, weaponBonus: randomBonus)
        case 2:
            print("heal")
            attackingPlayer.healing()

        default:
            print("I don't understand your response. \nTry again please")
            attackOrHealing(for: attackingPlayer, defendingPlayer: defendingPlayer)
        }
    }
    
    private func changePlayer(player: Player) -> Player {
        if player.name == playerOne.name {
            return playerTwo
        } else {
            return playerOne
        }
    }
    
}


//  bonus
extension Game {
//    func askToUseBonus(weaponBonus: Weapon?) -> Bool {
//        var choice = ""
//
////        on vérifie si weaponsBonus contient quelque chose
//        guard let weaponBonus = weaponBonus else {
//           return false
//        }
//
//        print("Congratulation! \nTap 1- for use \(weaponBonus.name)(\(weaponBonus.damage)) \nTap 2- you select your hero")
//
//
//        while choice == "" {
//            choice = readLine() ?? ""
//            switch choice {
//            case "1":
//
//                // on passe la variable à true si on utilise le bonus
//                print("you choose a present")
//                return true
//            case "2" :
//
//                // on passe la variable à false si on utilise pas le bonus
//                print("You choose your hero")
//                return false
//            default:
//            choice = ""
//            }
//        }
//        return false
//
//    }
}

extension Game {
//    func checkGameContinue(playerDefense: Player, playerAttack: Player) -> Bool {
//
//        // si on 0 alors tout les personnages sont morts et la partie s'arrête grâce à la variable gameContinue false
//        if playerDefense.characterStillAlive() == 0 {
//
//            // on signal que la partie doit s'arrêter et on nomme le joueur gagnant
//            print("\(playerAttack.name) win")
//            return false
//        } else {
//            return true
//        }
//    }
}
