//
//  PersonVC.swift
//  CoreDataExplore
//
//  Created by mh53653 on 1/16/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit
import CoreData

class PersonVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var mobileNumberLabel: UITextField!
    @IBOutlet weak var bloodGroupLabel: UITextField!
    @IBOutlet weak var personTypeLabel: UITextField!
    @IBOutlet weak var personJobLocation: UITextField!
    @IBOutlet weak var personSkillsLabel: UITextField!
    var imagePickerMedia : UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        }
        imagePicker.delegate = self
        imagePicker.dataSource = self
        
        imagePickerMedia = UIImagePickerController()
        imagePickerMedia.delegate = self
       // getOccupation()
        applyFetch()
        
        if personToEdit != nil {
            loadPersonData()
        }
    }
    @IBOutlet weak var imagePicker: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    var personToEdit : Person?
    var occupation = [Occupation]()
    var field = [String]()

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.field.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.field[row]
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        
        var person : Person;
        var occupation : Occupation;
        var image : Image ;
        var personType  : PersonType;
        if personToEdit != nil{
            person = personToEdit!;
            occupation = person.toOccupation!;
            image = person.toImage!;
            personType = person.toPersonType!;
        } else {
            person = Person(context: context)
            occupation = Occupation(context: context)
            image = Image(context: context)
            personType = PersonType(context: context);
        }
        
        image.image = self.imageView.image;
        person.toImage = image
        
        if let personTypeStr = personTypeLabel.text{
            personType.personType = personTypeStr;
            person.toPersonType = personType;
        }
        
        if let name = nameLabel.text {
            person.name = name;
        }
        if let bloodgroup = bloodGroupLabel.text {
            person.bloodGroup = bloodgroup;
        }
        if let phoneNumber = mobileNumberLabel.text {
            person.mobileNumber = phoneNumber;
        }
        if let personTypeString = personTypeLabel.text {
            let personType = PersonType(context: context)
            personType.personType = personTypeString
            person.toPersonType = personType
        }
        
      //  let occupation = Occupation(context: context)
        if let skills = personSkillsLabel.text {
            occupation.skills = skills
        }
        if let location = personJobLocation.text{
            occupation.location = location
        }
        occupation.field = self.field[self.imagePicker.selectedRow(inComponent: 0)]
        person.toOccupation = occupation;
        
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imagePickBtnPressed(_ sender: UIButton) {
            present(imagePickerMedia, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = img;
        }
        
        imagePickerMedia.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteBtnPressed(_ sender: UIBarButtonItem) {
        
        if personToEdit != nil {
            //let occupation = personToEdit?.toOccupation
            context.delete(personToEdit!)
          //  context.delete(occupation!)
            ad.saveContext()
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func applyFetch(){
        let fetchRequest : NSFetchRequest<Occupation> = Occupation.fetchRequest()
        do {
            self.occupation = try context.fetch(fetchRequest)
            var fieldNames = [String]()
            fieldNames = self.occupation.map({$0.field!})
            self.field = Array(Set(fieldNames))
          //  self.field = ["IT","Analytics","Actor","Government Job","Doctor","Mechanical"];
            self.imagePicker.reloadAllComponents()
        } catch {
            
        }
    }
    
    func loadPersonData(){
        if let person = personToEdit {
            self.nameLabel.text = person.name;
            self.mobileNumberLabel.text = person.mobileNumber;
            self.bloodGroupLabel.text = person.bloodGroup
            self.personJobLocation.text = (person.toOccupation?.location)!
            self.personSkillsLabel.text = (person.toOccupation?.skills)!
            let index = self.field.index(of: (person.toOccupation?.field)!)
            self.imagePicker.selectRow(index!, inComponent: 0, animated: false)
            self.imageView.image = person.toImage?.image as? UIImage
            self.personTypeLabel.text = (person.toPersonType?.personType)!
        }
    }
    
    func getOccupation() {
//        let occupation = Occupation(context: context)
//        occupation.field = "IT"
//        occupation.location = "USA"
//        occupation.skills = "Algorithms"
//        
//        let occupation1 = Occupation(context: context)
//        occupation1.field = "Analytics"
//        occupation1.location = "India"
//        occupation1.skills = "Big Data"
        
        let occupation2 = Occupation(context: context)
        occupation2.field = "Doctor"
        occupation2.location = "India"
        occupation2.skills = "Ortho"
        
        let occupation3 = Occupation(context: context)
        occupation3.field = "Mechanical"
        occupation3.location = "India"
        occupation3.skills = "Automobile"
        
        let occupation4 = Occupation(context: context)
        occupation4.field = "Actor"
        occupation4.location = "India"
        occupation4.skills = "Comedy"
        
        let occupation5 = Occupation(context: context)
        occupation5.field = "Government Job"
        occupation5.location = "India"
        occupation5.skills = "IAS"
        
     
        
       ad.saveContext()

       //  self.field = ["IT","Analytics","Actor","Government Job","Doctor","Mechanical"];
    }
}
