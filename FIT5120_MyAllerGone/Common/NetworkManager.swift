//
//  NetworkManager.swift
//  HospitalLocation
//
//  Created by 夏舒衍 on 2021/3/30.
//

import UIKit
import Foundation

class NetworkManager: NSObject {
    
    private override init() {
        
    }
    
    /// Load Data From String URL
    /// - Parameters:
    ///   - urlString: String URL
    ///   - completeHander: completeHander
    public static func loadData(
        urlString: String,
        completeHander: ((Bool, Data?) -> Void)?) {
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completeHander?(false, nil)
            }
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        
        let sharedSession = URLSession.shared
        sharedSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let value = data {
                        completeHander?(true, value)
                    } else {
                        completeHander?(false, nil)
                    }
                } else {
                    completeHander?(false, nil)
                }
            }
        }.resume()
    }
    
    /// Load Codable Object From String URL
    /// - Parameters:
    ///   - urlString: String URL
    ///   - type: Codable Type
    ///   - completeHander: completeHander
    public static func loadData<Element: Codable>(
        urlString: String,
        type: Element.Type,
        completeHander: ((Bool, Element?) -> Void)?) {
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completeHander?(false, nil)
            }
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        
        let sharedSession = URLSession.shared
        sharedSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    if let value = data {
                        #if DEBUG
                        if let printValue = String(data: value, encoding: .utf8) {
                            print(printValue)
                        }
                        #endif
                        if let object = try? JSONDecoder().decode(type, from: value) {
                            completeHander?(true, object)
                        } else {
                            completeHander?(false, nil)
                        }
                    } else {
                        completeHander?(false, nil)
                    }
                } else {
                    completeHander?(false, nil)
                }
            }
        }.resume()
    }
}


extension UIImageView {
    
    /// Load image From local or Network
    /// - Parameters:
    ///   - urlString: String URL
    ///   - placeholderImage: placeholder image
    ///   - completeHandler: completeHandler
    public func networkImage(urlString :String, placeholderImage: UIImage?, completeHandler: ((Bool, UIImage?) -> Void)?) {
        /// first show placeholderImage
        self.image = placeholderImage
        /// load local image from UserDefaults
        if let data = UserDefaults.standard.data(forKey: urlString), let localImage = UIImage(data: data) {
            completeHandler?(true, localImage)
            return
        }
        
        /// if local image is empty, load image from network
        NetworkManager.loadData(urlString: urlString) {(success, data) in
            if success {
                if let value = data, let networkImage = UIImage(data: value) {
                    /// save image to UserDefaults
                    UserDefaults.standard.setValue(value, forKey: urlString)
                    UserDefaults.standard.synchronize()
                    completeHandler?(true, networkImage)
                } else {
                    completeHandler?(false, nil)
                }
            } else {
                completeHandler?(false, nil)
            }
        }
    }
}
