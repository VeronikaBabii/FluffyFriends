//
//  FluffyFriendsTests.swift
//  FluffyFriendsTests
//
//  Created by Veronika Babii on 06.07.2020.
//  Copyright © 2020 Veronika Babii. All rights reserved.
//

import XCTest

class FluffyFriendsTests: XCTestCase {
    
    func testHelloWorld() {
        var helloWorld: String?
        
        XCTAssertNil(helloWorld)
        
        helloWorld = "hello world"
        XCTAssertEqual(helloWorld, "hello world")
    }

}
