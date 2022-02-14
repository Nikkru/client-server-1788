//
//  UIImageView+Ratio.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 14.02.2022.
//

import UIKit

extension UIImage {
    var cropRatio: CGFloat {
        let withRatio = CGFloat(self.size.width / self.size.height)
        return withRatio
    }
}
