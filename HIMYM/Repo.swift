//
//  Repo.swift
//  HIMYM
//
//  Created by kingSemih on 4.07.2023.
//

import Foundation


class IRepo{
    private init(){}
    static let shared:IRepo = IRepo()
    
//    var characters:[ModelOfCharacters]?
    var characters:[[ModelOfCharacters]]?
}
