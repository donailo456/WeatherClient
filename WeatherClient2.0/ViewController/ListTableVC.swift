//
//  ListTableVC.swift
//  WeatherClient2.0
//
//  Created by Danil Komarov on 11.06.2023.
//

import UIKit

class ListTableVC: UITableViewController {
    
    let emptyCity = Weather()
    
    var citiesArray = [Weather]()
    let namecitiesArray = ["Москва", "Санкт-Петербург", "Уфа", "Омск", "Пенза", "Лондон", "Нью-Йорк"]
    
    let apiMeneger = APIMeneger()
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(actionRefreshControl(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = myRefreshControl
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: namecitiesArray.count)
        }
        
        addCities()
    }
    
    func addCities() {
        getCityWeather(citiesArray: self.namecitiesArray) { (index, weather) in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.namecitiesArray[index]
            print(self.citiesArray)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func actionRefreshControl(sender: UIRefreshControl) {
        sender.endRefreshing()
        
        getCityWeather(citiesArray: self.namecitiesArray) { (index, weather) in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.namecitiesArray[index]
            print(self.citiesArray)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell

        var weather = Weather()
        weather = citiesArray[indexPath.row]
        cell.configure(weather: weather)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDesc" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let cityWeather = citiesArray[indexPath.row]
            let dstVc = segue.destination as! DescViewController
            dstVc.weatherModel = cityWeather
        }
    }

}
