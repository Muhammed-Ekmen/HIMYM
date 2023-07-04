//
//  enums.swift
//  HIMYM
//
//  Created by kingSemih on 4.07.2023.
//

import Foundation


enum StorageErrors:Error{
    case inValidResource // When File Cannot Find The Path Or Source.
    case fetchFailure // When File Parsing Problem.
}

enum StorageFiles:String{case characters}
