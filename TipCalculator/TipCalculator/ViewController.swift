//
//  ViewController.swift
//  TipCalculator
//
//  Created by Di Wang on 8/20/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var friendsField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var friendsIndicatorLabel: UILabel!
    @IBOutlet weak var avgIndicatorLabel: UILabel!
    @IBOutlet weak var totalIndicatorLabel: UILabel!
    @IBOutlet weak var tipIndicatorLabel: UILabel!
    @IBOutlet weak var billIndicatorLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    func allDisappear() {
        billField.alpha = 0
        friendsField.alpha = 0
        tipLabel.alpha = 0
        totalLabel.alpha = 0
        avgLabel.alpha = 0
        tipControl.alpha = 0
        
        friendsIndicatorLabel.alpha = 0
        avgIndicatorLabel.alpha = 0
        totalIndicatorLabel.alpha = 0
        tipIndicatorLabel.alpha = 0
        billIndicatorLabel.alpha = 0
    }
    
    func allAppear() {
        self.billField.alpha = 1
        self.friendsField.alpha = 1
        self.tipLabel.alpha = 1
        self.totalLabel.alpha = 1
        self.avgLabel.alpha = 1
        self.tipControl.alpha = 1
        
        friendsIndicatorLabel.alpha = 1
        avgIndicatorLabel.alpha = 1
        totalIndicatorLabel.alpha = 1
        tipIndicatorLabel.alpha = 1
        billIndicatorLabel.alpha = 1
        
    }
    
    func loadingAnimation() {
        allDisappear()
        
        UIView.animate(withDuration: 1, animations: {
            self.allAppear()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func validateFriendInput(_ sender: Any) {
        var frd:Int = Int(friendsField.text!) ?? 1
        if frd < 1 {
            frd = 1
            print("firends amount should be at least 1.")
        }
        friendsField.text = String(frd)
        calculateTips(sender)
    }
    
    @IBAction func calculateTips(_ sender: Any) {
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let friends = Double(friendsField.text!) ?? 1.0
        let avg = total / friends
        
        tipLabel.text = String(format:"$%.2f", tip)
        totalLabel.text = String(format:"$%.2f", total)
        avgLabel.text = String(format:"$%.2f", avg)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        tipControl.selectedSegmentIndex = KeyValueStore.getInt(forKey:KeyValueStore.keyTipPercentage, withDefault:0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        loadingAnimation();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
        
        allDisappear()
    }
}

