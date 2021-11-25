//
//  LocationManager.swift
//  Lakshan-028
//
//  Created by on 11/24/21.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var isNear = false;
    var long: Double = 0.0;
    var lati: Double = 0.0;
    @AppStorage("slot") private var id: String?;
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        loadLocation()
    }

   
    func loadLocation(){
        let controller = FirebaseController()
        controller.getNibmLocation() {(success) -> Void in
            self.long = success["lon"] as! Double;
            self.lati = success["lati"] as! Double;
            }
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
        if(id != nil){
            let controller = FirebaseController()
            controller.bookingUpdateLoc(slotId: id! ,lon: (location.coordinate.longitude),lati: (location.coordinate.latitude)) {(success) in
                if(success){
                    
                }else{

                }
            }
        }
       
        var nibm = CLLocation(latitude: self.lati, longitude: self.long)
        var diffInMeter = nibm.distance(from: location)
        print(diffInMeter)
        
        if(diffInMeter<=1000){
            isNear = true;
        }else{
            isNear = false;
        }
        
    }
}
