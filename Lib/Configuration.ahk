﻿fEditSettings() {
    ; A_ThisHotkey
    gui GC: -AlwaysOnTop
    if ((!globalLogicSwitches.bIsAuthor & !globalLogicSwitches.bIsDebug) || (globalLogicSwitches.bIsAuthor & !globalLogicSwitches.bIsDebug)) {
        if ACS_InisettingsEditor(script.Name,script.scriptconfigfile,0,1,0) {
            reload
        } else {
            gui GC: +AlwaysOnTop
            return
        }
    }
    else
        if ACS_InisettingsEditor(script.Name,script.scriptconfigfile,0,1,1) {
            reload
        } else {
            gui GC: +AlwaysOnTop
            return
        }
}
restoredefaultConfig() {

}
setupdefaultconfig(Switch) {
    DefaultConfig=
        (LTrim

            [Version]
            ;Version Type: Text
            ;Version Hidden:
            build=124
            GFC_version=0.2.1
            [Settings]
            bDebugSwitch=0
            ;bDebugSwitch hidden
            ;bDebugSwitch Type: Checkbox
            ;bDebugSwitch CheckboxName: Enable Debugging-Mode?
            ;bDebugSwitch Allow extended logging of various information to be output in the program's directory.
            ;bDebugSwitch Default: 0
            AlwaysOnTop=0
            ;AlwaysOnTop Type: Checkbox
            ;AlwaysOnTop CheckboxName: Set the GUI to be always on top?
            ;AlwaysOnTop This will keep the gui front and center on your screen. You can still hide the GUI via the tray-menu item.
            ;AlwaysOnTop Default: 0
            sFontType_Text=Times New Roman
            ;sFontType_Text Set Font for all texts, excluding the listviews.
            ;sFontType_Text Type: DropDown Arial|Calibri|Cambria|Consolas|Comic Sans MS|Corbel|Courier|Courier New|Georgia|Lucidia Console|Lucidia Sans|MS Sans Serif|Segoe UI||Times New Roman|Tahoma|Verdana|System
            ;sFontType_Text Default: Times New Roman
            SizeSetting=auto
            ;SizeSetting Determine how to scale the GUI: Auto will calculate the GUI-dimensions based on your main monitor's size. '1080p' and '1440p' will force a scaling based on that assumption.
            ;SizeSetting Type: DropDown 1080p|1440p||auto
            ;SizeSetting Default: auto
            bRunAsAdmin=0
            ;bRunAsAdmin Do you want to always start the script with Administrator-privileges?
            ;bRunAsAdmin Type: Checkbox
            ;bRunAsAdmin CheckboxName: Always start as Administrator? (Requires restart to take effect.)
            ;bRunAsAdmin Default: 0
            GFA_Evaluation_InstallationPath=%A_ScriptDir%/GFA_Evaluation.R
            ;GFA_Evaluation_InstallationPath Type: File
            ;GFA_Evaluation_InstallationPath Please select the location of your 'GFA_Evaluation.R'-Script.
            ;GFA_Evaluation_InstallationPath By default, this utility is shipped with a copy on hand, so you can use this.
            ;GFA_Evaluation_InstallationPath
            ;GFA_Evaluation_InstallationPath
            CheckUpdatesOnScriptStart=0
            ;CheckUpdatesOnScriptStart Type: Checkbox
            ;CheckUpdatesOnScriptStart CheckboxName: Do you want to always check for updates when running the program?
            ;CheckUpdatesOnScriptStart Default:0


        )
    gfcGUIconfig=
        (LTRIM
            Experiment::blank
            %A_Tab%;; 1. General configuration
            %A_Tab%TO:DateTime|Type:String|Default:A_Now|String:"Set the T0-date for calculating 'plant-age' for your experiment, in format dd.MM.yyyy (24.12.2023)"|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%PotsPerGroup:Edit|Type:Integer|Default:7|String:"Set the number of pots per group"|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%UniqueGroups:Edit|Type:String|String:"Set the comma-separated list of all unique group names"|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%GroupsOrder:Edit|Type:String|String:"Set the comma-separated order of groups in the plots"|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%RefGroup:Edit|Type:String|String:"Set the reference group for all statistical tests"|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%Normalise:Checkbox|Type:boolean|Default:1|String:"Do you want to normalise your leaf area?"|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%Normalise_text:text|Type:String|Default:"This accesses the data-column 'plant_area_normalised'. For more info, check the documentation."|String:"This accesses the data-column 'plant_area_normalised'. For more info, check the documentation."|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%language:DDL|Type:String|Default:"English"|String:"Select language for auto-generated labels"|ctrlOptions:English,German|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%used_filesuffix:DDL|Type:String|Default:"xlsx"|String:"Select the filetype you want to ingest"|ctffrlOptions:xlsx,csv|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%Filename_Prefix:Edit|Type:String|Default:"GF"|Tab3Parent:1. General Configuration|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%Debug:Checkbox|Type:boolean|Default:0|String:"Do you want to print debug information?"|Tab3Parent:1. General Configuration|Link:"https://www.youtube.com"|Linktext:?|ConfigSection:General
            %A_Tab%;;
            %A_Tab%;;; figure
            %A_Tab%Facet2D:Checkbox|Type:boolean|Default:0|String:"Do you want to facet the plot, f.e. over a treatment? Manual options: TRUE/FALSE"|Tab3Parent:2. Figure|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%Facet2DVar:Edit|Type:String|Default:""|String:"Which Variable do you want to facet by?"|Tab3Parent:2. Figure|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%;;
            %A_Tab%Palette_Boxplot:Edit|Type:String|Default:"yellow","orange","orangered","red","darkred","black","white"|Tab3Parent:2. Figure|Link:"https://www.google.com"|ctrlOptions:w600|Linktext:?|ConfigSection:Experiment
            %A_Tab%Palette_Lines:Edit|Type:String|Default:"yellow","orange","orangered","red","darkred","black","black"|Tab3Parent:2. Figure|Link:"https://www.google.com"|ctrlOptions:w600|Linktext:?|ConfigSection:Experiment
            %A_Tab%Palette_Boxplot2:Edit|Type:String|Default:"white","yellow","orange","orangered","red","darkred","black"|Tab3Parent:2. Figure|Link:"https://www.google.com"|ctrlOptions:w600|Linktext:?|ConfigSection:Experiment
            %A_Tab%Palette_Lines2:Edit|Type:String|Default:#FFF5F0,#FEE0D2,#FCBBA1,#FC9272,#FB6A4A,#EF3B2C,#CB181D,#A50F15,whiter|Tab3Parent:2. Figure|Link:"https://www.google.com"|ctrlOptions:w600|Linktext:?|ConfigSection:Experiment
            %A_Tab%ShowNAtallboxplots:Checkbox|Type:boolean|Default:0|String:"NOT WORKING: Do you want to print 'n=XX' above every boxplot in the daily plots?"|Tab3Parent:2. Figure|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%;;
            %A_Tab%Name:Edit|Type:String|Default:"Experiment X"|String:"Set the name of the Experiment as seen in the figure title"|Tab3Parent:2. Figure|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%ShowTitle:Checkbox|Type:boolean|Default:0|String:"Do you want to show the title above each figure?"|Tab3Parent:2. Figure|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%;;
            %A_Tab%PlotMeanLine:Checkbox|Type:boolean|Default:1|String:"Do you want to plot the line connecting the means of each group's boxplots?"|Tab3Parent:2. Figure|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%PlotSampleSize:Checkbox|Type:boolean|Default:1|String:"Do you want to plot the sample size of each group's boxplots?"|Tab3Parent:2. Figure|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%Theme:Edit|Type:Integer|Default:7|String:"Choose your default theme."|Max:99|Min:1|ctrlOptions:Number|Tab3Parent:2. Figure|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%;;
            %A_Tab%;;; axes
            %A_Tab%RelativeColnames:Checkbox|Type:boolean|Default:1|String:"Do you want to display the X-positions as 'days since T0'?"|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%ShowBothColnames:Checkbox|Type:boolean|Default:0|String:"Do you want to display the X-positions as 'days since T0 - date'?"|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%ForceAxes:Checkbox|Type:boolean|Default:0|String:"Do you want to force the Y-Axis scaling? This requires setting 'YLimits'"|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%YLimits:Edit|Type:String|Default:"0,150"|String:"Set the minimum and maximum limit for the Y-Axis. Does not take effect if 'ForceAxes' is false. Used for all plots"|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%axis_units_x:Edit|Type:String|Default:Tage,days|String:"Set the unit of the X-axis. "|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%axis_units_y:Edit|Type:String|Default:cm^2,cm^2|String:"Set the unit of the Y-axis. "|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%axis_units_x_Daily:Edit|Type:String|Default:/,/|String:"Set the unit of the X-axis (for the daily plots)."|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%axis_units_y_Daily:Edit|Type:String|Default:cm^2,cm^2|String:"Set the unit of the Y-axis (for the daily plots)."|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:General
            %A_Tab%XLabel:Edit|Type:String|Default:"Time since repotting"|String:"Set the xlabel-string for the summary plot."|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%XLabel_Daily:Edit|Type:String|Default:"Treatment Groups"|String:"Set the xlabel-string for the daily analyses."|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment
            %A_Tab%YLabel:Edit|Type:String|Default:"green plant area"|String:"Set the ylabel-string for the summary plot and daily analyses."|Tab3Parent:3. Axes|Link:"https://www.google.com"|Linktext:?|ConfigSection:Experiment

        )
    if (Switch=1) {
        if (!FileExist(script.scriptconfigfile) || globalLogicSwitches.DEBUG ) {
            SplitPath % script.scriptconfigfile,,configDirectory
            if (!FileExist(configDirectory)) {
                FileCreateDir % configDirectory
            }
            DefaultConfig:=DerefAHKVariables(DefaultConfig)
            writeFile(script.scriptconfigfile,DefaultConfig,"UTF-8",,true)
            return
        }
    } else if (Switch=2) {
        if (!FileExist(script.gfcGUIconfigfile) || globalLogicSwitches.DEBUG ) {
            SplitPath % script.gfcGUIconfigfile,,configDirectory
            if (!FileExist(configDirectory)) {
                FileCreateDir % configDirectory
            }
            gfcGUIconfig:=LTrim(gfcGUIconfig)
            gfcGUIconfig:=DerefAHKVariables(gfcGUIconfig)
            writeFile(script.gfcGUIconfigfile,gfcGUIconfig,"UTF-8",,true)
            return
        }
    }
    return
    ;MsgBox 0x2024, script.name " - Restore default config", Do you want to restore the default config supplied with this program?`n`nBe aware that all settings you altered will be reset and may have to be edited again.`n`nNo backup of your old configuration will be made`n`nRestore?
    ;
    ;IfMsgBox Yes, {
    ;    writeFile(script.configfile,DefaultConfig,"UTF-8","w",true)
    ;    reload
    ;} Else IfMsgBox No, {
    ;    return
    ;}
}



