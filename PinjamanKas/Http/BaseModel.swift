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
        
        if let stringValue = try? container.decode(String.self, forKey: .sinking) {
            sinking = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .sinking) {
            sinking = String(intValue)
        } else {
            sinking = nil
        }
        
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
    var magically: [magicallyModel]?
    var waste: String?
    var speculatively: String?
    var tail: [tailModel]?
    var busied: String?
    var retainer: retainerModel?
    var flinging: [flingingModel]?
    var earth: flingingModel?
    var vera: veraModel?
    var park: veraModel?
    var steering: String?
    var hellos: String?
    var mario: String?
    var forgetting: String?
    var bait: String?
    var swallowed: String?
    var furnishing: [furnishingModel]?
    var rooms: roomsModel?
    var facebook: facebookModel?
}

class facebookModel: Codable {
    var appURLSchemeSuffix: String?
    var appID: String?
    var displayName: String?
    var clientToken: String?
}

class roomsModel: Codable {
    var magically: [magicallyModel]?
}

class furnishingModel: Codable {
    var uptown: String?
    var jump: String?
    var sinking: String?
    var mounted: String?
    var usually: String?
    var offensive: [offensiveModel]?
    var scrambled: String?
    var appear: String?
    
    private enum CodingKeys: String, CodingKey {
        case uptown, jump, sinking, mounted, usually, offensive, scrambled, appear
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        uptown = try decodeStringOrInt(from: container, forKey: .uptown)
        jump = try decodeStringOrInt(from: container, forKey: .jump)
        sinking = try decodeStringOrInt(from: container, forKey: .sinking)
        mounted = try decodeStringOrInt(from: container, forKey: .mounted)
        usually = try decodeStringOrInt(from: container, forKey: .usually)
        scrambled = try decodeStringOrInt(from: container, forKey: .scrambled)
        appear = try decodeStringOrInt(from: container, forKey: .appear)
        
        offensive = try container.decodeIfPresent([offensiveModel].self, forKey: .offensive)
    }
    
    private func decodeStringOrInt(from container: KeyedDecodingContainer<CodingKeys>, forKey key: CodingKeys) throws -> String? {
        if let stringValue = try? container.decode(String.self, forKey: key) {
            return stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: key) {
            return String(intValue)
        } else {
            return nil
        }
    }
}

class offensiveModel: Codable {
    var steering: String?
    var appear: String?
    
    enum CodingKeys: String, CodingKey {
        case steering, appear
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        steering = try container.decodeIfPresent(String.self, forKey: .steering)
        
        if let stringValue = try? container.decode(String.self, forKey: .appear) {
            appear = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .appear) {
            appear = String(intValue)
        } else {
            appear = nil
        }
        
    }
    
}

class veraModel: Codable {
    var cronies: Int?
    var busied: String?
    var acquaintances: acquaintancesModel?
}

class acquaintancesModel: Codable {
    var steering: String?
    var hellos: String?
    var mario: String?
}

class flingingModel: Codable {
    var uptown: String?
    var jump: String?
    var lucrative: String?
    var cronies: Int?
    var interior: String?
}

class magicallyModel: Codable {
    var appear: String?
    var lighter: [lighterModel]?
    var enemy: [magicallyModel]?
    var opponents: [offensiveModel]?
    var steering: String?
    var sinking: String?
    var merrick: String?
    var relationship_title: String?
    var relationship_placeholder: String?
    var contact_title: String?
    var contact_placeholder: String?
    var soldiers: String?
    var view: String?
    var headquarters: String?
    var possibly: Int?
    var rats: String?
    var emerge: String?
    var LoanAmountText: String?
    var moneyContent: String?
    var dateContent: String?
    var irritation: String?
    var soltozzo: String?
}

class lighterModel: Codable {
    var holes: Int?
    var rats: String?
    var emerge: String?
    var soltozzo: String?
    var microphone: String?
    var stalk: String?
    var shadows: String?
    var queer: String?
    var gled: String?
    var gleaming: String?
    var wood: String?
    var deserted: String?
}

class tailModel: Codable {
    var uptown: String?
    var lucas: String?
    var strange: String?
}

class retainerModel: Codable {
    var rats: String?
    var bridge: String?
    var drove: String?
    var beauties: String?
    var land: String?
    var swamplands: String?
    var shipment: String?
    var soltozzo: String?
    var emerge: String?
    var continued: String?
    var meadowbrook: meadowbrookModel?
    
    enum CodingKeys: String, CodingKey {
        case rats,
             bridge,
             drove,
             beauties,
             land,
             swamplands,
             shipment,
             soltozzo,
             meadowbrook,
             continued
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        meadowbrook = try container.decodeIfPresent(meadowbrookModel.self, forKey: .meadowbrook)
        
        continued = try container.decodeIfPresent(String.self, forKey: .continued)
        
        if let stringValue = try? container.decode(String.self, forKey: .rats) {
            rats = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .rats) {
            rats = String(intValue)
        } else {
            rats = nil
        }
        
        if let stringValue = try? container.decode(String.self, forKey: .bridge) {
            bridge = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .bridge) {
            bridge = String(intValue)
        } else {
            bridge = nil
        }
        
        if let stringValue = try? container.decode(String.self, forKey: .drove) {
            drove = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .drove) {
            drove = String(intValue)
        } else {
            drove = nil
        }
        
        if let stringValue = try? container.decode(String.self, forKey: .beauties) {
            beauties = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .beauties) {
            beauties = String(intValue)
        } else {
            beauties = nil
        }
        
        if let stringValue = try? container.decode(String.self, forKey: .land) {
            land = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .land) {
            land = String(intValue)
        } else {
            land = nil
        }
        
        if let stringValue = try? container.decode(String.self, forKey: .swamplands) {
            swamplands = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .swamplands) {
            swamplands = String(intValue)
        } else {
            swamplands = nil
        }
        
        if let stringValue = try? container.decode(String.self, forKey: .shipment) {
            shipment = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .shipment) {
            shipment = String(intValue)
        } else {
            shipment = nil
        }
        
        if let stringValue = try? container.decode(String.self, forKey: .soltozzo) {
            soltozzo = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .soltozzo) {
            soltozzo = String(intValue)
        } else {
            soltozzo = nil
        }
        
    }
    
}

class meadowbrookModel: Codable {
    var toes: toesModel?
    var causeway: toesModel?
}

class toesModel: Codable {
    var uptown: String?
    var merrick: String?
}
