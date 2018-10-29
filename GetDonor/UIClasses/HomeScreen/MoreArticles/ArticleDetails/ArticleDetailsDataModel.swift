//
//  ArticleDetailsDataModel.swift
//  GetDonor
//
//  Created by admin on 25/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

struct ArticleDetailsDataModel: Codable {
    var error: Int8?
    var message: String?
    var node: ContentDataModel?
}
