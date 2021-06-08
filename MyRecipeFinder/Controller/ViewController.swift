//
//  ViewController.swift
//  MyRecipeFinder
//
//  Created by William Santoso on 06/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
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
        
        getCategorisData()
    }

    func getCategorisData() {
        let urlSting = "https://www.themealdb.com/api/json/v1/1/categories.php"
        Networking.shared.getData(from: urlSting) { (result: Result<AllCategories,NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self.categories = data.categories
                    self.indicator.stopAnimating()
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
            controller.category = categories[selectedIndex].strCategory
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
}

extension ViewController: CardOnTapDelegate {
    func cardOnTap(index: Int) {
        selectedIndex = index
        performSegue(withIdentifier: "FoodSegue", sender: self)
    }
}
