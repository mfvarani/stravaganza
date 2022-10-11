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
    var path: GMSMutablePath = GMSMutablePath()
    let marker: GMSMarker = GMSMarker()
    let timerView = RideTimerView(frame: .zero)
    var resultView: RideResultView?
    var startedRide: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        timerView.delegate = self
        
        UserDefaults.standard.set([Ride](), forKey: "rides")
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
        addTimer()
    }
    
    private func addTimer() {
        if timerView.window != nil {
            timerView.removeFromSuperview()
        } else {
            timerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(timerView)
            
            NSLayoutConstraint.activate([
                timerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height/5),
                timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
            let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 14.0)
            mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
            view.addSubview(mapView)
            marker.position = location
            marker.map = mapView
        }
    }
    
    private func updateMarkerIfNeeded(_ location: CLLocationCoordinate2D) {
        if !startedRide {
            mapView.camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 14.0)
            marker.position = location
            marker.map = mapView
        }
    }
    
    private func trackRide(_ location: CLLocationCoordinate2D) {
        mapView.camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 14.0)
        path.add(location)
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .systemOrange
        polyline.strokeWidth = 5.0
        polyline.map = mapView
        view = mapView
    }
}

extension RideBaseViewController: RideTimerViewDelegate {
    func didTapStartButton() {
        startedRide = true
    }
    
    func didTapStopButton() {
        startedRide = false
        showResultView()
    }
    
    private func showResultView() {
        let startCoordinate = path.coordinate(at: 0)
        let start = CLLocation(latitude: startCoordinate.latitude, longitude: startCoordinate.longitude)
        
        let finishCoordinate = path.coordinate(at: UInt(path.count() - 1))
        let finish = CLLocation(latitude: finishCoordinate.latitude, longitude: finishCoordinate.longitude)
        
        let distanceInKms = start.distance(from: finish)/1000
        let finalDistance = String(format: "%.2f", distanceInKms)
        
        let time = timerView.getTime()
        
        resultView = RideResultView(
            frame: .zero,
            time: time,
            distance: finalDistance + " kms"
        )
        
        guard let resultView = resultView else { return }
        resultView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultView)
        
        NSLayoutConstraint.activate([
            resultView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            resultView.heightAnchor.constraint(equalToConstant: view.frame.height/2)
        ])
        
        let rideSummary = Ride(time: time, distance: finalDistance)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(rideSummary)
            
            var rides = UserDefaults.standard.array(forKey: "rides") ?? [] as [Ride]
            rides.append(data)
            UserDefaults.standard.set(data, forKey: "ride")
        } catch {
            print("Unable to Encode Ride (\(error))")
        }
        
        mapView.clear()
        timerView.removeFromSuperview()
        path = GMSMutablePath()
    }
}

extension RideBaseViewController {
    enum Constants {
        static let rideTitle = "My Ride"
        static let progressTitle = "My Progress"
    }
}
