//
//  UIImage+Extension.swift
//  widgetDemo
//
//  Created by caidd on 2025/3/4.
//

import UIKit

extension UIImage {
    static func fromBundle(_ bundle: Bundle? = nil, forName name: String?, ofType ext: String?) -> UIImage? {
        guard let path = (bundle ?? Bundle.main).path(forResource: name, ofType: ext) else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    /// 从 GIF 数据生成 UIImage（支持多帧动画）
    static func cddGifImage(with data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let count = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        var totalDuration: TimeInterval = 0
        
        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                continue
            }
            
            // 读取帧属性
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [CFString: Any],
                  let gifDict = properties[kCGImagePropertyGIFDictionary] as? [CFString: Any] else {
                continue
            }
            
            // 帧延迟时间
            let unclampedDelay = gifDict[kCGImagePropertyGIFUnclampedDelayTime] as? NSNumber
            let delay = unclampedDelay?.doubleValue ?? (gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber)?.doubleValue ?? 0.1
            totalDuration += delay
            
            let image = UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
            images.append(image)
        }
        
        if images.count == 1 {
            return images.first
        } else {
            return UIImage.animatedImage(with: images, duration: totalDuration)
        }
    }
    
    static func loadImageSequence(prefix: String, count: Int, ext: String = "png") -> [UIImage]? {
        var images: [UIImage] = []
        images.reserveCapacity(count)

        for i in 0..<count {
            let name = "\(prefix)\(i)"
            if let img = UIImage(named: name) {
                images.append(img)
            } else if let path = Bundle.main.path(forResource: name, ofType: ext),
                      let img = UIImage(contentsOfFile: path) {
                images.append(img)
            }
        }
        return images
    }
}

extension UIImage {
    struct GifResult {
        let images: [UIImage]
        let duration: TimeInterval
    }
    
    static func decodeBundleGIF(_ bundle: Bundle? = nil, forName name: String) async -> GifResult? {
        guard let path = (bundle ?? Bundle.main).path(forResource: name, ofType: "gif") else {
            return nil
        }
        return await decodeLocalGIF(URL(fileURLWithPath: path))
    }
    
    static func decodeLocalGIF(_  url: URL) async -> GifResult? {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return decodeGIF(data)
    }
    
    static func decodeGIF(_  data: Data) -> GifResult? {
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let count = CGImageSourceGetCount(imageSource)
        
        var images: [UIImage] = []
        var duration: TimeInterval = 0
        
        for i in 0 ..< count {
            guard let cgImg = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            
            let img = UIImage(cgImage: cgImg)
            images.append(img)
            
            guard let proertyDic = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) else {
                duration += 0.1
                continue
            }
            
            guard let gifDicValue = CFDictionaryGetValue(proertyDic, Unmanaged.passRetained(kCGImagePropertyGIFDictionary).autorelease().toOpaque()) else {
                duration += 0.1
                continue
            }
            
            let gifDic = Unmanaged<CFDictionary>.fromOpaque(gifDicValue).takeUnretainedValue()
            
            guard let delayValue = CFDictionaryGetValue(gifDic, Unmanaged.passRetained(kCGImagePropertyGIFUnclampedDelayTime).autorelease().toOpaque()) else {
                duration += 0.1
                continue
            }
            
            var delayNum = Unmanaged<NSNumber>.fromOpaque(delayValue).takeUnretainedValue()
            var delay = delayNum.doubleValue
            
            if delay <= Double.ulpOfOne {
                if let delayValue2 = CFDictionaryGetValue(gifDic, Unmanaged.passRetained(kCGImagePropertyGIFDelayTime).autorelease().toOpaque()) {
                    delayNum = Unmanaged<NSNumber>.fromOpaque(delayValue2).takeUnretainedValue()
                    delay = delayNum.doubleValue
                }
            }
            
            if delay < 0.02 {
                delay = 0.1
            }
            
            duration += delay
        }
        
        guard images.count > 0 else {
            return nil
        }
        
        return GifResult(images: images, duration: duration)
    }
}
