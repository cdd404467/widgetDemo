//
//  GifImageView.swift
//  widgetDemo
//
//  Created by caidd on 2025/3/4.
//

import SwiftUI
import ClockHandRotationKit

func webpFilePathInAppGroup(fileName: String = "cdd_gif.gif") -> String? {
    // 获取 App Group 容器 URL
    guard let groupURL = FileManager.default.containerURL(
        forSecurityApplicationGroupIdentifier: "group.com.cdd.widgetDemo") else {
        return nil
    }
    
    // 拼接文件路径
    let fileURL = groupURL.appendingPathComponent(fileName)
    
    // 判断文件是否存在
    guard FileManager.default.fileExists(atPath: fileURL.path) else {
        return nil
    }
    
    return fileURL.path
}

func getGif(_ gifName: String) -> UIImage.GifResult? {
    guard gifName.count > 0 else { return nil }
    
    guard let gifPath = Bundle.main.path(forResource: gifName, ofType: "gif") else {
        return nil
    }
    
//    guard let gifPath = webpFilePathInAppGroup(fileName: gifName) else {
//        return nil
//    }
    
    guard FileManager.default.fileExists(atPath: gifPath),
          let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath))
    else {
        return nil
    }
    
    return UIImage.decodeGIF(gifData)
}

struct GifImageView: View {
    //gif图片的名称,不带后缀名
    var gifName: String
    //gif没加载出来时的默认图片
    var defaultImage: String
    
    var body: some View {
        if let gif = getGif(gifName) {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                
                let arcWidth = max(width, height)
                let arcRadius = arcWidth * arcWidth
                let angle = 360.0 / Double(gif.images.count)
                
                ZStack {
                    //获取到gif的每一帧图片，然后遍历
                    ForEach(1...gif.images.count, id: \.self) { index in
                        Image(uiImage: gif.images[(gif.images.count - 1) - (index - 1)])
                            .resizable()
                            .applyWidgetAccented()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, minHeight: 0)
                            .mask(
                                ArcView(arcStartAngle: angle * Double(index - 1),
                                        arcEndAngle: angle * Double(index),
                                        arcRadius: arcRadius)
                                .stroke(style: .init(lineWidth: arcWidth * 1.1, lineCap: .square, lineJoin: .miter))
                                .frame(width: width, height: height)
                                .clockHandRotationEffect(period: .custom(gif.duration))
                                .offset(y: arcRadius) // ⚠️ 需要先进行旋转，再设置offset
                            )
                    }
                }
                .frame(width: width, height: height)
            }
        } else {
            Image(systemName: defaultImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

func loadImages(prefix: String, count: Int) -> [UIImage] {
    var images: [UIImage] = []
    for i in 1...count {
        if let image = UIImage(named: "\(prefix)\(i)") {
            images.append(image)
        }
    }
    return images
}

struct Cdd_GifImageView: View {
    //    var entry: DynamicWidgetProvider.Entry
        var name: String
        var body: some View {
//            if let gifPath = Bundle.main.path(forResource: name, ofType: "gif"),
//               let gifData = NSData(contentsOfFile: gifPath),
////               let gifImage = UIImage.sd_image(withGIFData: gifData as Data),
//               let gifImage = UIImage.cddGifImage(with: gifData as Data),
            if let gifImage = getGif(name) {
               let gifImages = gifImage.images
                GeometryReader { proxy in
                    let width = proxy.size.width
                    let height = proxy.size.height
                    let duration = gifImage.duration
                    
                    //https://max2d.com/archives/897   计算原理.   如果要方便,那就是lineWidth设置为imageWH.然后arcRadius设置为一个非常非常大的数即可不用做以下运算. 下面的只是为了说清楚算法
                    //多少度
                    let angle = 360.0 / Double(gifImages.count)
                    //正方形宽高
                    let imageWH = max(width, height)
                    //一半宽高
                    let halfWH = (imageWH / 2)
                    //一半弧度
                    let halfRadian = (angle / 2)/180.0 * Double.pi
                    let tanHalf = tan(halfRadian)
                    //半径
                    let radiu = sqrt((5 * halfWH * halfWH) + (halfWH * halfWH) / (tanHalf * tanHalf) + (4 * halfWH * halfWH / tanHalf))
                    let b = halfWH / tanHalf
                    let t = radiu - imageWH - b
                    let lineWidth = radiu - b;
                    let arcRadius = (radiu - (lineWidth / 2)) * 300//这里其实不乘以300才是完完全全正确的结果,每个大小都是刚刚好的.但是这样转起来之后重叠部分会留阴影, 所以加以放大后.半径变大了,但是重叠部分还是那么大.相应的周长绝对速度就变大了. 这样阴影就会快速略过,肉眼便无法感知了.越放大效果越好.应该是这个理
                    let offsetY = arcRadius - t / 2
                    
                    if #available(iOS 18.0, *) {
                        ZStack {
                            ForEach(1...gifImages.count, id: \.self) { index in
                                Image(uiImage: gifImages[gifImages.count-index])
                                    .resizable()
                                    .widgetAccentedRenderingMode(.fullColor)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: width, height: height)
                                    .mask(
                                        ArcView(arcStartAngle: angle * Double(index - 1),
                                                arcEndAngle: angle * Double(index),
                                                arcRadius: arcRadius)
                                        .stroke(style: .init(lineWidth: lineWidth, lineCap: .square, lineJoin: .miter))
                                        .frame(width: width, height: height)
                                        .clockHandRotationEffect(period: .custom(duration))
                                        .offset(y: offsetY)
                                    )
                                    
                            }
                        }
                        .frame(width: width, height: height)
                    } else {
                        
                    }
                    
                    
                    
                }
            }
        }
}

