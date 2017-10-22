
import UIKit
import BEFoldMenuViewController

class LeftViewController: UIViewController{
    
    @IBOutlet var tableViewDetails : UITableView?
    
    let reuseIdentifier : String = "menuCellDetails"
    
    let leftMenuArray : Array <String> = ["Home","Academics","Department","Facilities","Student","About Us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewDetails?.dataSource = self
        self.tableViewDetails?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postnotification(with indexValue:Int)  {
     
        let myDict : Dictionary = ["number":indexValue]
        let notificationName = Notification.Name("leftSideMenuSelectedIdentifier")
        NotificationCenter.default.post(name: notificationName, object: myDict)
        
    }
    
   
}

extension LeftViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return leftMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : leftMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! leftMenuTableViewCell
        cell.lableCellDetails?.text = leftMenuArray[indexPath.row]
        return cell
    }
    
}

extension LeftViewController : UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let bfobj : BEFoldMenuViewController = self.foldMenuController()
        bfobj.leftMenuAction()
        self.postnotification(with: indexPath.row)
    }
}
