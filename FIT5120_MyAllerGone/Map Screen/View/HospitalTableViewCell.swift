//
//  HospitalTableViewCell.swift
//  HospitalLocation
//
//  Created by 夏舒衍 on 2021/3/30.
//

import UIKit
import CoreLocation

class HospitalTableViewCell: UITableViewCell {

    @IBOutlet weak var hospitalImageView: UIImageView!
    @IBOutlet weak var hospitalNameL: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var whiteView: UIView!
    
    private var placeVo: PlaceSearchItemVo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hospitalImageView.image = nil
        hospitalNameL.text = nil
        distanceLabel.text = nil
        addressLabel.text = nil
    }

    public func configCell(searchResult: PlaceSearchItemVo, location: CLLocation) {
        placeVo = searchResult
        hospitalNameL.text = searchResult.name
        addressLabel.text = searchResult.vicinity
        
        if let reference = searchResult.photos?.first?.photo_reference {
            hospitalImageView.networkImage(urlString: imageUrl(for: reference), placeholderImage: nil) {[weak self] (success, image) in
                if success {
                    if reference == self?.placeVo?.photos?.first?.photo_reference {
                        self?.hospitalImageView.image = image                        
                    }
                }
            }
        } else {
            hospitalImageView.image = nil
        }
        
        if let lat = searchResult.geometry?.location?.lat, let lon = searchResult.geometry?.location?.lng {
            let current = CLLocation(latitude: lat, longitude: lon)
            
            let distance = current.distance(from: location)
            
            if distance < 1000 {
                distanceLabel.text = String(format: "%.0fm", distance)
            } else {
                distanceLabel.text = String(format: "%.2fkm", abs(current.distance(from: location)) / 1000.0)                
            }
            
            
        } else {
            distanceLabel.text = "Nan"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
