//
//  CharactersTableViewController.swift
//  HIMYM
//
//  Created by kingSemih on 4.07.2023.
//


/*
Important topics for this project:
 
 - .plist Data Source Usage
 - Advanced TableView Cell Usage.
 

 
 
 -> CREATING DATA SOURCE WITH .PLIST FILE
 
 [DESCRIPTION]
 Plist is kind of the speacila file. its full meaning is 'property list'. You can think similar to json.
 
 [USAGE]
 +first, create file normally. (cmd+n) After that, find the plist icon from the list and create plist.
 +now, we gotta create some proteries. You need to see root. change it to array and create some dict values.
 For this app, we have createrd 5 HIMYM character and image.
 
 +is it All? i do't think so, we gotta do 2 step. These are fetchin data from pList and create Model file.
 +First of all, we have create ModelOfCharacters file. Go and Revive all.
 +We have created model file, now we need to enum class for custom errors(Go to the enum class). Also, we have created the StorageManager class. we gonna use this clas sfor fetchiong our
 plist file.
 
 
 -> ADVANCED TABLEVIEW CELL USAGE
 [DESCRIPTION]
 it's very similiar to listTile from Flutter.
 
 [USAGE]
 +Firstly, select the cell from storyboard. (if you cannot find, you can use the right panel list.) After that enter the reuse identifier and assing cell. CK3
 + First property is 'Accessory'. It totaly equels to trailing from listTile on Flutter.
 + Other property is image. You can add image like leading on CK1
 + subtitle property. CK2 after the subtitle value, you gotta go story board while cell selected, change the style to subtitle choice.
 
 
 for now, these're enough.
 
 -> CREATE DETAIL VIEW
 
 173.video
 
 
*/


import UIKit

class CharactersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initCharacters()
    }
    
    private func initCharacters(){
        var dummyList:[ModelOfCharacters] {
            let data = try! StorageManager.shared.fetchData(fileName: StorageFiles.characters.rawValue, fileExtention: "plist")
            return data.compactMap {ModelOfCharacters(modelData: $0)}
        }
        IRepo.shared.characters = dummyList
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IRepo.shared.characters?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "custom_cell", for: indexPath) // CK3
        cell.textLabel?.text = IRepo.shared.characters?[indexPath.row].name
        cell.detailTextLabel?.text = IRepo.shared.characters?[indexPath.row].surname
        if IRepo.shared.characters?[indexPath.row].imageCode != nil {
            if let image = UIImage(named: (IRepo.shared.characters?[indexPath.row].imageCode)!) { cell.imageView?.image = image }   // CK1
        }
        return cell
    }
}
