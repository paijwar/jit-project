
import UIKit

class testimonialTableViewCell: UITableViewCell {
    
    @IBOutlet var descrptionLbl : UILabel?
    
    @IBOutlet var nameLbl : UILabel?
    
    @IBOutlet var designationLbl : UILabel?
    
    @IBOutlet var profileImage : UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
