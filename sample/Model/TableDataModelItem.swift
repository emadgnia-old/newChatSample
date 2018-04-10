//
//  TableDataModelItem.swift
//  sample
//
//  Created by Emad Ghorbani Nia on 1/20/1397 AP.
//

import Foundation
import UIKit

class TableDataModelItem {
    var contactPicture: Data?
    var contactName: String?
    var contactPhoneNumber: String?
    var contactId: Int32?
    
    public init(pic : Data , name : String , phone : String , id : Int32) {
        contactPicture = pic
        contactName = name
        contactPhoneNumber = phone
        contactId = id
    }
}
