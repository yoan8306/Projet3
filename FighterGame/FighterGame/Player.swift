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
    
    // on initialise le nom du joueur automatiquement
    init(name: String) {
        self.name = name
    }
    
    
    // on vérifie que le nom du personnage ne soit pas déjà entré et on renvoie un booléen
    func checkNameAlreadyExist(newName name: String) -> Bool {
        // On parcours le tableau de l'équipe
        for nameAlreadyExist in team {
            if nameAlreadyExist.name == name {
                // si correspondance trouvé on renvoie true et on sort de la fonction
                return true
            }
        }
        // sinon on renvoie false
        return false
    }
    
    // on liste les personnages de l'équipe avec les caractéristiques de chacun
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
    
    func characterStillAlive() -> Int {
        var numberCharacter = 0
      
            for character in self.team {
                if character.lifePoint > 0 {
                    // on compte le nombre de personnage encore en vie
                    numberCharacter += 1
                }
            }
        return numberCharacter
    }
    
}

// Attack
extension Player {
    
     func attack(playerDefense: Player, weaponBonus: Weapons?)  {
        var heroAttack : Character = team[0]
        var heroDefense : Character
        var index = 0
        // par défaut usePresent et false car si il n'y a pas de bonus on n'exécutera pas le code associé.
        var usePresent = false
        
        // on vérifie notre paramètre s'il y a un bonus
        if weaponBonus != nil {
            print("Congratulation! \nTap 1- for use \(weaponBonus!) \nTap 2- you select your hero")
            // on demande si on utilise le bonus ou non
            usePresent = Game().questionUsePresent()
        }
        
        //on vérifie si on doit utiliser le bonus ou si on doit sélectionner un attaquant.
        if usePresent == false {
            // on met l'index à 1 pour obtenir le bon numéro pour le choix de l'utilisateur
            index = 1
            print("--------- Select your Hero for attack.--------------")
            for character in team {
                
                //on ne liste que les personnages en vie
                if character.lifePoint > 0 {
                    print("- \(index) - \(character.name)"
                            + "\n❤️: \(character.lifePoint)"
                            + "\n⚔️\(character.weapon)"
                            + "\n❤️‍🩹: \(character.healing)"
                            + "\n*********************")
                    index += 1
                } else {
                    index += 1
                }
            }
            // on récupère le choix de l'utilisateur
            heroAttack = choiceHeroAttack()
        }
        
        // on remet la valeur à 1
        index = 1
        
        print("-------------- Select hero receiving attack. -----------------")
        for heroDefense in playerDefense.team {
            
            // on ne liste que les personnages en vie dans l'équipe adverse
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
        
        // on récupère le choix de l'utilisateur
        heroDefense = choiceHeroDefense(playerDefense: playerDefense)
        
        // on vérifie si nous devons utiliser le bonus pour infliger les dégâts sur la personne attaquée
        if usePresent == false {
            heroDefense.lifePoint -=  heroAttack.weapon.damages
        } else {
            heroDefense.lifePoint -= weaponBonus!.damages
        }
        
        // on informe du succès de l'attaque
        print("\(heroDefense.name): ❤️\(heroDefense.lifePoint) - ")
    }
    
    
    private func choiceHeroAttack()-> Character {
        var choice = ""
        var heroAttack = team[0]
        while choice == "" {
            choice = readLine() ?? ""
            switch choice {
            case "1":
                
                // on vérifie que le choix sélectionné correspond à un joueur encore en vie
                if team[0].lifePoint > 0 {
                    heroAttack = team[0]
                } else {
                    print("\(team[0].name) is died. Select another hero")
                    choice = ""
                }
            case "2":
                
                // on vérifie que le choix sélectionné correspond à un joueur encore en vie
                if team[1].lifePoint > 0 {
                    heroAttack = team[1]
                } else {
                    print("\(team[1].name) is died. Select another hero")
                    choice = ""
                }
            case "3":
                
                // on vérifie que le choix sélectionné correspond à un joueur encore en vie
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
    
    private func choiceHeroDefense(playerDefense: Player) -> Character {
        var choice = ""
        var heroDefense = playerDefense.team[0]
        while choice == "" {
            choice = readLine() ?? ""
            switch choice {
            case "1":
                
                // on vérifie que le choix sélectionné correspond à un joueur encore en vie
                if playerDefense.team[0].lifePoint > 0 {
                    heroDefense = playerDefense.team[0]
                } else {
                    print("\(playerDefense.team[0].name) is died. Select another hero")
                    choice = ""
                }
            case "2":
                
                // on vérifie que le choix sélectionné correspond à un joueur encore en vie
                if playerDefense.team[1].lifePoint > 0 {
                    heroDefense = playerDefense.team[1]
                } else {
                    print("\(playerDefense.team[1].name) is died. Select another hero")
                    choice = ""
                }
            case "3":
                
                // on vérifie que le choix sélectionné correspond à un joueur encore en vie
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
        
        //on liste les personnages en vie et ceux qui ont une valeur de soin supérieur à 0
            for character in team {
                if character.healing > 0 && character.lifePoint > 0 {
                    print("\(index) - \(character.name)"
                            + "\n❤️‍🩹\(character.healing)")
                }
                index += 1
            }
        //on récupère le choix de l'utilisateur
        doctor = chooseDoctor()
        
        print("******** Select your hero to be treating")
            index = 1
        
        //on liste les personnes qui sont encore en vie
            for character in team {
                if character.lifePoint > 0 {
                    print("\(index) - \(character.name)"
                            + "\n❤️\(character.lifePoint)")
                }
                index += 1
            }
        
        
        // on récupère le choix de l'utilisateur et on ajoute les points de vie
        heroWounded = chooseHeroWounded()
        heroWounded.lifePoint += doctor
        
        // on informe du succès du soins.
        print("\(heroWounded.name) was treated: \n❤️ \(heroWounded.lifePoint)")
    }
    
    private func chooseDoctor() -> Int {
        var choice = ""
        var doctor = team[0].healing
        
        while choice == "" {
            choice = readLine() ?? ""
            switch choice {
            case "1":
                
                // on vérifie que la personne choisie soit en vie et possède une valeur de soins suffisante pour soigner
                if team[0].healing > 0 && team[0].lifePoint > 0 {
                    doctor = team[0].healing
                } else {
                    print("\(team[0].name) can't healing")
                    choice = ""
                }
                
            case "2":
                
                // on vérifie que la personne choisie soit en vie et possède une valeur de soins suffisante pour soigner
                if team[1].healing > 0 && team[1].lifePoint > 0 {
                    doctor = team[1].healing
                } else {
                    print("\(team[1].name) can't healing")
                    choice = ""
                }
                
            case "3":
                
                // on vérifie que la personne choisie soit en vie et possède une valeur de soins suffisante pour soigner
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
                // on vérifie que la personne choisie soit en vie
                if team[0].lifePoint > 0 {
                    heroWounded = team[0]
                } else {
                    print("\(team[0].name) is died.")
                    choice = ""
                }
            case "2":
                
                // on vérifie que la personne choisie soit en vie
                if team[1].lifePoint > 0 {
                    heroWounded = team[1]
                } else {
                    print("\(team[1].name) is died.")
                    choice = ""
                }
                
            case "3":
                
                // on vérifie que la personne choisie soit en vie
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
