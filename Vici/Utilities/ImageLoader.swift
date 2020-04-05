//
//  ImageLoader.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

/**
 This class is used to load images from remote urls.
 Sources: https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
 */
class ImageLoader {
        
    func downloadImage(from url: URL, completion: ((UIImage?) -> Void)?) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                completion?(UIImage(data: data))
            }
        }
    }
    
    fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
