//
//  TestViewController.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/28.
//  Copyright © 2017年 eesee. All rights reserved.
//

import Foundation
import UIKit

class TestViewController:UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var birthdayPicker: UIPickerView!
    
    @IBAction func show(_ sender: Any) {
        getPickerViewValue()
    }
    
    override func viewDidLoad() {
        birthdayPicker.dataSource = self
        birthdayPicker.delegate = self
        birthdayPicker.selectRow(1, inComponent: 0, animated: true)
        birthdayPicker.selectRow(1, inComponent: 1, animated: true)
        birthdayPicker.selectRow(1, inComponent: 2, animated: true)
        self.view.addSubview(birthdayPicker)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(component) + "-" + String(row)
    }
    
    func getPickerViewValue() -> String {
        let message = String(birthdayPicker.selectedRow(inComponent: 0)) + ":" + String(birthdayPicker.selectedRow(inComponent: 1)) + ":" + String(birthdayPicker.selectedRow(inComponent: 2))
        
        let alertController = UIAlertController(title:"message", message:message, preferredStyle:.alert)
        let okAction = UIAlertAction(title:"ok", style:.cancel, handler:nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        return message
    }
}
