//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Bartek Fira on 23/05/2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var nightTempLabel: UILabel!
    @IBOutlet var dayDescLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    let networkManager = NetworkManager()

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .lightGray
    }
    
    func configure(with model: DailyDTO) {
        self.dayDescLabel.textAlignment = .left
        self.nightTempLabel.textAlignment = .center
        self.dayDescLabel.text = model.weather.first?.main
        self.nightTempLabel.text = "\(model.temp.day.toInt) / \(model.temp.night.toInt) °"
        self.dayLabel.text = model.day

        let iconURL = "https://openweathermap.org/img/wn/\(model.weather.first!.icon)@2x.png"
        downloadImage(from: URL(string: iconURL)!)
    }

    // Icon from URL
    func downloadImage(from url: URL) {
        print("Download Started")

        networkManager.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.iconImageView.image = UIImage(data: data)
            }
        }
    }
    
}
