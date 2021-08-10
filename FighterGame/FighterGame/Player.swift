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
    
    init(name: String) {
        self.name = name
    }
    
    /// Check if name exist in the team
    /// - Parameter name: it's name of comparaison
    /// - Returns: true if name exist and false if name doesn't exist
    func checkNameAlreadyExist(newName name: String) -> Bool {
        for nameAlreadyExist in team {
            if nameAlreadyExist.name == name {
                return true
            }
        }
        return false
    }
    
    /// list all characters with statistics in a team
    func listAllCharacters() {
        for indexOfCharacter in (0...team.count - 1) {
            team[indexOfCharacter].introduceCharacter(index: indexOfCharacter)
        }
    }
    
    /// list character still alive
    /// - Parameter attacking: if attacking is true show print for introduce attack, and if false show introduce receive attack
    func showTeam(attacking: Bool) {
        let introduction = attacking ? "Select your Hero for attack." : "Select hero receiving attack."
        print("--------- \(introduction) --------------")
        
        for indexOfCharacter in (0...team.count - 1) {
            if characterIsAlive(index: indexOfCharacter) {
                team[indexOfCharacter].introduceCharacter(index: indexOfCharacter)
            }
        }
    }
    
    /// list character still alive and can healing
    /// - Parameter healing: select if show just still alive or can healing
    func showTeam(healing: Bool) {
        let introduction = healing ? "Select your doctor": "Select your hero to be treating"
        print("--------- \(introduction) ---------")
        
        if healing {
            for indexOfCharacter in (0...team.count - 1) {
                if team[indexOfCharacter].healing > 0 && characterIsAlive(index: indexOfCharacter) {
                    print("\(indexOfCharacter + 1) - \(team[indexOfCharacter].name)"
                            + "\n❤️‍🩹\(team[indexOfCharacter].healing)")
                }
            }
        } else {
            
            for indexOfCharacter in (0...team.count - 1) {
                if characterIsAlive(index: indexOfCharacter){
                    team[indexOfCharacter].introduceCharacter(index: indexOfCharacter)
                }
            }
        }
    }
    
    /// return true if character is alive
    /// - Parameter index: inform what character is
    /// - Returns: return true if character is alive and false if character is died
    private func characterIsAlive(index: Int) ->Bool {
        if team[index].lifePoint > 0 {
            return true
        } else {
            print("\(team[index].name) is died")
            return false
        }
    }
    
    /// check if they one character again alive
    /// - Returns: if one character is alive return true else return false. all character in team are died
    func characterStillAlive() -> Bool {
        for character in self.team {
            if character.lifePoint > 0 {
                return true
            }
        }
        return false
    }
}

// Attack
extension Player {
    
    
    /// Choose his hero attack and choose hero receive attack and impose damage
    /// - Parameters:
    ///   - playerDefense: hero reeive attack
    ///   - weaponBonus: if player choose bonus weaponbonus impose damage if not player choose his hero
    func attack(playerDefense: Player, weaponBonus: Weapon?)  {
        var heroAttack: Character = team[0]
        var heroDefense: Character
        
        if weaponBonus == nil {
            showTeam(attacking: true)
            heroAttack = choiceHero()
        }
        
        playerDefense.showTeam(attacking: false)
        
        heroDefense = playerDefense.choiceHero()
        
        if weaponBonus == nil {
            heroDefense.lifePoint -=  heroAttack.weapon.damage
        } else if let bonusWeapon = weaponBonus {
            heroDefense.lifePoint -= bonusWeapon.damage
        }
        if heroDefense.lifePoint < 0 {
            heroDefense.lifePoint = 0
        }
        
        print("\(heroDefense.name): ❤️\(heroDefense.lifePoint) - ")
    }
    
    ///  selection hero and check selection is good
    /// - Returns: hero choice by player
    private func choiceHero()-> Character {
        var choice = ""
        var hero = team[0]
        
        while choice == "" {
            choice = readLine() ?? ""
            
            if var intChoice = Int(choice), [1,2,3].contains(intChoice) {
                intChoice -= 1

                if characterIsAlive(index: intChoice) {
                    hero = team[intChoice]
                } else {
                    print("Select another hero Please")
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
        
        showTeam(healing: true)

        doctor = chooseDoctor()
        
        showTeam(healing: false)
        
        heroWounded = chooseHeroWounded()
        heroWounded.lifePoint += doctor.healing
        
        print("\(heroWounded.name) was treated: \n❤️ \(heroWounded.lifePoint)")
    }
    
    private func chooseDoctor() -> Character {
        var choice = ""
        var doctor = team[0]
        
        while choice == "" {
            choice = readLine() ?? ""
            
            if var intChoice =  Int(choice), [1,2,3].contains(intChoice) {
                intChoice -= 1

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
                intChoice -= 1

                if characterIsAlive(index: intChoice) {
                    heroWounded = team[intChoice]
                } else {
                    print("Select another hero please")
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
