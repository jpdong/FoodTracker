//
//  LifeCycleLogViewController.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/14.
//  Copyright © 2017年 eesee. All rights reserved.
//

import UIKit

class LifeCycleLogViewController: UIViewController {
    
    open var tag = "LifeCycleLogViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        print(tag + ":viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(tag + ":viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(tag + ":viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print(tag + ":viewDidDisappear")
    }
    
    

}
