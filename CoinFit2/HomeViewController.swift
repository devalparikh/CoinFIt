//
//  ViewController.swift
//  CoinFit2
//
//  Created by Deval Parikh on 7/19/18.
//  Copyright © 2018 Deval Parikh. All rights reserved.
//

import UIKit

struct GlobalVars {
    static var GlobalPriceVar = 0.00
}
class ViewController: UIViewController {

    @IBOutlet weak var PriceLabel: UILabel!
    
    var PriceVar = ""
    var PriceVarDouble = Double(0.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PriceLabel.text = "Loading..."
        print("Calling getJSON")
        getJson()
        print("Not Sugoi")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Gets data from JSON
    func getJson() {
        //Link to JSON Response
        guard let gitUrl = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let bitData = try decoder.decode(BTCPrice.self, from: data)
                print("JSON WORKING")
                print(bitData.bpi.usd.rate)
                self.PriceVar = bitData.bpi.usd.rate
                self.PriceVarDouble = bitData.bpi.usd.rateFloat
                GlobalVars.GlobalPriceVar = self.PriceVarDouble
                
            } catch let err {
                //print("UGHHHHHHHHHHHHHHH")
                print("Err", err)
            }
            OperationQueue.main.addOperation({
                //calling another function after fetching the json
                //it will show the names to label
                self.showNames()
            })
            }.resume()
        
    }
    func showNames(){
        
        //Sets Label to BTC Price converted to currency format
        PriceLabel.text = ConvertToCurrency(variableToConvert: self.PriceVarDouble)
        
    }
    //Converts a double parameter to String in currency format
    func ConvertToCurrency(variableToConvert: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        let priceString = currencyFormatter.string(from: self.PriceVarDouble as NSNumber)!
        print(priceString) // Displays $9,999.99 in the US locale
        return priceString
    }


}

// To parse the JSON, add this file to your project and do:
//
//   let bTCPrice = try? JSONDecoder().decode(BTCPrice.self, from: jsonData)

import Foundation

struct BTCPrice: Codable {
    let time: Time
    let disclaimer, chartName: String
    let bpi: Bpi
}

struct Bpi: Codable {
    let usd, gbp, eur: Eur
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct Eur: Codable {
    let code, symbol, rate, description: String
    let rateFloat: Double
    
    enum CodingKeys: String, CodingKey {
        case code, symbol, rate, description
        case rateFloat = "rate_float"
    }
}

struct Time: Codable {
    let updated, updatedISO, updateduk: String
}
//MARK: - Dismiss Keyboard
//put self.hideKeyboardWhenTappedAround() in viewDidLoad function
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
