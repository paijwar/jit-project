
import UIKit

class PrincipalViewController: UIViewController {
    
    let plistName : String = "principalData"
    
    let typeOfFile : String = "plist"
    
    let kNameKey : String = "name"
    
    let kDegreeKey : String = "degree"
    
    let kPGDegreeKey : String = "pgdegree"
    
    let kPhdKey : String = "phd"
    
    let kDesignationKey : String = "designation"
    
    let kCommentKey : String = "comment"
    
    var keysArray : Array <String> = []
    
    var imageNameArray : Array <String> = ["JITPrincipal","Madhavi","Bhowmick"]
    
    var contentDict : [String : Any]?
    
    @IBOutlet var tableViewDetails : UITableView?
    
    let reuseIdentifier : String = "principalCell"

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
    
    //MARK:- Setup View
    
    func setupViewControler(){
        
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
        var leftBtn : UIBarButtonItem?
        leftBtn = UIBarButtonItem.init(image: UIImage.init(named: "left"), style:.plain, target: self, action: #selector(PrincipalViewController.buttonMenuTapped))
        leftBtn?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBtn
        self.readDataFromPlist()
    }
    
    func buttonMenuTapped(){
       let _ = self.navigationController?.popViewController(animated: true)
    }

    func readDataFromPlist(){
        
        //read path of plist
        let path : String = Bundle.main.path(forResource:plistName, ofType:typeOfFile)!
        
        if let myDict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            keysArray = Array(myDict.keys)
            contentDict = myDict
            self.tableViewDetails?.estimatedRowHeight = 215.0
            self.tableViewDetails?.rowHeight = UITableViewAutomaticDimension
            self.tableViewDetails?.reloadData()
        }
        
    }
    
    //MARK:- Read Data From Plist
    
    func getName(with key: String) -> String{
    
        let dictTemp : [String : String] = contentDict?[key] as! [String : String]
        return dictTemp[kNameKey]!
    }
    
    func getEducationDetails(with key: String) -> String{
        
        let dictTemp : [String : String] = contentDict?[key] as! [String : String]
        let educationDetails : String = NSString.init(format: "%@\n%@\n%@",dictTemp[kDegreeKey]!,dictTemp[kPGDegreeKey]!,dictTemp[kPhdKey]!) as String
        return educationDetails
    }
    
    func getCommentDetails(with key: String) -> String{
        
        let dictTemp : [String : String] = contentDict?[key] as! [String : String]
        return dictTemp[kCommentKey]!
    }

}

extension PrincipalViewController : UITableViewDataSource{
    
    //Setup number of row for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return keysArray.count
    }
    
    //Create table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : principalTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! principalTableViewCell
        cell.namelbl?.text = self.getName(with: keysArray[indexPath.row])
        cell.degreelbl?.text = self.getEducationDetails(with: keysArray[indexPath.row])
        cell.descriptionlbl?.text = self.getCommentDetails(with: keysArray[indexPath.row])
        return cell
    }
}

extension PrincipalViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
}

