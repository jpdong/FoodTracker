//
//  MealTableViewCell.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/14.
//  Copyright © 2017年 eesee. All rights reserved.
//

import UIKit
import os.log

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    

}
