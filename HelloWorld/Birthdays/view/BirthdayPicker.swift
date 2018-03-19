//
//  BirthdayPicker.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/27.
//  Copyright © 2017年 eesee. All rights reserved.
//

import Foundation
import UIKit

class BirthdayPicker:UIStackView {
    
    @IBInspectable var pickerSize = CGSize(width:106.0, height:216.0){
        didSet{
            setPickers()
        }
    }
    
    var pickerCount:Int = 3
    var pickers = Array<UIPickerView>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setPickers()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setPickers()
    }
    
    func setPickers(){
        for picker in pickers{
            removeArrangedSubview(picker)
            picker.removeFromSuperview()
        }
        pickers.removeAll()
        for _ in 0..<pickerCount{
            let picker = UIPickerView()
            
        }
    }
    
}
