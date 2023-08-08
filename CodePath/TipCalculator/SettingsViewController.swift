//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Di Wang on 8/20/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultTipPercent: UISegmentedControl!
    
    @IBAction func onSave(_ sender: Any) {
        KeyValueStore.storeInt(
            defaultTipPercent.selectedSegmentIndex
            , forKey: KeyValueStore.keyTipPercentage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaultTipPercent.selectedSegmentIndex = KeyValueStore.getInt(forKey: KeyValueStore.keyTipPercentage, withDefault: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
