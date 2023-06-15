//
//  DescViewController.swift
//  WeatherClient2.0
//
//  Created by Danil Komarov on 12.06.2023.
//

import UIKit
import SwiftSVG

class DescViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var descView: UIView!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    
    var weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTextLabel()
    }
    
    func getTextLabel() {
        nameLabel.text = weatherModel?.name
        tempLabel.text = weatherModel?.temperatureString
        descLabel.text = weatherModel?.conditionString
        
        let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weatherModel!.conditionCode).svg")
        let weatherImage = UIView(SVGURL: url!) { (image) in
            image.resizeToFit(self.descView.bounds)
        }
        
        self.descView.addSubview(weatherImage)
        
        pressureLabel.text = "\((weatherModel?.pressureMm)!)"
        windSpeedLabel.text = "\((weatherModel?.windSpeed)!)"
        tempMaxLabel.text = "\((weatherModel?.tempMin)!)"
        tempMinLabel.text = "\((weatherModel?.tempMax)!)"
    }
    
    


}
