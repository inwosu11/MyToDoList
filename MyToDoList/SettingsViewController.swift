//
//  SettingsViewController.swift
//  MyToDoList
//
//  Created by user257944 on 4/23/24.
//

import UIKit

class SettingsViewController: UIViewController,UIPickerViewDataSource,
                              UIPickerViewDelegate {
   
    
    @IBOutlet weak var pckSortField: UIPickerView!
    
    @IBOutlet weak var swAscending: UISwitch!
    
    let sortOrderItems: [String] = ["low", "medium", "high","urgent"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pckSortField.dataSource = self
        pckSortField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        // Set the UI based on values in UserDefaults
        let settings = UserDefaults.standard
        swAscending.isOn = settings.bool(forKey: "sortDirectionAscending")
        
        if let sortField = settings.string(forKey: "sortField"),
            let selectedIndex = sortOrderItems.firstIndex(of: sortField) {
            pckSortField.selectRow(selectedIndex, inComponent: 0, animated: false)
        }
    }
    
    @IBAction func sortDirectionChanged(_ sender: Any) {
        let settings = UserDefaults.standard
        settings.set(swAscending.isOn, forKey: "sortDirectionAscending")
    }
    
    // MARK: - UIPickerViewDataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOrderItems.count
    }
    
    // MARK: - UIPickerViewDelegate Methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOrderItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sortField = sortOrderItems[row]
        let settings = UserDefaults.standard
        settings.set(sortField, forKey: "sortField")
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


