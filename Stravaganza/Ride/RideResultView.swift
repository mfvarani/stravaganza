//
//  RideResultView.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 11/10/2022.
//

import UIKit

class RideResultView: UIView {
    
    private var ride = Ride(time: "0.0", distance: "0.0 kms")
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.text = "Your time was"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .abelRegular(size: 32.0)
        label.clipsToBounds = true
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .abelRegular(size: 40.0)
        label.clipsToBounds = true
        return label
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
        label.text = "Distance"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .abelRegular(size: 32.0)
        label.clipsToBounds = true
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0 km"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .abelRegular(size: 40.0)
        label.clipsToBounds = true
        return label
    }()
    
    private let storeButton: UIButton = {
        let button = UIButton()
        button.setTitle("STORE", for: .normal)
        button.titleLabel?.font = .abelRegular(size: 30.0)
        button.setTitleColor(.mainOrange, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapStore), for: .touchUpInside)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("DELETE", for: .normal)
        button.titleLabel?.font = .abelRegular(size: 30.0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public init(frame: CGRect, time: String?, distance: String?, ride: Ride) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.ride = ride
        self.timeLabel.text = time
        self.distanceLabel.text = distance
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapStore() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(ride)
            
            var savedRides = UserDefaults.standard.array(forKey: "rides") ?? [Ride]()
            savedRides.append(data)
            UserDefaults.standard.set(savedRides, forKey: "rides")
        } catch {
            print("Unable to Encode Ride (\(error))")
        }
        self.removeFromSuperview()
    }
    
    @objc private func didTapDelete() {
        
        self.removeFromSuperview()
    }
    
    private func setupConstraints() {
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(subtitle)
        stackView.addArrangedSubview(distanceLabel)
        
        self.addSubview(stackView)
        self.addSubview(storeButton)
        self.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            
            storeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/8),
            storeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            storeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            storeButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            storeButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            
            deleteButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/8),
            deleteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: storeButton.trailingAnchor),
            deleteButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)
        ])
    }
}
