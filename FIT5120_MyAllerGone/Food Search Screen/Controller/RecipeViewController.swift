//
//  RecipeViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 18/4/21.
//

import UIKit
import SafariServices

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    public var recipe: FoodRecipe?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "FoodDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodDetailTableViewCell")
        tableView.register(UINib(nibName: "FoodDetailIntroCell", bundle: nil), forCellReuseIdentifier: "FoodDetailIntroCell")
    }
    
    fileprivate func jumpToSafari() {
        guard let urlString = self.recipe?.url else {
            return
        }
        
        guard  let url = URL(string: urlString) else {
            return
        }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDetailTableViewCell", for: indexPath) as! FoodDetailTableViewCell
            cell.recipe = recipe
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodDetailIntroCell", for: indexPath) as! FoodDetailIntroCell
            cell.recipe = recipe
            cell.didClickedDetailButtonHandler = {[weak self] in
                self?.jumpToSafari()
            }
            return cell
        }
    }

}
