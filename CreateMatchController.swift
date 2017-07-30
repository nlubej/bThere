//
//  CreateMatchController.swift
//  bThere
//
//  Created by Nejc Lubej on 06/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import XLForm
import RealmSwift

class CreateMatchViewController : XLFormViewController {
    
    var match: Match!
    var matchCopy: Match!
    var groups : Results<Group>!
    var isEditingMatch : Bool! {
        get {
            return match != nil && match.matchId != 0
        }
    }
    
    var dataModel : DataModel!
    
    private struct Tags {
        static let Name = "name"
        static let Location = "location"
        static let Sport = "sport"
        static let Group = "group"
        static let AllDay = "all-day"
        static let Public = "public"
        static let Start = "start"
        static let Repeat = "repeat"
        static let Reminder = "reminder"
        static let Note = "note"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //initializeForm()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //initializeForm()
    }
    
    func initializeForm() {
        
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor()
        
        
        
        section = XLFormSectionDescriptor.formSection()
        section.footerTitle = "Players can join a public match without confirmation"
        form.addFormSection(section)
        
        
        // Name
        row = XLFormRowDescriptor(tag: Tags.Name, rowType: XLFormRowDescriptorTypeText, title : "Name")
        // row.cellConfig.setValue(UIColor.red, forUndefinedKey: "tintColor")
        row.cellStyle = UITableViewCellStyle.value1
        section.addFormRow(row)
        
        
        // Location
        row = XLFormRowDescriptor(tag: Tags.Location, rowType: XLFormRowDescriptorTypeText, title: "Location")
        section.addFormRow(row)
        
        
        row = XLFormRowDescriptor(tag: Tags.Sport, rowType:XLFormRowDescriptorTypeSelectorPush, title: "Sport")
        row.value = XLFormOptionsObject(value: 0, displayText: "Soccer")
        row.selectorTitle = "Sports"
        row.selectorOptions = Array(dataModel.getSports().map{ (sport : Sport) -> XLFormOptionsObject in
            return XLFormOptionsObject(value: sport.id, displayText: sport.name)})
        section.addFormRow(row)
        
        // Alert
        groups = dataModel.getGroups()
        row = XLFormRowDescriptor(tag: Tags.Group, rowType:XLFormRowDescriptorTypeSelectorPush, title: "Group")
        row.value = XLFormOptionsObject(value: 0, displayText: "None")
        row.selectorTitle = "Groups"
        row.selectorOptions = Array(groups.map{ (group : Group) -> XLFormOptionsObject in
            return XLFormOptionsObject(value: group.groupId, displayText: group.name)})
        
        section.addFormRow(row)
        
        
        // All-day
        row = XLFormRowDescriptor(tag: Tags.Public, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Public Match")
        section.addFormRow(row)
        
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        
        // All-day
        row = XLFormRowDescriptor(tag: Tags.AllDay, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "All day")
        section.addFormRow(row)
        
        // Starts
        row = XLFormRowDescriptor(tag: Tags.Start, rowType: XLFormRowDescriptorTypeDateTimeInline, title: "Starts")
        row.value = Date(timeIntervalSinceNow: 60*60*24)
        section.addFormRow(row)
        
        
        // Repeat
        row = XLFormRowDescriptor(tag: Tags.Repeat, rowType:XLFormRowDescriptorTypeSelectorPush, title: "Repeat")
        row.value = XLFormOptionsObject(value: 0, displayText: "Never")
        row.selectorTitle = "Repeat"
        row.selectorOptions = [XLFormOptionsObject(value: 0, displayText: "Never"),
                               XLFormOptionsObject(value: 1, displayText: "Every Day"),
                               XLFormOptionsObject(value: 2, displayText: "Every Week"),
                               XLFormOptionsObject(value: 3, displayText: "Every Month"),
                               XLFormOptionsObject(value: 4, displayText: "Every Year")]
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSection()
        section.footerTitle = "Reminder will be sent only to those that have not yet responded."
        form.addFormSection(section)
        
        // Alert
        row = XLFormRowDescriptor(tag: Tags.Reminder, rowType:XLFormRowDescriptorTypeSelectorPush, title: "Reminder")
        row.value = XLFormOptionsObject(value: 0, displayText: "None")
        row.selectorTitle = "Event Reminder"
        row.selectorOptions = [
            XLFormOptionsObject(value: 0, displayText: "None"),
            XLFormOptionsObject(value: 1, displayText: "1 day before"),
            XLFormOptionsObject(value: 2, displayText: "2 days before"),
            XLFormOptionsObject(value: 3, displayText: "3 days before")]
        section.addFormRow(row)
        
        
        section = XLFormSectionDescriptor.formSection()
        form.addFormSection(section)
        
        row = XLFormRowDescriptor(tag: Tags.Note, rowType: XLFormRowDescriptorTypeTextView, title: "Notes")
        section.addFormRow(row)
        
        
        
        self.form = form
        
    }
    
    override func formRowDescriptorValueHasChanged(_ formRow: XLFormRowDescriptor!, oldValue: Any!, newValue: Any!) {
        super.formRowDescriptorValueHasChanged(formRow, oldValue: oldValue, newValue: newValue)
        
        if isEditingMatch {
            switch formRow.tag! {
                
            case Tags.Name:
                matchCopy.name = getName()
            case Tags.Location:
                matchCopy.name = getLocation()
            case Tags.Sport:
                matchCopy.sportId = getSport()
            case Tags.Group:
                matchCopy.groupId = getGroup()
            case Tags.Public:
                matchCopy.isPublic = isPublic()
            case Tags.AllDay:
                matchCopy.isAllDay = isAllDay()
            case Tags.Start:
                matchCopy.start = getStartDate()
            case Tags.Repeat:
                matchCopy.repeatTypeId = getRepeatTypeId()
            case Tags.Reminder:
                matchCopy.reminderTypeId = getReminderTypeId()
            case Tags.Note:
                matchCopy.note = getNote()
            default:
                matchCopy.name = ""
                
            }
        }
        
        if formRow.tag == Tags.AllDay {
            let startDateDescriptor = form.formRow(withTag: Tags.Start)!
            let dateStartCell: XLFormDateCell = startDateDescriptor.cell(forForm: self) as! XLFormDateCell
            if (formRow.value! as AnyObject).valueData() as? Bool == true {
                startDateDescriptor.valueTransformer = DateValueTrasformer.self
                dateStartCell.formDatePickerMode = .date
                updateFormRow(startDateDescriptor)
            }
            else{
                startDateDescriptor.valueTransformer = DateTimeValueTrasformer.self
                dateStartCell.formDatePickerMode = .dateTime
                updateFormRow(startDateDescriptor)
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dataModel = DataModel()
        
        initializeForm()
        title = isEditingMatch == true ? "Edit Match" : "New Match"
        if(!isEditingMatch)
        {
            navigationItem.leftBarButtonItem = nil
        }
        else
        {
            matchCopy = Match.copyObject(match: match)
            fillMatchData()
            
        }
        
    }
    
    private func fillMatchData() {
        
        var row = form.formRow(withTag: Tags.Name)!
        row.value = match.name
        
        row = form.formRow(withTag: Tags.Location)!
        row.value = match.location
        
        row = form.formRow(withTag: Tags.Sport)!
        row.value = XLFormOptionsObject(value: match.sportId, displayText: SportConst.getDescription(sportId: match.sportId))
        
        let groupDescription = groups.filter("groupId == \(match.groupId)").first?.name
        row = form.formRow(withTag: Tags.Group)!
        row.value = XLFormOptionsObject(value: match.groupId, displayText: groupDescription)
        row.disabled = true
        
        row = form.formRow(withTag: Tags.Repeat)!
        row.value = XLFormOptionsObject(value: match.repeatTypeId, displayText: RepeatTypeConst.getDescription(sportId: match.repeatTypeId))
        
        row = form.formRow(withTag: Tags.Reminder)!
        row.value = XLFormOptionsObject(value: match.reminderTypeId, displayText: ReminderTypeConst.getDescription(sportId: match.reminderTypeId))
        
        row = form.formRow(withTag: Tags.Public)!
        row.value = match.isPublic
        
        row = form.formRow(withTag: Tags.Start)!
        row.value = match.start
        
        row = form.formRow(withTag: Tags.Note)!
        row.value = match.note
        
        row = form.formRow(withTag: Tags.AllDay)!
        row.value = match.isAllDay
        
        if match.isAllDay {
            let startDateDescriptor = form.formRow(withTag: Tags.Start)!
            let dateStartCell: XLFormDateCell = startDateDescriptor.cell(forForm: self) as! XLFormDateCell
            startDateDescriptor.valueTransformer = DateValueTrasformer.self
            dateStartCell.formDatePickerMode = .date
            updateFormRow(startDateDescriptor)
            
        }
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let validationErrors : Array<NSError> = self.formValidationErrors() as! Array<NSError>
        if (validationErrors.count > 0){
            self.showFormValidationError(validationErrors.first)
            return
        }
        self.tableView.endEditing(true)
        if isEditingMatch {
            
            dataModel.updateMatch(matchCopy)
            performSegue(withIdentifier: "cancelToParentControlSegue", sender: self)
        }
        else {
            dataModel.insertMatch(match: Match(name: getName(), start: getStartDate(), location: getLocation(), sportId: getSport(), groupId: getGroup(), note: getNote(), isPublic: isPublic(), isAllDay: isAllDay(), reminderTypeId: getReminderTypeId(), repeatTypeId: getRepeatTypeId()))
            
            tabBarController?.selectedIndex = 0
            
            let controller = tabBarController?.viewControllers?[0].contentViewControler as? MatchesTableViewController
            controller?.reloadData()
        }
    }
    
    private func getName() -> String {
        let row = form.formRow(withTag: Tags.Name)!
        return row.value as! String
    }
    
    private func getLocation() -> String {
        let row = form.formRow(withTag: Tags.Location)!
        return row.value as! String
    }
    
    private func getNote() -> String {
        let row = form.formRow(withTag: Tags.Note)!
        return row.value as! String
    }
    
    private func getSport() -> Int {
        let row = form.formRow(withTag: Tags.Sport)!
        let result = row.value as! XLFormOptionsObject
        return result.formValue() as! Int
    }
    
    private func getGroup() -> Int {
        let row = form.formRow(withTag: Tags.Group)!
        let result = row.value as! XLFormOptionsObject
        return result.formValue() as! Int
    }
    
    private func isPublic() -> Bool {
        let row = form.formRow(withTag: Tags.Public)!
        return row.value as? Bool ?? false
    }
    
    private func isAllDay() -> Bool {
        let row = form.formRow(withTag: Tags.AllDay)!
        return row.value as! Bool
    }
    
    private func getStartDate() -> Date {
        let row = form.formRow(withTag: Tags.Start)!
        let date =  row.value as! Date
        
        return date
    }
    
    private func getReminderTypeId() -> Int {
        let row = form.formRow(withTag: Tags.Reminder)!
        let result = row.value as! XLFormOptionsObject
        return result.formValue() as! Int
    }
    
    private func getRepeatTypeId() -> Int {
        let row = form.formRow(withTag: Tags.Repeat)!
        let result = row.value as! XLFormOptionsObject
        return result.formValue() as! Int
    }
}
