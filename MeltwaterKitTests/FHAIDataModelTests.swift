//
//  FHAIDataModelTests.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/1/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import XCTest
import Alamofire

class FHAIDataModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetDocuments() {
        
       // let exp = expectation(description: "\(#function)\(#line)")

        let payload: Parameters = [
                        "query":"Apple and orange",
                        "type":"article",
                        "language":"en",
                        "startDate":1489305600000,
                        "endDate":1490857200000,
                        "country":"us",
                        "from":0,
                        "size":5]
        
        let dataManager = FHAIDataManager();
        
        dataManager.retrieveDocuments(payload: payload)
//            .then { json -> Void in // Return Void to stop the chain
//                print(json)
//                exp.fulfill()
//            }
//            .catch { error in
//                print(error)
//            }
//        
//
//        
//        // Wait for the async request to complete
//        waitForExpectations(timeout: 10, handler: { (error) in
//            if error != nil {
//                XCTFail((error?.localizedDescription)!)
//            }
//        })
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
