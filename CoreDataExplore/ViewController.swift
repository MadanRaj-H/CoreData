//
//  ViewController.swift
//  CoreDataExplore
//
//  Created by mh53653 on 1/15/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate{

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var controller : NSFetchedResultsController<Person>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
     //   getPersonData()
        attemptFetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
        configureCell(cell: cell, index: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell : PersonCell, index indexPath: NSIndexPath){
        let person = controller.object(at: indexPath as IndexPath);
        cell.updatePersonCell(person: person)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type){
        case.insert :
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            let cell = tableView.cellForRow(at: indexPath!) as! PersonCell
            configureCell(cell: cell, index: indexPath! as NSIndexPath)
            break
            
        }
    }
    
    
    func attemptFetch(){
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        let contactsCreated = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [contactsCreated]
        let controller  = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    func getPersonData() {
        
        let person = Person(context: context)
        person.name = "Harun"
        person.mobileNumber = "9962603712"
        person.bloodGroup = "A1 +ve"
        person.emailId = "harun@gmail.com"
        
        let occupation = Occupation(context: context)
        occupation.field = "IT"
        occupation.location = "USA"
        occupation.skills = "Algorithms"
        
        person.toOccupation = occupation
        
        
        let person1 = Person(context: context)
        person1.name = "Mukesh"
        person1.mobileNumber = "9884314030"
        person1.bloodGroup = "O +ve"
        person1.emailId = "mukesh@gmail.com"
        
        let occupation1 = Occupation(context: context)
        occupation1.field = "IT"
        occupation1.location = "India"
        occupation1.skills = "Java,Algorithms"
        
        person1.toOccupation = occupation1
        
        ad.saveContext()
        
    }
    
}