;#############   Edit ini file settings in a GUI   #############################
;  A function that can be used to edit settings in an ini file within it's own
;  GUI. Just plug this function into your script.
;
;  by Rajat, mod by toralf
;  www.autohotkey.com/forum/viewtopic.php?p=69534#69534
;
;   Tested OS: Windows XP Pro SP2
;   AHK_version= 1.0.44.09     ;(http://www.autohotkey.com/download/)
;   Language: English
;   Date: 2006-08-23
;
;   Version: 6
;
; changes since 5:
; - add key type "checkbox" with custom control name
; - added key field options (will only apply in Editor window)
; - whole sections can be set hidden
; - reorganized code in Editor and Creator
; - some fixes and adjustments
; changes since 1.4
; - Creator and Editor GUIs are resizeable (thanks Titan). The shortened Anchor function
;    is added with a long name, to avoid nameing conflicts and avoid dependencies.
; - switched from 1.x version numbers to full integer version numbers
; - requires AHK version 1.0.44.09
; - fixed blinking of description field
; changes since 1.3:
; - added field option "Hidden" (thanks jballi)
; - simplified array naming
; - shorted the code
; changes since 1.2:
; - fixed a bug in the description (thanks jaballi and robiandi)
; changes since 1.1:
; - added statusbar (thanks rajat)
; - fixed a bug in Folder browsing
; changes since 1.0:
; - added default value (thanks rajat)
; - fixed error with DisableGui=1 but OwnedBy=0 (thanks kerry)
; - fixed some typos
;  
; format:
; =======
;   IniSettingsEditor(ProgName, IniFile[, OwnedBy = 0, DisableGui = 0])
;
; with
;   ProgName - A string used in the GUI as text to describe the program 
;   IniFile - that ini file name (with path if not in script directory)
;   OwnedBy - GUI ID of the calling GUI, will make the settings GUI owned
;   DisableGui - 1=disables calling GUI during editing of settings
;
; example to call in script:
;   IniSettingsEditor("Hello World", "Settings.ini", 0, 0)
;
; Include function with:
;   #Include Func_IniSettingsEditor_v6.ahk
;
; No global variables needed.
;
; features:
; =========
; - the calling script will wait for the function to end, thus till the settings
;     GUI gets closed. 
; - Gui ID for the settings GUI is not hard coded, first free ID will be used 
; - multiple description lines (comments) for each key and section possible 
; - all characters are allowed in section and key names
; - when settings GUI is started first key in first section is pre-selected and
;     first section is expanded
; - tree branches expand when items get selected and collapse when items get
;     unselected
; - key types besides the default "Text" are supported 
;    + "File" and "Folder", will have a browse button and its functionality 
;    + "Float" and "Integer" with consistency check 
;    + "Hotkey" with its own hotkey control 
;    + "DateTime" with its own datetime control and custom format, default is
;        "dddd MMMM d, yyyy HH:mm:ss tt"
;    + "DropDown" with its own dropdown control, list of choices has to be given
;        list is pipe "|" separated 
;    + "Checkbox" where the name of the checkbox can be customized
; - default value can be specified for each key 
; - keys can be set invisible (hidden) in the tree
; - to each key control additional AHK specific options can be assigned  
;
; format of ini file:
; ===================
;     (optional) descriptions: to help the script's users to work with the settings 
;     add a description line to the ini file following the relevant 'key' or 'section'
;     line, put a semi-colon (starts comment), then the name of the key or section
;     just above it and a space, followed by any descriptive helpful comment you'd
;     like users to see while editing that field. 
;     
;     e.g.
;     [SomeSection]
;     ;somesection This can describe the section. 
;     Somekey=SomeValue 
;     ;somekey Now the descriptive comment can explain this item. 
;     ;somekey More then one line can be used. As many as you like.
;     ;somekey [Type: key type] [format/list] 
;     ;somekey [Default: default key value] 
;     ;somekey [Hidden:] 
;     ;somekey [Options: AHK options that apply to the control] 
;     ;somekey [CheckboxName: Name of the checkbox control] 
;     
;     (optional) key types: To limit the choice and get correct input a key type can
;     be set or each key. Identical to the description start an extra line put a
;     semi-colon (starts comment), then the name of the key with a space, then the
;     string "Type:" with a space followed by the key type. See the above feature
;     list for available key types. Some key types have custom formats or lists,
;     they are written after the key type with a space in-between.
;     
;     (optional) default key value: To allow a easy and quick way back to a 
;     default value, you can specify a value as default. If no default is given,
;     users can go back to the initial key value of that editing session.
;     Format: Identical to the description start an extra line, put a semi-colon
;     (starts comment line), then the name of the key with a space, then the
;     string "Default:" with a space followed by the default value.
;
;     (optional) hide key in tree: To hide a key from the user, a key can be set 
;     hidden.
;     Format: Identical to the description start an extra line, put a semi-colon
;     (starts comment line), then the name of the key with a space, then the
;     string "Hidden:".
;
;     (optional) add additional AHK options to key controls. To limit the input
;     or enforce a special input into the key controls in the GUI, additional 
;     AHK options can be specified for each control.
;     Format: Identical to the description start an extra line, put a semi-colon
;     (starts comment line), then the name of the key with a space, then the
;     string "Options" with a space followed by a list of AHK options for that
;     AHK control (all separated with a space).
;
;     (optional) custom checkbox name: To have a more relavant name then e.g.
;     "status" a custom name for the checkbox key type can be specified.
;     Format: Identical to the description start an extra line, put a semi-colon
;     (starts comment line), then the name of the key with a space, then the
;     string "CheckboxName:" with a space followed by the name of the checkbox.
;
;
; limitations:
; ============
; - ini file has to exist and created manually or with the IniFileCreator script
; - section lines have to start with [ and end with ]. No comments allowed on
;     same line
; - ini file must only contain settings. Scripts can't be used to store setting,
;     since the file is read and interpret as a whole. 
; - code: can't use g-labels for tree or edit fields, since the arrays are not
;     visible outside the function, hence inside the g-label subroutines. 
; - code: can't make GUI resizable, since this is only possible with hard
;     coded GUI ID, due to %GuiID%GuiSize label

ACS_IniSettingsEditor(ProgName,IniFile,OwnedBy = 0,DisableGui = 0, ShowHidden = 0) {
    static pos
    global bSettingsChanged:=false
    ;Find a GUI ID that does not exist yet 
    Loop, 99 { 
        Gui %A_Index%:+LastFoundExist
        If not WinExist() { 
            SettingsGuiID = %A_Index% 
            break 
        }Else If (A_Index = 99){ 
            MsgBox 4112, Error in IniSettingsEditor function, Can't open settings dialog,`nsince no GUI ID was available.
            Return 0   
        } 
    } 
    Gui %SettingsGuiID%:Default

    ;apply options to settings GUI 
    If OwnedBy { 
        Gui +ToolWindow +Owner%OwnedBy%
        If DisableGui 
            Gui %OwnedBy%:+Disabled
    }Else
        DisableGui := False 

    Gui +Resize +LabelGuiIniSettingsEditor
    vCheckOldSizes:=0
    ;create GUI (order of the two edit controls is crucial, since ClassNN is order dependent) 
    if vCheckOldSizes
    {
        ;; OLD VERSION - more compact. I prefer a bigger gui when editing, as I often have much longer variable names and texts
        Gui Add, Statusbar
        Gui Add, TreeView, x16 y75 w180 h242 0x400
        Gui Add, Edit, x215 y114 w340 h20,                           ;ahk_class Edit1
        Gui Add, Edit, x215 y174 w340 h100 ReadOnly,                 ;ahk_class Edit2
        Gui Add, Button, x250 y335 w70 h30 gExitSettings , E&xit     ;ahk_class Button1
        Gui Add, Button, x505 y88 gBtnBrowseKeyValue Hidden, B&rowse ;ahk_class Button2
        Gui Add, Button, x215 y274 gBtnDefaultValue, &Restore        ;ahk_class Button3
        Gui Add, DateTime, x215 y114 w340 h20 Hidden,                ;ahk_class SysDateTimePick321
        Gui Add, Hotkey, x215 y114 w340 h20 Hidden,                  ;ahk_class msctls_hotkey321
        Gui Add, DropDownList, x215 y114 w340 h120 Hidden,           ;ahk_class ComboBox1
        Gui Add, CheckBox, x215 y114 w340 h20 Hidden,                ;ahk_class Button4
        Gui Add, GroupBox, x4 y63 w560 h263 ,                        ;ahk_class Button5
        Gui Font, Bold
        Gui Add, Text, x215 y93, Value                               ;ahk_class Static1
        Gui Add, Text, x215 y154, Description                        ;ahk_class Static2
        Gui Add, Text, x45 y48 w480 h20 +Center, ( All changes are Auto-Saved )
        Gui Font, S16 CDefault Bold, Verdana
        Gui Add, Text, x45 y13 w480 h35 +Center, Settings for %ProgName%

    }
    Else
    {
        Gui Add, Statusbar
        Gui Add, TreeView, x16 y75 w320 h484 0x400                                                       ; w180 h284 â†’ w+140, h+242
        ; Gui, Add, Edit, x360 y114 w340 h20,                           ;ahk_class Edit1
        Gui Add, Edit, x360 y114 w340 h20,                           ;ahk_class Edit1
        Gui Add, Edit, x360 y174 w340 h355 ReadOnly,                 ;ahk_class Edit2
        Gui Add, Button, x390 y533 w70 h30 gExitSettings , E&xit     ;ahk_class Button1
        Gui Add, Button, x505 y88 gBtnBrowseKeyValue Hidden, B&rowse ;ahk_class Button2
        Gui Add, Button, x505 y533 w70 h30 gBtnDefaultValue, &Restore        ;ahk_class Button3
        Gui Add, DateTime, x360 y114 w340 h20 Hidden,                ;ahk_class SysDateTimePick321
        Gui Add, Hotkey, x360 y114 w340 h20 Hidden,                  ;ahk_class msctls_hotkey321
        Gui Add, DropDownList, x360 y114 w340 h120 Hidden,           ;ahk_class ComboBox1
        Gui Add, CheckBox, x360 y114 w340 h20 Hidden,                ;ahk_class Button4
        Gui Add, GroupBox, x4 y63 w712 h504 ,                        ;ahk_class Button5
        Gui Font, Bold
        Gui Add, Text, x360 y93, Value                               ;ahk_class Static1
        Gui Add, Text, x360 y154, Description                        ;ahk_class Static2
        Gui Add, Text, x45 y48 w480 h20 +Center, ( All changes are Auto-Saved )
        Gui Font, S16 CDefault Bold, Verdana
        Gui Add, Text, x45 y13 w480 h35 +Center, Settings for %ProgName%

    }



    ;read data from ini file, build tree and store values and description in arrays 
    Loop, Read, %IniFile% 
    { 
        CurrLine = %A_LoopReadLine% 
        CurrLineLength := StrLen(CurrLine) 

        ;blank line 
        If CurrLine is space 
            Continue 

        ;description (comment) line 
        If ( InStr(CurrLine,";") = 1 ){
            StringLeft chk2, CurrLine, % CurrLength + 2
            StringTrimLeft Des, CurrLine, % CurrLength + 2 ; create the description.
            ;description of key
            If ( %CurrID%Sec = False AND ";" CurrKey A_Space = chk2){ 
                ;handle key types  
                If ( InStr(Des,"Type: ") = 1 ){ 
                    StringTrimLeft Typ, Des, 6
                    Typ = %Typ% 
                    Des = `n%Des%     ;add an extra line to the type definition in the description control

                    ;handle format or list  
                    If (InStr(Typ,"DropDown ") = 1) {
                        StringTrimLeft Format, Typ, 9
                        %CurrID%For = %Format%
                        Typ = DropDown
                        Des =
                    }Else If (InStr(Typ,"DateTime") = 1) {
                        StringTrimLeft Format, Typ, 9
                        If Format is space
                            Format = dddd MMMM d, yyyy HH:mm:ss tt 
                        %CurrID%For = %Format%
                        Typ = DateTime
                        Des =
                    }
                    ;set type
                    %CurrID%Typ := Typ 
                    ;remember default value
                }Else If ( InStr(Des,"Default: ") = 1 ){ 
                    StringTrimLeft Def, Des, 9
                    %CurrID%Def = %Def% 
                    ;remember custom options  
                }Else If ( InStr(Des,"Options: ") = 1 ){ 
                    StringTrimLeft Opt, Des, 9
                    %CurrID%Opt = %Opt%
                    Des =
                    ;remove hidden keys from tree
                }Else If ( InStr(Des,"Hidden:") = 1 ) and (!ShowHidden){   ; allow override of invisible keys/sections if variable is specified - such as a developer wanting to edit hidden variables easier.
                    TV_Delete(CurrID)
                    Des =
                    CurrID =
                    ;handle checkbox name
                }Else If ( InStr(Des,"CheckboxName: ") = 1 ){  
                    StringTrimLeft ChkN, Des, 14
                    %CurrID%ChkN = %ChkN%  
                    Des =
                } 
                %CurrID%Des := %CurrID%Des "`n" Des 
                ;; testing code
                ; d:=%CurrID%Des
                ; tooltip, % d
                ;; testing code end - remove at end.
                ;description of section 
            } Else If ( %CurrID%Sec = True AND ";" CurrSec A_Space = chk2 ){
                ;remove hidden section from tree
                If ( InStr(Des,"Hidden:") = 1 ) and (!ShowHidden) {  
                    TV_Delete(CurrID)
                    Des =
                    CurrSecID =
                }
                ;set description
                %CurrID%Des := %CurrID%Des "`n" Des 
            } 
            ;remove leading and trailing whitespaces and new lines
            If ( InStr(%CurrID%Des, "`n") = 1 )
                StringTrimLeft %CurrID%Des, %CurrID%Des, 1
            Continue 
        } 

        ;section line 
        If ( InStr(CurrLine, "[") = 1 And InStr(CurrLine, "]", "", 0) = CurrLineLength) { 
            ;extract section name
            StringTrimLeft CurrSec, CurrLine, 1
            StringTrimRight CurrSec, CurrSec, 1
            CurrSec = %CurrSec% 
            CurrLength := StrLen(CurrSec)  ;to easily trim name off of following comment lines

            ;add to tree
            CurrSecID := TV_Add(CurrSec)
            CurrID = %CurrSecID%
            %CurrID%Sec := True
            CurrKey =
            Continue 
        } 

        ;key line 
        Pos := InStr(CurrLine,"=") 
        If ( Pos AND CurrSecID ){ 
            ;extract key name and its value
            StringLeft CurrKey, CurrLine, % Pos - 1
            StringTrimLeft CurrVal, CurrLine, %Pos%
            CurrKey = %CurrKey%             ;remove whitespaces
            CurrVal = %CurrVal% 
            CurrLength := StrLen(CurrKey)

            ;add to tree and store value
            CurrID := TV_Add(CurrKey,CurrSecID) 
            %CurrID%Val := CurrVal
            %CurrID%Sec := False

            ;store initial value as default for restore function
            ;will be overwritten if default is specified later on comment line
            %CurrID%Def := CurrVal 
        } 
    } 

    ;select first key of first section and expand section
    TV_Modify(TV_GetChild(TV_GetNext()), "Select")

    ;show Gui and get UniqueID
    ; Gui, Show, w570 h400, %ProgName% Settings 
    Gui Show,, %ProgName% Settings
    Gui +LastFound
    GuiID := WinExist() 

    ;check for changes in GUI 
    Loop { 
        ;get current tree selection 
        CurrID := TV_GetSelection() 

        If SetDefault { 
            %CurrID%Val := %CurrID%Def 
            LastID = 0
            SetDefault := False
            SetDefault_Checkbox:=true
            ValChanged := True
        } 

        MouseGetPos,,, AWinID, ACtrl
        If ( AWinID = GuiID){ 
            If ( ACtrl = "Button3")  
                SB_SetText("Restores Value to default (if specified), else restores it to initial value before change")
        } Else 
            SB_SetText("") 

        ;change GUI content if tree selection changed 
        If (CurrID <> LastID) {
            ;remove custom options from last control
            Loop, Parse, InvertedOptions, %A_Space%
                GuiControl %A_Loopfield%, %ControlUsed%

            ;hide/show browse button depending on key type
            Typ := %CurrID%Typ 
            If Typ in File,Folder 
                GuiControl Show , Button2,
            Else 
                GuiControl Hide , Button2,

            ;set the needed value control depending on key type
            If (Typ = "DateTime")
                ControlUsed = SysDateTimePick321
            Else If ( Typ = "Hotkey" )
                ControlUsed = msctls_hotkey321
            Else If ( Typ = "DropDown")
                ControlUsed = ComboBox1
            Else If ( Typ = "CheckBox")
                ControlUsed = Button4
            Else                    ;e.g. Text,File,Folder,Float,Integer or No Tyo (e.g. Section) 
                ControlUsed = Edit1

            ;hide/show the value controls
            Controls = SysDateTimePick321,msctls_hotkey321,ComboBox1,Button4,Edit1  
            Loop, Parse, Controls, `,
                If ( ControlUsed = A_LoopField )
                    GuiControl Show , %A_LoopField%,
            Else
                GuiControl Hide , %A_LoopField%,

            If ( ControlUsed = "Button4" )
                GuiControl,  , Button4, % %CurrID%ChkN

            ;get current options
            CurrOpt := %CurrID%Opt
            ;apply current custom options to current control and memorize them inverted
            InvertedOptions =   
            Loop, Parse, CurrOpt, %A_Space%
            {
                ;get actual option name
                StringLeft chk, A_LoopField, 1
                StringTrimLeft chk2, A_LoopField, 1
                If chk In +,-
                {
                    GuiControl %A_LoopField%, %ControlUsed%
                    If (chk = "+")
                        InvertedOptions = %InvertedOptions% -%chk2%
                    Else
                        InvertedOptions = %InvertedOptions% +%chk2%
                }Else {
                    GuiControl +%A_LoopField%, %ControlUsed%
                    InvertedOptions = %InvertedOptions% -%A_LoopField%
                }
            }

            If %CurrID%Sec {                      ;section got selected
                CurrVal =                        
                GuiControl, , Edit1,
                GuiControl Disable , Edit1,
                GuiControl Disable , Button3,
            }Else {                               ;new key got selected
                CurrVal := %CurrID%Val   ;get current value
                GuiControl, , Edit1, %CurrVal%   ;put current value in all value controls
                GuiControl Text, SysDateTimePick321, % %CurrID%For
                GuiControl, , SysDateTimePick321, %CurrVal%
                GuiControl, , msctls_hotkey321, %CurrVal%
                GuiControl, , ComboBox1, % "|" %CurrID%For
                GuiControl ChooseString, ComboBox1, %CurrVal%
                GuiControl, , Button4 ,     ;; Untested Hotfix for the Checkbox not clearing correctly. This means you cannot give anymore direct prompts, but you can use the description-edit field for that instead.
                guicontrol, ,Button4, %CurrVal%
                ; anchor here 
                if (ControlUsed="Button4") ;; Tested Hotfix for the Checkbox string not displaying after using the above hotfix to alway clear it. Allows direct checkbox prompts to be given again, this time without clearing-issues.
                {
                    CurrVal:=%CurrID%ChkN
                    GuiControl, , Button4 , %CurrVal%
                    ; GuiControl,  
                }
                Else
                    GuiControl, , Button4 , %CurrVal%
                GuiControl Enable , Edit1,
                GuiControl Enable , Button3,
                ; GuiControl, Chec

                ;;; There doesn't seem to be code to clear the description out from the previous type 
                ;;; when selecting 'CheckBox' as your next type. 


            } 
            If  !(%CurrID%Sec) 	; normal key was selected
            {                      
                GuiControl, , Edit2, ; clear out the description-field to avoid larger previous texts from "ghosting" behind the new entry.
                GuiControl, , Edit2, % %CurrID%Des
            }
            if (%CUrrID%Sec) 	; section got selected
            {
                GuiControl, , Edit2,
                GuiControl, , Edit2, % %CurrID%Des
            }
        }
        LastID = %CurrID%                   ;remember last selection

        ;sleep to reduce CPU load
        Sleep 100

        ;exit endless loop, when settings GUI closes 
        If not WinExist("ahk_id" GuiID) 
            Break 

        ;if key is selected, get value
        If (%CurrID%Sec = False){
            ; if (%CurrID%Typ!="Checkbox")
            GuiControlGet NewVal, , %ControlUsed%  ; get the new value from the recent input
            ;save key value when it has been changed 
            If ( NewVal <> CurrVal OR ValChanged ) {
                ValChanged := False
                if (Typ= "Checkbox")
                {
                    ;  d:=%CurrID%Val
                    ; GuiControl, , Edit1, %NewVal%
                    ; guicontrol, ,Button4, %d%
                    if SetDefault_Checkbox
                    {
                        SetDefault_Checkbox:= not SetDefault_Checkbox
                        InvertedNewVal:= not NewVal 
                        ; GuiControl, , Edit1, %InvertedNewVal%
                        ; tooltip, % "line 488: figure out how to determine if the checkbox's ID that's selected here is actually the correct ID then find the corresponding def and figure out how to determine what to revert to (def or previous). One mode works properly, the other one is not tested .`n`n somne bugs persist that need to be eradicated."
                        ; guicontrol, ,Button4, %InvertedNewVal%

                        RestoredVal:=%currID%Def ;;; this is a functional hotfix if you want to restore to DEF. Not sure how to implement restoring to previous entry though.
                        guicontrol, ,Button4, %RestoredVal%
                    }
                }
                ; 	GuiControl
                ;consistency check if type is integer or float
                If (Typ = "Integer")
                    If NewVal is not space
                        If NewVal is not Integer
                        {
                            GuiControl, , Edit1, %CurrVal%
                            Continue
                        }
                    If (Typ = "Float")
                        If NewVal is not space
                            If NewVal is not Integer
                                If (NewVal <> ".")
                                    If NewVal is not Float
                                    {
                                        GuiControl, , Edit1, %CurrVal%
                                        Continue
                                    }

                                ;set new value and save it to INI      
                                if (%CurrID%Val!=NewVal)
                                    bSettingsChanged:=true
                %CurrID%Val := NewVal 
                CurrVal = %NewVal%
                PrntID := TV_GetParent(CurrID)
                TV_GetText(SelSec, PrntID) 
                TV_GetText(SelKey, CurrID) 
                If (SelSec AND SelKey) 
                    IniWrite %NewVal%, %IniFile%, %SelSec%, %SelKey%
            } 
        } 
    } 

    ;Exit button got pressed 
    ExitSettings: 
    ;re-enable calling GUI 
    If DisableGui { 
        Gui %OwnedBy%:-Disabled
        Gui %OwnedBy%:,Show
    } 
    Gui Destroy
    ;exit function 
    Return bSettingsChanged ; inform the script if settings have been changed or not.

    ;browse button got pressed
    BtnBrowseKeyValue: 
    ;get current value
    GuiControlGet StartVal, , Edit1
    Gui +OwnDialogs

    ;Select file or folder depending on key type
    If (Typ = "File"){ 
        ;get StartFolder
        IfExist %A_ScriptDir%\%StartVal% 
            StartFolder = %A_ScriptDir% 
        Else IfExist %StartVal% 
        SplitPath StartVal, , StartFolder
        Else 
            StartFolder = 

        ;select file
        FileSelectFile Selected,, %StartFolder%, Select file for %SelSec% - %SelKey%, Any file (*.*)
    }Else If (Typ = "Folder"){ 
        ;get StartFolder
        IfExist %A_ScriptDir%\%StartVal% 
            StartFolder = %A_ScriptDir%\%StartVal% 
        Else IfExist %StartVal% 
        StartFolder = %StartVal% 
        Else 
            StartFolder = 

        ;select folder
        FileSelectFolder Selected, *%StartFolder% , 3, Select folder for %SelSec% - %SelKey%

        ;remove last backslash "\" if any
        StringRight LastChar, Selected, 1
        If LastChar = \ 
            StringTrimRight Selected, Selected, 1
    } 
    ;If file or folder got selected, remove A_ScriptDir (since it's redundant) and set it into GUI
    If Selected { 
        StringReplace Selected, Selected, %A_ScriptDir%\
        GuiControl, , Edit1, %Selected%
        %CurrID%Val := Selected 
    } 
    Return  ;end of browse button subroutine

    ;default button got pressed
    BtnDefaultValue: 
    SetDefault := True 
    Return  ;end of default button subroutine

    ;gui got resized, adjust control sizes
    GuiIniSettingsEditorSize:
    GuiIniSettingsEditorAnchor("SysTreeView321"      , "wh") 
    GuiIniSettingsEditorAnchor("Edit1"               , "x")
    GuiIniSettingsEditorAnchor("Edit2"               , "xh")
    GuiIniSettingsEditorAnchor("Button1"             , "xy",true)
    GuiIniSettingsEditorAnchor("Button2"             , "x",true)
    GuiIniSettingsEditorAnchor("Button3"             , "xy",true)
    GuiIniSettingsEditorAnchor("Button4"             , "x",true)
    GuiIniSettingsEditorAnchor("Button5"             , "wh",true)
    GuiIniSettingsEditorAnchor("SysDateTimePick321"  , "x")
    GuiIniSettingsEditorAnchor("msctls_Hotkey321"    , "x")
    GuiIniSettingsEditorAnchor("ComboBox1"           , "x")
    GuiIniSettingsEditorAnchor("Static1"             , "x")
    GuiIniSettingsEditorAnchor("Static2"             , "x")
    GuiIniSettingsEditorAnchor("Static3"             , "x")
    GuiIniSettingsEditorAnchor("Static4"             , "x")
    Return 
}  ;end of function

GuiIniSettingsEditorAnchor(ctrl, a, draw = false) { ; v3.2 by Titan (shortened)
    static pos
    sig = `n%ctrl%=
    If !InStr(pos, sig) {
        GuiControlGet p, Pos, %ctrl%
        pos := pos . sig . px - A_GuiWidth . "/" . pw  - A_GuiWidth . "/"
            . py - A_GuiHeight . "/" . ph - A_GuiHeight . "/"
    }
    StringTrimLeft p, pos, InStr(pos, sig) - 1 + StrLen(sig)
    StringSplit p, p, /
    c = xwyh
    Loop, Parse, c
        If InStr(a, A_LoopField) {
            If A_Index < 3
                e := p%A_Index% + A_GuiWidth
            Else e := p%A_Index% + A_GuiHeight
            m = %m%%A_LoopField%%e%
        }
    If draw
        d = Draw
    GuiControl Move%d%, %ctrl%, %m%
}
