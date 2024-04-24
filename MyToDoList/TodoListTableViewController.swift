//
//  TodoListTableViewController.swift
//  MyToDoList
//
//  Created by Fredy Trejo on 4/24/24.
//

import UIKit
import CoreData

class TodoListTableViewController: UITableViewController {
    
    //let Items = ["Jim", "John", "Dana", "Rosie", "Justin", "Jeremy", "Sarah", "Matt", "Joe", "Donald", "Jeff"]
    var Items:[NSManagedObject] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromDatabase()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func loadDataFromDatabase () {
        //Read settings to enable sorting
        let settings = UserDefaults.standard
        let sortField = settings.string(forKey: Constants.kSortField)
        let sortAscending = settings.bool (forKey: Constants.kSortDirectionAscending)
        //Set up Core Data Context
        let context = appDelegate.persistentContainer.viewContext
        //Set up Request
        let request = NSFetchRequest<NSManagedObject>(entityName: "Item")
        //Specify sorting
        let sortDescriptor = NSSortDescriptor (key: sortField, ascending: sortAscending)
        let sortDescriptorArray = [sortDescriptor]
        //to sort by multiple fields, add more sort descriptors to the array
        //request.sortDescriptors = sortDescriptorArray
        //Execute request
        do {
            Items = try context.fetch(request)
        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo) ")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
     //   loadDataFromDatabase()
        tableView.reloadData()
    }
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)

        // Configure the cell...
        let item = Items[indexPath.row] as? Item
        cell.textLabel?.text = item?.title
        cell.detailTextLabel?.text = item?.descript
        return cell
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check for the right segue identifier
        if segue.identifier == "EditItem" {
            // Get a reference to the destination view controller
            let toDoViewController = segue.destination as? ToDoViewController
            
            // Find the selected row index
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                // Retrieve the item from your Items array
                let selectedItem = Items[selectedRowIndexPath.row] as? Item
                // Pass the selected item to the ToDoViewController
                toDoViewController?.currentToDo = selectedItem
            }
        }
    }


}
