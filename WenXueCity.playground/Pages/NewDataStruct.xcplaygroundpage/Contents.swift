//
//  wxcItems.swift
//  NewsReader
//
//  Created by Conan on 17/12/15.
//  Copyright © 2015年 Conan. All rights reserved.
//

import Foundation


/**
 *  List Item, info for each item in list
 */
class WxcItems : Comparable {
    var postId : Int = 0
    var title: String = ""
    var time : String = ""
    
    private enum ItemLable : String {
        case postid  = "postid"
        case subid     = "subid"
        case title   = "title"
        case dateline     = "dateline"
        case datetime   = "datetime"
        case count  = "count"
        case images  = "images"
        case author  = "author"
        case content     = "content"
        case basecode  = "basecode"
        case comment    = "comment"
        case usr   = "username"
        case usrface   = "userface"
        case url   = "url"
        case previous  = "previous_news"
        case next  = "next_news"
    }
    
    init? (fromdict dict: [ String: AnyObject ]?){
        //dict
        guard dict != nil else{
            return nil
        }
    }
    
    private func checkDataAviliable(fromdict dict: [ String: AnyObject ], musthave must: ItemLable...) -> Bool {
        let hasKeys = dict.keys
        var ret = true
        must.forEach({ret = ret && hasKeys.contains($0.rawValue)})
        return ret
    }
    
    private func refresh < T1, T2 > (inout target: T1, value : T2?){
        let test = value as? T1
        target = ((test == nil) ? target : (test!))
    }
}



// List Item, info for each item in list
class WxcListItem : WxcItems {
    var count : Int = 0
    var images : Array<String> = []
    
    override init? (fromdict dict: [ String: AnyObject ]?){
        super.init(fromdict: dict)
        if !checkDataAviliable(fromdict: dict!, musthave: .postid, .title, .dateline, .count) {
            //printf("No data needed")
            return nil
        }
        dict!.forEach({
            switch $0.0 {
            case ItemLable.postid.rawValue :    refresh(&postId, value: $0.1.integerValue)
            case ItemLable.title.rawValue :         refresh(&title, value: $0.1)
            case ItemLable.dateline.rawValue :  refresh(&time, value: $0.1)
            case ItemLable.count.rawValue :     refresh(&count, value: $0.1.integerValue)
            case ItemLable.images.rawValue :    refresh(&images, value: $0.1)
            default: break
            }
        })
        return
    }
}

/// Post Comment Item
class WxcPostComment  : WxcItems{
    var usrface : String = ""
    var usr : String     = "NO-NAME"
    var content : String = ""
    
    override init? (fromdict dict: [ String: AnyObject ]?){
        dict
        super.init(fromdict: dict)
        if !checkDataAviliable(fromdict: dict!, musthave: .postid,  .dateline, .usr) {
            //printf("No data needed")
            return nil
        }
        
        dict!.forEach({
            switch $0.0 {
            case ItemLable.postid.rawValue :    refresh(&postId, value: $0.1.integerValue)
            case ItemLable.content.rawValue :   refresh(&content, value: $0.1)
            case ItemLable.dateline.rawValue :  refresh(&time, value: $0.1)
            case ItemLable.usr.rawValue :           refresh(&usr, value: $0.1)
            case ItemLable.usrface.rawValue :   refresh(&usrface, value: $0.1)
            default: break
            }
        })
        return
    }
}

// Post Item, info about every post
class WxcPostItem : WxcItems {
    var content : String       = ""
    var url : String           = ""
    var subid : String         = "news"
    var author : String        = "UNKNOWN"
    var basecode : Int         = 0
    var previous : Int         = 0
    var next : Int             = 0
    var count : Int            = 0
    var images : Array<String> = []
    var comment : Array<WxcPostComment> = []
    
