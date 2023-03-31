//
//  Data + Ext.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 31/03/23.
//

import Foundation

extension Data {
    
    var html2AttributedString: NSMutableAttributedString? {
        do {
            return try NSMutableAttributedString(data: self,
                                                 options: [.documentType: NSMutableAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSMutableAttributedString? {
        Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
