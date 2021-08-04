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
    var playing = true
    
    // on initialise le nom du joueur
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
    
    // on imprime le personnage voulu avec les caractéristiques
    func printCharacter(index: Int) {
            print("- \(index + 1) - \(self.team[index].name)"
                    + "\n❤️: \(self.team[index].lifePoint)"
                    + "\n⚔️: \(self.team[index].weapon.name)(\(self.team[index].weapon.damage))"
                    + "\n❤️‍🩹: \(self.team[index].healing)"
                    + "\n**********************")
    }
    
    func listAllCharacters() {
        for i in (0...team.count - 1) {
            printCharacter(index: i)
        }
    }
    
    func showTeam(attacking: Bool) {
        let introduction = attacking ? "Select your Hero for attack." : "Select hero receiving attack."
        print("--------- \(introduction) --------------")
        
        for i in (0...team.count - 1) {
            //on ne liste que les personnages en vie
            if characterIsAlive(index: i) {
            printCharacter(index: i)
            }
        }
    }
    
    func showTeam(healing: Bool) {
        let introduction = healing ? "Select your doctor": "Select your hero to be treating"
        print("--------- \(introduction) ---------")
        
        if healing {
            for i in (0...team.count - 1) {
                if team[i].healing > 0 && characterIsAlive(index: i) {
                    print("\(i + 1) - \(team[i].name)"
                            + "\n❤️‍🩹\(team[i].healing)")
                }
            }
        } else {
            
            for i in (0...team.count - 1) {
                if self.team[i].lifePoint > 0 {
                    printCharacter(index: i)
                }
            }
        }
    }
    
    private func characterIsAlive(index: Int) ->Bool {
        if team[index].lifePoint > 0 {
            return true
        } else {
            print("\(team[index].name) is died. Select another hero")
            return false
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
    
     func attack(playerDefense: Player, weaponBonus: Weapon?)  {
        var heroAttack : Character = team[0]
        var heroDefense : Character
        var usePresent: Bool?
        
//         on vérifie notre paramètre s'il y a un bonus
        if let bonusWeapon = weaponBonus {
            print("Congratulation! \nTap 1- for use \(bonusWeapon.name)(\(bonusWeapon.damage) \nTap 2- you select your hero")
            // on demande si on utilise le bonus ou non
            usePresent = Game().questionUsePresent()
        }
        
//        on vérifie si on doit utiliser le bonus ou si on doit sélectionner un attaquant.
        if usePresent == false || usePresent == nil {
            showTeam(attacking: true)
//       on récupère le choix de l'utilisateur
            heroAttack = choiceHero()
        }
        
//       on liste l'équipe qui va recevoir l'attaque
        playerDefense.showTeam(attacking: false)
        
//       on récupère le choix de l'utilisateur
        heroDefense = playerDefense.choiceHero()
        
//         on vérifie si nous devons utiliser le bonus pour infliger les dégâts sur la personne attaquée
        if usePresent == false || usePresent == nil {
            heroDefense.lifePoint -=  heroAttack.weapon.damage
        } else if let bonusWeapon = weaponBonus {
            heroDefense.lifePoint -= bonusWeapon.damage
        }
        
//         on informe du succès de l'attaque
        print("\(heroDefense.name): ❤️\(heroDefense.lifePoint) - ")
    }
    
    private func transformChoice(choice: String) -> Int {
        if let intChoice = Int(choice), [1,2,3].contains(intChoice) {
            return intChoice - 1
        }else {
            return 0
        }
    }
    
    private func choiceHero()-> Character {
        var choice = ""
        var hero = team[0]
        
        while choice == "" || Int(choice) == 0 {
            choice = readLine() ?? ""
            
            if var intChoice = Int(choice), [1,2,3].contains(intChoice) {
                intChoice -= 1
//            on vérifie que le choix sélectionné correspond à un joueur encore en vie
                if characterIsAlive(index: intChoice) {
                    hero = team[intChoice]
                } else {
                    choice = ""
                }
                
            } else {
                print("I don't understand your response"
                        + "\nTry again please")
                choice = ""
            }
        }
        return hero
    }
}

// Healing
extension Player {
    
    func healing() {
        var doctor = team[0]
        var heroWounded = team[0]
        
        //on liste les personnages en vie et ceux qui ont une valeur de soin supérieur à 0
        showTeam(healing: true)

        //on récupère le choix de l'utilisateur
        doctor = chooseDoctor()
        
//        on liste les personnages que l'on veut soigner
        showTeam(healing: false)
        
        // on récupère le choix de l'utilisateur et on ajoute les points de vie
        heroWounded = chooseHeroWounded()
        heroWounded.lifePoint += doctor.healing
        
        // on informe du succès du soins.
        print("\(heroWounded.name) was treated: \n❤️ \(heroWounded.lifePoint)")
    }
    
    private func chooseDoctor() -> Character {
        var choice = ""
        var doctor = team[0]
        
        while choice == "" {
            choice = readLine() ?? ""
            
            if var intChoice =  Int(choice), [1,2,3].contains(intChoice) {
                intChoice -= 1
//           on vérifie que la personne choisie soit en vie et possède une valeur de soins suffisante                pour soigner
                if team[intChoice].healing > 0 && characterIsAlive(index: intChoice) {
                    doctor = team[intChoice]
                } else {
                    print("\(team[intChoice].name) can't healing")
                    choice = ""
                }
            }
        }
        return doctor
    }
    
    private func chooseHeroWounded() -> Character {
        var heroWounded = team[0]
        var choice = ""
        
        while choice == "" {
            choice = readLine() ?? ""
            
            if var intChoice = Int(choice), [1,2,3].contains(intChoice) {
//                on vérifie que la personne choisie soit encore en vie.
                intChoice -= 1
                if characterIsAlive(index: intChoice) {
                    heroWounded = team[intChoice]
                } else {
                    
                    choice = ""
                }
            } else {
                print("I donc't understand")
                choice = ""
            }
        }
        return heroWounded
    }
}
