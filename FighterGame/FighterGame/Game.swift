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
    var choice = ""
    var numberRound : Int = 0
    var present: Weapons?
    
    init() {
        playerOne = Player(name: "Player 1")
        playerTwo = Player(name: "Player 2")
    }
    
    func startNewGame() {
        gameCreateTeam(player: playerOne)
        gameCreateTeam(player: playerTwo)
        roundByRound()
        print("\nYou have played \(numberRound) round"
                + "\n############ \(playerOne.name) your team was: ")
        playerOne.listTeam()
        print("\n############ \(playerTwo.name) your team was: ")
        playerTwo.listTeam()
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
            
            // on renseigne le nom du joueur
            var newName = readLine()
            
            // on boucle tant que characterName n'est pas different de faux
                while characterNameExist(newName: newName ?? "") == false {
                    newName = readLine()
                }
            
            let newPerson: Character = Character(newName: newName ?? "")
                newPerson.name = newName ?? ""
                print("\(newPerson.name) has added in your team ")
                player.team.append(newPerson)
        }
        print("Successful! \n your team is create")
        print("-------\(player.name) your team is: -----------")
    }
    
    func characterNameExist(newName: String) ->Bool {
        // on vérifie que le paramètre soit bien renseigné sinon la fonction renvoie la valeur faux avec le message associé.
        if newName == "" {
            print("I don't understand your response. \nTry again please.")
            return false
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
        var bonus : Int = Int.random(in: 1...5)
        choice = ""
        
        while gameContinue {
            numberRound += 1
            if numberRound == bonus {
                print("You have bonus")
                present = randomBonus()
                bonus += Int.random(in: 1...5)
                print("next bonus in \(bonus) round")
            } else {
                present = nil
            }
            if playerOne.playing == true {
                print("\(playerOne.name) Attack !")
                choice = ""
                while choice == "" {
                    print("What do you want do: " + "\n- 1 - Attack" + "\n- 2 - Healing")
                    choice = readLine() ?? ""
                    switch choice {
                    case "1":
                        playerOne.attack(playerDefense: playerTwo, weaponBonus: present)
                    case "2":
                        playerOne.healing()
                    default:
                        print("I don't understand your response. \nTry again please")
                        choice = ""
                    }
                }
                present = nil
                playerOne.playing = false
                playerTwo.playing = true
                
            } else {
                print("\(playerTwo.name) Attack !")
                choice = ""
                while choice == "" {
                    print("What do you want do: " + "\n- 1 - Attack" + "\n- 2 - Healing")
                    choice = readLine() ?? ""
                    switch choice {
                    case "1":
                        playerTwo.attack(playerDefense: playerOne, weaponBonus: present)
                    case "2":
                        playerTwo.healing()
                    default:
                        print("I don't understand your response. \nTry again please")
                        choice = ""
                    }
                }
                present = nil
                playerOne.playing = true
                playerTwo.playing = false
            }
        }
    }
}


// create bonus
extension Game {
    private func randomBonus()-> Weapons{
        var weapon : Weapons
        let cataloguesWeapons: [Weapons] = [Knife(), Gun(), Rocket(), Boomerang(), Flamethrower(), Rifle(), Grenade()]
        let max = cataloguesWeapons.count - 1
        weapon = cataloguesWeapons[Int.random(in: 0...max)]
        return weapon
    }
}
