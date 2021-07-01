//
//  Player.swift
//  FighterGame
//
//  Created by Yoan on 25/06/2021.
//

import Foundation

// create Team
class Player {
    var name: String
    var team: [Character] = []
    var playing = false
    
    
    init(name: String) {
        self.name = name
    }
    
    
//    func createTeam() {
//        print("-----\(name) begin----")
//        // on boucle tant que nous n'avons pas nos 3 personnages
//        for index in 1...3 {
//            print("Enter name of personage \(index)")
//            // on renseigne le nom du joueur
//            var newName = readLine()
//            // on boucle tant que characterName n'est pas different de faux
//            while newGame.characterNameExist(newName: newName ?? "") == false {
//                newName = readLine()
//            }
//
//            let newPerson: Character = Character(newName: newName ?? "")
//            newPerson.name = newName ?? ""
//            print("\(newPerson.name) has added in your team ")
//            team.append(newPerson)
//        }
//        print("Successful! \n your team is create")
//        print("-------\(name) your team is: -----------")
//        listTeam()
//    }
    
    
    // on vérifie que le nom ne soit pas déjà entré et on renvoie
    func checkNameAlreadyExist(newName name: String) -> Bool {
        // On parcours le tableau des deux équipes
        for nameAlreadyExist in team {
            if nameAlreadyExist.name == name {
                return true // ici le nombre de récurrence
            }
        }
        return false
    }
}

// liste Team
extension Player {
    
    func listTeam() {
        var index = 1
        for character in team {
            print("\(index) - \(character.name)"
                    + "\n❤️: \(character.lifePoint)"
                    + "\n⚔️: \(character.weapon)"
                    + "\n❤️‍🩹: \(character.healing)"
                    + "\n**********************")
            index += 1
        }
    }
}


// Attack round by round
extension Player {
    
    func attack(playerDefense: Player, weaponBonus: Weapons?) {
        gameContinue = makeAttack(playerDefense: playerDefense, weaponBonus: weaponBonus)
    }
    
    
    private func makeAttack(playerDefense: Player, weaponBonus: Weapons?) -> Bool {
        var heroAttack : Character = team[0]
        var heroDefense : Character
        var usePresent = false
        
        if weaponBonus != nil {
            print("Congratulation! \nTap 1- for use \(weaponBonus!) \nTap 2- you select your hero")
            var choice = ""
            while choice == "" {
                choice = readLine() ?? ""
                switch choice {
                case "1":
                    print("you choose a present")
                    usePresent = true
                case "2":
                    print("You choose your hero")
                    usePresent = false
                default:
                    print("I don't understand")
                    choice = ""
                }
            }
        }
        
        var index = 1
        if usePresent == false {
            print("--------- Select your Hero for attack.--------------")
            for heroAttack in team {
                if heroAttack.lifePoint > 0 {
                    print("- \(index) - \(heroAttack.name)"
                            + "\n❤️: \(heroAttack.lifePoint)"
                            + "\n⚔️\(heroAttack.weapon)"
                            + "\n❤️‍🩹: \(heroAttack.healing)"
                            + "\n*********************")
                    index += 1
                } else {
                    index += 1
                }
            }
            heroAttack = choiceAttack()
        }
        
        index = 1
        print("-------------- Select hero receiving attack. -----------------")
        for heroDefense in playerDefense.team {
            if heroDefense.lifePoint > 0 {
                print("- \(index) - \(heroDefense.name)"
                        + "\n❤️: \(heroDefense.lifePoint)"
                        + "\n⚔️\(heroDefense.weapon)"
                        + "\n❤️‍🩹 \(heroDefense.healing)")
                index += 1
            } else {
                index += 1
            }
        }
        
        index = 0
        
        heroDefense = choiceDefense(playerDefense: playerDefense)
        
        if usePresent == false {
            heroDefense.lifePoint -=  heroAttack.weapon.damages
        } else {
            heroDefense.lifePoint -= weaponBonus!.damages
        }
        print("\(heroDefense.name): ❤️\(heroDefense.lifePoint) - ")
        
        for character in playerDefense.team {
            if character.lifePoint > 0 {
            } else {
                index += 1
            }
        }
        if index >= 3 {
            gameContinue = false
            print("\(name) win")
        } else {
            gameContinue = true
        }
        return gameContinue
    }
    
