//
//  FoodSearchFilterCell.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 2021/5/1.
//

import UIKit

class FoodSearchFilterCell: UICollectionViewCell {

    @IBOutlet weak var fishSwitch: UISegmentedControl!
    
    @IBOutlet weak var beanSwitch: UISegmentedControl!
    
    @IBOutlet weak var nutSwitch: UISegmentedControl!
    
    @IBOutlet weak var eggSwitch: UISegmentedControl!
    
    @IBOutlet weak var sesameSwitch: UISegmentedControl!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    public var didChangedFilterHandler:((String, Int) -> Void)? = nil
    
    public var didClickedSearchButtonHandler:(() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        whiteView.layer.cornerRadius = 5.0
        whiteView.layer.shadowOpacity = 0.3
        whiteView.layer.shadowRadius = 5
        whiteView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        didClickedSearchButtonHandler?()
    }
    
    @IBAction func switchDidChanged(_ sender: UISegmentedControl) {
        if sender == fishSwitch {
            didChangedFilterHandler?(sender.selectedSegmentIndex == 0 ? "fish" : "", 0)
        } else if sender == beanSwitch {
            didChangedFilterHandler?(sender.selectedSegmentIndex == 0 ? "bean" : "", 1)
        } else if sender == nutSwitch {
            didChangedFilterHandler?(sender.selectedSegmentIndex == 0 ? "nut" : "", 2)
        } else if sender == eggSwitch {
            didChangedFilterHandler?(sender.selectedSegmentIndex == 0 ? "egg" : "", 3)
        } else if sender == sesameSwitch {
            didChangedFilterHandler?(sender.selectedSegmentIndex == 0 ? "sesame" : "", 4)
        }
    }
    
}
