//
//  OptionsPopOverViewController.swift
//  Hospital
//
//  Created by Shridhar on 2/4/17.
//
//

import UIKit

protocol OptionsPopOverViewControllerDelegate : class {
    func didSelectOption(sender : OptionsPopOverViewController, index : Int, title : String)
}

let OptionsCellIdentifier = "OptionsCellIdentifier"
class OptionsPopOverViewController: RUIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {

    var delegate : OptionsPopOverViewControllerDelegate?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleLabel: RUILabel!
    @IBOutlet var titleHeightConstraint: NSLayoutConstraint!
    
    var options : [String]!
    var showSerialNumbers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.popoverPresentationController!.delegate = self
        
        self.view.addBorderAndCornerRadius()
        titleLabel.text = self.title
        if self.title == nil || self.title!.isEmpty {
            titleHeightConstraint.constant = 0.0
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(RUITableViewCell.self, forCellReuseIdentifier: OptionsCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCellIdentifier, for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        cell.textLabel?.numberOfLines = 0
        if showSerialNumbers {
            cell.textLabel?.text = "\(indexPath.row + 1)=\(options[indexPath.row])"
        } else {
            cell.textLabel?.text = options[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectOption(sender: self, index: indexPath.row, title: options[indexPath.row])
        self.dismiss(animated: false, completion: nil)
    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}
