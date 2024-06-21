//
//  ViewController.swift
//  Core_Location Project
//
//  Created by E5000855 on 21/06/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var resultLongitude: UILabel!
    @IBOutlet weak var resultLatitude: UILabel!
    @IBOutlet weak var resultAddress: UILabel!
    
    var locationManager: CLLocationManager!
    var gecoder:CLGeocoder!
    var userLocation = CLLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gecoder = CLGeocoder()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }


    @IBAction func getLonAndLat(_ sender: Any) {
        var address = addressTextField.text!
        gecoder.geocodeAddressString(address){(parameters , error) in
            if let error = error {
                print(error.localizedDescription)
            }else if let address = parameters?.first {
                print("\(address.location?.coordinate.longitude ?? 0) , \(address.location?.coordinate.latitude ?? 0)")
                self.resultLatitude.text = "\(address.location?.coordinate.latitude ?? 0)"
                self.resultLongitude.text = "\(address.location?.coordinate.longitude ?? 0)"
            }
        }
    }
    @IBAction func getAddress(_ sender: Any) {
        var longitude = Double(longitudeTextField.text ?? "0.0")!
        var latitude = Double(latitudeTextField.text ?? "0.0")!
        var location = CLLocation(latitude: latitude, longitude: longitude)
      
        gecoder.reverseGeocodeLocation(location) {(parameters, error) in
            if let error = error {
                print(error.localizedDescription)
            }else if let address = parameters?.first {
                print("\(address.locality ?? "") , \(address.postalCode ?? "") , \(address.country ?? "")")
                self.resultAddress.text = " \(address.locality ?? " ")" + "," + " \(address.postalCode ?? " ") " + "," + "\(address.country ?? "" )";
            }
        }
    }
}

