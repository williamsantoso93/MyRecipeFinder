//
//  ViewController.swift
//  MyRecipeFinder
//
//  Created by William Santoso on 06/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var categories = [Category]()
    var selectedIndex = 0
    
    var titles: [String] {
        var temp = [String]()
        for index in 0...20 {
            temp.append("hello\(index)")
        }
        return temp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        getCategorisData()
    }

    func getCategorisData() {
        let urlSting = "https://www.themealdb.com/api/json/v1/1/categories.php"
        Networking.shared.getData(from: urlSting) { (result: Result<AllCategories,NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self.categories = data.categories
                    self.tableView.reloadData()
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FoodSegue" {
            let controller = segue.destination as! FoodListViewController
            controller.title = categories[selectedIndex].strCategory
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardTableViewCell
        
        cell.cardTitleLabel.text = categories[indexPath.row].strCategory
        cell.index = indexPath.row
        if let url = URL(string: categories[indexPath.row].strCategoryThumb) {
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

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
    }

}

extension ViewController: CardOnTapDelegate {
    func cardOnTap(index: Int) {
        print(index)
        selectedIndex = index
        performSegue(withIdentifier: "FoodSegue", sender: self)
    }
}
