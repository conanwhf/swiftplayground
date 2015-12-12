import Foundation

//指定文件夹文件名乱码重命名，跳过隐藏文件

let manager = NSFileManager.defaultManager()
let dir =  Process.arguments.count>1 ? Process.arguments[1] : NSHomeDirectory() + "/Downloads/books/"
let contentsOfPath = try? manager.contentsOfDirectoryAtPath(dir)

//print("DIR = \(dir), files = \(contentsOfPath)\n")
guard contentsOfPath != nil else  {
    print("DIR = \(dir), No folder!!!")
    exit(0)
}

for i in contentsOfPath! {
    if i[i.startIndex] != "." && i.stringByRemovingPercentEncoding != nil {
        //print("\(i) --> \(i.stringByRemovingPercentEncoding!)")
        try! manager.moveItemAtPath(dir + i, toPath: dir + i.stringByRemovingPercentEncoding!)
    }
    else {
        print("Error: \(i) --> \(i.stringByRemovingPercentEncoding)")
    }
}
