//
//  InforDetailViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 11/5/21.
//

import UIKit

class InforDetailViewController: UIViewController {
    @IBOutlet weak var hayfeverView: UIView!
    @IBOutlet weak var foodAllergyView: UIView!
    @IBOutlet weak var hayFeverImage: UIImageView!
    @IBOutlet weak var foodAllergyImage: UIImageView!
    @IBOutlet weak var hayFeverLabelView: UIView!
    @IBOutlet weak var foodAllergyLabelView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hayfeverView.layer.shadowOpacity = 0.5
        hayfeverView.layer.shadowRadius = 6
        hayfeverView.layer.shadowOffset = CGSize(width: 0, height: 0)
        foodAllergyView.layer.shadowOpacity = 0.5
        foodAllergyView.layer.shadowRadius = 6
        foodAllergyView.layer.shadowOffset = CGSize(width: 0, height: 0)
        //hayfeverView.layer.masksToBounds = false
        hayFeverLabelView.layer.cornerRadius = 8.0
        hayFeverLabelView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        //hayFeverLabelView.layer.masksToBounds = false
        foodAllergyLabelView.layer.cornerRadius = 8.0
        foodAllergyLabelView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        //foodAllergyLabelView.layer.masksToBounds = true
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
