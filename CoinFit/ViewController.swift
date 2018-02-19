//
//  ViewController.swift
//  CoinFit
//
//  Created by Deval Parikh on 12/25/17.
//  Copyright © 2017 Deval Parikh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    


    @IBOutlet weak var AmountofCoinsLabel: UILabel!
    @IBOutlet weak var Profits: UILabel!
    @IBOutlet weak var Amount: UITextField!
    @IBOutlet weak var CurrentWorth: UITextField!
    @IBOutlet weak var DesiredWorth: UITextField!
    @IBOutlet weak var Ans: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Amount.keyboardType = UIKeyboardType.decimalPad
        CurrentWorth.keyboardType = UIKeyboardType.decimalPad
        DesiredWorth.keyboardType = UIKeyboardType.decimalPad
        Amount.text = ""
        CurrentWorth.text = ""
        DesiredWorth.text = ""
        Ans.text = ""
        Profits.text = ""
        AmountofCoinsLabel.text = ""
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
  
    @IBAction func Reset(_ sender: Any) {
        
        Amount.text = ""
        CurrentWorth.text = ""
        DesiredWorth.text = ""
        
        AmountofCoinsLabel.text = "0 Coins"
        
        Ans.text = "Re-Enter Values"
        Profits.text = "$0.00"
        
    }
    @IBAction func Calc(_ sender: Any) {
        
        if Amount.text == "" {
            if CurrentWorth.text == ""{
                if DesiredWorth.text == ""{
                    Ans.text = "ERROR"
                    Profits.text = "$0.00"
                    return
                }
            }
            
        }
        if Amount.text == ""{
            Amount.text = "0"
        }
        if CurrentWorth.text == ""{
            CurrentWorth.text = "0"
        }
        if DesiredWorth.text == ""{
            DesiredWorth.text = "0"
        }
        
        let am: Double? = Double(Amount.text!)
        let cw: Double? = Double(CurrentWorth.text!)
        let dw: Double? = Double(DesiredWorth.text!)
        
        let final = ( am! / cw! ) * dw!
        
        let CoinAmount = ( am! / cw! )
        
        let finalCoinAmount = Double(round(100*CoinAmount)/100)
        let finalCoinAmountText = String(finalCoinAmount) + " Coins"
        
        let finalans = Double(round(100*final)/100)
        
        let finaltext = "$ " + String(finalans)
        
        Ans.text = finaltext
        
        let ft: Double? = Double(finalans)
        
        let profit = ft! - am!
        
        if profit > 0{
            Profits.textColor = UIColor.green
        }else{
            Profits.textColor = UIColor.red
        }
        let pf: Double? = Double(profit)
        
        let perc = pf! / ft! * 100
        
        let perc1 = Double(round(10*perc)/10)
        
        let perctext = String(perc1) + "%"
        
        let profitrounded = Double(round(100*profit)/100)
        
        let profittext = "$ " + String(profitrounded) 
        
   
        
        Profits.text = profittext
        
        AmountofCoinsLabel.text = finalCoinAmountText
        

        

    }
    
}

