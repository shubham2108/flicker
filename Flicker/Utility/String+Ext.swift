//
//  String+Ext.swift
//  Flicker
//
//  Created by Shubham Choudhary on 15/09/17.
//  Copyright © 2017 Shubham Choudhary. All rights reserved.
//

import Foundation

extension String {
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
