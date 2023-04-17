//
//  ViewController.swift
//  Persisted JSON
//
//  Created by Aleksey Alyonin on 10.04.2023.
//

import UIKit

class ViewController: UITableViewController {

    let store = DataStore.shared
    var newArrayUser = [User]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
//      getFunc()
        print("\(newArrayUser.count)")
    }
    
    func getFunc(){
        store.request() {[weak self] (i) in
            self?.newArrayUser = i
            self?.tableView.reloadData()
        }
    }
    
    func changeLength(of arrayOfInt: [Any], to newLength: Int) -> [Any] {
        if newLength < arrayOfInt.count {
            return Array(arrayOfInt.prefix(newLength))
        } else if newLength == arrayOfInt.count {
            return arrayOfInt
        } else {
            return arrayOfInt + Array(repeating: 0, count: newLength - arrayOfInt.count)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArrayUser.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = newArrayUser[indexPath.row]
        cell.textLabel?.text = (item.name ?? "None text") + " is \(String(describing: item.category))"
        return cell
    }
}

