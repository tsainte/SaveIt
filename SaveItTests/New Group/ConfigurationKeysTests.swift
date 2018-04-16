//
//  ConfigurationKeys.swift
//  SaveItTests
//
//  Created by Tiago Bencardino on 27/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

@testable import SaveIt
import XCTest

class ConfigurationKeysTests: XCTestCase {
    
    var configurationKeys: ConfigurationKeys {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: "configuration", withExtension: "plist")!
        return ConfigurationKeys(with: path)
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    /// Asserts it can reads all the values properly
    func testReadValues() {
        XCTAssertEqual(configurationKeys.monzoClientId, "monzo_client_id")
        XCTAssertEqual(configurationKeys.monzoClientSecret, "monzo_client_secret")
        XCTAssertEqual(configurationKeys.monzoRedirectLink, "monzo_redirect_link")
        XCTAssertEqual(configurationKeys.starlingToken, "starling_token")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
