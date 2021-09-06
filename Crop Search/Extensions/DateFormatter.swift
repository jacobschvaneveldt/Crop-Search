//
//  DateFormatter.swift
//  Crop Search
//
//  Created by Jacob Schvaneveldt on 9/5/21.
//

import Foundation

extension DateFormatter {
    
    static let deviceTime: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
        
    }()
}//End of extension
