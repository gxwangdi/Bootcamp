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
    var refreshControl: UIRefreshControl!;
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = self.movies
        {
            return movies.count;
        } else {
            return 0;
        }
    }// end of tableView->Int

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("tableView cells:\(indexPath.row)");
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoTableViewCell
        
        // Configure YourCustomCell using the outlets that you've defined.
        if let movie = self.movies?[indexPath.row] {
            let title = movie["title"] as? String;
            let synopsis = movie["overview"] as? String;
            
            if let posterPath = movie["poster_path"] as? String {
//                let posterURL = URL(string: GlobalConstants.Image_Base_Url + posterPath);
                let posterURL = URL(string: GlobalConstants.IMAGE_LOW_RESOLUTION_URL + posterPath);
                cell.posterView.setImageWith(posterURL!);
            }
            
            cell.titleLabel.text = title;
            cell.synopsisLabel.text = synopsis;
//            print(movie)
        }
        return cell
    }// end of tableView->UITableViewCell    
    
    func fetchImageFor(ImageView:UIImageView, atPath:String) {
        let lowUrl = URL(string: GlobalConstants.IMAGE_HIGH_RESOLUTION_URL + atPath);
        //        let Request = URLRequest(url: lowUrl!);
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        let task = session.dataTask(with: lowUrl!) { (data, response, error) in
            print("fetchImageTask.completionHandler.");
            // No need to get large pic for main menu.
//            let posterURL = URL(string: GlobalConstants.IMAGE_HIGH_RESOLUTION_URL + atPath);
//            ImageView.setImageWith(posterURL!);
            
            if let e = error {
                self.showToast(message: "Network Error.")
                print("Error downloading cat picture: \(e)")
                return;
            }
            if let imageData = data {
                //TODO(gxwangdi):Add fade-in animation here.
                ImageView.image = UIImage(data: imageData)
            }
        }
        task.resume();
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTableView.delegate = self
        photoTableView.dataSource = self
        
        initNavBar();
        initUI();
        
        initData()
    }
    
    func initNavBar() {
        if let navBar = self.navigationController?.navigationBar {
            navBar.barStyle = UIBarStyle.blackTranslucent;
            navBar.tintColor = UIColor.white;
            navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.yellow]
        }
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
//        initNavBar();
    }
    
    func initUI() {
        refreshControl = UIRefreshControl();
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to update");
        refreshControl.addTarget(self, action: #selector(PhotosViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged);
        photoTableView.insertSubview(refreshControl, at: 0);
    }
    
    func getDateString() -> NSAttributedString {
        let now = Date();
        let updateString = "Last Update At " + String(describing: now);
        return NSAttributedString(string: updateString);
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing();
        
        self.refreshControl.attributedTitle = getDateString();
        
        let urlStr = "\(GlobalConstants.API_url)\(endpoint!)?api_key=\(GlobalConstants.API_KEY)";
        print(urlStr)
        let url = URL(string:urlStr);
        var request = URLRequest(url: url!)
        // For debugging network error only.
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData;
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                
                if error != nil {
                    self.showToast(message: "Network Error.");
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
                if (self.refreshControl.isRefreshing) {
                    refreshControl.endRefreshing();
                }
        });
        task.resume();
    }

    func initData() {
        let urlStr = "\(GlobalConstants.API_url)\(endpoint!)?api_key=\(GlobalConstants.API_KEY)";
        print(urlStr)
        let url = URL(string:urlStr);
        var request = URLRequest(url: url!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData;
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                
                if error != nil {
                    self.showToast(message: "Network Error.");
                    print("Network error.");
                    return;
                }
                
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
//                      print("responseDictionary: \(responseDictionary)")
                        
                        self.movies = responseDictionary["results"] as? [NSDictionary];
                        
                        self.photoTableView.reloadData();
                    }
                }
        });
        task.resume()
    }
    
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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














