//
//  PackageTariff.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 23.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

struct PackageTariff: Decodable {
    var data: Int = 0
    var talk: Int = 0
    var sms: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case data
        case talk
        case sms
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let data = Int(try container.decode(String.self, forKey: .data)),
            let talk = try Int(container.decode(String.self, forKey: .talk)),
            let sms = try Int(container.decode(String.self, forKey: .sms))
        {
            self.data = data
            self.talk = talk
            self.sms = sms
        }

    }
}
