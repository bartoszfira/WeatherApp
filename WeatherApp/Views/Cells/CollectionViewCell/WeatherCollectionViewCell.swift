//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Bartek Fira on 31/05/2022.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!

    let networkManager = NetworkManager()

    func configure(with model: HourlyDTO ) {
        self.tempLabel.text = "\(model.temp.toInt)° \n\(model.getTime)"
        self.iconImageView.contentMode = .scaleAspectFit

        let iconURL = "https://openweathermap.org/img/wn/\(model.weather.first!.icon)@2x.png"
        downloadImage(from: URL(string: iconURL)!)
    }

    func downloadImage(from url: URL) {
        print("Download Started")

        networkManager.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            
            DispatchQueue.main.async() { [weak self] in
                self?.iconImageView.image = UIImage(data: data)
            }
        }
    }
}
