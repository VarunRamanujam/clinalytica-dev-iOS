//
//  PastProblemsForm16TableView.swift
//  Hospital
//
//  Created by Shridhar on 2/8/17.
//
//

import UIKit

let PastProblemsForm16TableViewCellIdentifier = "PastProblemsForm16TableViewCellIdentifier"
let PastProblemsForm16TableViewTitleCellIdentifier = "PastProblemsForm16TableViewTitleCellIdentifier"

class PastProblemsForm16TableView: RUITableView {
    
    var pastProbles = [PastProblemForm16]()
    
    func clearData() {
        for obj in pastProbles {
            obj.clearData()
        }
        
        reloadData()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        initialzePastProblemsTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialzePastProblemsTableView()
    }
    
    func initialzePastProblemsTableView() {
        
        self.addBorderAndCornerRadius()
        self.delegate = self
        self.dataSource = self
        
        self.register(UINib(nibName: "PastProblemsForm16Cell", bundle: nil), forCellReuseIdentifier: PastProblemsForm16TableViewCellIdentifier)
        self.register(UINib(nibName: "PastProblemsForm16TitleCell", bundle: nil), forCellReuseIdentifier: PastProblemsForm16TableViewTitleCellIdentifier)
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 85.0
        
        for _ in 1...6 {
            let object = PastProblemForm16()
            pastProbles.append(object)
        }
    }
}

extension PastProblemsForm16TableView : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pastProbles.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: PastProblemsForm16TableViewTitleCellIdentifier, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PastProblemsForm16TableViewCellIdentifier, for: indexPath) as! PastProblemsForm16Cell
            cell.pastProblem = pastProbles[indexPath.row - 1]
            return cell
        }
    }
}
