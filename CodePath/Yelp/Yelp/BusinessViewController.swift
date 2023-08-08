//
//  BusinessViewController.swift
//  Yelp
//
//  Created by Di Wang on 9/24/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterViewControllerDelegate {

    // MARK: variable definitions
    var businesses: [Business]!
    
    
    // MARK: Outlet definitions
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120;
        
        // Do any additional setup after loading the view.
        initData();
        initUI();
    }
    
    func initUI() {
        // configure navigation bar.
        if let navBar = self.navigationController?.navigationBar {
//            navBar.barStyle = UIBarStyle.default
            navBar.isTranslucent = true;
//            UINavigationBar.appearance().isTranslucent = false
//            navBar.tintColor = UIColor.red;
            navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        }
        
        
    }
    
    func initData() {
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses;
            self.tableView.reloadData();
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
        }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count;
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        return cell;
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let navigationController = segue.destination as! UINavigationController
        let filterViewController = navigationController.topViewController as! FilterViewController
        filterViewController.delegate = self
    }
    
    func filterViewController(_ filtersViewController: FilterViewController, didUpdateFileters filters: [String:Any]) {
        
        let categories = filters["categories"] as? [String]
        
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses;
            self.tableView.reloadData();
        })
    }

}
