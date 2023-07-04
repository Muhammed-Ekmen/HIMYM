//
//  ModelOfCharacters.swift
//  HIMYM
//
//  Created by kingSemih on 4.07.2023.
//

import Foundation
import UIKit


//That is classic Model Structure.
struct ModelOfCharacters{
    let name:String
    let surname:String
    let age:String
    let imageCode:String
}


//In Additon, teacher said that model class's constructor is here. This field similar to ModelOfCharacter.fromJson() in Flutter.
extension ModelOfCharacters{
    init?(modelData : [String:String]){
        guard let nameData = modelData["name"],
        let surnameData = modelData["surname"],
        let ageData = modelData["age"],
        let imageData = modelData["imageCode"]
        else {return nil}
        name = nameData
        surname = surnameData
        age = ageData
        imageCode = imageData
    }
}
