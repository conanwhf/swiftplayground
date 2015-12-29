//: Playground - noun: a place where people can play
import Foundation

/// Define part
let _CALLBACK_ID      = "CONANTEST"
let _APIURL_BASE      = "http://api.wenxuecity.com/service/api/?"
let _DEFAULT_PAGESIZE = 30
let _WXC_POSTID_    = "postid"
let _WXC_SUBID_       = "subid"
let _WXC_TITLE_        = "title"
let _WXC_DATE_        = "dateline"
let _WXC_DATE_T_    = "datetime"
let _WXC_COUNT_     = "count"
let _WXC_IMAGE_      = "images"
let _WXC_AUTHOR_   = "author"
let _WXC_CONTENT_      = "content"
let _WXC_BASECODE_   = "basecode"
let _WXC_COMMENT_     = "comment"
let _WXC_USR_NAME_   = "username"
let _WXC_USR_FACE_    = "userface"
let _WXC_URL_   = "url"
let _WXC_PREV_  = "previous_news"
let _WXC_NEXT_  = "next_news"

let acts = ["view": "&act=view", "list":"&act=list", "index":"&act=index", "send":"&act=send"]
let formats = ["json": "&format=json", "xml" :"&format=xml", "josnp":"&format=jsonp"]
let channels = ["news": "&channel=news", "bbs" : "&channel=bbs", "blog" : "&channel=blog", "hot" : "&channel=hot",   "passport" : "&channel=passport", "search" : "&channel=search", "ads" : "&channel=ads", "qqh" : "&channel=qqh" ]
/*
    - act:             view. list. index(永远返回24个). send（未知）
        list    - pagesize
                - lastID
        view          - id
                        - version:      1. 2
    - channel:      news. bbs. blog. hot. passport. search. ads. qqh
    - callback:
    - format:       jsonp. json. xml
*/

func refresh < T1, T2 > (inout target: T1, value : T2?){
    let test = value as? T1
    target = ((test == nil) ? target : (test!))
}
/**
*  List Item, info for each item in list
*/
struct ListItem {
    let postId : Int
    let title: String
    let dateLine : String
    var count : Int
    let images : Array<String>?

    init? (fromdict dict: [ String: AnyObject ]?){
        // dict
        guard dict != nil else{
            return nil
        }
        guard ( (dict!.keys.contains(_WXC_POSTID_) && dict!.keys.contains(_WXC_COUNT_) &&
            dict!.keys.contains(_WXC_TITLE_)  && dict!.keys.contains(_WXC_DATE_)) == true) else{
                return nil
        }
        postId   = dict![_WXC_POSTID_]!.integerValue
        title    = String(dict![_WXC_TITLE_]!)
        dateLine = String(dict![_WXC_DATE_]!)
        count    = dict![_WXC_COUNT_]!.integerValue
        images   = dict![_WXC_IMAGE_] as? Array<String>
        return
    }
}
var _items : Array<ListItem> = []

/**
 *  Post Item, for info at every post
 */
struct PostItem {
    struct PostComment {
        let postid : Int
        let content : String
        let dateline : String
        var userface : String = ""
        var username : String = "UNKNOW"
        
        init? (fromdict dict: [ String: String ]?){
            //dict
            guard dict != nil else{
                return nil
            }
            // Check data
            guard ( (dict!.keys.contains(_WXC_POSTID_) && dict!.keys.contains(_WXC_CONTENT_)
                && dict!.keys.contains(_WXC_DATE_) ) == true) else{
                    return nil
            }
            postid   = Int(dict![_WXC_POSTID_]!)!
            content  = String(dict![_WXC_CONTENT_]!)
            dateline = String(dict![_WXC_DATE_]!)
            refresh(&username, value: dict![_WXC_USR_NAME_])
            refresh(&userface, value: dict![_WXC_USR_FACE_])
            return
        }
    }
    
    let postid : Int
    let title : String
    let datetime : String
    let content : String
    // Something not very important
    let images : Array<String>?
    var comment : Array<PostComment> = []
    var subid : String = "news"
    var author : String = "UNKNOW"
    var basecode : Int = 0
    var previous : Int = 0
    var next : Int = 0
    var count : Int = 0
    var url : String = ""
    
