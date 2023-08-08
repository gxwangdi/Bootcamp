//
//  GlobalConstants.swift
//  Tumblr
//
//  Created by Di Wang on 9/17/17.
//  Copyright © 2017 Di Wang. All rights reserved.
//

import UIKit

class GlobalConstants: NSObject {

    static let API_KEY = "a07e22bc18f5cb106bfe4cc1f83ad8ed";
    
    static let API_url = "https://api.themoviedb.org/3/movie/";
    
    static let Image_Base_Url = "https://image.tmdb.org/t/p/w500/"; // deprecated
    //TODO(gxwangdi): hard code 150/500 for now, need to implement configuration API (https://developers.themoviedb.org/3/configuration/get-api-configuration)
    static let IMAGE_LOW_RESOLUTION_URL = "https://image.tmdb.org/t/p/w150/";
    static let IMAGE_HIGH_RESOLUTION_URL = "https://image.tmdb.org/t/p/w500/";
    
    static let API_nowplaying = "now_playing";
    static let API_toprated = "top_rated";
}
