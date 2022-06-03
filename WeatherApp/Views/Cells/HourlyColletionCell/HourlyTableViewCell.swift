//
//  HourlyTableViewCell.swift
//  WeatherApp
//
//  Created by Bartek Fira on 23/05/2022.
//

import UIKit
class HourlyTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    
    var models = [HourlyDTO]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(WeatherCollectionViewCell.nib, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        backgroundColor = .defaultGray
    }
    
    func configure(with models: [HourlyDTO]) {
        self.models = models
        collectionView.reloadData()
    }
}
extension HourlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
}

extension HourlyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

