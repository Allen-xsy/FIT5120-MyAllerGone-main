//
//  AllergenChooseViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 17/4/21.
//

import UIKit

class AllergenChooseViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var allergen: [String] = ["fish","bean","nut","egg","sesame"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: self.view.frame.size.width, height: 100)
        
        collectionView.register(UINib(nibName: "FoodSearchImageCell", bundle: nil), forCellWithReuseIdentifier: "FoodSearchImageCell")
        collectionView.register(UINib(nibName: "FoodSearchIntroCell", bundle: nil), forCellWithReuseIdentifier: "FoodSearchIntroCell")
        collectionView.register(UINib(nibName: "FoodSearchFilterCell", bundle: nil), forCellWithReuseIdentifier: "FoodSearchFilterCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startSearchSegue" {
            let destination = segue.destination as! FoodSearchTableViewController
            
            destination.choosenAllergen = allergen
        }
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        collectionView.reloadData()
    }
}

extension AllergenChooseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: self.view.frame.width, height: (self.view.frame.width - 32) * 9.0 / 16.0 + 16)
        } else if indexPath.item == 1 {
            return CGSize(width: self.view.frame.width, height: 100)
        } else if indexPath.item == 2 {
            var height: CGFloat = 8.0
            height += (36.0 * 5.0)
            height += (16.0 * 5.0)
            height += 32.0
            height += 40.0
            return CGSize(width: self.view.frame.width, height: height)
        }
        return CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodSearchImageCell", for: indexPath) as! FoodSearchImageCell
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodSearchIntroCell", for: indexPath) as! FoodSearchIntroCell
            return cell
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodSearchFilterCell", for: indexPath) as! FoodSearchFilterCell

            cell.fishSwitch.selectedSegmentIndex = allergen.contains("fish") ? 0 : 1
            cell.beanSwitch.selectedSegmentIndex = allergen.contains("bean") ? 0 : 1
            cell.nutSwitch.selectedSegmentIndex = allergen.contains("nut") ? 0 : 1
            cell.eggSwitch.selectedSegmentIndex = allergen.contains("egg") ? 0 : 1
            cell.sesameSwitch.selectedSegmentIndex = allergen.contains("sesame") ? 0 : 1
            
            cell.didChangedFilterHandler = { [weak self] (value, index) in
                self?.allergen[index] = value
                self?.collectionView.reloadData()
            }
            
            cell.didClickedSearchButtonHandler = {[weak self] in
                self?.performSegue(withIdentifier: "startSearchSegue", sender: nil)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
}