///------------------------------------------------------------------------
struct GifPlayView: View {
    var name: String
    var body: some View {
        if let gifPath = Bundle.main.path(forResource: name, ofType: "gif"),
           let gifData = NSData(contentsOfFile: gifPath),
//               let gifImage = UIImage.sd_image(withGIFData: gifData as Data),
           let gifImage = UIImage.cddGifImage(with: gifData as Data),
           let gifImages = gifImage.images, gifImages.count > 0 {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                let duration = gifImage.duration
                
                //https://max2d.com/archives/897   计算原理.   如果要方便,那就是lineWidth设置为imageWH.然后arcRadius设置为一个非常非常大的数即可不用做以下运算. 下面的只是为了说清楚算法
                //多少度
                let angle = 360.0 / Double(gifImages.count)
                //正方形宽高
                let imageWH = max(width, height)
                //一半宽高
                let halfWH = (imageWH / 2)
                //一半弧度
                let halfRadian = (angle / 2)/180.0 * .pi
                let tanHalf = tan(halfRadian)
                //半径
                let radiu = sqrt((5 * halfWH * halfWH) + (halfWH * halfWH) / (tanHalf * tanHalf) + (4 * halfWH * halfWH / tanHalf))
                let b = halfWH / tanHalf
                let t = radiu - imageWH - b
                let lineWidth = radiu - b;
                let arcRadius = (radiu - (lineWidth / 2)) * 300//这里其实不乘以300才是完完全全正确的结果,每个大小都是刚刚好的.但是这样转起来之后重叠部分会留阴影, 所以加以放大后.半径变大了,但是重叠部分还是那么大.相应的周长绝对速度就变大了. 这样阴影就会快速略过,肉眼便无法感知了.越放大效果越好.应该是这个理
                let offsetY = arcRadius - t / 2
                ZStack {
                    ForEach(1...gifImages.count, id: \.self) { index in
                        Image(uiImage: gifImages[gifImages.count-index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: width, height: height)
                            .mask(
                                ArcView(arcStartAngle: angle * Double(index - 1),
                                        arcEndAngle: angle * Double(index),
                                        arcRadius: arcRadius)
                                .stroke(style: .init(lineWidth: lineWidth, lineCap: .square, lineJoin: .miter))
                                .frame(width: width, height: height)
                                .clockHandRotationEffect(period: .custom(duration))
                                .offset(y: offsetY)
                            )
                    }
                }
                .frame(width: width, height: height)
            }
        }
    }
}


struct ArcView: Shape {
    var arcStartAngle: Double
    var arcEndAngle: Double
    var arcRadius: Double
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: arcRadius,
                    startAngle: .degrees(arcStartAngle),
                    endAngle: .degrees(arcEndAngle),
                    clockwise: false)
        return path
    }
}
