//
//  DetailFoodViewController.swift
//  MyRecipeFinder
//
//  Created by William Santoso on 08/06/21.
//

import UIKit

//52772
class DetailFoodViewController: UIViewController {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var mealName = String()
    var mealID = String()
    var meal = [[String:String?]]()
    
    var ingredients = [String]()
    var measures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = mealName
        getMealData(from: mealID)
        
        foodImage.layer.cornerRadius = foodImage.layer.frame.width / 2
    }

    func getMealData(from id: String) {
        let urlSting = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        Networking.shared.getData(from: urlSting) { (result: Result<MealData,NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self.meal = data.meals
                    self.categoryLabel.text = self.meal[0]["strCategory"] ?? ""
                    self.genreLabel.text = self.meal[0]["strArea"] ?? ""
                    if let url = URL(string: (self.meal[0]["strMealThumb"] ?? "")!) {
                        self.foodImage.load(url: url) { finished in
                            if finished {
                                self.indicator.stopAnimating()
                            }
                        }
                    }
                    self.getIngredient()
                    self.tableView.reloadData()
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getIngredient() {
        for (key, value) in meal[0] {
            if key.contains("strIngredient") {
                if let value = value {
                    if !value.isEmpty {
                        ingredients.append(value)
                    }
                }
            } else if key.contains("strMeasure") {
                if let value = value {
                    if !value.isEmpty {
                        measures.append(value)
                    }
                }
            }
        }
    }

}

extension DetailFoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientListTableViewCell
        
        cell.titleLabel.text = ingredients[indexPath.row]
        cell.detailLabel.text = measures[indexPath.row]
        
        return cell
    }
}
