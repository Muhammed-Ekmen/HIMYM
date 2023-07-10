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
 
 [DESCRIPTION]you
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
 
 173.video and 175.vidoe
 
 So, Actualy it is very simple. Everythink goes on lines. for example, you wnats to add profile Image. Separete the lines
 and set up only 1 row. After that, adjust the row heigth and add image view or label etc. That's all.
 
 
 
 -> Complicated segue usage. CK4
 
 your UI has more than one routes. So, you always take segue identifier and roting according to the identifier.
 
 -> Sort the Characters and show the UI with right panel.
 
 -> Add Favorite Action
 
 
 
 -> Sorted Character List
 
 our aim is learn more array function and add section header on table view and mini menu at the right side.
 
 +firstly, we need to crate and list to keep first letter each model name. So, we have cxreated dummy list and data list on initCharacter function and IRepo.
 we have used the set type collection.
 
 + after that, we have created one more time array to keep sectioned list. that list is nested lists which keep inside model lists. CK6
 
 + when you wna tot reach section index (NOT ROW INDEX) you can acces with section params CK7
 
 + in additon , we gotta chagne the cell function/. CK8
 
 + time to create section title. So, override tableView fucntion and just use it. CK9
 
 + look at the CK10. that is ready function from swift develoeprs. just take it with a list to write the right side.
 
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
        
        var userSectionHeaders:[String] {            // CK5
            let firstLetters = dummyList.map {String($0.name.prefix(1))}
            let reduceBinaryDatas = Set(firstLetters)
            return Array(reduceBinaryDatas).sorted()
        }
        
        IRepo.shared.userSectionHeaders = userSectionHeaders // CK5
        
       
        var sectionedCharacters:[[ModelOfCharacters]] {          // CK6
            return userSectionHeaders.map {characterHeader in
                let filteredCharacters = dummyList.filter {String($0.name.prefix(1)) == characterHeader}
                return filteredCharacters.sorted(by: {  String($0.name.prefix(1)) < String($1.name.prefix(1)) })
            }
        }
        
        IRepo.shared.characters = sectionedCharacters
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return IRepo.shared.characters?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IRepo.shared.characters![section].count          // CK7
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "custom_cell", for: indexPath) // CK3
        // BEFORE THE SORTED CHARACTER LIST
//        cell.textLabel?.text = IRepo.shared.characters?[indexPath.row].name
//        cell.detailTextLabel?.text = IRepo.shared.characters?[indexPath.row].surname
//        if IRepo.shared.characters?[indexPath.row].imageCode != nil {
//            if let image = UIImage(named: (IRepo.shared.characters?[indexPath.row].imageCode)!) { cell.imageView?.image = image }   // CK1
//        }
//
        //AFTER SORTED CHARACTER LIST
        let exaModel:ModelOfCharacters? = (IRepo.shared.characters?[indexPath.section][indexPath.row])      // CK8
        if exaModel != nil{
            cell.textLabel?.text = exaModel?.name
            cell.detailTextLabel?.text = exaModel?.surname
            if exaModel?.imageCode != nil {
                if let image = UIImage(named: (exaModel?.imageCode)!) { cell.imageView?.image = image }   // CK1
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueKeys.detailScreen.rawValue, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let characterIndex:Int? = self.tableView.indexPathForSelectedRow?.row
        let characterSectionIndex:Int? = self.tableView.indexPathForSelectedRow?.section
        let segueInfo:String? = segue.identifier     //CK4
        if segueInfo == SegueKeys.detailScreen.rawValue{
            if let detailViewCtrl:DetailTableViewController = segue.destination as? DetailTableViewController{
                if characterIndex != nil && IRepo.shared.characters != nil && characterSectionIndex != nil { detailViewCtrl.characterModel = IRepo.shared.characters![characterSectionIndex!][characterIndex!]}
            }
        }
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {       // CK9
        return IRepo.shared.userSectionHeaders
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {     // CK10
        let letter:String? = IRepo.shared.userSectionHeaders?[section]
        return letter != nil ? IRepo.shared.userSectionHeaders![section] : nil
    }
    
}
