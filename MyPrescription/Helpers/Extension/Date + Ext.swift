//
//  Date + Ext.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import Foundation

extension Date {
    var convertedDate:Date {

        let dateFormatter = DateFormatter();

        let dateFormat = "dd MMM yyyy";
        dateFormatter.dateFormat = dateFormat;
        let formattedDate = dateFormatter.string(from: self);

        dateFormatter.locale = NSLocale.current;
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00");

        dateFormatter.dateFormat = dateFormat as String;
        let sourceDate = dateFormatter.date(from: formattedDate as String);

        return sourceDate!;
    }
    
    public var dateToFullDayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        
        // Force specific and consistent DateFormatter settings
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(abbreviation: "WIT")
        formatter.locale = Locale(identifier: "id_ID")
        
        return formatter.string(from: self)
    }
    
    public var dateOnlyString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        
        // Force specific and consistent DateFormatter settings
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(abbreviation: "WIT")
        formatter.locale = Locale(identifier: "id_ID")
        
        return formatter.string(from: self)
    }
}
