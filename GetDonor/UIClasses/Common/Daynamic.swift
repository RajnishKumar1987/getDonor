//
//  Daynamic.swift
//  BaseVCDemo
//
//  Created by Rajnish kumar on 05/10/18.
//  Copyright © 2018 Zee. All rights reserved.
//

import Foundation


class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    
    init(v: T) {
        self.value = v
    }
    
    
    
}
