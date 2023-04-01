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
}
