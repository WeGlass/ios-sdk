//
//  DataFormDocsGroupLayouts.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class DataFormDocsGroupLayouts: TKDataFormViewController {
    let dataSource = TKDataFormEntityDataSource()
    let personalInfo = PersonalInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataForm.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.960, alpha: 1.0)
        dataSource.sourceObject = personalInfo
        
        dataSource["password"].hintText = "Ask every time"
        dataSource["password"].editorClass = TKDataFormPasswordEditor.self
        dataSource["infoProtocol"].valuesProvider = ["L2TP", "PPTP", "IPSec"]
        dataSource["encryptionLevel"].valuesProvider = [ "FIPS Compliant", "High", "Client Compatable", "Low" ]
        
        dataSource.addGroupWithName(" ", propertyNames: [ "infoProtocol" ])
        dataSource.addGroupWithName(" ", propertyNames: [ "details", "server", "account", "secure", "password", "encryptionLevel", "sendAllTraffic" ])
        
        self.dataForm.dataSource = dataSource
        self.dataForm.commitMode = TKDataFormCommitMode.OnLostFocus
        self.dataForm.groupSpacing = 20
    }
    
    //MARK: - TKDataFormDelegate
    
    override func dataForm(dataForm: TKDataForm, updateEditor editor: TKDataFormEditor, forProperty property: TKEntityProperty) {
        let feedbackDef = editor.gridLayout.definitionForView(editor.feedbackLabel)
        editor.gridLayout.setHeight(0, forRow: feedbackDef.row.integerValue)
        
        if property.name == "infoProtocol" {
            editor.style.textLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden
            let textLabelDef = editor.gridLayout.definitionForView(editor.textLabel)
            editor.gridLayout.setWidth(0, forColumn: textLabelDef.column.integerValue)
        }
        
        if editor.isKindOfClass(TKDataFormTextFieldEditor.self) && property.name != "password" {
            property.hintText = "Required"
        }
    }

    override func dataForm(dataForm: TKDataForm, updateGroupView groupView: TKEntityPropertyGroupView, forGroupAtIndex groupIndex: UInt) {
        groupView.titleView.hidden = true
        // >> dataform-groups-layout-swift
        groupView.collapsible = true
        if groupIndex == 0 {
            let grid = TKGridLayout()
            groupView.editorsContainer.layout = grid
            var row = 0
            var col = 0
            for editor in groupView.editorsContainer.items {
                let editorDefinition = grid.definitionForView(editor as! UIView)
                editorDefinition.row = row
                editorDefinition.column = col
                col += 1
                if col == 2 {
                    row += 1
                    col = 0
                }
            }
        }
        // << dataform-groups-layout-swift
    }
}
