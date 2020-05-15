//
//  MapViewController.swift
//  covid
//
//  Created by Антон Тимонин on 10.05.2020.
//  Copyright © 2020 Антон Тимонин. All rights reserved.
//

import UIKit
import MapKit
import Firebase
class MapViewController: UIViewController {
    var mapView = MKMapView()
    var annotationLocations : [ProblemData] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapView()
        listenFirebase()
        
         
    }
    func setMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       }
    func createAnnotations(locations: [ProblemData]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.problem
            annotation.coordinate = CLLocationCoordinate2D(latitude:  location.latitude as! CLLocationDegrees, longitude: location.longitude as! CLLocationDegrees)
            annotation.title = location.problem
            annotation.subtitle = location.phone
            mapView.addAnnotation(annotation)
        }
        
    }
    func listenFirebase() {
        db.collection("Problems").addSnapshotListener { querySnapshot, error in
        
        guard let documents = querySnapshot?.documents else {
            print("Error fetching documents: \(error!)")
            return
        }
        self.annotationLocations = []
        for i in documents {
            
            let phone = "" // i["phone"] as! String
            let problem = "" // i["problem"] as! String
            let latitude = Double(i["latitude"] as! String)
            let longitude = Double(i["longitude"] as! String)
            var problemData = ProblemData(problem: problem, phone: phone, longitude: longitude, latitude: latitude)
            self.annotationLocations.append(problemData)
            print(self.annotationLocations)
            }
            self.createAnnotations(locations: self.annotationLocations)
        }
    }
}
