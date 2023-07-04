//
//  StorageManager.swift
//  HIMYM
//
//  Created by kingSemih on 4.07.2023.
//

import Foundation



class StorageManager{
    
    //SINGLETON USAGE
    private init(){}
    static let shared:StorageManager = StorageManager()
    
    func fetchData(fileName:String,fileExtention:String)throws -> [[String:String]]{
        
        //Find The File Path.
        /*
        QUICK NOTE: Bundle represent to our main field.So, we can seek our file with this object.
        */
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtention)else{
            throw StorageErrors.inValidResource
        }
        
        //Fetching Data
        //NOTE: NS  strucutres access xml etc. file type. So, we have reached the file and parsed.
        guard let fileData = NSArray(contentsOfFile: filePath) as? [[String:String]] else{
            throw StorageErrors.fetchFailure
        }
        
        // Finally, that function returns file if there is no any error.
        return fileData
    }
}
