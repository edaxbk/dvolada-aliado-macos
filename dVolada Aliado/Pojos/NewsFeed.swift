//
//  NewsFeed.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 24/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation

class NewsFeed: Decodable , Encodable{
    
    var _id: String?
        
    var date_created : Int64?
    
    var type: String?
    
    var state: String?
    
    var store: StorePost?
        
    var isAvailable: Bool?
    
    var content: String?
    
    var numComments: Int?
    
    var numLike: Int?
    
    var media: Array<Media>?
}

class NewsFeedResponse : Decodable , Encodable {
    
    var result: Array<NewsFeed>?
    
}

class StorePost : Decodable , Encodable{
    
    var _id: String?
    
    var name: String?

    var url_logo: String?

}


class Media: Decodable , Encodable{
    
    var url: String?
    
    var isAvailable: Bool?
    
}

class CommentFeed: Decodable , Encodable {
    
    var date_created: Int?
    
    var _id: String?
    
    var newId: String?
    
    var userId: String?
    
    var gender: String?
    
    var userName: String?
    
    var profile_url: String?
    
    var comment: String?
    
}

class NewComment: Decodable , Encodable {
    
    var comment: String?
    
    var userId: String?
    
    var newId: String?
    
    var date_created: Int?
    
}
    
