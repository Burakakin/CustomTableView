//
//  ViewController.swift
//  CustomTableView
//
//  Created by Burak Akin on 15.07.2018.
//  Copyright © 2018 Burak Akin. All rights reserved.
//

import UIKit

struct App: Decodable {
    var id: Int
    var name: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var apps = [App]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let information = apps[indexPath.row]
        cell.nameLabel.text = information.name
        cell.surnameLabel.text = String(information.id)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let rowSelected = (sender as! IndexPath).row
        let rowSelected = (sender as! IndexPath).row
        if segue.identifier == "showDetail"{
            if let destinationVC = segue.destination as? DetailViewController{
                destinationVC.text = String(apps[rowSelected].name)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       getUrl(UrlString: "https://api.letsbuildthatapp.com/jsondecodable/courses")
        
    }
    
   
    func getUrl(UrlString: String) {
        let url = URL(string: UrlString)
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            guard let data = data else { return }
            self.getData(dataValues: data)
            
            }.resume()
    }
    
    func getData(dataValues: Data){
        
        do {
            let appData = try JSONDecoder().decode([App].self, from: dataValues)
            print(appData[0].name)
            DispatchQueue.main.async {
                self.apps.append(contentsOf:appData)
                self.myTableView.reloadData()
            }
            
        } catch let err {
            print("Err", err)
        }
        
    }
    
    


}

