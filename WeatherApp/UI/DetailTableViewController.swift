//
//  DetailTableViewController.swift
//  WeatherApp
//
//  Created by emile on 11/04/2019.
//  Copyright © 2019 emile. All rights reserved.
//

import UIKit
import MapKit

class DetailTableViewController: UITableViewController {
	
	var city: City?
	var forecast: DayForecast?
	
	@IBOutlet weak var mapView: MKMapView!
	
	@IBOutlet weak var tempLabel: UILabel!
	@IBOutlet weak var minTempLabel: UILabel!
	@IBOutlet weak var maxTempLabel: UILabel!
	
	@IBOutlet weak var humidityLabel: UILabel!
	
	@IBOutlet weak var seaPressureLabel: UILabel!
	@IBOutlet weak var groundPressureLabel: UILabel!
	
	@IBOutlet weak var conditionsLabel: UILabel!
	
	@IBOutlet weak var windSpeedLabel: UILabel!
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		guard let city = city else {
			return
		}
		
		self.title = "\(city.name), \(city.country)"
		
		setupView()
	}
	
	private func setupView() {
		
		guard let forecast = forecast, let city = city else {
			return
		}
		
		let location = CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon)
		let region = MKCoordinateRegion(center: location, latitudinalMeters: 4000, longitudinalMeters: 4000)
		
		mapView.setRegion(region, animated: true)

		tempLabel.text = "\(Int(forecast.main.temp)/10)°"
		minTempLabel.text = "\(Int(forecast.main.temp_min)/10)°"
		maxTempLabel.text = "\(Int(forecast.main.temp_max)/10)°"
		
		humidityLabel.text = "\(forecast.main.humidity)%"
		
		seaPressureLabel.text = "\(Int(forecast.main.pressure)) hPa"
		groundPressureLabel.text = "\(Int(forecast.main.grnd_level)) hPa"
		
		conditionsLabel.text = forecast.weather[0].description.capitalizingFirstLetter()
		
		windSpeedLabel.text = "\(forecast.wind.speed) m/s"
	}
}

extension String {
	
	func capitalizingFirstLetter() -> String {
		return prefix(1).uppercased() + self.lowercased().dropFirst()
	}
	
	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
}
