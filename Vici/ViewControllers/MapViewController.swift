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

class MapViewController: UIViewController, CLLocationManagerDelegate {
        
    
    // outlets and variables
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var centerButton: UIButton!
    
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyDescription: UILabel!
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet var servicesImageViews: [UIImageView]!
    
    var locationManager = CLLocationManager.init()
    var locationAllowed: Bool {
        get {
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .authorizedAlways, .authorizedWhenInUse:
                    return true
                case .denied, .notDetermined, .restricted:
                    return false
                default:
                    return false
                }
            } else {
                return false
            }
        }
    }
    var currentAnnotation: CompanyPointAnnotation?
    
    var startYOfWindow: CGFloat = 0
    var swipeAnimator: UIViewPropertyAnimator?
    
    var companies: [Company] = []
    
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
    
    @IBAction func swipeHandler(_ gestureRecognizer : UIPanGestureRecognizer) {
        
        if (gestureRecognizer.state == .began) {
            startYOfWindow = self.slideView.center.y
        }
        
        if (gestureRecognizer.state == .changed) {
            let translation = gestureRecognizer.translation(in: self.view)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
            
            if (slideView.center.y - translation.y >= startYOfWindow || translation.y > 0) {
                slideView.center.y += translation.y
            }
            if (slideView.center.y < startYOfWindow) {
                slideView.center.y = startYOfWindow
            }
        }
        
        if (gestureRecognizer.state == .ended) {
            let difference = slideView.center.y - startYOfWindow
            let percentage = difference/slideView.frame.height
            
            if (percentage > 0.3) {
                mapView.deselectAnnotation(currentAnnotation, animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.slideView.center.y = self.startYOfWindow
                }
            }
        }
    }
    
    @IBAction func tapGestureToSegue(_ sender: Any) {
        performSegue(withIdentifier: "mapToCompanyVC", sender: self)
    }
    
    
    // this function can be called without parameters to center on the current location
    // or to center on given location
    func centerMap(latitude : Double = -1, longitude : Double = -1) {
        // if the coords are (-1, -1) we want the location of the phone so we need to check if
        // it is allowed otherwise it can show the map
        if (locationAllowed || (latitude != -1 && longitude != -1)) {
            // corresponds to a zone of around 1km * 1km
            let span = MKCoordinateSpan.init(latitudeDelta: 0.009, longitudeDelta: 0.009)
            var coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            if (latitude == -1 && longitude == -1) {
                coord = (locationManager.location?.coordinate)!
            }
            
            let region = MKCoordinateRegion.init(center: coord, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // Make the current location unclickable
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if let userLocationView = mapView.view(for: mapView.userLocation) {
            userLocationView.canShowCallout = false
        }
    }
    
    // When ask for authorization to use location, update the center button to make it visible when needed
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerButton.isHidden = !locationAllowed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // request the location when app launches
        locationManager.requestWhenInUseAuthorization()
        centerButton.isHidden = !locationAllowed

        // set up the map
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.delegate = self
        centerMap()
        
        // set up the slide view
        slideView.alpha = 0
        
        
        navigationController?.delegate = self
        
        let s1 = Service(category: ServiceCategory.artisanat.rawValue, description: "Service 1,")
        let s2 = Service(category: ServiceCategory.basket.rawValue, description: "Service 2")
        let s3 = Service(category: ServiceCategory.charity.rawValue, description: "À votre service, service 3")
        let s4 = Service(category: ServiceCategory.delivery.rawValue, description: "Coucou")
        let s5 = Service(category: ServiceCategory.house.rawValue, description: "C'est de la merde ces noms")
        let s6 = Service(category: ServiceCategory.other.rawValue, description: "Salut ca va oui et toi")
        
        let i1 = Image(legend: "cover", image: "vaches")
        let i2 = Image(legend: "cover", image: "velo1")
        let i3 = Image(legend: "cover", image: "biere1")
        
        let c1 = Company(name: "BioCoop", description: "Nous sommes une coopérative agricole locale et nous avons beaucoup d'artichaux à revendre !")
        c1.services = [s1, s2, s3]
        c1.images = [i1]
        c1.location = [45.7543263, 4.8293729]
        
        let c2 = Company(name: "Velo Mec", description: "Nous sommes à votre disposition pour réparer vos vélos cassés.")
        c2.services = [s2, s4, s3]
        c2.images = [i2]
        c2.location = [45.7595525, 4.8315546]
        
        let c3 = Company(name: "Chez Leo", description: "Même en temps de crise, continuez de vous abbreuvez ! On vous livre les provisions.")
        c3.services = [s5, s6]
        c3.images = [i3]
        c3.location = [45.7566603, 4.8343156]
        
        companies.append(c1)
        companies.append(c2)
        companies.append(c3)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for i in 0..<companies.count {
            let annotation = CompanyPointAnnotation(pos: i)
            annotation.coordinate = companies[i].getLocationForMap()
            annotation.title = companies[i].name
            mapView.addAnnotation(annotation)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpSlideView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (currentAnnotation != nil) {
            mapView.deselectAnnotation(currentAnnotation, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CompanyViewController {
            dest.company = companies[(currentAnnotation?.companyPos)!]
        }
    }
    
    func setUpSlideView() {
        // 1. Set up logo
        self.companyLogo.layer.cornerRadius = self.companyLogo.frame.width/2
        self.companyLogo.layer.borderColor = UIColor.gray.cgColor
        self.companyLogo.layer.borderWidth = 1.0
        
        // 2. Set up the gradient of the top
        let view = UIView(frame: imageView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        imageView.addSubview(view)
        imageView.bringSubviewToFront(view)
        
        // 3. Set up the gradient of the top
        let gradient2: CAGradientLayer = CAGradientLayer()
        gradient2.colors = [UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.clear.cgColor]
        gradient2.locations = [0.0 , 1.0]
        gradient2.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient2.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient2.frame = CGRect(x: 0.0, y: 0.0, width: self.downView.frame.size.width, height: self.downView.frame.size.height)
        self.downView.layer.insertSublayer(gradient2, at: 0)
        
        slideView.center.y = mapView.frame.maxY + slideView.frame.height/2
        slideView.alpha = 0
    }
    
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if (view != mapView.view(for: mapView.userLocation)) {
            slideView.alpha = 1
            currentAnnotation = view.annotation as? CompanyPointAnnotation
            
            let lat = (currentAnnotation?.coordinate.latitude)!
            let lon = (currentAnnotation?.coordinate.longitude)!
            centerMap(latitude: lat, longitude: lon)
            
            let companyPos = (currentAnnotation?.companyPos)!
            
            companies[companyPos].setScreenWithSelf(titleLabel: companyName, bodyLabel: companyDescription, coverImageView: imageView, logoImageView: companyLogo, serviceImageViews: servicesImageViews)
            
            //currentAnnotation.
            UIView.animate(withDuration: 0.3) {
                self.slideView.center.y = self.mapView.frame.maxY - self.slideView.frame.height/2
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if (view != mapView.view(for: mapView.userLocation)) {
            currentAnnotation = nil
            UIView.animate(withDuration: 0.3, animations: {
                self.slideView.center.y = self.mapView.frame.maxY + self.slideView.frame.height/2
            }, completion: {(_) in
                // check if no annotation is currently on
                if self.currentAnnotation == nil {
                    self.slideView.alpha = 0
                }
            })
        }
    }
}

extension MapViewController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if (toVC is CompanyViewController || fromVC is CompanyViewController) {
            let transition = MapToCompanyTransition()
            transition.operation = operation
            transition.duration = 0.5
            return transition
        }
        
        return nil
    }
    
}
