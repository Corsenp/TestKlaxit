//
//  Service.swift
//  TestKlaxit
//
//  Created by Pierre Corsenac on 25/03/2022.
//

import Foundation

class Service {
    func readLocalProfile(forName name:String) -> LocalProfile? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return parseJsonData(jsonData: jsonData)
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parseJsonData(jsonData: Data) -> LocalProfile? {
        do {
            let decodedData = try JSONDecoder().decode(LocalProfile.self,
                                                       from: jsonData)
            
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
    
    func fetchGeoData(url: String, completion: @escaping (Geo) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Geo.self, from: data)
                completion(json)
            } catch {
                print(error.self)
                print("failed to JSON DECODE \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}