    override init? (fromdict dict: [ String: AnyObject ]?){
        dict
        super.init(fromdict: dict)
        
        if !checkDataAviliable(fromdict: dict!, musthave: .postid,  .datetime, .title, .content) {
            return nil
        }
        
        dict!.forEach({
            switch $0.0 {
            case ItemLable.postid.rawValue :        refresh(&postId, value: $0.1.integerValue)
            case ItemLable.title.rawValue :             refresh(&title, value: $0.1)
            case ItemLable.content.rawValue :       refresh(&content, value: $0.1)
            case ItemLable.datetime.rawValue :     refresh(&time, value: $0.1)
            case ItemLable.images.rawValue :       refresh(&images, value: $0.1)
            case ItemLable.subid.rawValue :          refresh(&subid, value: $0.1)
            case ItemLable.author.rawValue :         refresh(&author, value: $0.1)
            case ItemLable.basecode.rawValue :    refresh(&basecode, value: $0.1.integerValue)
            case ItemLable.count.rawValue :         refresh(&count, value: $0.1.integerValue)
            case ItemLable.url.rawValue :               refresh(&url, value: $0.1)
            case ItemLable.comment.rawValue :
                let temp = $0.1 as? Array<AnyObject>
                temp?.forEach({
                    let new = WxcPostComment(fromdict: ($0 as! ([ String: String]) ))
                    if new != nil {
                        comment.append(new!)
                    }
                })
            default: break
            }
        })
        return
    }
}


func < (lhs: WxcItems, rhs: WxcItems) -> Bool {
    return lhs.postId < rhs.postId
}

func == (lhs: WxcItems, rhs: WxcItems) -> Bool{
    return lhs.postId == rhs.postId
}

//
//  WxcAPI.swift
//  NewsReader
//
//  Created by Conan on 17/12/15.
//  Copyright © 2015年 Conan. All rights reserved.
//

import Foundation

enum WxcChannels : String {
    case news = "&channel=news"
    case bbs = "&func=bbs"
    case blog = "&func=blog"
    case social = "&channel=gossip"
    case ent = "&channel=ent"
}

struct WxcAPI  {
    private let _APIURL_BASE      = "http://api.wenxuecity.com/service/api/?"
    private let _CALLBACK_ID      = "CONANTEST"
    private let _FORMAT_             =  "json"
    var pagesize = 30
    /*  - act: {
    view. ( - id)
    list.    ( - lastID,  - pagesize)
    index(永远返回24个)}
    - version:      1. 2
    - channel:      news. bbs. blog. ent
    - format:   {jsonp(- callback:). json. xml}
    bbs&blog数据不一样
    */
    
    /**
    根据需要生成URL （请求List数据)
    - parameter ch: 请求的频道名字， news. bbs. blog. hot. passport. search. ads. qqh
    - parameter last: 最后post ID，为0的时候为请求最新数据
    - parameter num:  返回的item数量
    */
    func getURL( requestChannel ch : WxcChannels, last: Int = 0 ) -> NSURL {
        //act=list, channel, format, lastid, pagesize
        var st = _APIURL_BASE + "&act=list" + ("&format=" + _FORMAT_ )
        st = st + ch.rawValue + "&lastID=\(last)" + "&pagesize=\(pagesize)"
        return NSURL(string: st)!
    }
    
    /**请求单篇文章数据）
     - parameter id: 请求的PostID
     - parameter ver: 返回数据使用版本，默认为2
     */
    func getURL(requestId id: Int, ver : Int = 2 ) -> NSURL {
        //act=view, format, version
        var st = _APIURL_BASE + "&act=view" + ("&format=" + _FORMAT_ )
        st = st + "&version=\(ver)" + "&id=\(id)" + "&channel=ent"
        return NSURL(string: st)!
    }
    
    //如果需要针对网站预先处理
    private func operation(inout st: String) {
        //TODO: do sth. about string
    }
    
    func speicalForData(data : NSData) -> NSData? {
        var st = String(data: data, encoding: NSUTF8StringEncoding)!
        self.operation(&st)
        return st.dataUsingEncoding(NSUTF8StringEncoding)
    }
    
    func speicalForData(var st : String) -> NSData? {
        self.operation(&st)
        return st.dataUsingEncoding(NSUTF8StringEncoding)
    }
}

