//
//  Meal.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/14.
//  Copyright © 2017年 eesee. All rights reserved.
//

import Foundation
import UIKit

class Meal {
    var name:String
    var photo:UIImage?
    var rating:Int
    
    init?(name:String, photo:UIImage?, rating:Int){
        if (name.isEmpty || rating < 0 || rating > 5){
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
