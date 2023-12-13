//
//  ViewController.swift
//  TextFieldTest
//
//  Created by Jerome on 11/28/23.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet private weak var textView: UITextView!
  @IBOutlet private weak var textView2: UITextView!
  
  @IBOutlet private weak var customTextView1: UITextView!
  @IBOutlet private weak var customTextView2: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.initViews()
  }
}

extension ViewController: UITextViewDelegate {
  // NOTE: custom menu를 생성해서 리턴합니다.
  func textView(_ textView: UITextView, menuConfigurationFor textItem: UITextItem, defaultMenu: UIMenu) -> UITextItem.MenuConfiguration? {
    let customMenu = UIMenu(
      title: "",
      options: .displayInline,
      children: (1...2).map { UIAction(title: "Static Item \($0)") { action in } }
      + [UIDeferredMenuElement { completion in
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          let items = (1...2).map { UIAction(title: "Dynamic Item \($0)") { action in } }
          completion([UIMenu(title: "", options: .displayInline, children: items)])
        }
      }]
      + defaultMenu.children
    )
    
    return UITextItem.MenuConfiguration(menu: customMenu)
  }
  
  // NOTE: tap 이벤트 발생 시 실행할 action을 지정합니다.
  func textView(_ textView: UITextView, primaryActionFor textItem: UITextItem, defaultAction: UIAction) -> UIAction? {
    return defaultAction
  }
}

extension ViewController {
  private func initViews() {
    self.textView.dataDetectorTypes = [.link, .phoneNumber]
    self.textView.isEditable = false
    
    self.textView2.dataDetectorTypes = [.link, .phoneNumber]
    self.textView2.isEditable = false
    
    self.customTextView1.dataDetectorTypes = [.link, .phoneNumber]
    self.customTextView1.isEditable = false
    self.customTextView1.delegate = self
    
    self.customTextView2.dataDetectorTypes = [.link, .phoneNumber]
    self.customTextView2.isEditable = false
    self.customTextView2.delegate = self
  }
}
