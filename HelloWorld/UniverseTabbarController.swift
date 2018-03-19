//
//  UniverseTabbarController.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/25.
//  Copyright © 2017年 eesee. All rights reserved.
//

import Foundation
import UIKit

class UniverseTabbarController : UITabBarController{
    
    override func viewDidLoad() {
        for (index, viewController) in self.viewControllers!.enumerated() {
            print("tabbar:\(index) \(viewController) \(viewController.tabBarItem.title)")
        }
        let secondTab:UIViewController = viewControllers![1]
        secondTab.tabBarItem.title = "second"
        viewControllers![2].tabBarItem.title = "birthday"
    }
}
