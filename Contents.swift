//参考https://softmoco.com/swift-basics/swift-for.php


import UIKit
import Foundation

var greeting = "Hello, playground"

let busStopList = [
    "busStop010": ["name": "東京", "lat": 35.6813, "lon": 139.7671], // key : バス停名称,緯度,経度
    "busStop020": ["name": "有楽町", "lat": 35.6749, "lon": 139.7629],
    "busStop030": ["name": "新橋", "lat": 35.6664, "lon": 139.7583]
]

var lat1 = 0.0
var lon1 = 0.0

for aaa in busStopList.keys{
  //  print("01")
    print("key：\(aaa)")
    print("value：\(busStopList[aaa]!)")
    print("name：\(busStopList[aaa]!["name"]!)")
    lat1 = busStopList[aaa]!["lat"]as! Double
    lon1 = busStopList[aaa]!["lon"]as! Double
    print("lat：\(lat1)")
    print("lon：\(lon1)")
}
