//
//  MediaAPI.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MediaAPI {
    func create(image: UIImage, success successHandler: @escaping (String)->Void, error errorHandler: @escaping (String)->Void) {
        let headers = ["Accept": "application/json"]
        let URL = try! URLRequest(url: "http://delivery-service-api.appspot.com/v1/media/?async=true", method: .post, headers: headers)
        Alamofire.upload(multipartFormData: {
            multipartFormData in
            multipartFormData.append(UIImageJPEGRepresentation(image, 0.5)!, withName: "file", fileName: "file", mimeType: "image/jpeg")
        }, with: URL, encodingCompletion: {
            result in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseSwiftyJSON({
                    response in
                    
                    if let e = response.result.error as? NSError {
                        errorHandler("CREATE media: error \(e.domain) \(e.code): \(e.localizedDescription)")
                        return
                    }
                    
                    if response.response?.statusCode != 200 && response.response?.statusCode != 202 {
                        errorHandler("CREATE media: bad response status code \(response.response?.statusCode)")
                        return
                    }
                    
                    let json : JSON = response.result.value!
                    if let hash = json["hash"].string {
                        successHandler(hash)
                    } else {
                        errorHandler("CREATE media error: NO HASH")
                    }
                })
            case .failure( _):
                errorHandler("error while encoding media")
            }            
        })
    }
}
