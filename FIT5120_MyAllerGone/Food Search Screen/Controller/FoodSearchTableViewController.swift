//
//  FoodSearchTableViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 17/4/21.
//

import UIKit

class FoodSearchTableViewController: UITableViewController, UISearchBarDelegate {

    var allRecipe:[FoodRecipe]=[]
    var indicator = UIActivityIndicatorView()
    var choosenAllergen:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
         searchController.searchBar.delegate = self
         searchController.obscuresBackgroundDuringPresentation = false
         searchController.searchBar.placeholder = "Search for recipes"

         navigationItem.searchController = searchController
         navigationItem.hidesSearchBarWhenScrolling = false
         definesPresentationContext = true

         indicator.style = UIActivityIndicatorView.Style.medium
         indicator.center = self.tableView.center
         self.view.addSubview(indicator)
        
         navigationController?.tabBarItem.selectedImage = UIImage(named: "search_click")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)

        // Configure the cell...
        let recipe = allRecipe[indexPath.row]
        cell.textLabel?.text = recipe.label
        cell.detailTextLabel?.text = recipe.image
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        /*let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextPage = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
        nextPage.label = allRecipe[indexPath.row].label

        self.navigationController?.pushViewController(nextPage, animated: true)
*/
        //performSegue(withIdentifier: "showRecipe", sender: self)

     }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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

     let task = URLSession.shared.dataTask(with: jsonURL!) {
     (data, response, error) in
     // Regardless of response end the loading icon from the main thread
     DispatchQueue.main.async {
     self.indicator.stopAnimating()
     self.indicator.hidesWhenStopped = true
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showRecipe"{
                let destination = segue.destination as! RecipeViewController
                destination.ingredientLine = allRecipe[tableView.indexPathForSelectedRow!.row].ingredientLines
                destination.name = allRecipe[tableView.indexPathForSelectedRow!.row].label
                destination.imageURL = allRecipe[tableView.indexPathForSelectedRow!.row].image
                destination.recipeDetail =  allRecipe[tableView.indexPathForSelectedRow!.row].url

            }
        }

}
