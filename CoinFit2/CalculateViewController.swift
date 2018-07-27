//
//  CalculateViewController.swift
//  CoinFit2
//
//  Created by Deval Parikh on 7/19/18.
//  Copyright © 2018 Deval Parikh. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var MainAmountLabel: UILabel!
    @IBOutlet weak var ProfitLabel: UILabel!
    
    @IBOutlet weak var CalculateButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    @IBOutlet weak var BTCButton: UIButton!
    
    @IBOutlet weak var initValueTextField: UITextField!
    @IBOutlet weak var currentValueTextField: UITextField!
    @IBOutlet weak var futureValueTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Default Values for TextField (Disabled)
        //currentValueTextField.text = ConvertToCurrency(variableToConvert: (GlobalVars.GlobalPriceVar)) + ""

        //Default Values for Labels
        MainAmountLabel.text = "Amount Worth"
        ProfitLabel.text = "Profit"
        
        //Default Colors for Labels
        ProfitLabel.textColor = UIColor(red:0.56, green:0.90, blue:0.77, alpha:0.6)
        MainAmountLabel.textColor = UIColor(red:0.56, green:0.90, blue:0.77, alpha:0.6)
        
        //        myTextFieldDidChange function being called
        
        initValueTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        currentValueTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        futureValueTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        
        self.hideKeyboardWhenTappedAround()
        //Below does not work with TextFieldEffect POD
        //initValueTextField.becomeFirstResponder()
        initValueTextField.delegate = self
        currentValueTextField.delegate = self
        futureValueTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //Button to calculate
    
    @IBAction func ButtonCalculateAction(_ sender: Any) {
        //If there is something missing
        if initValueTextField.text == "" || currentValueTextField.text == "" || futureValueTextField.text == ""{
            MainAmountLabel.text = "Error"
        }
        if initValueTextField.text == "" {
            initValueTextField.text = "$0.00"
        }
        if currentValueTextField.text == "" {
            currentValueTextField.text = "$0.00"
        }
        if futureValueTextField.text == "" {
            futureValueTextField.text = "$0.00"
        }
        
        //print("initValueTest: " + initValueTextField.text!)
        //print("currentValueTest: " + currentValueTextField.text!)
        //print("futureValueTest: " + futureValueTextField.text!)
        
        //Converts textfield inputs to doubles
        let initValueDouble = ConvertToDoubleFromCurrecny(variableToConvert: initValueTextField.text!)
        let currentValueDouble = ConvertToDoubleFromCurrecny(variableToConvert: currentValueTextField.text!)
        let futureValueDouble = ConvertToDoubleFromCurrecny(variableToConvert: futureValueTextField.text!)
        
        //NewFutureValue calculation
        let AnsFutureValue = ( initValueDouble / currentValueDouble ) * futureValueDouble
        //Converts NewFutureValue to Currency
        let AnsFutureValueCurrency = ConvertToCurrency(variableToConvert: AnsFutureValue)
        
        //profitValue calculation
        let profitValue = (AnsFutureValue - initValueDouble)
        //Converts profitValue to Currency
        let profitValueCurrency = ConvertToCurrency(variableToConvert: profitValue)
        
        //initValueDouble = 100 + initValueDouble
        //Below does not work after 1000
        //let FutureValueString = ConvertToCurrency(variableToConvert: FutureValue)
        //Below works but worthless now smh
        //let AnsFutureValueString:String = "$" + String(format:"%0.02f", AnsFutureValue)
        
        //Label font color change
        if (profitValue >= 0) {
            //Change to green theme color
            ProfitLabel.textColor = UIColor(red:0.56, green:0.90, blue:0.77, alpha:1.0)
            MainAmountLabel.textColor = UIColor(red:0.56, green:0.90, blue:0.77, alpha:1.0)
        } else {
            ProfitLabel.textColor = UIColor(red:0.85, green:0.35, blue:0.50, alpha:1.0)
            MainAmountLabel.textColor = UIColor(red:0.85, green:0.35, blue:0.50, alpha:1.0)
        }
        
        
        
        ProfitLabel.text = profitValueCurrency
        MainAmountLabel.text = AnsFutureValueCurrency
    }
    
    //Button to reset
    
    @IBAction func resetButtonAction(_ sender: Any) {
        //Default blank values for textfields and labels
        initValueTextField.text = ""
        currentValueTextField.text = ""
        futureValueTextField.text = ""
        ProfitLabel.text = ""
        MainAmountLabel.text = ""
        //Default Colors for Labels
        ProfitLabel.textColor = UIColor(red:0.56, green:0.90, blue:0.77, alpha:0.6)
        MainAmountLabel.textColor = UIColor(red:0.56, green:0.90, blue:0.77, alpha:0.6)
        
    }
    
    //Button for BTC
    
    @IBAction func BTCButtonAction(_ sender: Any) {
        initValueTextField.text = "$0.00"
        currentValueTextField.text = ConvertToCurrency(variableToConvert: (GlobalVars.GlobalPriceVar))
        futureValueTextField.text = "$0.00"
        ProfitLabel.text = ""
        MainAmountLabel.text = ""
        
    }
    
    
    
    // Using currency extension to string to convert TextField to currency format call initValueTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged) in viewDidLoad
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Search Method (Dismisses Keyboard on "Done" Press)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == initValueTextField {
            // Switch focus to other text field
            currentValueTextField.becomeFirstResponder()
        }
        if textField == currentValueTextField {
            // Switch focus to other text field
            futureValueTextField.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    //Converts a double parameter to String in currency format
    func ConvertToCurrency(variableToConvert: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        let priceString = currencyFormatter.string(from: variableToConvert as NSNumber)!
        print(priceString) // Displays $9,999.99 in the US locale
        return priceString
    }
    //Converts a currenct String parameter to Double
    func ConvertToDoubleFromCurrecny(variableToConvert: String) -> Double {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        var priceString = "0.00"
        priceString = variableToConvert
        priceString.remove(at: priceString.startIndex)
        priceString = (priceString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil))
        //print(priceString)
        let priceDouble = (priceString as NSString).doubleValue
        return priceDouble
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

//For TextField to be formatted to currency
extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}

