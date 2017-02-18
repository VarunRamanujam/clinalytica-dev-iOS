//
//  PowerBIWebViewController.swift
//  Hospital
//
//  Created by Shridhar on 2/17/17.
//
//

import UIKit

class PowerBIWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!
    
    let url = "https://app.powerbi.com/view?r=eyJrIjoiOWRhOWQ3ZTItMDhlMy00OTdkLWJlOTgtNWE5NmJlNThmOWI0IiwidCI6IjlhMjkzOGMwLTQ3NmItNDlhOC04NzhiLTI2MTdlNzUzNjA4NiIsImMiOjN9"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.delegate = self
        
        if appDelegate.hasConnectivity() == false {
            appDelegate.showMessageHudWithMessage(message: NoInternetAccess, delay: 2.0)
            return
        }
        appDelegate.showProgressHudForViewMy(withDetailsLabel: "Please wait…", labelText: "Requesting")
        
        webView.loadRequest(URLRequest(url: URL(string: url)!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "PowerBI"
        
        self.navigationController!.navigationBar.topItem!.title = "Back"
//        self.navigationController?.navigationBar.backItem?.title = "Back2";
//        self.navigationItem.backBarButtonItem?.title = "Back3"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.backBarButtonItem?.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
//        if webView.isLoading == false {
            appDelegate.hideProgressHudInView()
//        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if navigationType == .linkClicked {
            return false
        }
        return true
    }

}
