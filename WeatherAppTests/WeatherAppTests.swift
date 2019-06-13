//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by emile on 13/06/2019.
//  Copyright © 2019 emile. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testExample() {
		guard let url = URL(string: "https:www.google.com/") else {
			XCTAssertTrue(false, "Could not instantiate url")
			return
		}
		var urlRequest = URLRequest(url: url)
		let parameters: Parameters = ["UserID": 1,
									  "Name": "Malcolm",
									  "Email": "malcolm@network.com",
									  "IsCool": true
		]
		
		do {
			let encoder = URLParameterEncoder()
			try encoder.encode(urlRequest: &urlRequest, with: parameters)
			guard let fullURL = urlRequest.url else {
				XCTAssertTrue(false, "urlRequest url is nil.")
				return
			}
			
			let expectedURL = "https:www.google.com/?Name=Malcolm&Email=malcolm%2540network.com&UserID=1&IsCool=true"
			XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
		} catch {
			
		}
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
