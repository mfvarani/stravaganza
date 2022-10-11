//
//  RideBaseViewController.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 10/10/2022.
//

import UIKit
import CoreLocation
import GoogleMaps

class RideBaseViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var mapView: GMSMapView! = nil
    let path: GMSMutablePath = GMSMutablePath()
    let marker: GMSMarker = GMSMarker()
    let timerView = RideTimerView(frame: .zero)
    var startedRide: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerView.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = Constants.rideTitle
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        tabBarController?.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc private func addButtonTapped(_ sender: UIPageControl) {
        guard let mapView = mapView,
              let tabBar = tabBarController?.tabBar else { return }
        
        if timerView.window != nil {
            timerView.removeFromSuperview()
        } else {
            timerView.translatesAutoresizingMaskIntoConstraints = false
            mapView.addSubview(timerView)
            
            NSLayoutConstraint.activate([
                timerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -20),
                timerView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
                timerView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
                timerView.heightAnchor.constraint(equalToConstant: view.frame.height/5)
            ])
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coordinate = location.coordinate
        setStartingLocationIfNeeded(coordinate)
        updateMarkerIfNeeded(coordinate)
        
        if startedRide {
            trackRide(coordinate)
        }
    }
    
    private func setStartingLocationIfNeeded(_ location: CLLocationCoordinate2D) {
        if mapView == nil {
            let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 13.0)
            mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
            view.addSubview(mapView)
            marker.position = location
            marker.map = mapView
        }
    }
    
    private func updateMarkerIfNeeded(_ location: CLLocationCoordinate2D) {
        if !startedRide {
            marker.position = location
            marker.map = mapView
        }
    }
    
    private func trackRide(_ location: CLLocationCoordinate2D) {
        path.add(location)
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .systemOrange
        polyline.strokeWidth = 5.0
        polyline.map = mapView
        view = mapView
    }
}

extension RideBaseViewController {
    enum Constants {
        static let rideTitle = "My Ride"
        static let progressTitle = "My Progress"
    }
}
