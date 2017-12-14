//
//  HelloWorldTests.swift
//  HelloWorldTests
//
//  Created by eesee on 2017/12/11.
//  Copyright © 2017年 eesee. All rights reserved.
//

import XCTest
@testable import HelloWorld

class HelloWorldTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMealInitializationSucceeds(){
        let zeroRatingMeal = Meal.init(name:"Zero", photo:nil, rating:0)
        XCTAssertNotNil(zeroRatingMeal)
        
        let positiveRatingMeal = Meal.init(name:"Positive", photo:nil, rating:5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    func testMealInitializationFails(){
        let negativeRatingMeal = Meal.init(name:"Negative", photo:nil, rating:-1)
        XCTAssertNil(negativeRatingMeal)
        
        let emptyStringMeal = Meal.init(name:"", photo:nil, rating:0)
        XCTAssertNil(emptyStringMeal)
        
        let largeRatingMeal = Meal.init(name:"Large", photo:nil, rating:6)
        XCTAssertNil(largeRatingMeal)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
