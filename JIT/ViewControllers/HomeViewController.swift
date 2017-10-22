
import UIKit
import BEFoldMenuViewController

class HomeViewController: UIViewController {
    
    @IBOutlet var widthConstraint : NSLayoutConstraint?
    
    @IBOutlet var scrollviewImg : UIScrollView?
    
    @IBOutlet var pageControl : UIPageControl?
    
    @IBOutlet var descrptionLbl : UILabel?
    
    @IBOutlet var nameLbl : UILabel?
    
    @IBOutlet var designationLbl : UILabel?
    
    let notificationName = Notification.Name("leftSideMenuSelectedIdentifier")
    
    let leftMenuArray : Array <String> = ["mainSegueIdentifier","academics","department","facilities","student","about","contact"]
 
    var widthConstant : CGFloat = 0.0
    
    var scrollCounter : CGFloat = 0
    
    let staticScrollTimer : CGFloat = 3.0
    
    var autoScrollTimer : Timer?
    
    let kTitleOfScreen : String = "Home"
    
    let kHomeIdentifier : String = "mainSegueIdentifier"
    
    let kAcademicsIdentifier : String = "academics"
    
    let kFacilitiesIdentifier : String = "facilities"
    
    let kDepartmentIdentifier : String = "department"
    
    let kStudentIdentifier : String = "student"
    
    let kAboutIdentifier : String = "about"
    
    let kContactIdentifier : String = "contact"
    
    let kStoryboarName : String = "Main"
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Setup new details
        self.setupViewDetails()
        
        //Read data from plist
        self.readDataFromPlist()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        autoScrollTimer?.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Utility Methods
    
    func setupViewDetails(){
        
        var leftBtn : UIBarButtonItem?
        leftBtn = UIBarButtonItem.init(image: UIImage.init(named: "menu"), style:.plain, target: self, action: #selector(HomeViewController.buttonMenuTapped))
        leftBtn?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBtn
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.pushtoNextViewController), name: notificationName, object: nil)
        self.title = kTitleOfScreen
        
        //Initaite timer for auto scroll
       autoScrollTimer = Timer.scheduledTimer(timeInterval: TimeInterval(staticScrollTimer), target: self, selector: #selector(HomeViewController.autoscrollView), userInfo: nil, repeats: true)
 
    }
    
    func pushtoNextViewController(with notification: NSNotification){
        
        //Get value from notification Dictionary
        var dict : [String : Int] = notification.object as! Dictionary
        
        //Set selected index path
        let indexPath : Int = dict["number"]!
        
        //Set up current view controller
        let viewController : UIViewController = self.getCureentViewController()
        
        //Set up destination controller identifier
        let identifier : String = leftMenuArray[indexPath]
        
        //Setup current view contoller identifier
        let currentIdentifier = viewController.restorationIdentifier
       
        //Check current and destination view controller identifier
        if currentIdentifier == identifier{
            return
        }
   
        //Push to next view controller
        switch indexPath {
        case 0:
            let _ = self.navigationController?.popToRootViewController(animated: true)
        case 1:
            self.performSegue(withIdentifier:kAcademicsIdentifier, sender: viewController)
        case 2:
            self.performSegue(withIdentifier:kDepartmentIdentifier, sender: viewController)
        case 3:
            self.performSegue(withIdentifier:kFacilitiesIdentifier, sender: viewController)
        case 4:
            self.performSegue(withIdentifier:kStudentIdentifier, sender: viewController)
        case 5:
            self.performSegue(withIdentifier:kAboutIdentifier, sender: viewController)
        case 6:
            self.performSegue(withIdentifier:kContactIdentifier, sender: viewController)
        default:
            break
        }
    }
    
    func getCureentViewController () -> UIViewController {
    
        //Get view controller array
        let arrayControllers : Array <UIViewController> = (self.navigationController?.viewControllers)!
        
        //Set up current view controller
        let viewController : UIViewController = arrayControllers.last!
    
        return viewController
    }
    
