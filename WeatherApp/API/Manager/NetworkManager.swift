//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by emile on 11/04/2019.
//  Copyright © 2019 emile. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
	
	case success
	case authenticationError = "You need to be authenticated first."
	case badRequest = "Bad request"
	case outdated = "The url you requested is outdated."
	case failed = "Network request failed."
	case noData = "Response returned with no data to decode."
	case unableToDecode = "We could not decode the response."
}

enum Result<String> {
	case success
	case failure(String)
}

struct NetworkManager {
	
	let router = Router<WeatherEndPoint>()
	
	func getForecast(completion: @escaping (_ weather: Forecast?, _ error: String?) ->Void) {
		
		router.request(.forecast) { data, response, error in
			
			if error != nil {
				completion(nil, "Please check your network connection.")
			}
			
			if let response = response as? HTTPURLResponse {
				
				let result = self.handleNetworkResponse(response)
				
				switch result {
				case .success:
					guard let responseData = data else {
						completion(nil, NetworkResponse.noData.rawValue)
						return
					}
					do {
						print(responseData)
						let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
						print(jsonData)
						let apiResponse = try JSONDecoder().decode(Forecast.self, from: responseData)
						completion(apiResponse, nil)
					}
					catch {
						print(error)
						completion(nil, NetworkResponse.unableToDecode.rawValue)
					}
				case .failure(let networkFailureError): completion(nil, networkFailureError)
				}
			}
		}
	}
	
	func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
		
		switch response.statusCode {
		case 200...299: return .success
		case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
		case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
		case 600: return .failure(NetworkResponse.outdated.rawValue)
		default: return .failure(NetworkResponse.failed.rawValue)
		}
	}
}
