import UIKit

class MainViewController: UITableViewController {

    var cities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - IBAction
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Enter city", message: "", preferredStyle: .alert)
        
        let alertOkAction = UIAlertAction(title: "Ok", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let text = textField?.text else { return }
            self.cities.append(text)
            self.tableView.reloadData()
        }
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(alertCancelAction)
        alertController.addAction(alertOkAction)
        alertController.addTextField { textField in
            textField.placeholder = "For example: Moscow"
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]

        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

}
