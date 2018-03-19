//
//  BirthdayList.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/25.
//  Copyright © 2017年 eesee. All rights reserved.
//

import Foundation
import UIKit

class BirthdayList:UITableViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    var birthdays:[Birthday] = Array<Birthday>()
    
    override func viewDidLoad() {
        for index in 0..<5{
            birthdays.append(Birthday("test\(index)","1994-10-25"))
        }
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let birthday = birthdays[indexPath.row]
        let identifier = "BirthdayItem"
        guard let birthdayItem = tableView.dequeueReusableCell(withIdentifier: identifier,for:indexPath) as? BirthdayItem else {
            fatalError("get list item fail")
        }
        birthdayItem.nameLabel.text = birthday.name
        birthdayItem.birthdayLabel.text = birthday.birthday
        return birthdayItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            birthdays.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    
    @IBAction func unwindToList(sender:UIStoryboardSegue){
        if let source = sender.source as? BirthdayDetail, let birthday = source.birthday {
            let newIndexPath = IndexPath(row:birthdays.count, section:0)
            birthdays.append(birthday)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        } else {
            Log("segue source wrong")
        }
    }
}
