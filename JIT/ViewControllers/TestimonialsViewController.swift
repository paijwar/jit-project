
import UIKit

class TestimonialsViewController: UIViewController {
    
    var nameArray : Array <String> = []
    
    var desginationArray : Array <String> = []
    
    var descArray : Array <String> = []
    
    let reuseIdentifier : String = "testimonialCell"
    
    let plistName : String = "testimonialsData"
    
    let typeOfFile : String = "plist"
    
    @IBOutlet var tableViewDetails : UITableView?

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
        leftBtn = UIBarButtonItem.init(image: UIImage.init(named: "left"), style:.plain, target: self, action: #selector(TestimonialsViewController.buttonMenuTapped))
        leftBtn?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBtn
        self.readDataFromPlist()
    }
    
    func buttonMenuTapped(){
       let _ = self.navigationController?.popViewController(animated: true)
    }

    func readDataFromPlist(){
        
        //read path of plist
        let path : String = Bundle.main.path(forResource: plistName, ofType: typeOfFile)!
        
        if let myDict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            
            nameArray = (myDict["name"] as? Array<String>)!
            desginationArray = (myDict["desgination"] as? Array<String>)!
            descArray = (myDict["description"] as? Array<String>)!
            self.tableViewDetails?.estimatedRowHeight = 215.0
            self.tableViewDetails?.rowHeight = UITableViewAutomaticDimension
            self.tableViewDetails?.reloadData()
            
        }
        
    }
}

extension TestimonialsViewController : UITableViewDataSource{
    
    //Setup number of row for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return nameArray.count
    }

    //Create table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : testimonialTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! testimonialTableViewCell
        cell.descrptionLbl?.text = descArray[indexPath.row]
        cell.nameLbl?.text = nameArray[indexPath.row]
        cell.designationLbl?.text = desginationArray[indexPath.row]
        return cell
    }
}

extension TestimonialsViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


