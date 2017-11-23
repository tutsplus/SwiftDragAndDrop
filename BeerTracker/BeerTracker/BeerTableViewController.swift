//
//  BeerTableViewController.swift
//  BeerTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class BeerTableViewController: UITableViewController {
    
    //MARK: Properties
    var beers = [Beer]()
    @IBOutlet var dataSource: CBLUITableSource!
    var database: CBLDatabase?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadBeers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BeerTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BeerTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BeerTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let beer = beers[indexPath.row]
        
        cell.nameLabel.text = beer.name
        cell.descriptionLabel = beer.description
        
        return cell
    }
    
    
}

/// MARK: Data Loading
extension BeerTableViewController{
    
    func useDatabase(theDatabase: CBLDatabase){
       self.database = theDatabase
    }
    
    private func loadBeers() {
        
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }
        
        meals += [meal1, meal2, meal3]
    }

}
