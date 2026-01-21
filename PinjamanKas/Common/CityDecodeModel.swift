//
//  CityDecodeModel.swift
//  PinjamanKas
//
//  Created by hekang on 2026/1/21.
//

import BRPickerView

struct CityDecodeModel {
    static func getAddressModelArray(from dataSourceArr: [magicallyModel]) -> [BRTextModel] {
        return dataSourceArr.enumerated().map { provinceIndex, provinceDic in
            createProvinceModel(from: provinceDic, at: provinceIndex)
        }
    }
    
    private static func createProvinceModel(from provinceDic: magicallyModel, at index: Int) -> BRTextModel {
        let model = BRTextModel()
        model.code = provinceDic.sinking ?? ""
        model.text = provinceDic.steering ?? ""
        model.index = index
        model.children = createCityModels(from: provinceDic.enemy)
        return model
    }
    
    private static func createCityModels(from cityList: [magicallyModel]?) -> [BRTextModel] {
        guard let cityList = cityList else { return [] }
        
        return cityList.enumerated().map { cityIndex, cityDic in
            let model = BRTextModel()
            model.code = cityDic.sinking ?? ""
            model.text = cityDic.steering
            model.index = cityIndex
            model.children = createAreaModels(from: cityDic.enemy)
            return model
        }
    }
    
    private static func createAreaModels(from areaList: [magicallyModel]?) -> [BRTextModel] {
        guard let areaList = areaList else { return [] }
        
        return areaList.enumerated().map { areaIndex, areaDic in
            let model = BRTextModel()
            model.code = areaDic.sinking ?? ""
            model.text = areaDic.steering
            model.index = areaIndex
            return model
        }
    }
}

class CitysModel {
    static let shared = CitysModel()
    
    private init() {}
    
    var modelArray: [magicallyModel]?
}
