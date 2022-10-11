//
//  ProgressTableViewCell.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 11/10/2022.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {

    static let identifier = "progressCell"
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .abelRegular(size: 24.0)
        label.clipsToBounds = true
        label.text = "00:05:10"
        label.textColor = .white
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .abelRegular(size: 24.0)
        label.clipsToBounds = true
        label.text = "1.2 kms"
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addSubview(timeLabel)
        addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            distanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            distanceLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
    }
    
}
