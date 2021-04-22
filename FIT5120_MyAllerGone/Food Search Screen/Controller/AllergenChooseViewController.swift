//
//  AllergenChooseViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 17/4/21.
//

import UIKit

class AllergenChooseViewController: UIViewController {

    var allergen: [String] = ["","",""]
    @IBOutlet weak var fishSegmented: UISegmentedControl!
    @IBOutlet weak var beanSegmented: UISegmentedControl!
    @IBOutlet weak var nutSegmented: UISegmentedControl!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var fishImage: UIImageView!
    @IBOutlet weak var beanImage: UIImageView!
    @IBOutlet weak var nutImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarItem.selectedImage = UIImage(named: "search_click")
        foodImage.image = UIImage(named: "foodSearch")
        fishImage.image = UIImage(named: "fishIcon")
        beanImage.image = UIImage(named: "beanIcon")
        nutImage.image = UIImage(named: "nutIcon")
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
    @IBAction func fishIndex(_ sender: Any) {
        switch fishSegmented.selectedSegmentIndex
        {
        case 0:
            allergen[0] = "fish"
        case 1:
            allergen[0] = ""
        default:
            break
        }
    }
    
    @IBAction func beanIndex(_ sender: Any) {
        switch beanSegmented.selectedSegmentIndex
        {
        case 0:
            allergen[1] = "bean"
        case 1:
            allergen[1] = ""
        default:
            break
        }
    }
    
    @IBAction func nutIndex(_ sender: Any) {
        switch nutSegmented.selectedSegmentIndex
        {
        case 0:
            allergen[2] = "nut"
        case 1:
            allergen[2] = ""
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "startSearchSegue" {
     let destination = segue.destination as! FoodSearchTableViewController

        destination.choosenAllergen = allergen
     }
     }
}
