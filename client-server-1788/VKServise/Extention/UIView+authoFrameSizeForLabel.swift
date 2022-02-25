//
//  UIView+authoFrameSizeForLabel.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 17.02.2022.
//

import UIKit

extension UIView {
    
    func getLabelSize(text: String, font: UIFont, instets: CGFloat, indent: CGFloat?) -> CGSize {
        
        // определяем максимальную ширину текста - это ширина ячейки минус отступы слева и справа
        let maxWidth = bounds.width - instets * 2 - (indent ?? 0)
        
        // получаем размеры блока под надпись
        // используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        
        // получаем прямоугольник под текст в этом блоке и уточняем шрифт
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        // получаем ширину блока, переводим её в Double
        let width = Double(rect.size.width)
        
        // получаем высоту блока, переводим её в Double
        let height = Double(rect.size.height)
        
        // получаем размер, при этом округляем значения до большего целого числа
        let size = CGSize(width: ceil(width), height: ceil(height))
        
        return size
    }
    
    /// Автоматическая настройка ширины лейба для оптимизации таблицы
    /// - Parameters:
    ///   - label: название лейба
    ///   - instets: отступы между элементами
    ///   - indent: размер другого элемента в ячейке, если он есть
    func setLabelFrame(label: UILabel, instets: CGFloat, indent: CGFloat?) {
        
        // получаем размер текста, передавая сам текст и шрифт
        let labelSize = getLabelSize(text: label.text ?? "", font: label.font, instets: instets, indent: indent)
        
        // рассчитываем координату по оси Х
        let labelX = instets + (indent ?? 0)
        
        // получаем точку верхнего левого угла надписи
        let labelOrigin =  CGPoint(x: labelX, y: instets / 2)
        
        // получаем фрейм и устанавливаем его UILabel
        label.frame = CGRect(origin: labelOrigin, size: labelSize)
    }
}
