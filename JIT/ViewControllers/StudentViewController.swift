
import UIKit
 import BEFoldMenuViewController

class StudentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewControler()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Setup Details
    
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

}
