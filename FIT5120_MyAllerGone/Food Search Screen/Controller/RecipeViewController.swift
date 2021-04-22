//
//  RecipeViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 18/4/21.
//

import UIKit
import SafariServices

class RecipeViewController: UIViewController {

    var ingredientLine:[String]?
    var name:String?
    var text:String=""
    var imageURL:String?
    var recipeDetail:String?
    var index:Int=1
    
    @IBOutlet weak var ingredientLines: UILabel!
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        for element in ingredientLine!{
            text += "\(index). " + element + "\n"
            index += 1
        }
        recipeName.text = name
        ingredientLines.text = text
        setImage (from: imageURL!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func jumpToSafari(_ sender: Any) {
        let url = URL(string:recipeDetail!)!
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.recipeImage.image = image
            }
        }
    }

}
