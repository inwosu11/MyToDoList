//
//  ToDoViewController.swift
//  MyToDoList
//
//  Created by user257944 on 4/23/24.
//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var lbldate: UILabel!
    
    @IBOutlet weak var btnChange: UIButton!
    
    @IBOutlet weak var btnLow: UIButton!
    
    @IBOutlet weak var btnMedium: UIButton!
    
    @IBOutlet weak var btnHigh: UIButton!
    
    @IBOutlet weak var btnUrgent: UIButton!
    
    @IBOutlet weak var txtDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
