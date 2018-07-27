//
//  AllCryptoViewController.swift
//  CoinFit2
//
//  Created by Deval Parikh on 7/19/18.
//  Copyright © 2018 Deval Parikh. All rights reserved.
//

import UIKit
import WebKit

class AllCryptoViewController: UIViewController {

    @IBOutlet weak var webViewAll: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://coinmarketcap.com/")
        let request = URLRequest(url: url!)
        webViewAll.load(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
