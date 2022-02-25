//
//  String+Height.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 21.02.2022.
//

import UIKit

extension String {
    
    /// Автоматический подбор высоты ячейки по тексту лейба
    /// - Parameters:
    ///   - indent: ширина другого элемента ячейки, если он есть
    ///   - font: шрифт текста ячейки
    ///   - indentX: отступ по оси Х
    ///   - indentY: отступ по оси У
    /// - Returns: CGFloat - значение требуемой высоты ячейки по заданной ширине и для заданного шрифта
    func getHeightForLabel(
        indent: CGFloat?,
        font: UIFont,
        indentX: CGFloat?,
        indentY: CGFloat?) -> CGFloat {
        
        // определяем максимальную ширину текста - это ширина ячейки минус отступы слева и справа
        let maxWidth = UIScreen.main.bounds.width - (indentX ?? 0)*2 - (indent ?? 0)
        
        let labelFrame = CGRect(
            x: indentX ?? 0,
            y: indentY ?? 0,
            width: maxWidth,
            height: CGFloat.greatestFiniteMagnitude)
        
        let label = UILabel(frame: labelFrame)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
}
