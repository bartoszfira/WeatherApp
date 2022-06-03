//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Bartek Fira on 27/05/2022.
//

import UIKit

class CurrentWeatherView: UIView {
    var locationLabel = UILabel()
    var summaryLabel = UILabel()
    var tempLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        build()
        layout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width/8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func build() {
        self.clipsToBounds = true
        self.backgroundColor = .darkGray

        buildLabel(&locationLabel)
        buildLabel(&tempLabel, fontSize: 64)
        buildLabel(&summaryLabel)
        // Interakcja tutaj?
        locationLabel.isUserInteractionEnabled = true

    }

    func buildLabel(_ label: inout UILabel, fontSize: CGFloat = 24) {
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: fontSize)

        addSubview(label)
    }
    
    func layout() {
        layoutLocationLabel()
        layoutSummaryLabel()
        layoutTempLabel()
    }

    func layoutLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func layoutSummaryLabel() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        summaryLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func layoutTempLabel() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    public func updateView(location: String?, summary: String?, temp: String?) {
        locationLabel.text = location
        summaryLabel.text = summary
        tempLabel.text = temp
    }

    public func updateView(with dto: DailyWeatherDTO) {
        let currentWeather = dto.current
        let zone = dto.timezone

        locationLabel.text = zone
        summaryLabel.text = "\(currentWeather.weather[0].description)"
        tempLabel.text = "\(Int(currentWeather.temp))°"
    }
}
