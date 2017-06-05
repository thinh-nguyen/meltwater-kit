//
//  WebViewController.swift
//  Meltwater Mobile
//
//  Created by James Wang on 2/18/16.
//  Copyright © 2016 Meltwater. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

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
    @IBOutlet weak var socialEchoView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var fbCount: UILabel!
    @IBOutlet weak var twitterCount: UILabel!
    @IBOutlet weak var linkInCount: UILabel!
    
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
    var body: String?
    
    let urlString = "https://api-sbox.fairhair.ai/insights/v1/b63054db6ca1240e8484a8d4cbbb44f4/workflows/86b17f69-f8d7-4a4c-af76-768e1535b2fb/jobs/api_b63054db6ca1240e8484a8d4cbbb44f4"
    
    
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
            loadAI1()
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
    
    func loadAI1() {
        
        let payload = ["text": documentUrl!]
        //let urlString = "https://api-sbox.fairhair.ai/insights/v1/b63054db6ca1240e8484a8d4cbbb44f4/workflows/86b17f69-f8d7-4a4c-af76-768e1535b2fb/jobs/api_b63054db6ca1240e8484a8d4cbbb44f4"
        Alamofire.request(
            URL(string: "\(urlString)")!,
            method: .post,
            parameters: payload)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                let docId = value["docID"] as? String else {
                    print("Malformed data received from fetchAllRooms service")
                    return
                }
            self.loadAI2(docId: docId)
                
        }
        
        Alamofire.request(urlString, method: .post, parameters: payload, encoding: JSONEncoding.default, headers: RestClient.headers)
        .validate().responseObject { (response: DataResponse<SocialEcho>) in
            switch response.result {
            case .success(let obj):
                DispatchQueue.main.async {
                    print(obj)
                    //self.documentsHandler?.onDocumentsRetrieved(documents: page.documents)
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    //self.documentsHandler?.onDocumentsRetrieved(documents: page.documents)
                }

            }
        }

        RestClient.getFromUrl(urlString: "https://api-sbox.fairhair.ai/insights/v1/b63054db6ca1240e8484a8d4cbbb44f4/workflows/9c03b168-6932-4118-b5b7-304869314d3c/jobs/api_b63054db6ca1240e8484a8d4cbbb44f4/results/0337f4f0-4ca6-402d-99cf-725759dc8e5d", parameters: payload)
            .then { page -> Void in // Return Void to stop the promise chain
                DispatchQueue.main.async {
                    print(page)
                    //self.documentsHandler?.onDocumentsRetrieved(documents: page.documents)
                }
            }
            .catch { error in
                print(error)
                //self.documentsHandler?.onError(errorMsg: error.localizedDescription)
        }
    }
    
    func loadAI2(docId: String) {
        let url2:String = "\(urlString)/results/937e3757-43eb-409e-a82d-5ebae695d877/\(docId)"
        Alamofire.request(
            URL(string: url2)!,
            method: .get)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                        print("Malformed data received from fetchAllRooms service")
                        return
                }
        
                let a1 = value["metadata"] as! [String: Any]
                let a2 = a1["enrichments"] as! [String: Any]
                let a3 = a2["fhaiSocialEcho"] as! [String: Any]
                let a4 = a3["facebook"] as! [String: Any]
                self.fbCount.text = a4["shares"] as? String
                
                let b4 = a3["twitter"] as! [String: Any]
                self.twitterCount.text = b4["shares"] as? String
                
                let c4 = a3["twitter"] as! [String: Any]
                self.linkInCount.text = c4["shares"] as? String

                
        }

    }

}

//curl -X POST -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRoaW5oLm5ndXllbkBtZWx0d2F0ZXIuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOi8vZmhhaS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTU3MDgwNjk4NjA1MTcwNTU2NjIiLCJhdWQiOiJQTk9aV3AyNXc1VUNQNjNDd3MwRkprbTFiU090NGRiUCIsImV4cCI6MTQ5MTY0OTE2NSwiaWF0IjoxNDkxNjEzMTY1fQ.C_LdDIGvf6bza4NtT16l_oOqLvWKIGT64ipq5Mrd2oA" -d '{"text":"http://meltwater.com"}' https://api-sbox.fairhair.ai/insights/v1/b63054db6ca1240e8484a8d4cbbb44f4/workflows/a660bee9-65e9-41ad-a046-0062844916da/jobs/api_b63054db6ca1240e8484a8d4cbbb44f4
//
//curl -X GET -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRoaW5oLm5ndXllbkBtZWx0d2F0ZXIuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOi8vZmhhaS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTU3MDgwNjk4NjA1MTcwNTU2NjIiLCJhdWQiOiJQTk9aV3AyNXc1VUNQNjNDd3MwRkprbTFiU090NGRiUCIsImV4cCI6MTQ5MTY0OTE2NSwiaWF0IjoxNDkxNjEzMTY1fQ.C_LdDIGvf6bza4NtT16l_oOqLvWKIGT64ipq5Mrd2oA" https://api-sbox.fairhair.ai/insights/v1/b63054db6ca1240e8484a8d4cbbb44f4/workflows/a660bee9-65e9-41ad-a046-0062844916da/jobs/api_b63054db6ca1240e8484a8d4cbbb44f4/results/37e26457-3523-4bf9-8305-95b16dfd7cf4
//
//curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRoaW5oLm5ndXllbkBtZWx0d2F0ZXIuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOi8vZmhhaS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTU3MDgwNjk4NjA1MTcwNTU2NjIiLCJhdWQiOiJQTk9aV3AyNXc1VUNQNjNDd3MwRkprbTFiU090NGRiUCIsImV4cCI6MTQ5MTY0OTE2NSwiaWF0IjoxNDkxNjEzMTY1fQ.C_LdDIGvf6bza4NtT16l_oOqLvWKIGT64ipq5Mrd2oA" https://api-sbox.fairhair.ai/insights/v1/b63054db6ca1240e8484a8d4cbbb44f4/workflows/86b17f69-f8d7-4a4c-af76-768e1535b2fb/jobs/api_b63054db6ca1240e8484a8d4cbbb44f4/results/937e3757-43eb-409e-a82d-5ebae695d877
