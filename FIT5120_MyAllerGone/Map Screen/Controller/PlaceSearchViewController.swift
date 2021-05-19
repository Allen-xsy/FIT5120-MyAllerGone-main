//
//  PlaceSearchViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍  on 2021/4/20.
//

import UIKit

class PlaceSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet var footerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var dataSource: [AddressSearchItemVo] = []
    public var page: Bool = false
    
    /// Search Controller
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.searchTextField.placeholder = "Enter address to search"
        search.searchResultsUpdater = self
        search.delegate = self
        search.searchBar.delegate = self
        search.searchBar.searchTextField.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        return search
    }()
    
    // Loading View
    lazy var loadingView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        tableView.tableFooterView = UIView()
        view.addSubview(loadingView)

        loadingView.style = UIActivityIndicatorView.Style.large
        loadingView.center = self.tableView.center
        self.view.addSubview(loadingView)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let place: AddressSearchItemVo = dataSource[indexPath.row]
        cell.textLabel?.text = place.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if page {
            performSegue(withIdentifier: "weatherPage", sender: dataSource[indexPath.row])
        } else {
            let place = dataSource[indexPath.row]
            
            guard let place_id = place.place_id, place_id.count > 0  else {
                return
            }
            
            queryLocation(for: place_id, searchItem: place)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "weatherPage" {
            let controller = segue.destination as? HomeViewController
            let loc = sender as? AddressSearchItemVo
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            //print(loc?.geometry?.location?.lat!)
            controller?.location = loc
        } else {
            guard let controller = segue.destination as? SearchResultTableViewController, let place = sender as? AddressSearchItemVo  else {
                return
            }
            controller.location = place
        }
    }
    
    fileprivate func queryLocation(for place_id: String, searchItem : AddressSearchItemVo) {
        
        if let _ = searchItem.geometry?.location {
            performSegue(withIdentifier: "showSearchResultController", sender: searchItem)
            return
        }
        view.isUserInteractionEnabled = false
        loadingView.startAnimating()
        NetworkManager.loadData(urlString: googleMapsPlaceDetail(place_id: place_id), type: PlaceDetailVo.self) {[weak self] (success, value) in
            self?.view.isUserInteractionEnabled = true
            self?.loadingView.stopAnimating()
            guard let strong_self = self else {
                return
            }
            
            guard let lat = value?.result?.geometry?.location?.lat, let lng = value?.result?.geometry?.location?.lng else {
                let alertController = UIAlertController(title: "", message: "Query place detail failure", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "I Know", style: .default, handler: nil))
                strong_self.present(alertController, animated: true, completion: nil)
                return
            }
            /// Save
            searchItem.geometry = AddressSearchItemGeometryVo(location: PlaceLocationVo(lat: lat, lng: lng))
            
            strong_self.performSegue(withIdentifier: "showSearchResultController", sender: searchItem)
        }
    }
}

extension PlaceSearchViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UITextFieldDelegate {
    
    /// Call when search controller did change
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource.removeAll()
        tableView.reloadData()
        tableView.tableFooterView = UIView()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        dataSource.removeAll()
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let address = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), address.count > 0 {
            self.geocodeAddress(address: address)
        }
        return true
    }
    
    private func geocodeAddress(address: String) {
        dataSource.removeAll()
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        loadingView.startAnimating()
        view.isUserInteractionEnabled = false
        
        NetworkManager.loadData(urlString: googleMapsGeocoding(for: address), type: AddressSearchVo.self) {[weak self] (success, searchResult) in
            self?.view.isUserInteractionEnabled = true
            self?.loadingView.stopAnimating()
            guard let strong_self = self else {
                return
            }
            
            guard let value = searchResult?.predictions, value.count > 0 else {
                strong_self.tableView.tableFooterView = strong_self.footerView
                strong_self.dataSource = []
                return
            }
            
            strong_self.dataSource = value
            strong_self.tableView.tableHeaderView = UIView()
            strong_self.tableView.reloadData()
        }
        
        /*
        geocoder.cancelGeocode()
        dataSource.removeAll()
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        geocoder.geocodeAddressString(address) {[weak self] (placemarks, error) in
            guard let strong_self = self else {
                return
            }
            
            print(error)
            
            guard let value = placemarks, value.count > 0 else {
                strong_self.tableView.tableFooterView = strong_self.footerView
                return
            }
            
            DispatchQueue.main.async {
                strong_self.dataSource = value
                strong_self.tableView.reloadData()
            }
        }
 */
    }
}
