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
    
    let annotationTest = MKPointAnnotation()
    
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
    
    func centerMap() {
        // corresponds to a zone of around 1km * 1km
        let span = MKCoordinateSpan.init(latitudeDelta: 0.009, longitudeDelta: 0.009)
        let region = MKCoordinateRegion.init(center: (locationManager.location?.coordinate)!, span: span)
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
        
        annotationTest.coordinate = CLLocationCoordinate2D(latitude: 45.7580620, longitude: 4.8313981)
        annotationTest.title = "Chez Leo"
        mapView.addAnnotation(annotationTest)
        
        centerMap()
        
        print(slideView.frame)
    }
    
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let h = self.view.frame.height
        let w = self.view.frame.width
        let view = UIView(frame: CGRect(x: 0, y: h/2, width: w, height: 50))
        view.backgroundColor = .gray
        view.alpha = 1
        self.view.addSubview(view)
    }
}
