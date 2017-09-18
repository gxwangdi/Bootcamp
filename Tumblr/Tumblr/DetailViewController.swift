//
//  DetailViewController.swift
//  Tumblr
//
//  Created by Di Wang on 9/17/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var overviewLable: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var infoView: UIView!
    
    var movie: NSDictionary?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detailViewControler.movie:\(String(describing: movie))")
        // Do any additional setup after loading the view.
        initUI();
    }
    
    @IBAction func OnBackPressed(_ sender: Any) {
        print("Detail View Back Pressed.");
        self.navigationController?.popViewController(animated: true);
    }
    
    func initNavBar() {
        if let navBar = self.navigationController?.navigationBar {
            navBar.barStyle = UIBarStyle.blackTranslucent;
            navBar.tintColor = UIColor.white;
            navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.yellow]
        }
    }
    
    func initUI() {
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: infoView.frame.origin.y + infoView.frame.size.height);
        
        if let title = movie?["title"] as? String {
            titleLable.text = title;
            self.title = title;
        }
        if let overview = movie?["overview"] as? String {
            overviewLable.text = overview;
            overviewLable.sizeToFit();
        }
        if let posterPath = movie?["poster_path"] as? String {
//            let posterURL = URL(string: GlobalConstants.Image_Base_Url + posterPath);
//            let posterURL = URL(string: GlobalConstants.IMAGE_HIGH_RESOLUTION_URL + posterPath);
//            posterImageView.setImageWith(posterURL!);
            fetchImageFor(ImageView: posterImageView, atPath: posterPath);
        }
        initNavBar();
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
            let posterURL = URL(string: GlobalConstants.IMAGE_HIGH_RESOLUTION_URL + atPath);
            ImageView.setImageWith(posterURL!);
            
            if let e = error {
                self.showToast(message: "Network Error.")
                print("Error downloading cat picture: \(e)")
                return;
            }
            if let imageData = data {
                ImageView.image = UIImage(data: imageData)
                
            }
        }
        task.resume();
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
