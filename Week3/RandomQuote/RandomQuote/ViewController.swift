//
//  ViewController.swift
//  RandomQuote
//
//  Created by Alihan KUZUCUK on 18.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblQuote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblQuote.sizeToFit()
        
        getNewQuote()
    }

    @IBAction func btnNewQuoteClicked(_ sender: Any) {
        getNewQuote()
    }
    
    func getNewQuote() {
        Client.getRandomQuote { randomQuote, error in
            self.lblQuote.text = randomQuote.en
        }
    }
    
}

