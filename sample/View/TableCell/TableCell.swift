//
//  TableCell.swift
//  sample
//
//  Created by Emad Ghorbani Nia on 1/20/1397 AP.
//

import UIKit

class TableCell: UITableViewCell {


    @IBOutlet weak var contactMobileLable: UILabel!
    @IBOutlet weak var contactTitleLable: UILabel!
    @IBOutlet weak var greenButton: UIButton! {
        didSet {
            self.greenButton.layer.borderWidth = 0.5
            self.greenButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var contactImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWithItem(item: TableDataModelItem, isSelected: Bool, indexes: [IndexPath], currentIndex: IndexPath) {
        if indexes.index(where: { (indexes) -> Bool in
            indexes == currentIndex
        }) != nil{
            greenButton.setImage(#imageLiteral(resourceName: "success"), for: .normal)
        }
        else {
            greenButton.setImage(nil, for: .normal)
            greenButton.setTitleColor(UIColor.clear, for: .normal)
            
        }
        contactMobileLable?.text = item.contactPhoneNumber
        contactTitleLable?.text = item.contactName
        contactImage?.image =  UIImage(data: item.contactPicture!)
        contactImage.layer.cornerRadius = contactImage.frame.width / 2
        contactImage.clipsToBounds = true
        greenButton.layer.cornerRadius = greenButton.frame.width / 2
        greenButton.clipsToBounds = true
    }

}
