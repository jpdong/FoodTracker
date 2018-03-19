//
//  Utils.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/21.
//  Copyright © 2017年 eesee. All rights reserved.
//

import Foundation
import UIKit

func Log<T>(_ message:T, file:String = #file, funcName:String = #function,lineNum:Int = #line){
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
        print("Line:\(lineNum) \(fileName)/\(funcName)/\(message)")
    #endif
}
