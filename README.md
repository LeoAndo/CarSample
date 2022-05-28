# CarSample

This is the sample from the WWDC 2020 Talk [Accelerate your app with CarPlay](https://developer.apple.com/wwdc20/10635) in a working fashion

# 変更点

位置情報を定期取得し、位置情報の変更をトリガーにテキストを更新する調査用のコード。<br>
TemplateUIには、Informationを採用。<br>

[CarPlay-App-Programming-Guide.pdf](https://developer.apple.com/carplay/documentation/CarPlay-App-Programming-Guide.pdf) のP18参照<br>
<img width="707" alt="スクリーンショット 2022-05-28 23 53 04" src="https://user-images.githubusercontent.com/16476224/170830705-c0624ded-3fb9-43fd-92cc-6c0f69a3b0f6.png">

# 設計

- [CLLocationManager](https://developer.apple.com/documentation/corelocation/cllocationmanager)
- [Combine](https://developer.apple.com/documentation/combine)

![image_67140609](https://user-images.githubusercontent.com/16476224/170831404-8d197a2d-0eb5-4fc2-8115-0232c459d150.JPG)



# capture (CarPlay / iPhone 13 Pro Max Simulator)
<img src="https://github.com/LeoAndo/CarSample/blob/observe_location/carPlay_capture.png" width=600 />
<img src="https://github.com/LeoAndo/CarSample/blob/observe_location/request_location_permission.png" width=320 />

