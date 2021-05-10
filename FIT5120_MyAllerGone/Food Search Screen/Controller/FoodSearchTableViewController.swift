//
//  FoodSearchTableViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 17/4/21.
//

import UIKit

class FoodSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var allRecipe:[FoodRecipe] = []
    var indicator = UIActivityIndicatorView()
    var choosenAllergen:[String] = []
    var randomRecipe:[String] = ["Chicken","Beef","Fish","Lamb","Salad","meat","vegetable"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for recipes"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = self.tableView.center
        self.view.addSubview(indicator)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.tableFooterView = UIView()
        
        
        let randomInt = Int.random(in: 0..<5)
        let defaultRecipe = randomRecipe[randomInt]
        requestRecipes(recipeName: defaultRecipe)
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allRecipe.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        cell.configCell(recipe: allRecipe[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showRecipe", sender: allRecipe[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipe"{
            let destination = segue.destination as! RecipeViewController
            destination.recipe = sender as? FoodRecipe
        }
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // If there is no text end immediately
        guard let searchText = searchBar.text, searchText.count > 0 else {
            return;
        }
        
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.clear
        
        allRecipe.removeAll()
        tableView.reloadData()
        requestRecipes(recipeName: searchText)
    }
    
    // MARK: - Web Request
    
    func requestRecipes(recipeName: String) {
        var searchString = "https://api.edamam.com/search?q=" + recipeName //"&excluded=fish&app_id=254ef07c&app_key=2ea1489ef247ecc233cadd8e250f8356"
        for allergen in choosenAllergen {
            if allergen != ""{
                searchString += "&excluded=" + allergen
            }
        }
        searchString += "&to=25&app_id=254ef07c&app_key=2ea1489ef247ecc233cadd8e250f8356"
        
        let jsonURL =
            URL(string: searchString.addingPercentEncoding(withAllowedCharacters:
                                                            .urlQueryAllowed)!)

        indicator.startAnimating()
        let task = URLSession.shared.dataTask(with: jsonURL!) {
            (data, response, error) in
            // Regardless of response end the loading icon from the main thread
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
            }
            
            if let error = error {
                print(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let volumeData = try decoder.decode(VolumeData.self, from: data!)
                
                if let recipes = volumeData.hits {
                    self.allRecipe.append(contentsOf: recipes)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch let err {
                print(err)
            }
        }
        
        task.resume()
    }

}
