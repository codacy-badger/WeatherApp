//
//  WeatherEndPoint.swift
//  WeatherApp
//
//  Created by emile on 11/04/2019.
//  Copyright © 2019 emile. All rights reserved.
//

import Foundation


public enum WeatherEndPoint: String {
	
	case forecast = "forecast"
}

extension WeatherEndPoint: EndPointType {
	
	var baseURL: URL {
		
		guard let url = URL(string: weatherAPI) else {
			fatalError("baseURL could not be configured.")
		}
		
		return url
	}
	
	var path: String {
		return "data/2.5/forecast"
	}
	
	var httpMethod: HTTPMethod {
		return .get
	}
	
	var task: HTTPTask {
		return .requestParameters(bodyParameters: nil,
								  bodyEncoding: .urlEncoding,
								  urlParameters: ["q": city,
												  "appid": apiKey])
	}
	
	var headers: HTTPHeaders? {
		return nil
	}
}
