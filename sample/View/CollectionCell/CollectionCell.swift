//
//  CollectionCell.swift
//  sample
//
//  Created by Emad Ghorbani Nia on 4/9/18.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageViewWrapper: UIView! {
        didSet {
           self.imageViewWrapper.layer.cornerRadius = self.imageViewWrapper.frame.width / 2
            self.imageViewWrapper.clipsToBounds = true
            self.imageViewWrapper.layer.borderWidth = 0
            self.imageViewWrapper.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var buttonWrapper: UIView! {
        didSet {
            self.buttonWrapper.layer.cornerRadius = self.buttonWrapper.frame.width / 2
            self.buttonWrapper.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            self.imageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var selectionButton: UIButton! {
        didSet {
            self.selectionButton.layer.cornerRadius = self.selectionButton.frame.width / 2
            self.selectionButton.clipsToBounds = true
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    
    func configureWithItem(item: TableDataModelItem) {
        self.nameLabel.text = item.contactName
        self.imageView.image =  UIImage(data: item.contactPicture!)
    
    }
}
