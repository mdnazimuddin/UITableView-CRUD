//
//  ViewController.swift
//  TableViewCRUD
//
//  Created by Nazim Uddin on 7/8/19.
//  Copyright © 2019 Nazim Uddin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var addOut: UIButton!
    @IBOutlet weak var updateOut: UIButton!
    
    var data = [String]()
    var index:IndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()
        roundButton()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        if !txtField.text!.isEmpty {
            data.append(txtField.text!)
            
            let indexPath = IndexPath(row: data.count-1, section: 0)
            
            tblView.beginUpdates()
            tblView.insertRows(at: [indexPath], with: .automatic)
            tblView.endUpdates()
        }
        txtField.text = ""
    }
    
    @IBAction func updateAction(_ sender: Any) {
        if !index.isEmpty{
            if let cell = tblView.cellForRow(at: index) {
                data[index.row] = txtField.text!
                cell.textLabel?.text = txtField.text!
            }
        }
    }
    
    @IBAction func autoUpdateTextField(_ sender: Any) {
//        if !index.isEmpty{
//            if let cell = tblView.cellForRow(at: index) {
//                data[index.row] = txtField.text!
//                cell.textLabel?.text = txtField.text!
//            }
//        }
    }
    
    private func roundButton(){
        addOut.layer.cornerRadius = addOut.layer.bounds.height / 2
        updateOut.layer.cornerRadius = updateOut.layer.bounds.height / 2
    }

}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath
        txtField.text = data[indexPath.row]
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
