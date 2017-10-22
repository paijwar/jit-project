
import UIKit

class principalTableViewCell: UITableViewCell {
    
    @IBOutlet var namelbl : UILabel?
    
    @IBOutlet var degreelbl : UILabel?
    
    @IBOutlet var descriptionlbl : UILabel?
    
    @IBOutlet var profileIV : UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
