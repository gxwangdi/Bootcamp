//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Di Wang on 9/13/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // IBOutlets
    @IBOutlet weak var photoTableView: UITableView!
    
    // Vars
    var movies: [NSDictionary]?;
    var endpoint: String!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = self.movies
        {
            return movies.count;
        } else {
            return 0;
        }
    }// end of tableView->Int

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView cells:\(indexPath.row)");
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoTableViewCell
        
        // Configure YourCustomCell using the outlets that you've defined.
        if let movie = self.movies?[indexPath.row] {
            let title = movie["title"] as? String;
            let synopsis = movie["overview"] as? String;
            
            if let posterPath = movie["poster_path"] as? String {
//                let posterURL = URL(string: GlobalConstants.API_url + posterPath + "?api_key=" + GlobalConstants.API_KEY);
                let posterURL = URL(string: GlobalConstants.Image_Base_Url + posterPath);
                cell.posterView.setImageWith(posterURL!);
            }
            
            cell.titleLabel.text = title;
            cell.synopsisLabel.text = synopsis;
            print(movie)
        }
        return cell
    }// end of tableView->UITableViewCell    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTableView.delegate = self
        photoTableView.dataSource = self
        
        initPosts()
    }

    func initPosts() {
        let urlStr = "\(GlobalConstants.API_url)\(endpoint!)?api_key=\(GlobalConstants.API_KEY)";
        print(urlStr)
        let url = URL(string:urlStr);
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("Network error.");
                    return;
                }
                
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
//                        print("responseDictionary: \(responseDictionary)")
                        
                        self.movies = responseDictionary["results"] as? [NSDictionary];
                        
                        self.photoTableView.reloadData();
                    }
                }
        });
        task.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell;
        let indexPath = photoTableView.indexPath(for: cell);
        let movie = movies?[indexPath!.row];
        print("prepare for segue called. \nmovie:\(String(describing: movie))")
        
        let detailViewController = segue.destination as! DetailViewController;
        detailViewController.movie = movie;
    }
}














