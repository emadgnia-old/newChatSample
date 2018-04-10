 //
//  MainController.swift
//  sample
//
//  Created by Emad Ghorbani Nia on 12/23/1396 AP.
//

import UIKit
import CoreData

class MainController: UIViewController {
  
    fileprivate var dataArray = [TableDataModelItem]()
    fileprivate var tmpDataArray = [TableDataModelItem]()
    fileprivate var selectedDataArray = [TableDataModelItem]()
    var mainContact: [NSManagedObject] = []
    
    @IBAction func nextAction(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "second") as? SecondController {
            viewController.contacts = selectedDataArray
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var collectionView: UICollectionView?
    var isSelected = false
    var selectedIndexPath = IndexPath(row: -1, section: -1)
    var indexCreation : Int32 = 0
    var indexesArray = [IndexPath]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.delegate = self
        tableView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.dataSource = self
        searchBar.placeholder = "🔎 جستجو مخاطبین"
        searchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "IRANSansMobile", size: 17)!,NSAttributedStringKey.foregroundColor : UIColor.white]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        deleteAllRecords()
        indexCreation = 0
        createData()
        createData()
        createData()
        createData()
        createData()
        createData()
        createData()
        createData()
        createData()
        createData()
        fetchData()


    }
    func createData()  {
        let pic = UIImage.init(named: "\(indexCreation)")
        let picData = UIImagePNGRepresentation(pic!) as Data?
        
        let fakeData = TableDataModelItem(pic: picData!, name: "عماد\(indexCreation)", phone: convertToPersian(text: "0912837981\(indexCreation)"), id: indexCreation)
        indexCreation = indexCreation+1
        
        self.save(contactLocal: fakeData)
    }
    
    func fetchData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Contact")
        
        do {
            mainContact = try managedContext.fetch(fetchRequest)
            for single in mainContact {
                dataArray.append(TableDataModelItem.init(pic: single.value(forKey: "picture") as! Data, name: single.value(forKey: "name") as! String, phone: single.value(forKey: "phonenumber") as! String, id: single.value(forKey: "id") as! Int32))
            }
            tmpDataArray = dataArray
            tableView?.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func save(contactLocal: TableDataModelItem) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Contact",
                                       in: managedContext)!
        
        let contactToSave = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        contactToSave.setValue(contactLocal.contactId, forKeyPath: "id")
        contactToSave.setValue(contactLocal.contactPhoneNumber, forKeyPath: "phonenumber")
        contactToSave.setValue(contactLocal.contactName, forKeyPath: "name")
        contactToSave.setValue(contactLocal.contactPicture, forKeyPath: "picture")
        
        do {
            try managedContext.save()
            mainContact.append(contactToSave)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func convertToPersian(text : String)-> String {
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "۴", "5" : "۵", "6" : "۶", "7" : "۷", "8" : "۸", "9" : "۹"]
        var str : String = text
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
}

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            fatalError("Unexpected Index Path")
        }
        let data = dataArray[indexPath.row]
        cell.configureWithItem(item: data, isSelected: isSelected, indexes:indexesArray , currentIndex: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        return dataArray.count

    }
}

extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        

        if let index = selectedDataArray.index(where: { (selectedDataArray) -> Bool in
            selectedDataArray.contactId == dataArray[indexPath.row].contactId
        }){
            selectedDataArray.remove(at: index)
            indexesArray.remove(at: index)
            self.isSelected = false
            self.selectedIndexPath = indexPath
            tableView.reloadData()
            tableView.reloadInputViews()
            collectionView?.reloadData()

        } else {
            self.isSelected = true
            self.selectedIndexPath = indexPath
            tableView.reloadData()
            selectedDataArray.append(dataArray[indexPath.row])
            indexesArray.append(indexPath)
            collectionView?.reloadData()
            tableView.reloadInputViews()
        }

    }
}
 
 
 extension MainController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath as IndexPath) as! CollectionCell
        
        let selectedData = selectedDataArray[indexPath.row]
        cell.configureWithItem(item: selectedData)
        
        return cell
    }
 }
 extension MainController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDataArray.remove(at: indexPath.row)
        indexesArray.remove(at: indexPath.row)
        self.isSelected = false
        self.selectedIndexPath = indexPath
        self.tableView?.reloadData()
        self.tableView?.reloadInputViews()
        collectionView.reloadData()
        print("You selected cell #\(indexPath.item)!")
    }
 }
 
 extension MainController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
print(txtAfterUpdate)
        var filtered = [TableDataModelItem]()
            filtered  = tmpDataArray.filter {
                ($0.contactName?.contains(txtAfterUpdate))! ||
            ($0.contactPhoneNumber?.contains(txtAfterUpdate))!}
        dataArray = filtered
        tableView?.reloadData()
        if txtAfterUpdate == "" {
            dataArray = tmpDataArray
            tableView?.reloadData()
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            dataArray = tmpDataArray
            tableView?.reloadData()
        }
        view.endEditing(true)
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        dataArray = tmpDataArray
        tableView?.reloadData()
        return true
    }
 }
 
 extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
 }
 

