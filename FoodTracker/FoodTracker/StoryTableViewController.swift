//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit


class StoryTableViewController: UITableViewController {
    
    var stories = List<NYTStory>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleNews()
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
        return stories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "StoryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StoryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of StoryTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let story = stories[indexPath.row]
        
        cell.titleLabel.text = story
        cell.photoImageView.hnk_setImageFromURL(story.storyImage.urlString)
        cell.descriptionLabel = story.abstract
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        super.prepare(for: segue, sender: sender)
//        
//        switch(segue.identifier ?? "") {
//            
//        case "AddItem":
//            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
//            
//        case "ShowDetail":
//            guard let mealDetailViewController = segue.destination as? MealViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//            
//            guard let selectedMealCell = sender as? MealTableViewCell else {
//                fatalError("Unexpected sender: \(sender)")
//            }
//            
//            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//            
//            let selectedMeal = meals[indexPath.row]
//            mealDetailViewController.meal = selectedMeal
//            
//        default:
//            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
//        }
//    }

    
    //MARK: Actions
    
    @IBAction func unwindToStoryList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? StoryViewController, let story = sourceViewController.story {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                stories[selectedIndexPath.row] = story
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new story.
                let newIndexPath = IndexPath(row: stories.count, section: 0)
                
                stories.append(story)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the stories.
            //saveMeals()
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleStories() {
        
        NYTStory.loadLatestStories(intoRealm: try! Realm(), withAPIKey: "fa7782ec2a3940ccbf2312475e946090")
    }
    
//    private func saveMeals() {
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
//        if isSuccessfulSave {
//            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
//        } else {
//            os_log("Failed to save meals...", log: OSLog.default, type: .error)
//        }
//    }
 

}
