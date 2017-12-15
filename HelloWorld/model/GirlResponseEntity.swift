//
// Created by eesee on 2017/12/15.
// Copyright (c) 2017 eesee. All rights reserved.
//

import Foundation
import HandyJSON

class GirlResponseEntity:HandyJSON {
    var results = [Girl]()
    var error:Int?

    required init(){}
}
