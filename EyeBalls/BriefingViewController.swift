//
//  BriefingViewController.swift
//  EyeBalls
//
//  Created by Jasper on 5/21/15.
//  Copyright (c) 2015 Jasper. All rights reserved.
//

import UIKit

class BriefingViewController: UIViewController {

    @IBOutlet weak var WebView: UIWebView!

    @IBAction func close()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye", ofType: "html")
        {
            let htmlData = NSData(contentsOfFile: htmlFile)
            let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
            WebView.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
