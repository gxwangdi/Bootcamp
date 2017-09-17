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
    
    var movie: NSDictionary?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detailViewControler.movie:\(String(describing: movie))")
        // Do any additional setup after loading the view.
        initUI();
    }
    
    func initUI() {
        if let title = movie?["title"] as? String {
//            titleLable.text = "\(title)";
            titleLable.text = title;
        }
        if let overview = movie?["overview"] as? String {
//            overviewLable.text = "\(overview)";
            overviewLable.text = overview;
        }
        if let posterPath = movie?["poster_path"] as? String {
//            let posterURL = URL(string: GlobalConstants.API_url + posterPath + "?api_key=" + GlobalConstants.API_KEY);
            let posterURL = URL(string: GlobalConstants.Image_Base_Url + posterPath);
            posterImageView.setImageWith(posterURL!);
        }
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
