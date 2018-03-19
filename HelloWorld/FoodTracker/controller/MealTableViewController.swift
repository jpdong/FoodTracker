//
//  MealTableViewController.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/14.
//  Copyright © 2017年 eesee. All rights reserved.
//

import UIKit
import os.log
import Alamofire
import HandyJSON
import Kingfisher
import CoreData

class MealTableViewController: UITableViewController {

    var meals = [Meal]()
    var girls = [Girl]()
    var loadMoreControl:RefreshControl?
    var currentPage:Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        loadMoreControl = RefreshControl(scrollView:self.tableView, refreshBlock:{self.beginRefreshing()}, loadmoreBlock: {self.beginLoadmore()})
        loadSampleMeals()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    func beginRefreshing(){
        print("BeginRefreshing")
        self.delay(delayTime:1.5, closure:{
            Thread.sleep(forTimeInterval:1.5)
            self.loadMoreControl!.endRefreshing()
        })
    }

    func beginLoadmore(){
        print("dropViewDidBeginLoadmore")
        self.currentPage +=  1
        self.delay(delayTime:1.5, closure:{
            //Thread.sleep(forTimeInterval:1.5)
            self.loadData()
            //self.loadMoreControl!.endLoadingmore()
        })
    }

    func delay(delayTime:Double, closure:@escaping()->()) {
        DispatchQueue.main.async(execute: closure)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        guard let meal2 = Meal(name: "Chicked and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal3")
        }
        meals += [meal1, meal2, meal3]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell")
        }
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        if (meal.imageUrl != nil) {
            let url = URL(string:meal.imageUrl!)
            cell.photoImageView.kf.setImage(with:url)
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        segue.destination.hidesBottomBarWhenPushed = true
        switch segue.identifier ?? "" {
        case "AddItem":
            print("AddItem")
                //os_log("Adding a new meal", log:OSLog.default, type:.debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination:\(segue.destination)")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender:\(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectMeal
        default:
            fatalError("Unexpected Segue Identifier;\(segue.identifier)")
        }
    }

    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Log("viewWillAppear")
        //hidesBottomBarWhenPushed = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Log("viewDidDisappear")
    }
    
    func createTableViewFooter() {
        tableView.tableFooterView = nil
        tableView.tableFooterView!.frame = CGRect(x:0,y:0,width:tableView.bounds.size.width, height:60)
        
    }

    func testJson() {
        let user: [String: Any] = ["username": "dong", "tel": ["mobile": "123", "home": "333"]]
        //let user = "{\"name\":\"dong\"}"
        //let user = {"name":"song"}
        if (!JSONSerialization.isValidJSONObject(user)) {
            print("is not")
        } else {
            print("is json")
        }
    }

    func loadData() {
        let TAG = "tag"
        Log("hello world")
        testJson()
        testThread()
        testCoreData()
        Alamofire.request("http://gank.io/api/data/%E7%A6%8F%E5%88%A9/10/\(currentPage)").responseJSON(completionHandler: {
            response in
            switch response.result{
            case .success(let value):
                //if let response = GirlResponseEntity.deserialize(from:String(response.data,encoding:.utf8) {
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8){
                    print("Data:\(utf8Text)")
                    if let response = JSONDeserializer<GirlResponseEntity>.deserializeFrom(json: utf8Text ){
                        var girlList:[Girl]! = response.results
                        var showList = Array<Meal>()
                        for(girl) in girlList{
                            self.girls.append(girl)
                            showList.append(Meal(name:girl.who,imageUrl:girl.url,rating:3)!)
                        }
                        self.meals += showList
                        print("girls:\(girlList)")
                        self.loadMoreControl!.endLoadingmore()
                        self.tableView.reloadData()
                        
                }
                
            }

            case .failure(let error):
                print(error)
                self.loadMoreControl!.endLoadingmore()
            }
        })
    }

    private func testCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let noodles = NSEntityDescription.insertNewObject(forEntityName:"MealData", into:context) as! MealData
        noodles.name = "王牌杂酱面"
        noodles.id = UUID().uuidString
        print("mealdata insert:\(noodles.id)")
        noodles.rating = 5
        do {
            try context.save()
            print("save meal success")
        } catch {
            print("save meal fail")
        }
        let fetchRequest = NSFetchRequest<MealData>(entityName:"MealData")
//        fetchRequest.fetchLimit = 10
//        fetchRequest.fetchOffset = 0
//        let predicate = NSPredicate(format:"*")
//        fetchRequest.predicate = predicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            for info in fetchedObjects{
                print("mealdata:\(info.name) \(info.rating) \(info.id)")
//                info.rating += 1;
//                try context.save()
                if (info.id == nil) {
                    context.delete(info)
                }
            }
            try context.save()
        } catch{
            fatalError("query fail")
        }
        
        

    }

    private func testThread() {
        DispatchQueue.main.async(execute: {
            print("main async ,\(Thread.current)")
        })
        print("ync 1")
//        DispatchQueue.main.sync(execute: {
//            print("main sync ,\(Thread.current)")
//        })
        DispatchQueue.global().sync(execute: {
            print("global sync ,\(Thread.current)")
        })
        print("ync 2")
        DispatchQueue.global().async(execute: {
            print("global async ,\(Thread.current)")
        })
        print("ync 3")
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrollViewDidScroll")
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
     Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
