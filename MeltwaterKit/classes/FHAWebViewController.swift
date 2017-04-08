//
//  WebViewController.swift
//  Meltwater Mobile
//
//  Created by James Wang on 2/18/16.
//  Copyright © 2016 Meltwater. All rights reserved.
//

import UIKit
import WebKit

@objc enum translationState: Int {
    case disabled, off, on
}

struct Constants {
    static let htmlOpenTag:String = "<html>"
    static let htmlCloseTag:String = "</html>"
    static let bodyOpenTag:String = "<body>"
    static let bodyCloseTag:String = "</body>"
    static let divOpenTag:String = "<div>"
    static let divCloseTag:String = "</div>"
    static let cssFont:String = "<style>div {word-break: break-word; font-family: \"HelveticaNeue\", Helvetica; font-size: 28px;}</style>"
}

class FHAWebviewController: UIViewController, UIScrollViewDelegate, UIWebViewDelegate { //WKNavigationDelegate {
    @IBOutlet weak var webViewContainer: UIView!
   // @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    
    @IBOutlet weak var contentBanner: UIView!
    @IBOutlet weak var contentBannerLabel: UILabel!
    
    @IBOutlet weak var topBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomBarConstraint: NSLayoutConstraint!
    
    var webView:WKWebView! = nil
    var mainKeyWindow = UIWindow()
    
    var tagIndexPath:IndexPath?
    var translate:translationState = .disabled
    
    var lastContentOffset:CGFloat = 0.0             // Used to detect scroll gesture to hide the bars
    var barsHidden = false                          // Used for bar hidden state
    var invalidateAllCallbacks = false              // If true, indicates callbacks should do nothing
    var shouldInjectJavaScriptScrollToTop = false   // Set to true only when hosted content is shown
    
    // Use this to get the url (instead of directly from the document)
    var documentUrl: String?
        
 
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.default, animated: false)
        super.viewDidAppear(animated)
        guard let _ = webView else {
            return
        }
       webView.frame = self.view.frame
        // TODO: Show some type of wait state UI while navigator is getting the document?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupWebView(documentUrl)
        super.viewDidLoad()
        myWebView.delegate = self
        if let url = URL(string: documentUrl!) {
            let request = URLRequest(url: url)
            myWebView.loadRequest(request)
        }
    }
    
//    func setupWebView(_ url:URL?) {
//        let webViewConfiguration = WKWebViewConfiguration()
//        webViewConfiguration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypes(rawValue: 0)
//        webView = WKWebView()
//        self.view = webView
////        
////        //        webView = WKWebView(frame: webViewContainer.bounds)
////        webView.scrollView.scrollsToTop = true
////        webView.allowsBackForwardNavigationGestures = true
////        webView.navigationDelegate = self
////        webView.scrollView.delegate = self
//        //Check for the following conditions:
//        // 1) Is the document Hosted & Premium to show the Premium Document Banner
//        // 2) Is the document Hosted but not Premium to show the Hosted Content Banner
//        
////        webView.scrollView.contentInset = UIEdgeInsets(top: contentBanner.frame.height, left: 0, bottom: 0, right: 0)
//        
//        let request = URLRequest(url: url!)
//    
//        webView.load(request)
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        }
//    }

    // MARK: - WKNavigationDelegate functions
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Web view content started loading...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("Web view content loaded.")
        
        // Workaround to a bug that only shows up on the 6 plus.
       
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("Web view content FAILED to load.")
        print("Error: \(error)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("Web view didFailProvisionalNavigation")
        print("Error: \(error)")
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
    }
}


