//
//  Books.swift
//  networkTest
//
//  Created by oky on 2015/01/18.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import UIKit
import Alamofire

protocol BooksDelegate{
    func reloadTableViewData()
}

class Books:NSObject,UITableViewDataSource{
    
    var booksDelegate:BooksDelegate?
    
    private var books:[Book] = [] {
        didSet{
            booksDelegate?.reloadTableViewData()
        }
    }
    
    class var sharedInstance:Books {
        struct Static {
            static let instance = Books()
        }
        return Static.instance
    }
    
    
    func apiRequest(searchString:String){
        
        Alamofire.request(Router.TITLE(searchString))
            .responseJSON { (_,_, data, error) in
                
                if error == nil {
                    
                    let json = JSON(data!)
                    var tempBooks:[Book] = []
                    
                    for elem in json[param.ITEMS] {
                        
                        let title = elem.1[param.ITEM][param.TITLE].asString!
                        let titleKana = elem.1[param.ITEM][param.TITLE_KANA].asString!
                        let desc = elem.1[param.ITEM][param.ITEM_CAPTION].asString!
                        let author = elem.1[param.ITEM][param.AUTHOR].asString!
                        let price = elem.1[param.ITEM][param.PRICE].asInt!
                        let salesDate = elem.1[param.ITEM][param.SALES_DATE].asString!
                        let publisherName = elem.1[param.ITEM][param.PUBLISHER_NAME].asString!
                        let itemUrl = elem.1[param.ITEM][param.ITEM_URL].asString!
                        let imageUrl = elem.1[param.ITEM][param.LARGE_IMAGE_URL].asString!
                        
                        let book = Book(title: title, titleKana: titleKana, desc: desc, author: author, price: price, salesDate: salesDate, publisherName: publisherName,itemUrl:itemUrl, imageUrl: imageUrl)
                        
                        tempBooks.append(book)
                    }

                    self.books = tempBooks
                }
            }
    }

    
    // MARK: - Table View
    
    
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return books.count
        }
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
            var cell:CustomCell = tableView.dequeueReusableCellWithIdentifier(Cell.reuseIdentifier,forIndexPath: indexPath) as CustomCell
    
            let book = books[indexPath.row]
    
            cell.titleLabel.text = book.title
            cell.authorLabel.text = book.author
            cell.publisherNameLabel.text = book.publisherName
            cell.priceLabel.text = "\(book.price!)円"
            
            let imageurl = NSURL(string: book.imageUrl!)

               //MARK: これを使いたいけどエラーがでる
//            cell.bookImageView.sd_setImageWithURL(imageurl, placeholderImage: nil, options: SDImageCacheType.Memory)
            cell.bookImageView.sd_setImageWithURL(imageurl, placeholderImage: nil)


            
//           cell.request =  Alamofire.request(.GET,book.imageUrl!)
//            .response() { (request,_, data,error) in
//                
//                if error == nil && data != nil {
//                    if request.URLString == cell.request?.request.URLString {
//
//                        dispatch_async(dispatch_get_main_queue()) { () in
//                            let image = UIImage(data: data as NSData)
//                            cell.bookImageView.image = image
//                        }
//                    }
//                    
//                }
//            }
            
            return cell
        }

       
    func getAllbooks() ->[Book]{
        return books
    }
    
   }
