//
//  BirthdayPickerView.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/28.
//  Copyright © 2017年 eesee. All rights reserved.
//

import Foundation
import UIKit

class BirthdayPickerView:UIView ,UIPickerViewDataSource, UIPickerViewDelegate{
    
    var pickerView:UIPickerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp(){
        pickerView = UIPickerView(frame:CGRect(x:100,y:100,width:200,height:300))
        pickerView.isUserInteractionEnabled = true
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(1,inComponent: 0,animated:true)
        pickerView.selectRow(2,inComponent: 1,animated:true)
        pickerView.selectRow(3,inComponent: 2,animated:true)
        addSubview(pickerView)
        
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
        let message = String(pickerView.selectedRow(inComponent: 0)) + ":" + String(pickerView.selectedRow(inComponent: 1)) + ":" + String(pickerView.selectedRow(inComponent: 2))
        return message
//        let alertController = UIAlertController(title:"message", message:message, preferredStyle:.alert)
//        let okAction = UIAlertAction(title:"ok", style:.cancel, handler:nil)
    }
    
    
}
