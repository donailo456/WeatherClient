//
//  ListCell.swift
//  WeatherClient2.0
//
//  Created by Danil Komarov on 12.06.2023.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var desLable: UILabel!
    
    func configure(weather: Weather) {
        self.nameLabel.text = weather.name
        self.desLable.text = weather.conditionString
        self.tempLabel.text = weather.temperatureString
    }
}
