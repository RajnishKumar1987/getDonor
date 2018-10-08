//
//  DownloadingQueue.swift
//  GetDonor
//
//  Created by admin on 06/10/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class DownloadingQueue {
    static let sharedInstance = DownloadingQueue()
    var downloadQueue = [String]()
    
    func add(id: String) {
        downloadQueue.append(id)
    }
    func remove(id: String) {
        if let index = downloadQueue.index(of: id) {
            downloadQueue.remove(at: index)
        }    }
    func isDownloading(id: String) -> Bool {
        if downloadQueue.contains(id) {
            return true
        }
        return false
    }
}
