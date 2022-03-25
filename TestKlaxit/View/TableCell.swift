//
//  TableCell.swift
//  TestKlaxit
//
//  Created by Pierre Corsenac on 25/03/2022.
//

import Foundation
import UIKit

class GeoTableCell : UITableViewCell {
    static let identifier = "GeoTableCell"
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 18)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postalCodeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        addressLabel.text = nil
        postalCodeLabel.text = nil
        
    }
    
    public func configure(item: Feature) {
        addressLabel.text = item.properties.name
        if let citycode = item.properties.citycode, let city = item.properties.city {
            postalCodeLabel.text = citycode + " " + city
        }
    }
    
    private func setupContentView() {
        contentView.addSubview(addressLabel)
        contentView.addSubview(postalCodeLabel)
        
        
        addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        postalCodeLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        postalCodeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        postalCodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
