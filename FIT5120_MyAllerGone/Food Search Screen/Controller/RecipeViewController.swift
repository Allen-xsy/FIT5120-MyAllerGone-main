//
//  RecipeViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 18/4/21.
//

import UIKit

class RecipeViewController: UIViewController {

    var ingredientLine:[String]?
    
    @IBOutlet weak var ingredientLines: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        ingredientLines.text = ingredientLine![0]
        // Do any additional setup after loading the view.
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
