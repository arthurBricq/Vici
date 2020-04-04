//
//  MapViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 03/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
        
    
    // outlets and variables
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var servicesScrollView: UIScrollView!
    
    var locationManager = CLLocationManager.init()
    
    // actions and functions
    @IBAction func searchButtonTapped(_ sender: Any) {
        print("search")
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        print("filter")
    }
    
    @IBAction func centerButtonTapped(_ sender: Any) {
        centerMap()
    }
    
    func centerMap(latitude : Double = -1, longitude : Double = -1) {
        // corresponds to a zone of around 1km * 1km
        let span = MKCoordinateSpan.init(latitudeDelta: 0.009, longitudeDelta: 0.009)
        var coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        if (latitude == -1 && longitude == -1) { coord = (locationManager.location?.coordinate)! }
        
        let region = MKCoordinateRegion.init(center: coord, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // request the location when app launches
        locationManager.requestWhenInUseAuthorization()

        // set up the map
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.delegate = self
        
        slideView.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let annotationTest = MKPointAnnotation()
        annotationTest.coordinate = CLLocationCoordinate2D(latitude: 45.7580620, longitude: 4.8313981)
        annotationTest.title = "Chez Leo"
        mapView.addAnnotation(annotationTest)
        
        let annotationTest2 = MKPointAnnotation()
        annotationTest2.coordinate = CLLocationCoordinate2D(latitude: 45.7590620, longitude: 4.8333981)
        annotationTest2.title = "Chez Marcel"
        mapView.addAnnotation(annotationTest2)
        
        centerMap()
        
        slideView.center.y += slideView.frame.height
        slideView.isHidden = false
    }
    
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let lat = (view.annotation?.coordinate.latitude)!
        let lon = (view.annotation?.coordinate.longitude)!
        centerMap(latitude: lat, longitude: lon)
        
        companyName.text = (view.annotation?.title)!
        
        UIView.animate(withDuration: 0.3) {
            self.slideView.center.y -= self.slideView.frame.height
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.slideView.center.y += self.slideView.frame.height
        })
    }
}
