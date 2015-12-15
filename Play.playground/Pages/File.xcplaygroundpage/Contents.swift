//: [Previous](@previous)

import UIKit
import Foundation

extension String {
    var toFilePathURL : NSURL {
        let url =  NSURL( fileURLWithPath: self)
        //print("    trans:  \(self) --> \(url)")
        return url
    }
}

let manager        = NSFileManager.defaultManager()//根控制器
// String 表示文件&文件夹路径
NSHomeDirectory()
NSHomeDirectoryForUser("Conan")
let HOME           = NSHomeDirectory()//用户目录，根据运行环境不同而不同
let workdir        = HOME + "/Documents/Shared Playground Data/"// 测试用
// NSURL 表示文件&文件夹路径
let urlForDocument = manager.URLsForDirectory( NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask)//获得用户Document目录
//let url = urlForDocument[0] as NSURL


/**
创建文件、文件夹、符号链接
*/
func createFiles() {
    var fn    = workdir + "/NewDir/"
    let url   = workdir.toFilePathURL
    let fnUrl = url.URLByAppendingPathComponent("/urlNewDir/", isDirectory: true)

    // Floder Creator
    do {
        // withIntermediateDirectories为ture表示路径中间如果有不存在的文件夹都会创建
        try manager.createDirectoryAtPath(fn, withIntermediateDirectories: true, attributes: nil)
    } catch {
        print("Error by createDirectoryAtPath: \(error)\n")
    }

    do {
        try manager.createDirectoryAtURL(fnUrl, withIntermediateDirectories: true, attributes: nil)
    } catch {
        print("Error by createDirectoryAtURL: \(error)\n")
    }

    // File
    fn          = workdir + "try.txt"
    manager.createFileAtPath(fn, contents: nil , attributes: nil)

    //Symbolic Link
    do {
        try manager.createSymbolicLinkAtPath(workdir + "tryLink.txt", withDestinationPath: fn)
    } catch {
        print("Error by createSymbolicLinkAtPath: \(error)\n")
    }

    do {
    let linkurl = url.URLByAppendingPathComponent("link-url", isDirectory: false)
        try manager.createSymbolicLinkAtURL(linkurl, withDestinationURL: fnUrl)
    } catch {
        print("Error by createSymbolicLinkAtURL: \(error)\n")
    }
}



/**
遍历文件夹
- parameter dir: (String)文件夹路径
*/
func traversal( dir : String) {
    let url = dir.toFilePathURL
    
    // 1-1 不遍历子文件夹，返回指定目录路径下的文件、子目录及符号链接的列表，相对文件名，包括隐藏文件
    do {
    let contentsOfPath   = try manager.contentsOfDirectoryAtPath(dir)
        contentsOfPath.forEach{ print($0) }
        print("Done 1-1")
    } catch {
        print("-----------Error by 1-1: \(error)\n")
    }

    // 1-2 NSURL形式，同1-1，返回绝对路径的文件名列表（“file://XXXXXX”），忽略隐藏文件
    do {
    let contentsOfURL    = try manager.contentsOfDirectoryAtURL(url, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles)
        contentsOfURL.forEach{ print($0) }
        print("Done 1-2")
    } catch {
        print("-----------Error by 1-2: \(error)\n")
    }

    // 2-1 会递归遍历子文件夹，但不会递归符号链接
    let enumeratorAtPath = manager.enumeratorAtPath(dir)
    if enumeratorAtPath == nil  {
        print("------------Error by 2-1: no such folder: \(dir)")
        //return
    }
    else {
        enumeratorAtPath!.forEach{ print($0) }
        print("Done 2-1")
    }

    // 2-2 NSURL形式，同2-1，返回绝对路径的文件名，忽略隐藏文件
    let enumeratorAtURL  = manager.enumeratorAtURL(url,includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles, errorHandler:nil)
    if enumeratorAtURL == nil  {
        print("------------Error by 2-2: no such folder: \(url)")
        //return
    }
    else {
        enumeratorAtURL!.forEach{ print($0) }
        print("Done 2-2")
    }

    // 3- 递归遍历子文件夹，包括符号链接
    let subpathsAtPath   = manager.subpathsAtPath(dir)
    if subpathsAtPath == nil  {
        print("------------Error by 3: no such folder: \(dir)")
        //return
    }
    else {
        subpathsAtPath!.forEach{ print($0) }
        print("Done 3")
    }
}




/**
 读取文件内容
 - parameter fn: 文件名
 */
func readFromFile(fn: String, way : Int) {
    let fnUrl   = fn.toFilePathURL
    var data : NSData?

    switch way {
    case 1 :
        // 直接读取数据
    data        = manager.contentsAtPath(fn)
    case 2 :
        // 使用file handler
    let handler = NSFileHandle(forReadingAtPath: fn)
    data        = handler?.readDataToEndOfFile()
    case 3:
        // 使用file handler -URL
        do {
    let handler = try NSFileHandle(forReadingFromURL: fnUrl)
    data        = handler.readDataToEndOfFile()
        } catch {
            print("Error by NSFileHandle: \(error)\n")
        }
    default :
        print("Error for way, return!")
        return
    }

    guard data != nil else {
        print("No such file : \(fn) !")
        return
    }
    let st      = String(data: data!, encoding: NSUTF8StringEncoding)!
    print("-------------Way \(way): \n\(st)")
}



/**
 数据写入文件
 - parameter fn: 文件名(前缀)
 可以通过writeToFile方法，可以创建文件并将对象写入，对象包括String，NSString，UIImage，NSArray，NSDictionary等。
 */