    init? (fromdict dict: [ String: AnyObject ]?){
        //dict
        guard dict != nil else{
            return nil
        }
        // Check data
        guard ( dict!.keys.contains(_WXC_POSTID_) && dict!.keys.contains(_WXC_TITLE_) &&
            dict!.keys.contains(_WXC_DATE_T_)  && dict!.keys.contains(_WXC_CONTENT_) == true) else{
                return nil
        }
        postid = dict![_WXC_POSTID_]!.integerValue
        title = String(dict![_WXC_TITLE_]!)
        content = String(dict![_WXC_CONTENT_]!)
        datetime = String(dict![_WXC_DATE_T_]!)
        images = dict![_WXC_IMAGE_] as? Array<String>
        let temp = dict![_WXC_COMMENT_] as? Array<AnyObject>
        temp?.forEach({
            let new = PostComment(fromdict: ($0 as! ([ String: String]) ))
            if new != nil {
                comment.append(new!)
            }
        })
        refresh(&subid, value: dict![_WXC_SUBID_] )
        refresh(&author, value: dict![_WXC_AUTHOR_] )
        refresh(&basecode, value: dict![_WXC_BASECODE_]?.integerValue)
        refresh(&count, value: dict![_WXC_COUNT_]?.integerValue)
        refresh(&url, value: dict![_WXC_URL_] )
        //refresh(&previous, value: dict![_WXC_PREV_]?.integerValue )
        //refresh(&next, value: dict![_WXC_NEXT_]?.integerValue)
        return
    }
}
var _post : PostItem?


/**
    根据需要生成URL
    （请求List数据)
 - parameter ch: 请求的频道名字， news. bbs. blog. hot. passport. search. ads. qqh
 - parameter last: 最后post ID，为0的时候为请求最新数据
 - parameter num:  返回的item数量
 
 - returns: URL
 */
func wenxuecityGetURL( requestChannel ch : String, last: Int, num : Int = _DEFAULT_PAGESIZE ) -> NSURL {
    //act=list, channel, format, lastid, pagesize
    var st = _APIURL_BASE + acts["list"]! + formats["json"]! + "&version=2"
    st = st + channels[ch]! + "&lastID=\(last)" + "&pagesize=\(num)"
    return NSURL(string: st)!
}
/** 
  （请求单篇文章数据）
 - parameter id: 请求的PostID
 - parameter ver: 返回数据使用版本，默认为2
 
 - returns: URL
 */
func wenxuecityGetURL(requestId id: Int, ver : Int = 2 ) -> NSURL {
    //act=view, format,
    var st = _APIURL_BASE + acts["view"]! + formats["json"]! + "&version=\(ver)"
    st = st + "&id=\(id)"
    return NSURL(string: st)!
}

/**
 Binary search function, find the target in a array
 
 - parameter target:    target value you want
 - parameter sortedArr: A sorted array
 
 - returns: return the index if found, otherwise return nil
 */
func insertListItem (target: ListItem, arr:Array<ListItem>)-> Int? {
    arr.reverse().forEach({ $0
        })
    return nil
}

func getDataFromURL(url :NSURL) -> NSData? {
    return NSData(contentsOfURL: url)
/*
    //如果需要针对网站预先处理
    do {
        var st :String = try String.init(contentsOfURL: url)
        data = st.dataUsingEncoding(NSUTF8StringEncoding)
        return data
    } catch {
        print("Cant get data from URL, \(error)")
        return nil
    }
*/
}


func fillData(data: NSData) {

    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        let more : NSArray? = json["list"] as? NSArray
        more?.forEach({
            let new = ListItem(fromdict: ($0 as! ([ String: AnyObject]) ))
            if new != nil {
                //locateItem(new!, _items)
                _items.append(new!)
            }
        })
        let newpost = json as? ([ String: AnyObject])
        _post = PostItem(fromdict: newpost)
    
    } catch {
        print("JSONObjectWithData: \(error)")
    }
}

let url = wenxuecityGetURL(requestChannel: "news", last: 4794208)
//let url = wenxuecityGetURL(requestId: 4794378)
//let st = try String(contentsOfURL: url2, encoding: NSUTF8StringEncoding)


fillData(getDataFromURL(url)!)

_items
_post

//TBD: list排序，前后，阅读次数