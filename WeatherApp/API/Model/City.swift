//
//  City.swift
//  WeatherApp
//
//  Created by emile on 11/04/2019.
//  Copyright © 2019 emile. All rights reserved.
//

import Foundation
import CoreLocation

struct City: Codable {
	
	let id: Int
	let name: String
	let country: String
	let population: Int
	let coord: Coordinates
}
