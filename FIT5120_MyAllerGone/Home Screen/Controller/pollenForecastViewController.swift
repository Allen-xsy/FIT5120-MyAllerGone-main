//
//  pollenForecastViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 7/4/21.
//

import UIKit

class pollenForecastViewController: UIViewController {

    @IBOutlet weak var plantsCollectionView: UICollectionView!
    var pollenManager = PollenManager()
    var plantsList = [PoData]()
    var cell1Desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pollenManager.plantsDelegate = self
        pollenManager.fetchPlantPollenLocation(latitude: 51.50998, longitude: -0.1337)
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

//MARK: - Receive the Pollen data and send it to the UI

extension PollenForecastViewController: pollenPlantsManagerDelegate {
    func updatePollenPlants(_ pollenManager: PollenManager, pollen: PollenPlantsModel) {
        //print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        DispatchQueue.main.async {
            self.plantsList = []
            if let plantsData = pollen.plantsData {
                self.plantsList.append(contentsOf: plantsData)
            }
            self.cell1Desc = pollen.graminaleCategory
            self.plantsCollectionView.reloadData()
        }
    }
    

    //func updatePollenIndex(_ pollenManager: PollenManager, pollen: PollenModel){
        
//        DispatchQueue.main.async {
//            // Set tree value
//            if let index1 = pollen.pollenTreeValue {
//                self.treePollenIndex = String(index1)
//                if index1 > 2 {
//                    self.treeColor = ["#FF9F00", "#F48A4F"]
//                } else {
//                    self.treeColor = ["#84CF33", "#3AA512"]
//                }
//            } else {
//                self.treePollenIndex = "--"
//            }
//            self.treePollenDesc = pollen.pollenTreeCategory ?? "NA"
//            // Set weed value
//            if let index2 = pollen.pollenWeedValue {
//                self.weedPollenIndex = String(index2)
//                if index2 > 2 {
//                    self.weedColor = ["#FF9F00", "#F48A4F"]
//                } else {
//                    self.weedColor = ["#84CF33", "#3AA512"]
//                }
//            } else {
//                self.weedPollenIndex = "--"
//            }
//            self.weedPollenDesc = pollen.pollenWeedCategory ?? "NA"
//
//            self.HomeCollectionView.reloadData()
//            self.checkLoadingStatus()
//        }
    
}

// MARK: - Collection view data source

extension PollenForecastViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if indexPath.row == 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
//
//            cell.layer.cornerRadius = 5.0
//            cell.layer.shadowOpacity = 0.3
//            cell.layer.shadowRadius = 5
//            cell.layer.masksToBounds = false
//
//
//            return cell
//        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlantsCollectionViewCell", for: indexPath) as! PlantsCollectionViewCell
        //print(plantsList.count)
        switch indexPath.row {
        case 0:
            cell.cell1Name.text = "Graminale"
        case 1:
            cell.cell1Name.text = "Hazel"
        default:
            cell.cell1Name.text = "--"
        }
        if plantsList.count > 0 {
            
            cell.cell1Desc.text = plantsList[0].plants?.graminales?.index.category
        }
        
        
        cell.layer.cornerRadius = 5.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    
    
}
