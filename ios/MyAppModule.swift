import Foundation
import UIKit
import React
import Foundation
import UIKit
import React

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}

@objc(MyAppModule)
class MyAppModule: NSObject {
  private let pickerController: UIImagePickerController;
  private weak var delegate: ImagePickerDelegate?;
  var promiseResolve: RCTPromiseResolveBlock?;
  
  override init() {
    self.pickerController = UIImagePickerController();
    super.init();
    self.pickerController.delegate = self
    self.pickerController.allowsEditing = true
    self.pickerController.mediaTypes = ["public.image"]
  }
  
  @objc
  func chooseFile(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      self.promiseResolve = resolve
      let view = RCTPresentedViewController()
      view?.present(self.pickerController, animated: true)
    }
  }
  
  @objc
  static func moduleName() -> [String] {
    return ["MyAppModule"]
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc
  private func pickerController(_ controller: UIImagePickerController) {
      controller.dismiss(animated: true, completion: nil)
  }
}


extension MyAppModule: UIImagePickerControllerDelegate {
  public func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
      let imgName = imgUrl.lastPathComponent
      let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
      let localPath = documentDirectory?.appending(imgName)
      let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
      let data = image.pngData()! as NSData
      data.write(toFile: localPath!, atomically: true)
      let photoURL = URL.init(fileURLWithPath: localPath!)
      self.pickerController(picker)
      self.promiseResolve!(photoURL.absoluteString)
    }
  }
}

extension MyAppModule: UINavigationControllerDelegate {
  
}
