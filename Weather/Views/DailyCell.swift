import UIKit

class DailyCell: UICollectionViewCell {
    
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dtLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    //MARK: - Convertion API date to readable day of week
    func convertWeek(with date: Int)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let unixTime = NSDate(timeIntervalSince1970: TimeInterval(date))
        let normalDate = dateFormatter.string(from: unixTime as Date)
        return normalDate
    }
    
    //MARK: - Creation of Image
    func createImage(with id: Weather)-> UIImage {
        
        let id = id.id ?? 0
        var image: UIImage? {
            switch id {
            case 200...232:
                return UIImage(systemName: "cloud.bolt.rain.fill")
            case 300...321:
                return UIImage(systemName: "cloud.drizzle")
            case 500...531:
                return UIImage(systemName: "cloud.rain")
            case 600...622:
                return UIImage(systemName: "snow")
            case 701...781:
                return UIImage(systemName: "tornado")
            case 800:
                return UIImage(systemName: "sun.min")
            case 801...804:
                return UIImage(systemName: "cloud")
            default:
                return UIImage(systemName: "aqi.medium")
            }
        }
        return image!
    }
}
