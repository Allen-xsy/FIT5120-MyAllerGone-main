//
//  InfoViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 20/3/21.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        guard let tabBar = tabBarController?.tabBar else {
            return
        }
        //tabBar.barTintColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true
        tabBar.layer.opacity = 0.9
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor.gray.cgColor
        
        //view.backgroundColor = UIColor.white
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarItem.selectedImage = UIImage(named: "house_click")
        backGroundImageView.image = UIImage(named: "launch_2")
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
// MARK: - Collection view data source

extension InfoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCollectionViewCell", for: indexPath) as! infoCollectionViewCell
        
        
        
        cell.layer.cornerRadius = 8.0
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 6
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    
    
}
