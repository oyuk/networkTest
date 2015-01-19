//
//  book.swift
//  networkTest
//
//  Created by oky on 2015/01/17.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import UIKit
import Alamofire

class Book: NSObject {
   
    var title:String?
    var titleKana:String?
    var desc:String?
    var author:String?
    var price:Int?
    var salesDate:String?
    var publisherName:String?
    var itemUrl:String?
    var imageUrl:String?
    var image:UIImage?
    

    init(title:String,titleKana:String,desc:String,author:String,price:Int,salesDate:String,publisherName:String,itemUrl:String,imageUrl:String) {
        self.title = title
        self.titleKana = titleKana
        self.desc = desc
        self.author = author
        self.price = price
        self.salesDate = salesDate
        self.publisherName = publisherName
        self.itemUrl = itemUrl
        self.imageUrl = imageUrl
    }
    
    
    //未使用
    subscript(#sectionIndex:Int) -> String {
            switch sectionIndex {
            case 0:
                return "タイトル"
            case 1:
                return "著者"
            case 2:
                return "価格"
            case 3 :
                return "説明"
            case 4 :
                return "出版社"
            case 5 :
                return "発売日"
            default:
                return ""
        }
    }

    
    subscript(cellIndex:Int) -> String {
            switch cellIndex {
            case 0:
                return title!
            case 1:
                return author!
            case 2:
                return "\(price!)円"
            case 3 :
                return desc!
            case 4 :
                return publisherName!
            case 5 :
                return salesDate!
            default:
                return ""
            }
    }
}
