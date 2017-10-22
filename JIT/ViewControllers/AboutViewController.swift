
import UIKit
import BEFoldMenuViewController

class AboutViewController: UIViewController {
    
    var arrayHeaders : Array <String> = ["Academic Advisors","Board Of Directors","Corporate Advisors","Faculties","Principal","Testimonials"]
    
    @IBOutlet var tableViewDetails : UITableView?
    
    var selectedIndex : Int = 0
    
    let reuseIdentifier : String = "aboutUsDetailsCell"
    
    let kPrincipalIdentifier : String = "principal"
    
    let kFacultiesIdentifier : String = "faculties"
    
    let kBoardOfdirectorsIdentifier : String = "boardOfdirectors"
    
    let kAdvisorsIdentifier : String = "advisors"
    
    let kTestimonialsIdentifier : String = "testimonials"
    
    let kStoryboarName : String = "Main"

    //MARK:- View Life Cycle
    
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
        leftBtn = UIBarButtonItem.init(image: UIImage.init(named: "menu"), style:.plain, target: self, action: #selector(StudentViewController.buttonMenuTapped))
        leftBtn?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBtn
        
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
        
        //Principal option selected
        if segue.identifier == kPrincipalIdentifier {
            let pricObj : PrincipalViewController = storyboard.instantiateViewController(withIdentifier:kPrincipalIdentifier) as! PrincipalViewController
            viewController.navigationController?.pushViewController(pricObj, animated: true)
        }
        
        //Faculties option selected
        else if segue.identifier == kFacultiesIdentifier {
            let facultObj : FacultiesJITViewController = storyboard.instantiateViewController(withIdentifier:kFacultiesIdentifier) as! FacultiesJITViewController
            viewController.navigationController?.pushViewController(facultObj, animated: true)
        }
        
        //Board Of Directors option selected
        else if segue.identifier == kBoardOfdirectorsIdentifier {
            let boardDirectorObj : BoardOfDirectorsViewController = storyboard.instantiateViewController(withIdentifier:kBoardOfdirectorsIdentifier) as! BoardOfDirectorsViewController
            viewController.navigationController?.pushViewController(boardDirectorObj, animated: true)
        }
        
        //Advisors option selected
        else if segue.identifier == kAdvisorsIdentifier {
            let advicerObj : AdvisorsViewController = storyboard.instantiateViewController(withIdentifier:kAdvisorsIdentifier) as! AdvisorsViewController
            advicerObj.titleOfViewController = self.setupTitleOfViewController()
            viewController.navigationController?.pushViewController(advicerObj, animated: true)
        }
        
        //Testimonials option selected
        else if segue.identifier == kTestimonialsIdentifier {
            let testObj : TestimonialsViewController = storyboard.instantiateViewController(withIdentifier:kTestimonialsIdentifier) as! TestimonialsViewController
            viewController.navigationController?.pushViewController(testObj, animated: true)
        }
    }
    
    func setupTitleOfViewController() -> String{
    
        if selectedIndex == 0 {
        
            return "Academic Advisors"
            
        }else {
        
            return "Corporate Advisors"
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

extension AboutViewController : UITableViewDataSource{
    
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

extension AboutViewController : UITableViewDelegate{
    
    //Selected table view cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier:kAdvisorsIdentifier, sender: self)
        case 1:
            self.performSegue(withIdentifier:kBoardOfdirectorsIdentifier, sender: self)
        case 2:
            self.performSegue(withIdentifier:kAdvisorsIdentifier, sender: self)
        case 3:
            self.performSegue(withIdentifier:kFacultiesIdentifier, sender: self)
        case 4:
            self.performSegue(withIdentifier:kPrincipalIdentifier, sender: self)
        case 5:
            self.performSegue(withIdentifier:kTestimonialsIdentifier, sender: self)
        default:
            break;
        }
    }
}

