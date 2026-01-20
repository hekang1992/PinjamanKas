//
//  BaseModel.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/20.
//

class BaseModel: Codable {
    var strangler: String?
    var sinking: String?
    var sagged: saggedModel?
    
    enum CodingKeys: String, CodingKey {
        case strangler
        case sinking
        case sagged
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strangler = try container.decodeIfPresent(String.self, forKey: .strangler)
        sinking = try container.decodeIfPresent(String.self, forKey: .sinking)
        if let model = try? container.decode(saggedModel.self, forKey: .sagged) {
            sagged = model
        } else if let _ = try? container.decode([saggedModel].self, forKey: .sagged) {
            sagged = nil
        } else {
            sagged = nil
        }
    }
}

class saggedModel: Codable {
    var petes: String?
}
