//
//  Lakshan_028Tests.swift
//  Lakshan-028Tests
//
//  Created by Mobios on 11/15/21.
//

import XCTest
@testable import Lakshan_028

class Lakshan_028Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAvailableSlots() throws {
      
        let controller = FirebaseController()
        controller.getAvailableSlots(type: "VIP") {(success) in
            
        }
        
        controller.getAvailableSlots(type: "NORMAL") {(success) in
            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
