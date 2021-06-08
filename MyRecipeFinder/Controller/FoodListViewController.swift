//
//  FoodListViewController.swift
//  MyRecipeFinder
//
//  Created by William Santoso on 08/06/21.
//

import UIKit

class FoodListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var category: String = ""
    var meals = [Meal]()
    
    var selectedIndex = 0
    var selectedImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        navigationItem.title = category
        
        getMealsData(from: category)
    }

    func getMealsData(from category: String) {
        let urlSting = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        Networking.shared.getData(from: urlSting) { (result: Result<AllMeals,NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self.meals = data.meals
                    self.indicator.stopAnimating()
                    self.tableView.reloadData()
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let controller = segue.destination as! DetailFoodViewController
            
            controller.mealName = meals[selectedIndex].strMeal
            controller.mealID = meals[selectedIndex].idMeal
        }
    }
}

extension FoodListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardTableViewCell
        
        cell.cardTitleLabel.text = meals[indexPath.row].strMeal
        cell.index = indexPath.row
        if let url = URL(string: meals[indexPath.row].strMealThumb) {
            cell.cardImageView.load(url: url) { finished in
                if finished {
                    cell.indicator.stopAnimating()
                }
            }
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FoodListViewController: CardOnTapDelegate {
    func cardOnTap(index: Int) {
        selectedIndex = index
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
}
