//参考　コード　https://softmoco.com/swift-basics/swift-for.php
//参考　緯度経度の1度の距離　https://www.wingfield.gr.jp/archives/9721

// バスの乗降者数が記録されるたびに、その位置の緯度経度が送られてくるので、それをバス停名称に変換する機能をつくるよ

import UIKit
import Foundation

//下の変数が、「乗降者数が記録された位置の緯度経度」
//3セット作って、入れ替えながら動作確認するよ
var latRecord1 = 35.66643262 //新橋付近
var lonRecord1 = 139.7581484
var latRecord2 = 35.67502467 //有楽町付近
var lonRecord2 = 139.7632284
var latRecord3 = 35.68163993 //東京付近
var lonRecord3 = 139.7666349

// バス停の位置はあらかじめ緯度経度を調査して定数にしておくよ
// 辞書型（そのvalueも辞書型）だよ
let busStopList = [
    "busStop010": ["name": "東京", "lat": 35.6813, "lon": 139.7671], // key : バス停名称,緯度,経度
    "busStop020": ["name": "有楽町", "lat": 35.6749, "lon": 139.7629],
    "busStop030": ["name": "新橋", "lat": 35.6664, "lon": 139.7583]
]

struct FindNearestBusStop{
    
    var name1 = "" // for-inループ用　各バス停の名称
    var lat1 = 0.0 // for-inループ用　各バス停の緯度
    var lon1 = 0.0 // for-inループ用　各バス停の経度
    var distance = 0.0 //バス停止位置から各バス停までの距離
    var distanceMin = 100000.0 //最小距離算出用
    var nearestBusStopName = "" //最小距離の（最寄のバス停名称）


    // 緯度経度が記録されたら、for-inループで全てのバス停との距離を算出
    // 最小値が最寄のバス停なので、そのバス停名称を記録するよ
    
    mutating func findBusStop(){
        for busStopID in busStopList.keys{
            print("key：\(busStopID)")
            print("value：\(busStopList[busStopID]!)")
            name1 = busStopList[busStopID]!["name"]as! String
            lat1 = busStopList[busStopID]!["lat"]as! Double
            lon1 = busStopList[busStopID]!["lon"]as! Double
            print("name：\(name1)")
            print("lat：\(lat1)")
            print("lon：\(lon1)")
            distance = sqrt(pow((lat1 - latRecord3)*111, 2.0) + pow((lon1 - lonRecord3)*93, 2.0))*1000
            // latRecord1~3とlonRecord1~3を入れ替えて(東京・有楽町・新橋を入れ替えて)動作確認
            // バスの停止位置の緯度経度と、バス停の緯度経度から、停止位置とバス停の距離distanceを算出
            // 111は緯度1度あたりの南北距離km
            // 91は経度1度当りの東西距離km（★★対象地の緯度によって変更が必要★★参考サイト参照）
            // distanceの単位はメートル
            
            
            if distanceMin > distance {
                distanceMin = distance
                nearestBusStopName = name1
            }
            // distanceMinの初期値は巨大
            // distanceがdistanceMinより小さければそれを採用して入力、大きければ無視
            // for-inループで全てのバス停のdistanceを計算して最小値のバス停名称をnearestBusStopNameに記録
        } //for-inループここまで
    } // func findBusStopここまで
} // struct FindNearestBusStopここまで


var findNearestBusStop = FindNearestBusStop() // structのインスタンスを作成

findNearestBusStop.findBusStop()


print("nearestBusStopName ::: \(findNearestBusStop.nearestBusStopName)")
