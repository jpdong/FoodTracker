//
//  BirthdayDetail.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/26.
//  Copyright © 2017年 eesee. All rights reserved.
//

import Foundation
import UIKit

class BirthdayDetail:UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var birthday:Birthday?
    
    override func viewDidLoad() {
        updateSaveButtonState()
        nameField.delegate = self
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        birthdayLabel.text = formatter.string(from: sender.date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState(){
        let text = nameField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            Log("the savebutton was not pressed")
            return
        }
        birthday = Birthday(nameField.text ?? "", birthdayLabel.text ?? "")
    }
}
