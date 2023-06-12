//
//  AppDelegate.swift
//  ThumbGenTest
//
//  Created by Guillaume Louel on 12/06/2023.
//

import Cocoa
import AVKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var LogTextField: NSTextField!
    @IBOutlet var window: NSWindow!

    
    @IBOutlet weak var thumb1: NSImageView!
    @IBOutlet weak var thumb2: NSImageView!
    @IBOutlet weak var thumb3: NSImageView!
    @IBOutlet weak var thumb4: NSImageView!
    @IBOutlet weak var thumb5: NSImageView!
    @IBOutlet weak var thumb6: NSImageView!
    @IBOutlet weak var thumb7: NSImageView!
    @IBOutlet weak var thumb8: NSImageView!
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func Log(_ string: String) {
        LogTextField.stringValue.append(string)
        LogTextField.stringValue.append("\n")
    }
    
    //
    @IBAction func fetchOnline(_ sender: Any) {
        Log("Fetch online started...")
    
        let assets = [
            ["https://sylvan.apple.com/Videos/G010_C026_UHD_SDR_v02_2K_AVC.mov", thumb1!],
            ["https://sylvan.apple.com/Aerials/2x/Videos/G010_C026_UHD_SDR_v02_2K_HEVC.mov", thumb2!],
            ["https://sylvan.apple.com/Aerials/2x/Videos/G010_C026_UHD_HDR_v02_2K_HEVC.mov", thumb3!],
            ["https://sylvan.apple.com/Aerials/2x/Videos/G010_C026_UHD_SDR_v02_4K_HEVC.mov", thumb4!],
            ["https://sylvan.apple.com/Aerials/2x/Videos/G010_C026_UHD_HDR_v02_4K_HEVC.mov", thumb5!],

            ["https:/sylvan.apple.com/itunes-assets/Aerials126/v4/ec/eb/c8/ecebc8d2-5486-c2b2-52ae-6f0ab2d6b65f/G010_C026_UHD_SDR_v02_240fps_5e903ed6-1acf-495d-a0b5-8a9dd94df96bq26_sRGB_tsa.mov", thumb6!],
            ["https://sylvan.apple.com/itunes-assets/Aerials126/v4/ec/eb/c8/ecebc8d2-5486-c2b2-52ae-6f0ab2d6b65f/G010_C026_UHD_SDR_v02_240fps_5e903ed6-1acf-495d-a0b5-8a9dd94df96bq26_sRGB_tsa.mov", thumb7!],

        ]
        
        DispatchQueue.main.async { [self] in
            for asset in assets {
                thumbToImage(url: asset[0] as! String, img: asset[1] as! NSImageView)
            }

            Log("Fetch online done!")
        }
    }
    
    func thumbToImage(url: String, img: NSImageView) {
        Log("Grabbing : " + url)
        if let cgImage = generateThumbnail(url: URL(string: url)!) {

            img.image = NSImage(cgImage: cgImage, size: NSSize(width: 192, height: 108))
        } else {
            Log("Error generating thumb")
        }
    }
    
    func generateThumbnail(url: URL) -> CGImage? {
        do {
            // Create the asset
            let asset = AVURLAsset(url: url)
            
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            return try imageGenerator.copyCGImage(at: .zero,
                                                            actualTime: nil)
            
            /*
             let saveURL = URL(fileURLWithPath: getPath(forVideo: video))
             
             try writeImage(image: NSImage(cgImage: cgImage, size: thumbSize),
             usingType: .png,
             withSizeInPixels: thumbSize,
             to: saveURL)
             */
        } catch {
            Log(error.localizedDescription)
        }
        
        return nil
    }
    
}

