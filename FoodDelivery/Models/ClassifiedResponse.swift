//
//  ClassifiedResponse.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

// Classified Response Model
class ClassifiedResponse : Codable {
    let results : [ClassifiedProduct]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case results = "results"
        case pagination = "pagination"
    }

    init() {
        results = [ClassifiedProduct]()
        pagination = Pagination()
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([ClassifiedProduct].self, forKey: .results)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }

}

// Results Model


// Pagination Model
class Pagination : Codable {
    let key : String?

    init() {
        key = ""
    }
    
    enum CodingKeys: String, CodingKey {

        case key = "key"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self, forKey: .key)
    }

}


//class DummyResults: NSObject {
//
//    @objc
//    class func getDummyResults() -> [ClassifiedProduct] {
//        let dummyData = """
//    {"created_at":"2019-02-24 04:04:17.566515","price":"AED 5","name":"Notebook","uid":"4878bf592579410fba52941d00b62f94","image_ids":["9355183956e3445e89735d877b798689"],"image_urls":["https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689?AWSAccessKeyId=ASIASV3YI6A46UEMS2H6&Signature=8a%2BsY6PWrs014YPHUIb78tE9pZM%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEPf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIBBIjKHg6L9tuPns7IfsYW%2BGPyuEFFKIO3spvpI5i2uDAiEAvo19BQlUTNEdNNCBLZErH2iyyLtWFvPh9nN8%2Fjg0UhAq1wEIn%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARACGgwxODQzOTg5NjY4NDEiDGxQa6Sx%2Fs1Nr%2F7FVyqrAcVzBD4ISXoYWrMTu74vAwlsPnW7wnyDcNLKRkQWVx2JJI9%2FCRY66aEB3lEg0cOsyirBLuXw10iUghkrfPg4U7RK4xL%2FO%2FLbjLG0UYqvhNHMxYDvC6M0TlFXt%2BzuzLGT%2FVC15G%2BS3Pz%2F%2BqeqY2LWUK9ldf%2FHMBBvS4%2Fj8W0IFljWUPco%2FHX0WBNTGB2hNXgPeCdeKICxxWBZISyPksKEaGGu9dBwYTG%2BmgX%2F%2FzC0nIb%2FBTrgAdQEi7MZof%2F4Fn9BLXr1KUpZloc0BIspuhTdOsRRmRjPs91E6Uy91qFfoOPlO4ukE86flUyTrkrW549naJPGPGiH9KG1Z3Udihv3JNOvH2IvTJwtUmkGk2K0JJ%2Bi%2Bb3v7l%2BTh%2F8PgTEZXaS7DIiKTXwv%2Bs%2F0BlnfyQFP6Wewl2WWGcAbczj2OAJq2VXop5GfTKza4w9pdDrvThxECwvEf%2BO8pg90lFXpl1K%2BO9ZWmieKN0ZD01J%2BGvenVQtnYumej8v6pcUwa8kiPggcqNRRWHaDz4w4PfZwJWc2nDFRxuS%2B&Expires=1608621127"],"image_urls_thumbnails":["https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689-thumbnail?AWSAccessKeyId=ASIASV3YI6A46UEMS2H6&Signature=6xgFcM1g%2Fy39%2FOk0d5jJe3%2BXjHk%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEPf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIBBIjKHg6L9tuPns7IfsYW%2BGPyuEFFKIO3spvpI5i2uDAiEAvo19BQlUTNEdNNCBLZErH2iyyLtWFvPh9nN8%2Fjg0UhAq1wEIn%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARACGgwxODQzOTg5NjY4NDEiDGxQa6Sx%2Fs1Nr%2F7FVyqrAcVzBD4ISXoYWrMTu74vAwlsPnW7wnyDcNLKRkQWVx2JJI9%2FCRY66aEB3lEg0cOsyirBLuXw10iUghkrfPg4U7RK4xL%2FO%2FLbjLG0UYqvhNHMxYDvC6M0TlFXt%2BzuzLGT%2FVC15G%2BS3Pz%2F%2BqeqY2LWUK9ldf%2FHMBBvS4%2Fj8W0IFljWUPco%2FHX0WBNTGB2hNXgPeCdeKICxxWBZISyPksKEaGGu9dBwYTG%2BmgX%2F%2FzC0nIb%2FBTrgAdQEi7MZof%2F4Fn9BLXr1KUpZloc0BIspuhTdOsRRmRjPs91E6Uy91qFfoOPlO4ukE86flUyTrkrW549naJPGPGiH9KG1Z3Udihv3JNOvH2IvTJwtUmkGk2K0JJ%2Bi%2Bb3v7l%2BTh%2F8PgTEZXaS7DIiKTXwv%2Bs%2F0BlnfyQFP6Wewl2WWGcAbczj2OAJq2VXop5GfTKza4w9pdDrvThxECwvEf%2BO8pg90lFXpl1K%2BO9ZWmieKN0ZD01J%2BGvenVQtnYumej8v6pcUwa8kiPggcqNRRWHaDz4w4PfZwJWc2nDFRxuS%2B&Expires=1608621127"]}
//    """
//        
//        var results = [ClassifiedProduct]()
//        
//        for _ in 1..<10 {
//            do {
//                let data = Data(dummyData.utf8)
//                let dummyResult = try JSONDecoder().decode(ClassifiedProduct.self, from: data)
//                
//                let name = dummyResult.name ?? ""
//                dummyResult.name = "\(name) \(Int.random(in: 1..<99))";
//                let price = dummyResult.price ?? ""
//                dummyResult.price = "\(price) \(Int.random(in: 1..<99))";
//                
//                results.append(dummyResult)
//            } catch {
//                print("Error while parsing Classified Items response")
//            }
//        }
//        
//        return results
//    }
//}
