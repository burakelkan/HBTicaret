//
//  StoresViewController.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import UIKit
import CoreLocation
import MapKit

class StoresViewController: BaseViewController {

    @IBOutlet private weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        fetchLocation()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapMapView(sender:)))
        mapView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapMapView(sender: UITapGestureRecognizer) {
        
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        mapView.addAnnotation(annotation)
    }

    private func fetchLocation() {
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        }
    }
}

extension StoresViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        
        let annotation = MKPointAnnotation()
        
        guard let lastLocation = locations.last else { return }
        
        annotation.coordinate = lastLocation.coordinate
        
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: lastLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension StoresViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.description)
        view.image = UIImage(named: "checked")
        return view
    }
}
