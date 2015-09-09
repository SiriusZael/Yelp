//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Matt Rucker on 9/7/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    SwitchCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: FiltersViewControllerDelegate?
    
    var sectionExpanded = [1: false, 2: false, 3: false]
    
    let distanceValues = [0, 482, 1609, 8046, 32186]
    let distanceLabels = ["Auto", "0.3 miles", "1 mile", "5 miles", "20 miles"]
    
    let sortByValues = [0,1,2]
    let sortByLabels = ["Best Match", "Distance", "Rating"]
    let categories = ["fooddeliveryservices", "bars", "vegetarian", "vegan", "musicvenues", "hotdogs", "cafes"]
    
    var sortByIndex = 0
    var distanceIndex = 0
    var switchStates = [Int:[Int:Bool]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSearch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        var filters = [String: AnyObject]()
        
        filters["sortBy"] = sortByValues[sortByIndex]
        filters["distance"] = distanceValues[distanceIndex]
        filters["deals"] = switchStates[0]?[0] ?? false
        filters["categories"] = [String]()
        
        for (row, value) in switchStates[3] ?? [:] {
            if value == true {
                filters["categories"] = filters["categories"] as! [String] + [categories[row]]
            }
        }
        
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
    }
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitles = ["", "Distance", "Sort By", "Category"]
        
        if (section == 0) {
            return nil
        }
        
        var headerView = UIView(frame: CGRect(x:0, y:0, width: 320, height: 40))
        headerView.backgroundColor = UIColor.whiteColor()
        
        var headerLabel = UILabel(frame: CGRect(x:8, y:0, width:320, height: 40))
        headerLabel.text = sectionTitles[section]
        headerLabel.font = UIFont(name: "helvetica neue", size: 14)
        
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        }
        
        return 40.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var section = indexPath.section
        if (section == 1 || section == 2) {
            if (sectionExpanded[section] == true) {
                sectionExpanded[section] = false
                
                if (section == 1) {
                    distanceIndex = indexPath.row
                } else if (section == 2) {
                    sortByIndex = indexPath.row
                }
            } else {
                sectionExpanded[section] = true
            }
        }
        
        
//        if (section == 3 && indexPath.row == 3 && !sectionExpanded[section]!) {
//            sectionExpanded[section] = true
////            for category in categoriesSelected {
////                categoryRowsSelected.append(find(generalCategoriesValues, category)!)
////            }
//        }
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var section = indexPath.section
//        if (section == 3 && indexPath.row == 3 && !sectionExpanded[section]!) {
//            var cell = tableView.dequeueReusableCellWithIdentifier("CategorySeeAllCell") as CategorySeeAllCell
//            cell.selectionStyle = UITableViewCellSelectionStyle.None
//            return cell
//        }
        
        if (section == 0 || section == 3) {
            var cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell") as! SwitchCell
            
            if (section == 0) {
                cell.switchLabel.text = "Deal"
            } else {
                cell.switchLabel.text = categories[indexPath.row]
            }
            
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.settingSwitch.on = switchStates[indexPath.section]?[indexPath.row] ?? false
            
            return cell
            
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("DropdownCell") as! DropdownCell
            cell.selectImageView.hidden = true
            
            if (!sectionExpanded[section]!) {
                cell.downPointerImageView.hidden = false
                cell.unSelectImageView.hidden = true
                
                if (section == 1) {
                    cell.nameLabel.text = distanceLabels[self.distanceIndex]
                } else if section == 2 {
                    cell.nameLabel.text = sortByLabels[self.sortByIndex]
                }
            } else {
                cell.downPointerImageView.hidden = true
                cell.unSelectImageView.hidden = false
                
                if (section == 1) {
                    cell.nameLabel.text = distanceLabels[indexPath.row]
                    if indexPath.row == distanceIndex {
                        cell.selectImageView.hidden = false
                        cell.unSelectImageView.hidden = true
                    }
                } else if (section == 2) {
                    cell.nameLabel.text = sortByLabels[indexPath.row]
                    if indexPath.row == sortByIndex {
                        cell.selectImageView.hidden = false
                        cell.unSelectImageView.hidden = true
                    }
                }
            }
            
            cell.sectionExpanded = sectionExpanded[section]!
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionRows = [1, 1, 1, 4]
        let expandedRows = [1, 5, 3, 7]
        
        if (sectionExpanded[section] != false) {
            return expandedRows[section]
        } else {
            return sectionRows[section]
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)!
        
        if let sectionSetting = switchStates[indexPath.section] {
            switchStates[indexPath.section]![indexPath.row] = value
        } else {
            switchStates[indexPath.section] = [indexPath.row:value]
        }
    }


}
