//
//  RideTimerView.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 11/10/2022.
//

import UIKit

class RideTimerView: UIView {
    
    private let timer: Timer = {
        let timer = Timer()
        timer
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00 : 00 : 00"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .abelRegular(size: 40.0)
        label.clipsToBounds = true
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = .abelRegular(size: 30.0)
        button.setTitleColor(UIColor(red: 1, green: 0.557, blue: 0.145, alpha: 1), for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("STOP", for: .normal)
        button.titleLabel?.font = .abelRegular(size: 30.0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        addSubview(timeLabel)
        addSubview(startButton)
        addSubview(stopButton)
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height/4),
            timeLabel.bottomAnchor.constraint(equalTo: self.startButton.topAnchor),
            timeLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            timeLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
            
            startButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
            startButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            startButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: stopButton.leadingAnchor),
            startButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            startButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            
            stopButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
            stopButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            stopButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stopButton.leadingAnchor.constraint(equalTo: startButton.trailingAnchor),
            stopButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            startButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor)
        ])
    }
}
