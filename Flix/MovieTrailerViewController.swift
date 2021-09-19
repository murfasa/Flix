//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by Murtaza Ali on 9/19/21.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {

    var movieId: Int!
    
    var movieTrailers = [[String:Any]]()
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=70d8429f9ce4fb073b70b18d7a617875
        // https://www.youtube.com/watch?v= + key
        
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/" + String(movieId!) + "/videos?api_key=70d8429f9ce4fb073b70b18d7a617875")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                self.movieTrailers = dataDictionary["results"] as! [[String:Any]]
                
               // self.webView.reload()
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
        
        let key = movieTrailers[1]["key"] as! String
        let videoURL = URL(string: "https://www.youtube.com/watch?v=" + key)
        let videoRequest = URLRequest(url: videoURL!)
        webView.load(videoRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
