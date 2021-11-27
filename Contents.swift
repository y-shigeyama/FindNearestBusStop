//参考　コード　https://softmoco.com/swift-basics/swift-for.php
//参考　緯度経度の1度の距離　https://www.wingfield.gr.jp/archives/9721

// バスが停車して乗降者数が記録されるたびに、その位置の緯度経度が送られてくる。
// それを最寄のバス停名称に変換する機能をつくるよ
// この機能をまとめた、struct FindNearestBusStop{} を作成
// 入力は、バス停の一覧（Dictionary）、バスの停車位置緯度(Double)、バスの停車位置経度(Double)
// 出力は、最寄のバス停名称（String）

import UIKit
import Foundation

struct FindNearestBusStop{ //バスの停車位置緯度経度から最寄のバス停を返すStructだよ
    
    var busStopList = [ //仮のデータを入れておく。実行の際はバス停のデータを代入する。
        "busStop010": ["name": "病院前", "lat": 35.6, "lon": 139.71], // key : バス停名称,緯度,経度
        "busStop020": ["name": "市役所前", "lat": 35.7, "lon": 139.72],
        "busStop030": ["name": "市民会館前", "lat": 35.8, "lon": 139.73]
    ]
    var latRecord = 35.6 //仮のデータを入れておく。バスの停止位置緯度を代入する
    var lonRecord = 139.7 //仮のデータを入れておく。バスの停止位置経度を代入する
    
    var name1 = "" // for-inループ用　各バス停の名称
    var lat1 = 0.0 // for-inループ用　各バス停の緯度
    var lon1 = 0.0 // for-inループ用　各バス停の経度
    var distance = 0.0 // バス停止位置から各バス停までの距離を算出
    var distanceMin = 100000.0 // 距離が最小になるごとにここに記録しておく
    var nearestBusStopName = "" // 最小距離の（最寄のバス停名称）

    // バス停止位置の緯度経度が記録されたら、それがstructに入力される。
    // for-inループで全てのバス停との距離を算出
    // 距離が最小が最寄のバス停なので、そのバス停名称を記録するよ
    
    mutating func findBusStop(){
        for busStopID in busStopList.keys{
              print("key：\(busStopID)") //確認用
              print("value：\(busStopList[busStopID]!)") //確認用
            name1 = busStopList[busStopID]!["name"]as! String
            lat1 = busStopList[busStopID]!["lat"]as! Double
            lon1 = busStopList[busStopID]!["lon"]as! Double
              print("name：\(name1)") //確認用
              print("lat：\(lat1)") //確認用
              print("lon：\(lon1)") //確認用
            distance = sqrt(pow((lat1 - latRecord)*111, 2.0) + pow((lon1 - lonRecord)*93, 2.0))*1000
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



// バス停の位置はあらかじめ緯度経度を調査して定数にしておくよ
// 辞書型（そのvalueも辞書型）だよ
let busStopListTokyo = [
    "busStop010": ["name": "東京", "lat": 35.6813, "lon": 139.7671], // key : バス停名称,緯度,経度
    "busStop020": ["name": "有楽町", "lat": 35.6749, "lon": 139.7629],
    "busStop030": ["name": "新橋", "lat": 35.6664, "lon": 139.7583]
]

findNearestBusStop.busStopList = busStopListTokyo
//StructのbusStopList（初期値）に実際のバス停データを代入するよ


//StructのlatRecord, lonRecord（初期値）にバスの停止位置緯度経を代入するよ
findNearestBusStop.latRecord = 35.66643262 //新橋付近
findNearestBusStop.lonRecord = 139.7581484 //新橋付近
findNearestBusStop.findBusStop() //関数を実行
print("nearestBusStopName ::: \(findNearestBusStop.nearestBusStopName) ::: ") //最寄バス停をプリント
findNearestBusStop.distanceMin = 100000.0 //次のバス停で止まった時のために初期値に戻しておくよ



//有楽町でテストだよ
findNearestBusStop.latRecord = 35.67502467 //有楽町付近
findNearestBusStop.lonRecord = 139.7632284 //有楽町付近
findNearestBusStop.findBusStop() //関数を実行
print("nearestBusStopName ::: \(findNearestBusStop.nearestBusStopName) ::: ") //最寄バス停をプリント
findNearestBusStop.distanceMin = 100000.0 //次のバス停で止まった時のために初期値に戻しておくよ



//東京でテストだよ
findNearestBusStop.latRecord = 35.68163993 //東京付近
findNearestBusStop.lonRecord = 139.7666349 //東京付近
findNearestBusStop.findBusStop() //関数を実行
print("nearestBusStopName ::: \(findNearestBusStop.nearestBusStopName) ::: ") //最寄バス停をプリント
findNearestBusStop.distanceMin = 100000.0 //次のバス停で止まった時のために初期値に戻しておくよ
