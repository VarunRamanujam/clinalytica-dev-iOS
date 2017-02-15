//
//  TakenMedicationsTableView.swift
//  Hospital
//
//  Created by Shridhar on 2/5/17.
//
//

import UIKit

let TakenMedicationCellIdentifier = "TakenMedicationCellIdentifier"
let TakenMedicationTitleCellIdentifier = "TakenMedicationTitleCellIdentifier"

class TakenMedicationsTableView: RUITableView {

    var medications = [Medication]()
    
    func clearData() {
        for obj in medications {
            obj.clearData()
        }
        
        reloadData()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        initialzeTakenMedicationsTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialzeTakenMedicationsTableView()
    }
    
    func initialzeTakenMedicationsTableView() {
        self.addBorderAndCornerRadius()
        
        self.delegate = self
        self.dataSource = self
        
        self.register(UINib(nibName: "TakenMedicationCell", bundle: nil), forCellReuseIdentifier: TakenMedicationCellIdentifier)
        self.register(UINib(nibName: "TakenMedicationTitleCell", bundle: nil), forCellReuseIdentifier: TakenMedicationTitleCellIdentifier)
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 85.0
        
        for _ in 1...6 {
            let object = Medication()
            medications.append(object)
        }
    }
}

extension TakenMedicationsTableView : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (medications.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: TakenMedicationTitleCellIdentifier, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TakenMedicationCellIdentifier, for: indexPath) as! TakenMedicationCell
            cell.medication = medications[indexPath.row - 1]
            return cell
        }
    }
}
