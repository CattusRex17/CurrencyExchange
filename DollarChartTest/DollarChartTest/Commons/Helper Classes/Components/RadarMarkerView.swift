//
//  RadarMarkerView.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import Foundation
import Charts
#if canImport(UIKit)
import UIKit
#endif

public class RadarMarkerView: MarkerView {
    
    @IBOutlet var label: UILabel!
    
    public override func awakeFromNib() {
        self.offset.x = -self.frame.size.width / 2.0
        self.offset.y = -self.frame.size.height * 20
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        label.text = ""
        layoutIfNeeded()
    }
}
