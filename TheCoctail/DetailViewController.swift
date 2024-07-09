//
//  DetailViewController.swift
//  TheCoctail
//
//  Created by Николай Гринько on 20.06.2024.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet weak var drinkLabel: UILabel!
	@IBOutlet weak var ratingTextfield: UITextField!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var alcoholLabel: UILabel!
	@IBOutlet weak var glassLabel: UILabel!
	@IBOutlet weak var ingredientsTextView: UITextView!
	@IBOutlet weak var recipeTextField: UITextView!
	
	
	
	var drink: Drink!
	var myDrinks: [String: String] = [:]
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		if drink == nil {
			drink = Drink()
		}
        
		updateUserInterface()
    }
	
	func updateUserInterface() {
		drinkLabel.text = drink.strDrink
		alcoholLabel.text = "Yes"
		if drink.strAlcoholic != "Alcoholic" {
			alcoholLabel.text = "No"
		}
		glassLabel.text = drink.strGlass
		recipeTextField.text = drink.strInstructions
		createIngredientsList()
		
		ratingTextfield.text = myDrinks[drink.strDrink] ?? "-"
		
		guard let url = URL(string: drink.strDrinkThumb ?? "") else { return }
		do {
			let data = try Data(contentsOf: url)
			self.imageView.image = UIImage(data: data)
		} catch {
			print("😡 ERROR: Could not get image from url \(url)")
		}
		
		func addIngridients(measure: String?, ingridient: String?) {
			guard measure != nil else { return }
			ingredientsTextView.text += measure!
			guard ingridient != nil else { return }
			ingredientsTextView.text += " \(ingridient!) \n"
		}
		
		func createIngredientsList() {
			ingredientsTextView.text = ""
			addIngridients(measure: drink.strMeasure1, ingridient: drink.strIngridient1)
			addIngridients(measure: drink.strMeasure2, ingridient: drink.strIngridient2)
			addIngridients(measure: drink.strMeasure3, ingridient: drink.strIngridient3)
			addIngridients(measure: drink.strMeasure4, ingridient: drink.strIngridient4)
			addIngridients(measure: drink.strMeasure5, ingridient: drink.strIngridient5)
			addIngridients(measure: drink.strMeasure6, ingridient: drink.strIngridient6)
			addIngridients(measure: drink.strMeasure7, ingridient: drink.strIngridient7)
			addIngridients(measure: drink.strMeasure8, ingridient: drink.strIngridient8)
			addIngridients(measure: drink.strMeasure9, ingridient: drink.strIngridient9)
			addIngridients(measure: drink.strMeasure10, ingridient: drink.strIngridient10)
			addIngridients(measure: drink.strMeasure11, ingridient: drink.strIngridient11)
			addIngridients(measure: drink.strMeasure12, ingridient: drink.strIngridient12)
			addIngridients(measure: drink.strMeasure13, ingridient: drink.strIngridient13)
			addIngridients(measure: drink.strMeasure14, ingridient: drink.strIngridient14)
			addIngridients(measure: drink.strMeasure15, ingridient: drink.strIngridient15)
			if ingredientsTextView.text != "" {
				ingredientsTextView.text.removeLast()
			}
		}
	}
		override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
			if let ratingNumber = Int(ratingTextfield.text!) {
				if ratingNumber >= 1 && ratingNumber <= 10 {
					myDrinks[drink.strDrink] = String(ratingNumber)
				}
			}
		}
	
	
	@IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
		let isPresentingInAddMode = presentingViewController is UINavigationController
		if isPresentingInAddMode {
			dismiss(animated: true, completion: nil)
		} else {
			navigationController?.popViewController(animated: true)
		}
	}
}
