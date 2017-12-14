//
//  ViewController.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/11.
//  Copyright © 2017年 eesee. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClick(_ sender: UIButton) {
        print("click");
        //test();
        //testNet();
        testAlamofire()

    }

    private func testAlamofire() {
        Alamofire.request("http://gank.io/api/data/%E7%A6%8F%E5%88%A9/2/1").responseJSON(completionHandler: {
            response in
            print("Request:\(String(describing:response.request))")
            print("Response:\(String(describing: response.response))")
            print("Result:\(response.result)")
//            if let json = response.result.value {
//                print("JSON:\(json)")
//
//            }
        let json:Any? = response.result.value;
            if (json != nil) {
                print("JSON:\(json)")
            }
            /*if let data = response.data, let utf8Text = String(data: data, encoding: .utf8){
                print("Data:\(utf8Text)")
            }*/
            //let data:

        })
    }

    func testNet() {
        let url: URL! = URL(string: "http://gank.io/api/data/%E7%A6%8F%E5%88%A9/10/1");
        var request: URLRequest = URLRequest(url: url);
        let list = NSMutableArray();
        var params = [String: String]();
        request.httpMethod = "GET";
        let config = URLSessionConfiguration.default;
        let session = URLSession(configuration: config)
        let data = session.dataTask(with: request) {
            (data,response,error) in
            print(data)
            print(response)
            print(error)

        }
        data.resume()
    }

    private func test() {
        for index in 1..<5 {
            print(index);
        }
        var i = 0;
        print("something:\(i)");
        var str: String = "hello world!";
        print(str.count);


        let decrem = calcDecrement(forDecrement: 30);
        print(decrem());

        var tom = Tom();
        tom.printValue();
        var dong: Person? = Person(name: "mao");
        var dong1: Person? = dong;
        var dong2: Person? = dong;
        dong = nil;
        dong1 = nil;
        dong2 = nil;
        var stack = Stack<Int>();
        stack.push(1);
        stack.push(2);
        stack.push(3);
        while (stack.topItem != nil) {
            print(stack.pop());
        }
    }

    func calcDecrement(forDecrement total: Int) -> (() -> Int) {
        var overallDecrement = 0;

        func decrement() -> Int {
            overallDecrement -= total;
            return overallDecrement;
        }

        return decrement;
    }


    class Person {
        let name: String;

        init(name: String) {
            self.name = name;
            print("\(name) 开始初始化");
        }

        deinit {
            print("\(name) 被析构");
        }
    }

    class StudentDetail {
        var value: Int;

        init(value: Int) {
            self.value = value;
            print("init StudentDetail");
        }

    }

    class Tom: StudentDetail {
        init() {
            super.init(value: 1);
            print("init Tom");
        }

        func printValue() {
            print(value);
            print(self.value);
            print(super.value);
        }
    }


}

struct Stack<T> {
    var items = [T]();

    mutating func push(_ t: T) {
        items.append(t);
    }

    mutating func pop() -> T {
        return items.removeLast();
    }
}

extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1];
    }
}

