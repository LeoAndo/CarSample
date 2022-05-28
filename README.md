# CarSample

This is the sample from the WWDC 2020 Talk [Accelerate your app with CarPlay](https://developer.apple.com/wwdc20/10635) in a working fashion

# 変更点

位置情報を定期取得し、位置情報の変更をトリガーにアイコン / タイトルを更新する調査用のコード。<br>
TemplateUIには、Gridを採用。<br>

[CarPlay-App-Programming-Guide.pdf](https://developer.apple.com/carplay/documentation/CarPlay-App-Programming-Guide.pdf) のP17参照<br>
<img width="736" alt="スクリーンショット 2022-05-29 1 45 31" src="https://user-images.githubusercontent.com/16476224/170834801-4ef042d8-fb0a-46e5-be1f-ffcaf569ab71.png">


# 設計

- [CLLocationManager](https://developer.apple.com/documentation/corelocation/cllocationmanager)
- [Combine](https://developer.apple.com/documentation/combine)

![image_67140609](https://user-images.githubusercontent.com/16476224/170831404-8d197a2d-0eb5-4fc2-8115-0232c459d150.JPG)



# capture (CarPlay / iPhone 13 Pro Max Simulator)
<img src="https://github.com/LeoAndo/CarSample/blob/observe_location_grid/carPlay_capture.png" width=600 />
<img src="https://github.com/LeoAndo/CarSample/blob/observe_location_grid/request_location_permission.png" width=320 />

