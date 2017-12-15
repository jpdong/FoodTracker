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
    var imageUrl:String?
    
    init?(name:String, photo:UIImage?, rating:Int){
        if (name.isEmpty || rating < 0 || rating > 5){
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    init?(name:String, imageUrl:String, rating:Int) {
        if (name.isEmpty || rating < 0 || rating > 5) {
            return nil
        }
        self.name = name
        self.imageUrl = imageUrl
        self.rating = rating
        
    }
}
