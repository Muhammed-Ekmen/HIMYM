//
//  DetailTableViewController.swift
//  HIMYM
//
//  Created by kingSemih on 5.07.2023.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var characterModel:ModelOfCharacters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDetail()
    }
    
    
    func initDetail(){
        guard let dummyModel:ModelOfCharacters = characterModel else { return }
        nameLabel.text = dummyModel.name
        surnameLabel.text = dummyModel.surname
        ageLabel.text = dummyModel.age
        if let dummyImage = UIImage(named: dummyModel.imageCode) {
            imageView.image = dummyImage
        }
    }
}
