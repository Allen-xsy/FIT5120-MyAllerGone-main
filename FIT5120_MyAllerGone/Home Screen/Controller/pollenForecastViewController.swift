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
    
    var lat: Double = -37.911706
    var lon: Double = 145.132430
    var dayOneDate: String?
    var dayTwoDate: String?
    var dayThreeDate: String?
    var dayIndex: Int = 0
    
    @IBOutlet weak var dayOneButton: UIButton!
    @IBOutlet weak var dayTwoButton: UIButton!
    @IBOutlet weak var dayThreeButton: UIButton!
    
    @IBAction func backToWeatherPage(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
//        let controller = self.storyboard?.instantiateViewController(identifier: "weatherPage") as! HomeViewController
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func showDayOneData(_ sender: Any) {
        dayIndex = 0
        dayOneButton.setTitleColor(UIColor.black, for: .normal)
        dayTwoButton.setTitleColor(UIColor.darkGray, for: .normal)
        dayThreeButton.setTitleColor(UIColor.darkGray, for: .normal)
        self.plantsCollectionView.reloadData()
    }
    
    @IBAction func showDayTwoData(_ sender: Any) {
        dayIndex = 1
        dayOneButton.setTitleColor(UIColor.darkGray, for: .normal)
        dayTwoButton.setTitleColor(UIColor.black, for: .normal)
        dayThreeButton.setTitleColor(UIColor.darkGray, for: .normal)
        self.plantsCollectionView.reloadData()
    }
    
    @IBAction func showDayThreeData(_ sender: Any) {
        dayIndex = 2
        dayOneButton.setTitleColor(UIColor.darkGray, for: .normal)
        dayTwoButton.setTitleColor(UIColor.darkGray, for: .normal)
        dayThreeButton.setTitleColor(UIColor.black, for: .normal)
        self.plantsCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayOneButton.setTitle("\(dayOneDate ?? "NA")", for: .normal)
        dayTwoButton.setTitle("\(dayTwoDate ?? "NA")", for: .normal)
        dayThreeButton.setTitle("\(dayThreeDate ?? "NA")", for: .normal)
        pollenManager.plantsDelegate = self
        pollenManager.fetchPlantPollenLocation(latitude: lat, longitude: lon)
        
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

extension pollenForecastViewController: pollenPlantsManagerDelegate {
    func updatePollenPlants(_ pollenManager: PollenManager, pollen: PollenPlantsModel) {
        //print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        DispatchQueue.main.async {
            self.plantsList = []
            if let plantsData = pollen.plantsData {
                self.plantsList.append(contentsOf: plantsData)
            }
            //self.cell1Desc = pollen.graminaleCategory
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

extension pollenForecastViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlantsCollectionViewCell", for: indexPath) as! PlantsCollectionViewCell
        
        if plantsList.count > 0 {
            switch indexPath.row {
            case 0:
                cell.cell1Name.text = "Graminale"
                if let index = plantsList[dayIndex].plants?.graminales?.index.value {
                    cell.cell1Value.text = String(index)
                } else {
                    cell.cell1Value.text = "--"
                }
                cell.cell1Desc.text = plantsList[dayIndex].plants?.graminales?.index.category ?? "NA"
                cell.cellIcon.image = UIImage(named: "graminale")
            case 1:
                cell.cell1Name.text = "Hazel"
                if let index = plantsList[dayIndex].plants?.hazel?.index.value {
                    cell.cell1Value.text = String(index)
                } else {
                    cell.cell1Value.text = "--"
                }
                cell.cell1Desc.text = plantsList[dayIndex].plants?.hazel?.index.category ?? "NA"
                cell.cellIcon.image = UIImage(named: "hazel")
            case 2:
                cell.cell1Name.text = "Oak"
                if let index = plantsList[dayIndex].plants?.oak?.index.value {
                    cell.cell1Value.text = String(index)
                } else {
                    cell.cell1Value.text = "--"
                }
                cell.cell1Desc.text = plantsList[dayIndex].plants?.oak?.index.category ?? "NA"
                cell.cellIcon.image = UIImage(named: "oak")
            case 3:
                cell.cell1Name.text = "Pine"
                if let index = plantsList[dayIndex].plants?.pine?.index.value {
                    cell.cell1Value.text = String(index)
                } else {
                    cell.cell1Value.text = "--"
                }
                cell.cell1Desc.text = plantsList[dayIndex].plants?.pine?.index.category ?? "NA"
                cell.cellIcon.image = UIImage(named: "pine")
            case 4:
                cell.cell1Name.text = "Birch"
                if let index = plantsList[dayIndex].plants?.birch?.index.value {
                    cell.cell1Value.text = String(index)
                } else {
                    cell.cell1Value.text = "--"
                }
                cell.cell1Desc.text = plantsList[dayIndex].plants?.birch?.index.category ?? "NA"
                cell.cellIcon.image = UIImage(named: "birch")
            case 5:
                cell.cell1Name.text = "Ash"
                if let index = plantsList[dayIndex].plants?.ash?.index.value {
                    cell.cell1Value.text = String(index)
                } else {
                    cell.cell1Value.text = "--"
                }
                cell.cell1Desc.text = plantsList[dayIndex].plants?.ash?.index.category ?? "NA"
                cell.cellIcon.image = UIImage(named: "ash")
            default:
                cell.cell1Name.text = "--"
            }
            //cell.cell1Desc.text = plantsList[0].plants?.graminales?.index.category
        }
        
        cell.layer.cornerRadius = 8.0
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 6
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    
    
}
