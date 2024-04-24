//
//  ToDoViewController.swift
//  MyToDoList
//
//  Created by user257944 on 4/23/24.
//

import UIKit
import CoreData
import AVFoundation

class ToDoViewController: UIViewController, UITextFieldDelegate, DateControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextViewDelegate {
    
    var currentToDo: Item?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedImportance: String?
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var sgmtEditMode: UISegmentedControl!
    
    @IBOutlet weak var lbldate: UILabel!
    
    @IBOutlet weak var btnChange: UIButton!
    
    @IBOutlet weak var btnLow: UIButton!
    
    @IBOutlet weak var btnMedium: UIButton!
    
    @IBOutlet weak var btnHigh: UIButton!
    
    @IBOutlet weak var btnUrgent: UIButton!
    
    @IBOutlet weak var txtDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeEditMode(self)
        // Do any additional setup after loading the view.
        
        let textFields: [UITextField] = [txtTitle]
        let textViews: [UITextView] = [txtDescription]
        
        for textfield in textFields {
            textfield.addTarget(self, action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)), for: UIControl.Event.editingDidEnd)
        }
        for textView in textViews {
            textView.delegate = self
        }
    }
    
    func selectImportance(_ sender: UIButton) {
           
           btnLow.isSelected = false
           btnMedium.isSelected = false
           btnHigh.isSelected = false
           btnUrgent.isSelected = false
           
           sender.isSelected = true
           
           // Set selectedImportance based on the tapped button
           switch sender {
           case btnLow:
               selectedImportance = "Low"
           case btnMedium:
               selectedImportance = "Medium"
           case btnHigh:
               selectedImportance = "High"
           case btnUrgent:
               selectedImportance = "Urgent"
           default:
               break
           }
       }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if currentToDo == nil {
            let context = appDelegate.persistentContainer.viewContext
            currentToDo = Item(context: context)
        }
        currentToDo?.descript = txtDescription.text
        currentToDo?.title = txtTitle.text
        currentToDo?.priority = selectedImportance
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func changeEditMode(_ sender: Any) {
        
        let textFields: [UITextField] = [txtTitle]
        let textViews: [UITextView] = [ txtDescription]
        if sgmtEditMode.selectedSegmentIndex == 0 {
            for textField in textFields {
                textField.isEnabled = false
                textField.borderStyle = UITextField.BorderStyle.none
            }
            for textView in textViews {
                textView.isEditable = false
                textView.layer.borderWidth = 0
            }
            navigationItem.rightBarButtonItem = nil
            
            btnChange.isHidden = true
        }
        else if sgmtEditMode.selectedSegmentIndex == 1{
            for textField in textFields {
                textField.isEnabled = true
                textField.borderStyle = UITextField.BorderStyle.roundedRect
            }
            for textView in textViews {
                textView.isEditable = true
                textView.layer.borderWidth = 1
            }
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContact)) // Fix selector
            btnChange.isHidden = false
        }
    }
    
    @objc func saveContact() {
        appDelegate.saveContext()
        sgmtEditMode.selectedSegmentIndex = 0
        changeEditMode(self)
    }
    
    func dateChanged(date: Date) {
        if currentToDo == nil {
            let context = appDelegate.persistentContainer.viewContext
            currentToDo = Item(context: context)
        }
        currentToDo?.date = date
        let formatter = DateFormatter()
        formatter.dateStyle  = .short
        lbldate.text = formatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDoDate" {
            let dateController = segue.destination as! DateViewController
            dateController.delegate = self
        }
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
