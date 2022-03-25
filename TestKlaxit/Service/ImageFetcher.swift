//
//  ImageFetcher.swift
//  TestKlaxit
//
//  Created by Pierre Corsenac on 24/03/2022.
//

import Foundation
import UIKit

class ImageFetcher {
    static let shared = ImageFetcher()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    public func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: NSString(string: "ProfileImage")) {
            completion(image)
            return
        }
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self?.cache.setObject(image, forKey: NSString(string: "ProfileImage"))
                completion(image)
            }
        }
        task.resume()
    }
}
