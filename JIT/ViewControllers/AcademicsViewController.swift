
import UIKit
import BEFoldMenuViewController

class AcademicsViewController: UIViewController {
    
    var arrayHeaders : Array <String> = ["Training & Placement","Placement History","Industrial Tieups"]
    
    @IBOutlet var tableViewDetails : UITableView?
    
    let reuseIdentifier : String = "academicsDetailsCell"
    
    let kTrainingPlacementIdentifier : String = "trainingandplacement"
    
    let kPlacementHistoryIdentifier : String = "placement"
    
    let kIndustrialIdentifier : String = "industrial"
    
    let kStoryboarName : String = "Main"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewControler()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Utitlity Methods
    
    func setupViewControler(){
        
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
        var leftBtn : UIBarButtonItem?
        leftBtn = UIBarButtonItem.init(image: UIImage.init(named: "menu"), style:.plain, target: self, action: #selector(AcademicsViewController.buttonMenuTapped))
        leftBtn?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBtn
        self.tableViewDetails?.reloadData()
        
    }
    
    func buttonMenuTapped(){
        let obj : BEFoldMenuViewController = self.foldMenuController()
        obj.leftMenuAction()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Get references of current storyboard
        let storyboard : UIStoryboard = UIStoryboard.init(name: kStoryboarName, bundle: nil)
        
        //Set up current view controller
        let viewController : UIViewController = self.getCureentViewController()
        
        //Training & Placement option selected
        if segue.identifier == kTrainingPlacementIdentifier {
            let trainingObj : TrainingAndPlacementViewController = storyboard.instantiateViewController(withIdentifier:kTrainingPlacementIdentifier) as! TrainingAndPlacementViewController
            viewController.navigationController?.pushViewController(trainingObj, animated: true)
        }
            
        //Placement History option selected
        else if segue.identifier == kPlacementHistoryIdentifier {
            let placementObj : PlacementHistoryViewController = storyboard.instantiateViewController(withIdentifier:kPlacementHistoryIdentifier) as! PlacementHistoryViewController
            viewController.navigationController?.pushViewController(placementObj, animated: true)
        }
            
        //Industrial option selected
        else if segue.identifier == kIndustrialIdentifier {
            let industryObj : IndustrialTieupsViewController = storyboard.instantiateViewController(withIdentifier:kIndustrialIdentifier) as! IndustrialTieupsViewController
            viewController.navigationController?.pushViewController(industryObj, animated: true)
        }

    }
    
    func getCureentViewController () -> UIViewController {
        
        //Get view controller array
        let arrayControllers : Array <UIViewController> = (self.navigationController?.viewControllers)!
        
        //Set up current view controller
        let viewController : UIViewController = arrayControllers.last!
        
        return viewController
    }

}

extension AcademicsViewController : UITableViewDataSource{
    
    //Setup number of row for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayHeaders.count
    }
    
    //Create table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : aboutUsDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! aboutUsDetailsTableViewCell
        cell.labelText?.text = arrayHeaders[indexPath.row]
        return cell
    }
    
}

extension AcademicsViewController : UITableViewDelegate{
    
    //Selected table view cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
       
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier:kTrainingPlacementIdentifier, sender: self)
        case 1:
            self.performSegue(withIdentifier:kPlacementHistoryIdentifier, sender: self)
        case 2:
            self.performSegue(withIdentifier:kIndustrialIdentifier, sender: self)
        default:
            break;
        }
    }
}

