//
//  ChartView.swift
//  DollarChartTest
//
//  Created by Mauricio Rodriguez on 20/04/21.
//

import UIKit
import Charts

class ChartView: UIViewController, ChartViewProtocol, ChartViewDelegate {

    @IBOutlet weak var chartView: CustomLineChart!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    var valuesDollar: [String: Double] = [:]
    var valuesEuro: [String: Double] = [:]
    var valuesDollarTwo: [String: Double] = [:]
    var valuesEuroTwo: [String: Double] = [:]
    var valuesDollarThree: [String: Double] = [:]
    var valuesEuroThree: [String: Double] = [:]
    var valuesDollarFour: [String: Double] = [:]
    var valuesEuroFour: [String: Double] = [:]
    var referenceTimeInterval: TimeInterval = 0
    var dataVals : [ChartDataEntry] = []
    var dataChart : [ChartData] = []
    var chartMarkers: [ChartData] = []
    var dateEur = [String]()
    var valuesEur = [Double]()
    var dateDoll = [String]()
    var valuesDoll = [Double]()
    var line: LineChartDataSet? = nil
    var presenter: ChartPresenterProtocol?
    var daysFilter: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVIPER()
        setUpFilters()
        getDate(daysFilter: 1)
    }
    
    // MARK: - Init components
    func configVIPER(){
        ChartRouter.createModule(chartRef: self)
    }
    
    func setUpFilters() {
        firstButton.setTitleColor(UIColor.red, for: .normal)
        firstButton.layer.cornerRadius = firstButton.frame.width / 2
        firstButton.clipsToBounds = true
        firstButton.setTitle("8D", for: .normal)
        
        secondButton.layer.cornerRadius = firstButton.frame.width / 2
        secondButton.clipsToBounds = true
        secondButton.setTitle("16D", for: .normal)
        
        thirdButton.layer.cornerRadius = firstButton.frame.width / 2
        thirdButton.clipsToBounds = true
        thirdButton.setTitle("24D", for: .normal)
        
        fourthButton.layer.cornerRadius = firstButton.frame.width / 2
        fourthButton.clipsToBounds = true
        fourthButton.setTitle("32D", for: .normal)
    }
    
    func getDate(daysFilter: Int) {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        switch daysFilter {
        case 1:
            let endDate = Date()
            let dayComp = DateComponents(day: -8)
            let date = Calendar.current.date(byAdding: dayComp, to: Date())
            let formatteEndDate = format.string(from: endDate)
            let formattedDate = format.string(from: date!)
            presenter?.getDataChart(date: formattedDate, endDate: formatteEndDate)
            break
        case 2:
            let endDayComp = DateComponents(day: -9)
            let dateCompo = DateComponents(day: -17)
            let endDate = Calendar.current.date(byAdding: endDayComp, to: Date())
            let date = Calendar.current.date(byAdding: dateCompo, to: Date())
            let formatteEndDate = format.string(from: endDate!)
            let formattedDate = format.string(from: date!)
            presenter?.getDataChart(date: formattedDate, endDate: formatteEndDate)
            break
        case 3:
            let endDayComp = DateComponents(day: -18)
            let dateCompo = DateComponents(day: -25)
            let endDate = Calendar.current.date(byAdding: endDayComp, to: Date())
            let date = Calendar.current.date(byAdding: dateCompo, to: Date())
            let formatteEndDate = format.string(from: endDate!)
            let formattedDate = format.string(from: date!)
            presenter?.getDataChart(date: formattedDate, endDate: formatteEndDate)
            break
        case 4:
            let endDayComp = DateComponents(day: -26)
            let dateCompo = DateComponents(day: -33)
            let endDate = Calendar.current.date(byAdding: endDayComp, to: Date())
            let date = Calendar.current.date(byAdding: dateCompo, to: Date())
            let formatteEndDate = format.string(from: endDate!)
            let formattedDate = format.string(from: date!)
            presenter?.getDataChart(date: formattedDate, endDate: formatteEndDate)
            break
        default:
            break
        }
    }
    
    func customizeChart(dollar: [String: Double], euro: [String: Double]) {
        chartView.clear()
        chartView.clearValues()
        line?.removeAll()
        line?.notifyDataSetChanged()
        
        // LineChart configuration
        chartView.delegate = self
        chartView.chartDescription.enabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.backgroundColor = .white

        let yAxis = chartView.leftAxis
        yAxis.drawGridLinesEnabled = true
        yAxis.enabled = true
        yAxis.axisLineColor = UIColor.gray
        yAxis.labelTextColor = UIColor.gray
        yAxis.setLabelCount(7, force: false)
        
        let xAxis = chartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.enabled = false

        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = true
        chartView.dragEnabled = true
        chartView.highlightPerTapEnabled = true
        chartView.animate(xAxisDuration: 2.5)
        chartView.highlightPerTapEnabled = true
        chartView.isUserInteractionEnabled = true
        chartView.noDataText = ""
        
        let valFormatter = NumberFormatter()
        valFormatter.numberStyle = .currency
        valFormatter.maximumFractionDigits = 2
        valFormatter.currencySymbol = "$"
        chartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
        
        let marker = RadarMarkerView.viewFromXib()!
        marker.chartView = chartView
        chartView.marker = marker
        setDataChart(dollar: dollar, euro: euro)
        let dragRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didDragChart))
        chartView.addGestureRecognizer(dragRecognizer)
    }
    
    func setDataChart(dollar: [String: Double], euro: [String: Double]) {
        let sortedByDateEur = euro.sorted {$0.key < $1.key}
        let sortedByDateDoll = dollar.sorted {$0.key < $1.key}

        for (key, value) in sortedByDateEur {
            dateEur.append(key)
            valuesEur.append(value)
        }

        for (key, value) in sortedByDateDoll {
            dateDoll.append(key)
            valuesDoll.append(value)
        }

        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0..<dateEur.count{
            yVals1.append(ChartDataEntry(x: valuesEur[i], y: valuesEur[i]))
        }
        
        let set1: LineChartDataSet = LineChartDataSet(entries: yVals1, label: "Euro Price")
        set1.mode = .cubicBezier
        set1.lineWidth = 4.5
        set1.circleRadius = 0
        set1.setColor(.red)
        set1.highlightColor = UIColor.white
        set1.drawCircleHoleEnabled = false
        set1.drawFilledEnabled = false
        set1.drawVerticalHighlightIndicatorEnabled = true
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightEnabled = false
        set1.highlightColor = .red

        var yVals2 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0..<dateDoll.count{
            yVals2.append(ChartDataEntry(x: valuesDoll[i], y: valuesDoll[i]))
        }
        let set2: LineChartDataSet = LineChartDataSet(entries: yVals2, label: "Dollar Price")
        set1.mode = .cubicBezier
        set1.lineWidth = 4.5
        set1.circleRadius = 0
        set1.setColor(.red)
        set1.highlightColor = UIColor.white
        set1.drawCircleHoleEnabled = false
        set1.drawFilledEnabled = false
        set1.drawVerticalHighlightIndicatorEnabled = true
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightEnabled = false
        set1.highlightColor = .red

        let lineChartData = LineChartData(dataSets: [set1, set2])
        self.chartView.data = lineChartData
    }

    @IBAction func didDragChart(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .ended, .cancelled:
            chartView.highlightValues(nil)
        default:
            break
        }
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func returnChart(data: ResponseChart) {
        self.customizeChart(dollar: data.usdMxn, euro: data.eurMxn)
    }
    
    @IBAction func firstFilter(_ sender: Any) {
        getDate(daysFilter: 1)
        firstButton.setTitleColor(UIColor.red, for: .normal)
        secondButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
        thirdButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
        fourthButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
    }
    
    @IBAction func secondFilter(_ sender: Any) {
        getDate(daysFilter: 2)
        secondButton.setTitleColor(UIColor.red, for: .normal)
        firstButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
        thirdButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
        fourthButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
    }
    
    
    @IBAction func thirdFilter(_ sender: Any) {
        getDate(daysFilter: 3)
        thirdButton.setTitleColor(UIColor.red, for: .normal)
        secondButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
        firstButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
        fourthButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
    }
    
    @IBAction func fourthFilter(_ sender: Any) {
        getDate(daysFilter: 4)
        fourthButton.setTitleColor(UIColor.red, for: .normal)
        secondButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
        thirdButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
        firstButton.setTitleColor(UIColor(hexString: "017847"), for: .normal)
    }
}