    func readDataFromPlist(){
        
        //read path of plist
        let path : String = Bundle.main.path(forResource: "testimonialsData", ofType: "plist")!
        
        if let myDict = NSDictionary(contentsOfFile: path) as? [String: Any] {
        
            let randomNum : Int = Int(arc4random_uniform(13))
            let nameArray : Array <String> = myDict["name"] as! Array<String>
            let desginationArray : Array <String> = myDict["desgination"] as! Array<String>
            let descArray : Array <String> = myDict["description"] as! Array<String>
            
            self.nameLbl?.text = nameArray[randomNum]
            self.descrptionLbl?.text = descArray[randomNum]
            self.designationLbl?.text = desginationArray[randomNum]
        
        }
        
    }
    
    //MARK: - IBAction Methods
    
    @IBAction func buttonMenuClick(sender : AnyObject){
        
        self.widthConstant = self.widthConstant == self.view.frame.size.width ? 0 : self.view.frame.size.width
        UIView.animate(withDuration: 0.8,
                       delay: 0.1,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        self.widthConstraint?.constant = self.widthConstant
                        self.view.superview?.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            
        })
        
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
        
        //Home option selected
        if segue.identifier == kHomeIdentifier {
            let homeObj : HomeViewController = storyboard.instantiateViewController(withIdentifier: kHomeIdentifier) as! HomeViewController
            viewController.navigationController?.pushViewController(homeObj, animated: true)
        }
            
        //Academics option selected
        else if segue.identifier == kAcademicsIdentifier {
            let acadmicsObj : AcademicsViewController = storyboard.instantiateViewController(withIdentifier: kAcademicsIdentifier) as! AcademicsViewController
            viewController.navigationController?.pushViewController(acadmicsObj, animated: true)
        }
            
        //Department option selected
        else if segue.identifier == kDepartmentIdentifier {
            let deptObj : DepartmentViewController = storyboard.instantiateViewController(withIdentifier: kDepartmentIdentifier) as! DepartmentViewController
            viewController.navigationController?.pushViewController(deptObj, animated: true)
        }
            
        //Facilities option selected
        else if segue.identifier == kFacilitiesIdentifier {
            let facilitiesObj : FacilitiesViewController = storyboard.instantiateViewController(withIdentifier: kFacilitiesIdentifier) as! FacilitiesViewController
            viewController.navigationController?.pushViewController(facilitiesObj, animated: true)
        }
    
        //Student option selected
        else if segue.identifier == kStudentIdentifier {
            let studentObj : StudentViewController = storyboard.instantiateViewController(withIdentifier: kStudentIdentifier) as! StudentViewController
            viewController.navigationController?.pushViewController(studentObj, animated: true)
        }
        
        //About option selected
        else if segue.identifier == kAboutIdentifier {
            let aboutObj : AboutViewController = storyboard.instantiateViewController(withIdentifier: kAboutIdentifier) as! AboutViewController
            viewController.navigationController?.pushViewController(aboutObj, animated: true)
        }
       
    }
    
    func autoscrollView(){
        
        //get widht of scroll view
        let widthofScrollView : CGFloat = 375.0
        let yavlueOfScrollView : CGFloat = (self.scrollviewImg?.frame.origin.y)!
        let widthOfScrollView : CGFloat = (self.scrollviewImg?.frame.size.width)!
        let heightOfScrollView : CGFloat = (self.scrollviewImg?.frame.size.height)!
        
        if scrollCounter < 5 {
            
            // calculate next page to display
            scrollCounter = scrollCounter + 1
            self.pageControl?.currentPage =  Int(scrollCounter);
            let nextPage : CGFloat = (scrollCounter * widthofScrollView)
            self.scrollviewImg?.scrollRectToVisible(CGRect.init(x:nextPage, y: yavlueOfScrollView, width: widthOfScrollView, height: heightOfScrollView), animated: true)
            
        }else{
            scrollCounter = 0
            self.pageControl?.currentPage =  Int(scrollCounter);
            self.scrollviewImg?.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        }
        
    }
    
    
}
