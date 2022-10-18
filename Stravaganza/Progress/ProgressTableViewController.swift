//
//  ProgressTableViewController.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 10/10/2022.
//

import UIKit

class ProgressTableViewController: UITableViewController {
    
    var progressData: [Ride] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        tableView.register(ProgressTableViewCell.self, forCellReuseIdentifier: ProgressTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressData = []
        getProgressData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        progressData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let progress = progressData[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ProgressTableViewCell.identifier, for: indexPath) as! ProgressTableViewCell
        
        cell.timeLabel.text = progress.time
        cell.distanceLabel.text = (progress.distance ?? "0.0") + " kms"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func getProgressData() {
        if let rides = UserDefaults.standard.array(forKey: "rides") {
            for ride in rides {
                do {
                    let decoder = JSONDecoder()
                    let ride = try decoder.decode(Ride.self, from: ride as? Data ?? Data())
                    progressData.append(ride)
                } catch {
                    print("Unable to Decode Rides (\(error))")
                }
            }
        }
    }
}

extension ProgressTableViewController {
    
    enum Constants {
        static let progressTitle = "My Progress"
    }
}