//
//  DataManager.swift
//  NewsReader
//
//  Created by Conan on 17/12/15.
//  Copyright © 2015年 Conan. All rights reserved.
//

import Foundation

enum NewsType{
    case wenxuecity
    case qiushi
    case channel8
    case wuyun
    case lifeinterst
}

enum DataRequestMode{
    case moreItems
    case latestItems
    case post
}

class NewsDataManager {
    private var url :NSURL
    private var wxc = ( api : WxcAPI, list:  Array<WxcListItem>,  post: WxcPostItem?,  channel: WxcChannels) (WxcAPI(), list: [], post: nil, .news)
    
    init (){
        url = NSURL(string:"")!
        return
    }
    
    func updateData(news: NewsType, mode: DataRequestMode, id: Int = 0) {
        switch (news, mode) {
        case (.wenxuecity, .latestItems) :            url = wxc.api.getURL(requestChannel: wxc.channel, last: id)
        case (.wenxuecity, .moreItems) :            url = wxc.api.getURL(requestChannel: wxc.channel, last: wxc.list.last!.postId)
        case (.wenxuecity, .post) :                      url = wxc.api.getURL(requestId: id)
        default: break
        }
        fillData(news)
    }
    
    
    /**
     填数据，通过拿到的URL，把list或post数据根据JSON解析出来，填到数据结构中
     - parameter news: 指定新闻网站
     */
    private func fillData(news: NewsType)  {
        guard let data = NSData(contentsOfURL: url) else {
            print("No data")
            return
        }
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
            
            let more : NSArray? = json["list"] as? NSArray
            more?.forEach({
                let temp = WxcListItem(fromdict: ($0 as! ([ String: AnyObject]) ))
                if temp != nil {
                    inserItemToList(temp!, arr: &wxc.list)
                }
            })
            
            let newpost = json as? ([ String: AnyObject])
            wxc.post = WxcPostItem(fromdict: newpost)
        } catch {
            print("JSONObjectWithData: \(error)")
        }
    }
    
    /**
     插入一个新的item进入List，list由大到小排列（新闻最新的显示在最前），有相同的数据则丢弃
     - parameter target: 待处理数据item
     - parameter arr:    目标List
     */
    private func inserItemToList < T: Comparable > (target: T, inout arr:Array< T >) {
        target
        if arr.isEmpty {
            return arr.append(target)
        }
        if arr.contains(target){
            return
        }
        if arr.first < target {
            return arr.insert(target, atIndex: 0)
        }
        if arr.last > target {
            return arr.append(target)
        }
        for i in 0...arr.count-2 {
            if (arr[i] > target) && (arr[i+1] < target) {
                return arr.insert(target, atIndex: i+1)
            }
        }
    }
    
    /// 计算属性，用来获取属性，实现只读封装
    var wxcList : Array<WxcListItem> {
        get {
            return wxc.list
        }
    }
    var wxcPost : WxcPostItem? {
        get {
            return wxc.post
        }
    }
    var wxcCh : WxcChannels {
        get {
            return wxc.channel
        }
        set (channel) {
            wxc.channel = channel
        }
    }
    var wxcGetItemNum : Int {
        get {
            return wxc.api.pagesize
        }
        set (size) {
            if size > 100 {
                print("Too many data will be refused")
            }
            else {
                wxc.api.pagesize = size
            }
        }
    }
    
}




var manager = NewsDataManager()
manager.wxcCh = WxcChannels.ent
manager.wxcGetItemNum = 5
manager.updateData(NewsType.wenxuecity, mode: DataRequestMode.latestItems)
manager.updateData(.wenxuecity, mode: .moreItems)

let id = manager.wxcList[0].postId
manager.updateData(.wenxuecity, mode: .post, id: id)
manager.wxcPost


//let url = wenxuecityGetURL(requestChannel: "news", last: 4794208)
//let url = wenxuecityGetURL(requestId: 4794378)

//TODO: list排序，前后，阅读次数
