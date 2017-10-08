//
//  Icons.swift
//  OTOT_Ver_1
//
//  Created by admin on 2017. 10. 7..
//  Copyright © 2017년 admin. All rights reserved.
//

import Foundation
import UIKit


enum Icons: Int {
    case bag = 0
    case brain
    case cat
    case glasses
    case key
    case wallet
    
    func image() -> UIImage? {
        return UIImage(named: "\(self.name())")
    }
    
    func name() -> String {
        switch self {
        case .bag: return "Number 0"
        case .brain: return "Number 1"
        case .cat: return "Number 2"
        case .glasses: return "Number 3"
        case .key: return "Number 4"
        case .wallet: return "Number 5"
        }
    }
    
    static func icon(forTag tag: Int) -> Icons {
        return Icons(rawValue: tag) ?? .bag
    }
    
    static let allIcons: [Icons] = {
        var all = [Icons]()
        var index: Int = 0
        while let icon = Icons(rawValue: index) {
            all += [icon]
            index += 1
        }
        return all.sorted { $0.rawValue < $1.rawValue }
    }()
}
