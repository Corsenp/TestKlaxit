//
//  Extension+String.swift
//  TestKlaxit
//
//  Created by Pierre Corsenac on 25/03/2022.
//

import Foundation

extension String {
    func convertToQuery(string: String) -> String {
        let result = string.replacingOccurrences(of: " ", with: "+")
        return result
    }
}
