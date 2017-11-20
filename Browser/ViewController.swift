//
//  ViewController.swift
//  Browser
//
//  Created by Pedro Herrera on 19/10/2017.
//  Copyright © 2017 Pedro Herrera. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var buscarBt: UIButton!
    @IBOutlet var webView: UIWebView!
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var backBt: UIButton!
    @IBOutlet weak var forwardBt: UIButton!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        FirebaseApp.configure()
        webView.delegate = self
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buscarBtAction(_ sender: UIButton)
    {
        let direccion = addressBar.text
        let url = NSURL(string: direccion!)
        let request = NSURLRequest(url: url as! URL)
        webView.loadRequest(request as URLRequest)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        ref.child("historial").childByAutoId().setValue(["url": request.url!.absoluteString])
        addressBar.text = request.url!.absoluteString
        
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.canGoBack
        {backBt.isEnabled = true}
        else
        {backBt.isEnabled = false}
        
        if webView.canGoForward
        {forwardBt.isEnabled = true}
        else
        {forwardBt.isEnabled = false}
    }

    
    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func goForward(_ sender: Any) {
        webView.goForward()
    }
    
    
}
