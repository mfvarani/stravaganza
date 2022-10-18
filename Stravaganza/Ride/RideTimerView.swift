//
//  RideTimerView.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 11/10/2022.
//

import UIKit

class RideTimerView: UIView {
    
    weak var delegate: RideTimerViewDelegate?
    
    private var hours: Int = 0
    private var minutes: Int = 0
    private var seconds: Int = 0
    private var timer: Timer?
    private var timerStopped: Bool = false
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
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
        button.setTitleColor(.mainOrange, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(didTapStop), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
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
            stopButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func startTimer() {
        
        guard timerStopped == false else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            
            if self.minutes == 59 && self.seconds == 59 {
                self.hours = self.hours + 1
                self.minutes = 0
                self.seconds = 0
            }
            else if self.seconds == 59 {
                self.minutes = self.minutes + 1
                self.seconds = 0
            }
            else {
                self.seconds = self.seconds + 1
            }
            self.updateLabel()
        })
    }
    
    private func updateLabel() {
        
        var labelSeconds = String(seconds)
        var labelMinutes = String(minutes)
        var labelHours = String(hours)
        
        if seconds < 10 { labelSeconds = "0\(seconds)" }
        if minutes < 10 { labelMinutes = "0\(minutes)" }
        if hours < 10 { labelHours = "0\(hours)" }
        
        timeLabel.text = "\(labelHours):\(labelMinutes):\(labelSeconds)"
    }
    
    @objc private func didTapStart() {
        timerStopped = false
        startTimer()
        startButton.isUserInteractionEnabled = false
        delegate?.didTapStartButton()
    }
    
    @objc private func didTapStop() {
        timerStopped = true
        timer?.invalidate()
        hours = 0
        minutes = 0
        seconds = 0
        startButton.isUserInteractionEnabled = true
        delegate?.didTapStopButton()
    }
    
    public func getTime() -> String? { timeLabel.text }
    public func setTime(time: String) { timeLabel.text = time }
}
