//  ViewController.swift
//  TicTacToe2
//
//  Created by Eri Shimada on 2020/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowRadius = 15
        button.layer.shadowOpacity = 1
        button.layer.cornerRadius = 15

    }

    @IBAction func buttonTapped(_ sender: UIButton) {

    }

}

extension UIColor {
  convenience init(hex: String) {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }
    if (cString.count) != 6 {
      self.init(red: CGFloat(255), green: CGFloat(255), blue: CGFloat(255), alpha: 1.0)
    }
    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