func writeToFile(fn: String){
    // String
    let info        = "测试数据1234"
    do {
        try info.writeToFile(fn + "_string.txt", atomically: true, encoding: NSUTF8StringEncoding)
    } catch {
        print("Error by writeToFile: \(error)\n")
    }

    // 图片
    let image       = UIImage(named: workdir + "/test/207006981.jpg")
    let data:NSData = UIImagePNGRepresentation(image!)!
    data.writeToFile(fn + "_img.jpg", atomically: true)

    // NSArray保存
    let array       = NSArray(objects: "aaa","bbb","ccc")
    array.writeToFile(fn + "_arr.txt", atomically: true)

    // NSDictionary保存
    let dictionary  = NSDictionary(objects: ["111","222"], forKeys: ["aaa","bbb"])
    dictionary.writeToFile(fn + "_dic.txt", atomically: true)
}


/**
 复制文件
 - parameter src:  <#src description#>
 - parameter dest: <#dest description#>
 */
func copyFile(src: String, dest : String){

    do {
        try manager.copyItemAtPath(src, toPath: dest)
    } catch let error as NSError {
        print("Error by Path: \(error)\n")
    }

    let srcUrl  = src.toFilePathURL
    let destUrl = (dest + "url.txt").toFilePathURL
    do {
        try manager.copyItemAtURL( srcUrl, toURL: destUrl)
    } catch let error as NSError {
        print("Error by URL: \(error)\n")
    }
}


/**
 修改文件
 同样是可用URL/Path方式，通过seek查找offset
 NSFileHandle参数，相当于打开方式
    forReadingXXX - readonly
    forWritingXXX - write only
    forUpdatingXXX - read/write
 - parameter fn: <#fn description#>
 */
func modifyFile( fn: String) {

    let fnUrl   = fn.toFilePathURL
    var string  = "\n用forUpdatingAtURL在文件第10个字节插入XXX\n"
    var data    = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!

    // URL to handler
    do {
    let handler = try NSFileHandle(forUpdatingURL: fnUrl)
        handler.seekToFileOffset(10)
    let data2   = handler.readDataToEndOfFile()
        handler.seekToFileOffset(10)
        handler.writeData(data)
        handler.writeData(data2)
    } catch {
        print("Error by NSFileHandle: \(error)\n")
    }

    // Another way to get the handler (by PATH)
    let handler = NSFileHandle(forUpdatingAtPath: fn)
    guard handler != nil else {
        print("No such file")
        return
    }
    string      = "\n用forUpdatingAtPath在文件末尾添加XXX"
    data        = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    handler!.seekToEndOfFile()
    handler!.writeData(data)
}


/**
 移动文件
 - parameter src:  <#src description#>
 - parameter dest: <#dest description#>
 */
func moveFile(src: String, dest: String){
    do {
        try manager.moveItemAtPath(src, toPath: dest)
    } catch {
        print("Error by Path: \(error)\n")
    }

    let srcUrl  = dest.toFilePathURL
    let destUrl = src.toFilePathURL
    do {
        try manager.moveItemAtURL( srcUrl, toURL: destUrl)
    } catch  {
        print("Error by URL: \(error)\n")
    }
}


/**
 删除文件

 - parameter fn: <#fn description#>
 */
func removeFile(fn: String){
    
    do {
        try manager.removeItemAtPath(fn)
    } catch {
        print("Error by Path: \(error)\n")
    }
    
    do {
        try manager.removeItemAtURL( fn.toFilePathURL)
    } catch  {
        print("Error by URL: \(error)\n")
    }

}



/**
文件权限和属性

 - parameter fn: <#fn description#>
 */
func attributesForFile(fn: String) {
    //权限判断
    let readable   = manager.isReadableFileAtPath(fn)
    let writeable  = manager.isWritableFileAtPath(fn)
    let executable = manager.isExecutableFileAtPath(fn)
    let deleteable = manager.isDeletableFileAtPath(fn)
    print("文件\(fn) \(readable ? "" : "不")可读， \(writeable ? "" : "不")可写，\(executable ? "" : "不")可执行，\(deleteable ? "" : "不")可删除")

    //获取文件属性
    do {
    let attributes = try manager.attributesOfItemAtPath(fn)
            print("attributes: \(attributes)")
    } catch {
        print("Error by attributesOfItemAtPath: \(error)\n")
    }
}



//  1. 判断文件或文件夹是否存在
//manager.fileExistsAtPath(workdir)
//manager.fileExistsAtPath(workdir + "aaa.txt")

//  2. 创建文件/文件夹/链接
//createFiles()

// 3. 遍历文件夹
//traversal( workdir )

// 4. 	读取文件
//readFromFile(workdir + "read.md", way: 1)
//readFromFile(workdir + "read.md", way: 2)
//readFromFile(workdir + "read.md", way: 3)

// 5. 将数据写入文件
//writeToFile(workdir + "/test/new")

// 6. 修改文件
//modifyFile(workdir + "/test/new_string.txt")

// 7. 复制文件
//copyFile(workdir + "read.md", dest: workdir + "copied.txt")

// 8. 移动文件
//moveFile(workdir + "read.md", dest: workdir + "new_read.md")

// 9. 删除文件/文件夹
//removeFile(workdir + "try.txt")
//removeFile(workdir + "urlNewDir")

// 10. 文件属性和权限
//attributesForFile(workdir + "read.md")

// 11. 比较文件/文件夹
//manager.contentsEqualAtPath(workdir + "read.md", andPath: workdir + "copied.txt")
//manager.contentsEqualAtPath(workdir, andPath: workdir + "/tesst/")
