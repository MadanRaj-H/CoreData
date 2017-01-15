//
//  PersonCell.swift
//  CoreDataExplore
//
//  Created by mh53653 on 1/15/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personMobileNumber: UILabel!
    @IBOutlet weak var personBloodGroup: UILabel!
    @IBOutlet weak var personOccupation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updatePersonCell(person : Person ){
        personName.text = person.name;
        personMobileNumber.text = person.mobileNumber;
        personBloodGroup.text = person.bloodGroup
        personOccupation.text = "\((person.toOccupation?.field)!) , \((person.toOccupation?.location)!)"
    }

}
