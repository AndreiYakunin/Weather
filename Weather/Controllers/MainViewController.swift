import UIKit
import CoreData

class MainViewController: UITableViewController {

    var cities: [NSManagedObject] = []
    var cityName: String?
    lazy var coreDataStack = CoreDataStack(modelName: "City")
    let entityName = "CityCoreData"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    // MARK: - IBAction
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Enter city", message: "", preferredStyle: .alert)
        
        let alertOkAction = UIAlertAction(title: "Ok", style: .default) { [unowned self] action in
            
            guard let textField = alertController.textFields?.first,
                  let nameToSave = textField.text,
                  nameToSave != ""
            else { return }
            self.saveName(name: nameToSave)
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
    
    // MARK: - CoreData
    
    func saveName(name: String) {
        let managedContext = coreDataStack.managedContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let cityName = NSManagedObject(entity: entity, insertInto: managedContext)
        cityName.setValue(name, forKey: "name")
        
        coreDataStack.saveContext()
        cities.append(cityName)
    }
    
    func fetchData() {
        let managedContext = coreDataStack.managedContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            cities = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let forecastVC = segue.destination as? ForecastViewController else { return }
        forecastVC.cityName = cityName
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = city.value(forKeyPath: "name") as? String

        return cell
    }
    
    // MARK: Delete city
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            let cityToRemove = cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            coreDataStack.managedContext.delete(cityToRemove)
            coreDataStack.saveContext()
        }
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        cityName = city.value(forKeyPath: "name") as? String
        performSegue(withIdentifier: "forecastSegue", sender: self)
    }
}
