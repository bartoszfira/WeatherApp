//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Bartek Fira on 03/06/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mapView: MKMapView!

    var pinLocalization: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        createAnnotaion()
        centerOnPinLocation()
    }

    func createAnnotaion() {
        guard let pinLocation = pinLocalization else { return }

        let annotation = MKPointAnnotation()
        annotation.coordinate = pinLocation
        mapView.addAnnotation(annotation)
    }

    func centerOnPinLocation() {
        guard let pinLocation = pinLocalization else { return }

        let regionRadius: CLLocationDistance = 2000
        let coordinateRegion = MKCoordinateRegion(center: pinLocation,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
}
