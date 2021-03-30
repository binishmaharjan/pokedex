//
//  BoxedBorder.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/03/30.
//

import UIKit

final class BoxedBorder: CALayer {
  /// 色　上から順に、左から右に配置する
  private let colors: [UIColor] = [
    .blue,
    .red,
    .orange,
    .green,
    .systemPink
  ]
  /// 配置された色レイヤー
  private var colorLayers: [CALayer] = []
  /// 親矩形変更見張り
  private var statusObserver: NSKeyValueObservation?
  /// カラーバーの太さ
  var thickness: CGFloat = 2
  override init() {
    super.init()
    addColorBarLayer()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    addColorBarLayer()
  }
  /// 各色レイヤー作成
  private func addColorBarLayer() {
    for color in colors {
      let colorLayer = CALayer()
      colorLayer.backgroundColor = color.cgColor
      addSublayer(colorLayer)
      colorLayers.append(colorLayer)
    }
  }
  /// 各色レイヤー再配置
  override func layoutSublayers() {
    super.layoutSublayers()
    var box = bounds
    box.size.width /= CGFloat(colorLayers.count)
    for colorLayer in colorLayers {
      colorLayer.frame = box
      box = box.offsetBy(dx: box.size.width, dy: 0)
    }
  }
  /// 見張りを外す
  override func removeFromSuperlayer() {
    super.removeFromSuperlayer()
    statusObserver = nil
  }
  /// 親矩形変更見張りの設定
  func adapt(layer: CALayer) {
    layer.addSublayer(self)
    statusObserver = layer.observe(\.bounds, changeHandler: { [weak self] _, _ in
      if let self = self, var frame = self.superlayer?.bounds {
        frame.origin.y += frame.size.height
        frame.size.height = self.thickness
        self.frame = frame
        print("myframe: \(frame)")
      }
    })
    layer.setNeedsLayout()
  }
    
    ///  直接設定
    func add(for layer: CALayer) {
      layer.addSublayer(self)
      frame = CGRect(x: 0, y: layer.frame.height - thickness, width: layer.frame.width, height: thickness)
      layer.setNeedsLayout()
    }
}
