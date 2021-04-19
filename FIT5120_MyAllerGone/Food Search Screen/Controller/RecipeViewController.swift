//
//  RecipeViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 18/4/21.
//

import UIKit

class RecipeViewController: UIViewController {

    var ingredientLine:[String]?
    var name:String?
    var text:String=""
    var index:Int=1
    
    @IBOutlet weak var ingredientLines: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for element in ingredientLine!{
            text += "\(index). " + element + "\n"
            index += 1
        }
        
        ingredientLines.text = text
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
