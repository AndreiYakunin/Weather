import UIKit

class DailyCell: UICollectionViewCell {
    
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dtLabel: UILabel!
    
    //MARK: - Convertion API date to readable day of week
    func convertWeek(with date: Int)-> String {
        let dt = date
        let apiDay: Int = dt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let unixTime = NSDate(timeIntervalSince1970: TimeInterval(apiDay))
        let normalDate = dateFormatter.string(from: unixTime as Date)
        return normalDate
    }
}
