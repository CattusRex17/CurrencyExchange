//
//  CustomLineChart.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import Foundation
import Charts

class CustomLineChart: LineChartView {
    override func gestureRecognizer(_ gestureRecognizer: NSUIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: NSUIGestureRecognizer) -> Bool {
        return true
    }
}
