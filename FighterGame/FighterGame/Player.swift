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
    var playing = false
    
    // on initialise le nom du joueur automatiquemet
    init(name: String) {
        self.name = name
    }
    
    
    // on vérifie que le nom du personnage ne soit pas déjà entré et on renvoie un booléen
    func checkNameAlreadyExist(newName name: String) -> Bool {
        
        // On parcours le tableau de l'équipe
        for nameAlreadyExist in team {
            if nameAlreadyExist.name == name {
                return true // ici le nombre de récurrence
            }
        }
        return false
    }
}


extension Player {
    // on liste l'équipe avec leur caractéristique
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



extension Player {
    // ici l'attaque on idientifie le joueur en défense et on met le bonus si présent en paramètre.
    func attack(playerDefense: Player, weaponBonus: Weapons?) {
        
        // l'action de l'attaque renvoie un booléen pour renseigner la variable gameContinue si la partie continue ou non
        gameContinue = makeAttack(playerDefense: playerDefense, weaponBonus: weaponBonus)
    }
    
    
    private func makeAttack(playerDefense: Player, weaponBonus: Weapons?) -> Bool {
        var heroAttack : Character = team[0]
        var heroDefense : Character
        
        // par défaut usePresent et false car si il n'y a pas de bonus on n'exécutera pas le code associé. '
        var usePresent = false
        
        // on vérifie notre paramètre si il y a un bonus
        if weaponBonus != nil {
            
            //on informe l'utilisateur de la présence du bonus
            print("Congratulation! \nTap 1- for use \(weaponBonus!) \nTap 2- you select your hero")
            var choice = ""
            while choice == "" {
                choice = readLine() ?? ""
                switch choice {
                case "1":
                    
                    // on passe la variable usePresent à true si on utilise le bonus
                    print("you choose a present")
                    usePresent = true
                case "2":
                    
                    // on passe la variable usePresent à false si on utilise pas le bonus
                    
                    print("You choose your hero")
                    usePresent = false
                default:
                    print("I don't understand")
                    choice = ""
                }
            }
        }
        
        // on met l'index à 1 pour obtenir le bon numéro pour le choix de l'utilisateur
        var index = 1
        
        //on vérifie si on doit utiliser le bonus ou si on doit sélectionner un attaquant.
        if usePresent == false {
            
            print("--------- Select your Hero for attack.--------------")
            for heroAttack in team {
                
                //on ne liste que les personnages en vie
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
            // on récupère le choix de l'utilisateur
            heroAttack = choiceAttack()
        }
        
        // on remet la valeur à 1
        index = 1
        
        // on sélectionne le personnage qui doit recevoir l'attaque
        print("-------------- Select hero receiving attack. -----------------")
        for heroDefense in playerDefense.team {
            
            // on ne liste que les personnages en vie
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
        
        // on récupère le choix de l'utilisateur
        heroDefense = choiceDefense(playerDefense: playerDefense)
        
        // on vérifie si nous devons utiliser le bonus pour infliger les dégats sur la personne attaqué
        if usePresent == false {
            heroDefense.lifePoint -=  heroAttack.weapon.damages
        } else {
            heroDefense.lifePoint -= weaponBonus!.damages
        }
        
        // on informe du succès de l'attaque
        print("\(heroDefense.name): ❤️\(heroDefense.lifePoint) - ")
        
        // on vérifie si le jeux continue en comptant le nombre de personnage ayant des points de vie
        for character in playerDefense.team {
            if character.lifePoint > 0 {
            } else {
                
                // on ajoute 1 a chaque personnage mort
                index += 1
            }
        }
        
        // si on a compté 3 ou plus tout les personnages sont morts et la partie s'arrête grace à la variable gameContinue false
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
                
                // on vérifie que le choix sélectionner correspond à un joueur encore en vie
                if team[0].lifePoint > 0 {
                    heroAttack = team[0]
                } else {
                    print("\(team[0].name) is died. Select another hero")
                    choice = ""
                }
            case "2":
                
                // on vérifie que le choix sélectionner correspond à un joueur encore en vie
                if team[1].lifePoint > 0 {
                    heroAttack = team[1]
                } else {
                    print("\(team[1].name) is died. Select another hero")
                    choice = ""
                }
            case "3":
                
                // on vérifie que le choix sélectionner correspond à un joueur encore en vie
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
                
                // on vérifie que le choix sélectionner correspond à un joueur encore en vie
                if playerDefense.team[0].lifePoint > 0 {
                    heroDefense = playerDefense.team[0]
                } else {
                    print("\(playerDefense.team[0].name) is died. Select another hero")
                    choice = ""
                }
            case "2":
                
                // on vérifie que le choix sélectionner correspond à un joueur encore en vie
                if playerDefense.team[1].lifePoint > 0 {
                    heroDefense = playerDefense.team[1]
                } else {
                    print("\(playerDefense.team[1].name) is died. Select another hero")
                    choice = ""
                }
            case "3":
                
                // on vérifie que le choix sélectionner correspond à un joueur encore en vie
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
