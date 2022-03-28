import Foundation
import UIKit
import React

@objc(MyAppModule)
class MyAppModule: NSObject {
  
  @objc
  func chooseFile(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock){
    let view = RCTPresentedViewController()
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.allowsEditing = true
    picker.delegate = self
//    view?.present(picker, animated: true)
    resolve("Opened picker")
    reject("Error", "Failed", nil)
  }
  
  @objc
  static func moduleName() -> [String] {
    return ["MyAppModule"]
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}


extension MyAppModule: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

}
