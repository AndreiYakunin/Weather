import UIKit

class ForecastViewController: UICollectionViewController {
    
    var forecastModel : Params!
    var cityName: String?
    
    let itemsPerRow: CGFloat = 1
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = cityName
        guard let cityName = cityName else { return }
        fetchWeather(for: cityName)
    }
    
    // MARK: Getting weather data
    
     func fetchWeather(for city: String) {
         NetworkManager.shared.getWeather(city: city) { decoderParams in
             print(decoderParams)
             self.forecastModel = decoderParams
             DispatchQueue.main.async {
                 self.collectionView.reloadData()
             }
         }
     }
    
    private func configureCell(cell: DailyCell, for indexPath: IndexPath) {
        let forecast = forecastModel
        guard
            let tempDay = forecast?.list?[indexPath.row].temp?.day,
            let tempMin = forecast?.list?[indexPath.row].temp?.min,
            let tempMax = forecast?.list?[indexPath.row].temp?.max,
            let dt = forecast?.list?[indexPath.row].dt,
            let description = forecast?.list?[indexPath.row].weather?.first?.description,
            let icon = forecast?.list?[indexPath.row].weather?.first//.id
        else { return }
        
        cell.dayTempLabel.text = "\(String(describing: tempDay))"
        cell.minTempLabel.text = "min: \(String(describing: tempMin))"
        cell.maxTempLabel.text = "max: \(String(describing: tempMax))"
        cell.dtLabel.text = DailyCell().convertWeek(with: dt)
        cell.descriptionLabel.text = description
        cell.iconView.image = DailyCell().createImage(with: icon)
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyCell", for: indexPath) as! DailyCell
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
}

// MARK: - Layout
extension ForecastViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth: CGFloat = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
