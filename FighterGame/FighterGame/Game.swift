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
    
    
    func launchGame() {
        var choice = ""
        // on boucle à l'infinie pour recommencer une nouvelle partie
        while choice == "" {
            print("Tap 1 for start new game"
                + "\nTap 2 for exit")
            choice = readLine() ?? ""
            switch choice {
            case "1":
                
                // on sélectionne 1 pour commencer une nouvelle partie et on remet gameContinue sur true pour une nouvelle partie
                print("Start new game")
                startNewGame()
                
                // choice = "" afin de relancer une nouvelle partie
                choice = ""
            case "2":
                
                //pour sortir du while et quitter l'application
                break
                
            default:
                print("I don't understand your choice")
                choice = ""
            }
        }
    }
    
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
        } else if  playerOne.checkNameAlreadyExist(newName: newName) || playerTwo.checkNameAlreadyExist(newName: newName) { // on vérifie dans les deux équipes le nom
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
        var choice = ""
        var gameContinue = true
        var attackingPlayer = playerOne
        var defendingPlayer = playerTwo
        
        // on initialise le bonus avec un nombre aléatoire de 1 à 5
        var roundForBonus : Int = Int.random(in: 1...5)
        
        // on vérifie que gameContinue ne soit pas faux
        while gameContinue {
            
            // on ajoute un aux nombre de tour
            numberRound += 1
            
            // on vérifie que le nombre de tour correspond au nombre bonus
            if numberRound == roundForBonus {
                
                //on informe l'utilisateur qu'il a obtenu u bonus et on initialise le cadeau "present" avec une arme aléatoire
               print("You have bonus")
                bonus = Bonus().createBonus()
                numberBonus += 1
                // ajoute un nombre aléatoire pour le prochain bonus
                roundForBonus += Int.random(in: 1...5)
            } else {
                
                // sinon le cadeau vaut nil
                bonus = nil
            }
            
//            remplacer avec attackingPlayer et defendingPlayer
            
            
            // on vérifie qui doit jouer
           
                print("\(attackingPlayer.name) Attack !")
                choice = ""
                while choice == "" {
                    
                    // on demande ce que l'utilisateur veut effectuer
                    print("What do you want do: "
                            + "\n- 1 - Attack"
                            + "\n- 2 - Healing")
                    choice = readLine() ?? ""
                    
                    switch choice {
                    
                    case "1":
                        
                        // on fait une attack
                         let useBonus = askToUseBonus(weaponBonus: bonus)
                            
                        attackingPlayer.attack(playerDefense: defendingPlayer, weaponBonus: useBonus ? bonus : nil)
                        // après l'attaque on vérifie si la partie doit continuer ou s'arrêter
                        gameContinue = checkGameContinue(playerDefense: defendingPlayer, playerAttack: attackingPlayer)
                    case "2":
                        
                        // on soigne
                        attackingPlayer.healing()
                        
                    default:
                        print("I don't understand your response. \nTry again please")
                        choice = ""
                    }
                }
                // une fois l'acton faite on décharge le cadeau et on change le tour du joueur
                bonus = nil
                
                if attackingPlayer.name == playerOne.name {
                    attackingPlayer = playerTwo
                    defendingPlayer = playerOne
                } else {
                    attackingPlayer = playerOne
                    defendingPlayer = playerTwo
                }
        }
    }
}


//  bonus
extension Game {
    func askToUseBonus(weaponBonus: Weapon?) -> Bool {
        guard let weaponBonus = weaponBonus else {
           return false
        }
        // par défaut on utilise pas le bonus car il n'existe pas toujours
        
        var choice = ""
        
        print("Congratulation! \nTap 1- for use \(weaponBonus.name)(\(weaponBonus.damage)) \nTap 2- you select your hero")
        
        while choice == "" {
            choice = readLine() ?? ""
            
            switch choice {
            case "1":
                
                // on passe la variable à true si on utilise le bonus
                print("you choose a present")
                
            case "2":
                
                // on passe la variable à false si on utilise pas le bonus
                print("You choose your hero")
                return false
            default:
                print("I don't understand")
                choice = ""
            }
        }
        return false

    }
}

extension Game {
    func checkGameContinue(playerDefense: Player, playerAttack: Player) -> Bool {
        
        // si on 0 alors tout les personnages sont morts et la partie s'arrête grâce à la variable gameContinue false
        if playerDefense.characterStillAlive() == 0 {
            
            // on signal que la partie doit s'arrêter et on nomme le joueur gagnant
            print("\(playerAttack.name) win")
            return false
        } else {
            return true
        }
    }
    
    func CheckResponse(userChoice: String) -> Int {
        var choice = ""
        var response = 1
        while choice == "" {
            choice = readLine() ?? ""
            if let intChoice = Int(choice), [1,2,3].contains(intChoice) {
                response = intChoice
            } else {
                print("I don't understand your response"
                        + "\nTry again please")
                choice = ""
            }
        }
        return response
    }
}
