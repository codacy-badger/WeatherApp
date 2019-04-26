//
//  MainViewController.swift
//  WeatherApp
//
//  Created by emile on 11/04/2019.
//  Copyright © 2019 emile. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

	let networkManager: NetworkManager = NetworkManager()
	
	var forecast: Forecast?
	var items = [DayForecast]()
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		networkManager.getForecast() { forecast, _ in
			
			guard let forecast = forecast else {
				return
			}
			
			self.forecast = forecast
			
			self.items = forecast.list
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		guard let vc = segue.destination as? DetailTableViewController else {
			return
		}
		
		if let indexPath = tableView.indexPathForSelectedRow  {
		
			vc.city = forecast?.city
			vc.forecast = items[indexPath.row]
		}
	}
}


//MARK: UITableViewDataSource
extension MainTableViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		guard let forecast = forecast else {
			return ""
		}
		
		return "\(forecast.city.name), \(forecast.city.country)"
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let item = items[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
		
		cell.textLabel?.text = item.dt_txt.description
		cell.detailTextLabel?.text = "\(Int(item.main.temp)/10)°"
		
		return cell
	}
}
