//
//  SecondController.swift
//  sample
//
//  Created by Emad Ghorbani Nia on 1/21/1397 AP.
//

import UIKit

class SecondController: UIViewController {

    public var contacts = [TableDataModelItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for contact in contacts {
            print(contact.contactPhoneNumber as Any)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
