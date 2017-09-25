//
//  FilterViewController.swift
//  Yelp
//
//  Created by Di Wang on 9/24/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit

@objc protocol FilterViewControllerDelegate {
    @objc func filterViewController(_ filtersViewController: FilterViewController, didUpdateFileters fileters: [String:Any])
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FilterViewControllerDelegate?
    var categories: [[String:String]]!
    var switchStates = [Int:Bool]()
    
    let section = ["Deals", "Distance", "Sort By", "Category"]
    
    let deals = ["Offering a Deal"]
    
    let distance = ["Auto", "0.3 miles", "1 mile", "5 miles", "20 miles"];
    
    let sortBy = ["Best match", "distance", "highest rated"];
    
    // MARK: Actions
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        var filters = [String : Any]()
        
        var selectedCategories = [String]()
        for (row, isSelected) in switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories
        }
        delegate?.filterViewController(self, didUpdateFileters: filters)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        initData();
    }
    
    func initData() {
        categories = yelpCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + categories.count;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section];
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return categories.count;
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var cell: UITableViewCell;
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as? SwitchCell ?? SwitchCell()
            cell.switchLabel.text = deals[0];
            cell.onSwitch.isOn = false;
            cell.delegate = self;
            return cell;
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CascadingCell", for: indexPath) as? CascadingCell ?? CascadingCell();
            cell.cascadingLabel.text = distance[0];
            // TODO: setup cascading tableview.
            cell.delegate = self;
            return cell;
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CascadingCell", for: indexPath) as? CascadingCell ?? CascadingCell()
            cell.cascadingLabel.text = sortBy[0];
            // TODO: setup cascading tableview.
            cell.delegate = self;
            return cell;
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as? SwitchCell ?? SwitchCell()
            
            cell.switchLabel.text = categories[indexPath.row-3]["name"];
            cell.delegate = self;
            
            cell.onSwitch.isOn = switchStates[indexPath.row-3] ?? false;
            return cell;
        }
        return nil;
    }
    
    func switchCell(switchCell:SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        print("filters view controller got the switch event")
        
        switchStates[indexPath.row] = value
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // TODO: implement the API to fetch categories. Simple hardcode for now.
    func yelpCategories() -> [[String:String]] {
        return [
            ["name":"Afghan", "code":"afghani"],
            ["name":"African", "code":"african"],
            ["name":"American, New", "code":"newamerican"],
            ["name":"American, Traditional", "code":"tradamerican"],
            ["name":"Arabian", "code":"arabian"],
            ["name":"Argentine", "code":"argentine"],
            ["name":"Armenian", "code":"armenian"],
            ["name":"Asian Fusion", "code":"asianfusion"],
            ["name":"Asturian", "code":"asturian"],
            ["name":"Australian", "code":"australian"],
            ["name":"Austrian", "code":"austrian"],
            ["name":"Baguettes", "code":"baguettes"],
            ["name":"Wok", "code":"wok"],
            ["name":"Thai", "code":"thai"],
            ["name":"Wraps", "code":"wraps"]
        ]
    }

}










