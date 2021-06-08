//
//  FoodListViewController.swift
//  MyRecipeFinder
//
//  Created by William Santoso on 08/06/21.
//

import UIKit

class FoodListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
//    var title: String
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        let category = navigationItem.title ?? ""
        getMealsData(from: category)
    }
//    https://www.themealdb.com/api/json/v1/1/filter.php?c=

    func getMealsData(from category: String) {
        let urlSting = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        Networking.shared.getData(from: urlSting) { (result: Result<AllMeals,NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self.meals = data.meals
                    self.tableView.reloadData()
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        print(indexPath.row)
    }
}

extension FoodListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
    }

}


extension FoodListViewController: CardOnTapDelegate {
    func cardOnTap(index: Int) {
        print(index)
//        selectedIndex = index
//        performSegue(withIdentifier: "FoodSegue", sender: self)
    }
}
