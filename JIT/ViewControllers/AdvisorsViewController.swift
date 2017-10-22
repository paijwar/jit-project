
import UIKit

class AdvisorsViewController: UIViewController {
    
    var titleOfViewController : String = ""

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
        leftBtn = UIBarButtonItem.init(image: UIImage.init(named: "left"), style:.plain, target: self, action: #selector(AdvisorsViewController.buttonMenuTapped))
        leftBtn?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBtn
        self.title =  titleOfViewController
    }
    
    func buttonMenuTapped(){
        let _ = self.navigationController?.popViewController(animated: true)
    }
 

}
