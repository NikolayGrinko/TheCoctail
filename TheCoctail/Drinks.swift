//
//  Drinks.swift
//  TheCoctail
//
//  Created by Николай Гринько on 20.06.2024.
//

import Foundation

class Drinks {
	
	struct Returned: Codable {
		var drinks: [Drink]
	}
	
	let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
	var alphabetIndex = 0
	
	let urlBase = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
	var urlString = ""
	var drinkArray: [Drink] = []
	var isFetching = false
	
	func getData(completed: @escaping ()->()) {
		
//		guard !isFetching else {
//			print("<><><> didn't call getData here because we hadn't fetched data.")
//			completed()
//			return
//		}
		
		isFetching = true
		
		urlString = urlBase + alphabet[alphabetIndex]
		
		print("❄️ We are accesing the url \(urlString)")
		alphabetIndex += 1
		
		guard let url = URL(string: urlString) else {
			print("😡 ERROR: Could not create a URL from \(urlString)")
			isFetching = false
			completed()
			return
		}
		let session = URLSession.shared
		
		let task = session.dataTask(with: url) { data, response, error in
			if let error = error {
				print("😡 ERROR: \(error.localizedDescription)")
			}
			do {
				let returned = try JSONDecoder().decode(Returned.self, from: data!)
				self.drinkArray = self.drinkArray + returned.drinks
			} catch {
				self.isFetching = false
				print("😡 JSON ERROR: \(error.localizedDescription)")
			}
			completed()
		}
		task.resume()
	}
}
