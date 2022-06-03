//
//  ViewController.swift
//  WeatherApp
//
//  Created by Bartek Fira on 23/05/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!
    
    var currentLocation: CLLocation?
    let locationMenager = CLLocationManager()
    let networkManager = NetworkManager()
    
    var dailyDto: DailyWeatherDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.register(HourlyTableViewCell.nib, forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()

    }
    
    // LOCATION
    func setupLocation() {
        locationMenager.delegate = self
        locationMenager.requestWhenInUseAuthorization()
        locationMenager.startUpdatingLocation()
        
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&lang=\(Locale.preferredLanguageCode)&units=metric&appid=048a1773a581310bc4d5a7f3aea13297"

        networkManager.getData(from: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                print("API Validation Error")
                return
            }
            
            var json: DailyWeatherDTO?
            do {
                json = try JSONDecoder().decode(DailyWeatherDTO.self, from: data)
            }
            catch {
                print("eror: \(error)")
            }
            
            guard let results = json else {
                return
            }

            self.dailyDto = results

            DispatchQueue.main.async { [self] in
                let header = CurrentWeatherView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))

                self.table.reloadData()
                self.table.tableHeaderView = header
                header.updateView(with: results)

                let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapLabel))
                header.locationLabel.addGestureRecognizer(tap)
            }

            print(long ," | ", lat)
        }
      
    }

    @objc func didTapLabel() {
        let vc = storyboard?.instantiateViewController(identifier: "mapViewController") as! MapViewController
        vc.pinLocalization = self.dailyDto?.location
        present(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dailyDto = dailyDto else {
            return UITableViewCell()
        }

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: dailyDto.hourly)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            cell.configure(with: dailyDto.daily[indexPath.row])
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dailyDto?.daily.count ?? 0
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 140:
            return 1
        default:
            return 90
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationMenager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
}