    private func choiceAttack()-> Character {
        var choice = ""
        var heroAttack = team[0]
        while choice == "" {
            choice = readLine() ?? ""
            switch choice {
            case "1":
                if team[0].lifePoint > 0 {
                    heroAttack = team[0]
                } else {
                    print("\(team[0].name) is died. Select another hero")
                    choice = ""
                }
            case "2":
                if team[1].lifePoint > 0 {
                    heroAttack = team[1]
                } else {
                    print("\(team[1].name) is died. Select another hero")
                    choice = ""
                }
            case "3":
                if team[2].lifePoint > 0 {
                    heroAttack = team[2]
                } else {
                    print("\(team[2].name) is died. Select another hero")
                    choice = ""
                }
            default:
                print("I don't understand your response")
                choice = ""
            }
        }
        return heroAttack
    }
    
    private func choiceDefense(playerDefense: Player) -> Character {
        var choice = ""
        var heroDefense = playerDefense.team[0]
        while choice == "" {
            choice = readLine() ?? ""
            switch choice {
            case "1":
                if playerDefense.team[0].lifePoint > 0 {
                    heroDefense = playerDefense.team[0]
                } else {
                    print("\(playerDefense.team[0].name) is died. Select another hero")
                    choice = ""
                }
            case "2":
                if playerDefense.team[1].lifePoint > 0 {
                    heroDefense = playerDefense.team[1]
                } else {
                    print("\(playerDefense.team[1].name) is died. Select another hero")
                    choice = ""
                }
            case "3":
                if playerDefense.team[2].lifePoint > 0 {
                    heroDefense = playerDefense.team[2]
                } else {
                    print("\(playerDefense.team[2].name) is died. Select another hero")
                    choice = ""
                }
            default:
                print("I don't understand your response")
                choice = ""
            }
        }
        return heroDefense
    }
}

// Healing
extension Player {
    
    func healing() {
        var doctor : Int
        var index = 1
        var heroWounded = team[0]
        print("******** Select your doctor")
        
            for character in team {
                if character.healing > 0 && character.lifePoint > 0 {
                    print("\(index) - \(character.name)"
                            + "\n❤️‍🩹\(character.healing)")
                }
                index += 1
            }
        doctor = chooseDoctor()
        
        print("******** Select your hero to be treating")
            index = 1
            for character in team {
                if character.lifePoint > 0 {
                    print("\(index) - \(character.name)"
                            + "\n❤️\(character.lifePoint)")
                }
                index += 1
            }
        
        heroWounded = chooseHeroWounded()
        heroWounded.lifePoint += doctor
        
        print("\(heroWounded.name) was treated: \n❤️ \(heroWounded.lifePoint)")
    }
    
    private func chooseDoctor() -> Int {
        var choice = ""
        var doctor = team[0].healing
        
        while choice == "" {
            choice = readLine() ?? ""
            switch choice {
            case "1":
                if team[0].healing > 0 && team[0].lifePoint > 0 {
                    doctor = team[0].healing
                } else {
                    print("\(team[0].name) can't healing")
                    choice = ""
                }
            case "2":
                if team[1].healing > 0 && team[1].lifePoint > 0 {
                    doctor = team[1].healing
                } else {
                    print("\(team[1].name) can't healing")
                    choice = ""
                }
            case "3":
                if team[2].healing > 0 && team[2].lifePoint > 0 {
                    doctor = team[1].healing
                } else {
                    print("\(team[2].name) can't healing")
                    choice = ""
                }
            default:
                print("I donc't understand")
                choice = ""
            }
        }
        return doctor
    }
    
    private func chooseHeroWounded() -> Character {
        var heroWounded = team[0]
        var choice = ""
        while choice == "" {
            choice = readLine() ?? ""
            switch choice {
            case "1":
                if team[0].lifePoint > 0 {
                    heroWounded = team[0]
                } else {
                    print("\(team[0].name) is died.")
                    choice = ""
                }
            case "2":
                if team[1].lifePoint > 0 {
                    heroWounded = team[1]
                } else {
                    print("\(team[1].name) is died.")
                    choice = ""
                }
                
            case "3":
                if team[2].lifePoint > 0 {
                    heroWounded = team[1]
                } else {
                    print("\(team[2].name) is died.")
                    choice = ""
                }
            default:
                print("I donc't understand")
                choice = ""
            }
        }
        return heroWounded
    }
}
