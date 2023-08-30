﻿#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Requires AutoHotkey v1.1.35+ ;; version at which script was written.
#SingleInstance Force
#MaxHotkeysPerInterval 99999999
#Warn All, Outputdebug
;#Persistent
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
DetectHiddenWindows On
SetKeyDelay -1, -1
SetBatchLines -1
SetTitleMatchMode 2
CodeTimer("")
FileGetTime ModDate, %A_ScriptFullPath%, M
FileGetTime CrtDate, %A_ScriptFullPath%, C
CrtDate := SubStr(CrtDate, 7, 2) "." SubStr(CrtDate, 5, 2) "." SubStr(CrtDate, 1, 4)
    , ModDate := SubStr(ModDate, 7, 2) "." SubStr(ModDate, 5, 2) "." SubStr(ModDate, 1, 4)
global script := new script()
    , bRunFromVSC:=(WinActive("ahk_class Chrome_WidgetWin_1") && WinActive("ahk_exe Code.exe"))
    , DEBUG := IsDebug()
    , globalLogicSwitches := {}
script := { base: script.base
        , name: regexreplace(A_ScriptName, "\.\w+")
        , crtdate: CrtDate
        , moddate: ModDate
        , offdoclink: A_ScriptDir "\assets\Documentation\GFA_Renamer_Readme.html"
        , resfolder: A_ScriptDir "\res"
        , iconfile: ""
        , version: ""
        , config: []
        , scriptconfigfile: A_ScriptDir "\INI-Files\" regexreplace(A_ScriptName, "\.\w+") ".ini"
        , gfcGUIconfigfile: A_ScriptDir "\INI-Files\GFC_DA.ini"
        , configfolder: A_ScriptDir "\INI-Files"
        , aboutPath: A_ScriptDir "\res\About.html"
        , reqInternet: false
        , rfile: "https://github.com/Gewerd-Strauss/Gr-nfl-chen-Utilities/archive/refs/heads/master.zip"
        , vfile_raw: "https://raw.githubusercontent.com/Gewerd-Strauss/Gr-nfl-chen-Utilities/master/version.ini"
        , vfile: "https://raw.githubusercontent.com/Gewerd-Strauss/Gr-nfl-chen-Utilities/master/version.ini"
        , rfile_dev: "https://github.com/Gewerd-Strauss/Gr-nfl-chen-Utilities/archive/refs/heads/dev.zip"
        , vfile_raw_dev: "https://raw.githubusercontent.com/Gewerd-Strauss/Gr-nfl-chen-Utilities/dev/version.ini"
        , vfile_dev: "https://raw.githubusercontent.com/Gewerd-Strauss/Gr-nfl-chen-Utilities/dev/version.ini"
    ; , vfile_local : A_ScriptDir "\res\version.ini"
        , EL: "359b3d07acd54175a1257e311b5dfaa8370467c95f869d80dba32f4afdcae19f4485d67815d9c1f4fe9a024586584b3a0e37489e7cfaad8ce4bbc657ed79bd74"
        , authorID: "Laptop-C"
        , author: "Gewerd Strauss"
        , Computername: A_ComputerName
        , license: A_ScriptDir "\res\LICENSE.txt" ;; do not edit the variables above if you don't know what you are doing.
        , blank: "" }

globalLogicSwitches.Debug:=DEBUG
#Include <OnError>
main()
CodeTimer("Startup Time")
sleep 3500
tooltip
return

main() {

    Loop, % A_Args.Length() {
        param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
            , bUpdateGeneratedFiles:=param
        if bUpdateGeneratedFiles {
            break
        }
    }
    if !script.requiresInternet() {
        exitApp()
    }
    globalLogicSwitches.bIsAuthor:=(script.computername=script.authorID) + 0
        , globalLogicSwitches.Debug:=DEBUG
    if !FileExist(script.scriptconfigfile) || ((DEBUG && globalLogicSwitches.bIsAuthor) || bUpdateGeneratedFiles) {
        if (globalLogicSwitches.bIsAuthor) {
            ttip("resetting conf 1")
        }
        setupdefaultconfig(1)
    }
    if !FileExist(script.gfcGUIconfigfile) || ((DEBUG && globalLogicSwitches.bIsAuthor)  || bUpdateGeneratedFiles) {
        if (globalLogicSwitches.bIsAuthor) {
            ttip("resetting conf 2")
        }
        setupdefaultconfig(2)
    }
    script.Load(script.scriptconfigfile, bSilentReturn:=1)
    if (script.config.Configurator_settings.bRunAsAdmin) {
        RunAsAdmin()
    }
    globalLogicSwitches.bIsDebug:=script.config.Configurator_settings.bDebugSwitch + 0
    script.version:=script.config.version.GFC_version
        , script.loadCredits(script.resfolder "\credits.txt")
        , script.loadMetadata(script.resfolder "\meta.txt")
        , IconString:=A_ScriptDir "\res\icon.ico"
    ;, IconString:="iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAYAAAA6/NlyAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAARISURBVGhD7dtLbxNXGMbxbFh2yRIpzkWQgpIUKFAVibCBknIJqCFOZNIbJg0Xp7ikkAAh4SJoCxUENiBgW6ktUldIKQURbmpAIkSiqlqg6gcAvsLLPPPKVjp5bM/xnAllMpb+K4/PeX9yjj1epGKmPpqcBmdAcLqPwcrKSol6cCo3BkczOJUbg6MZnMqNwdEMTuXG4GgGp3JjcDSDU7kG4OzvJ+TAs3NT6p04Kd1XB6TtbJc0fbZGaupq6etNqplX666VPNflrH1QesdP0b2/evAtfb03OJVrAext7x/fS9vwNlnwXiNdp1gLljXI5jNpdw22trdQwZnRI3TTQvX/NSwth1NSVVNF15tcorpKNgylZN+fp+lahfry7jG6njc4lWsAxp8W27RU237pk7kNdXRNNLe+TtJX9tHXlmr7yEG6pjc4lWsATl3aRTf1E96JhhWLp6xZv3yh9Nw+Sl/jp87LPVPWZMGpXANw89etdFO/ZcdOyPwl9fn18M6aHhNvH/a1/WfGQsGpXAPwwlVL6aYmdV89INW11e6ZTV/ZS68xadHqZXRWb3Aq1wCMMjcP041NWru/XdYPdNDnTMqMHpVEIkHn9Aancg3BH2Q30c1Nyj46Lnsef0OfM2lVz0Y6IwtO5RqCcUOQfXCcDuC39P1dkh4r/wMQZW4e8/V1lwtO5RqC0crPm+kQfup/Oizt1zZJ8teN0v/kLL3GTys+WU1nKxScyi0DjFIXd9JBSpWZOCRtI+vdMhMD9JpS4euRzVQsOJVbJhh/2uXciKTHdubBW8d20GuKhT3LuVeHU7llghG+R/E1wwYrVOetzjy4c/Rjek2h8ANlXuPbdJZSwancAGCEd3rL5QwdkNVxvTUP7vjN/41MytkjyK8wOJUbEJwLH2S4fWTDTi55rSUPTo600GsmhzVXbm2me5oEp3ItgRHuoNbs+Uh23yv8MzKHzbX/2TC9Dms097a6a7K9TINTuRbBuRJVCVmy7n3ZMJiST3/IundEvY9OSt/fZ6aA+5yfkHgO1+BavAavxRps7XKDU7khgIvlfSfZNWEEp3JjcLi9seCXdypea2ymYsGp3BjsLzbEdMZmKhacyg0AfnGjQv4Zchqcppy9nl9/jWD073dksJDCXrl92UzFglO5ZYJznR96Kz9E2GEvNoOf4FRuQPAX7bPpcGHUlZxNZ/ATnMoNCF7UOEee3+ID2u7dd+bQGfwEp3IDgtH4j7PogDZ7+NMsurff4HS1ziMw+MI0nOMg5xfBqVwL4O6O8M8xPivY3n6DU7kWwIudc8yGtFmQ84vgVK4FMArzHGNttqdJcLpa52EFfPFIeOcYnxFsT5PgVK4lcJjnGGuzPU2CU7mWwGGe46DnF8GpXEtgNP6z/XNs4/wiOF2t87AGDuMcY022l2lwKtci+P8cnMqNwdEMTuXG4GgGp3JjcDSDU7kz5j/TKppeAamEQurI/tgFAAAAAElFTkSuQmCC"
    if (script.requiresInternet(script.vfile,true) && script.config.Configurator_settings.CheckUpdatesOnScriptStart) {
        if (script.config.Configurator_settings.UpdateChannel="stable") {
            script.Update(script.vfile,script.rfile,1)
        } else if (script.config.Configurator_settings.UpdateChannel="development") {
            script.Update(script.vfile_dev,script.rfile_dev,1)
        }
    }
    if (bUpdateGeneratedFiles) {
        FileDelete % script.AboutPath
        script.About(1)
        ExitApp

    }
    script_TraySetup(IconString)

    ;script.Save(script.scriptconfigfile)
    global guiObject:=guiCreate()
    if !FileExist(script.gfcGUIconfigfile) || ((DEBUG && globalLogicSwitches.bIsAuthor)  || bUpdateGeneratedFiles) {
        if (globalLogicSwitches.bIsAuthor) {
            ttip("generating parameter documentation string")
            String:=guiObject.dynGUI.generateDocumentationString()
            Clipboard:=String
        }
    }
    global maingui_hwnd:=guiShow(guiObject)
        , f5:=Func("guiShow2").Bind(guiObject)
        , f6:=Func("prepare_release")
    guiResize(guiObject,true)
    Menu Tray, Add, Show/Hide GUI, % f5
    if (globalLogicSwitches.bIsAuthor) {
        menu Tray, Add, Recompile, % f6
    }
    /*
    ; TODO: write code-shell-template
    1. include the GFA_lib from the path given in the settings
    2. do the same with the mac-valid transformation
    3. determine what thte path must look like if it lies on a NAS
    4. upon code confirmation, insert the chosen checkboxes into the respective placeholder positions of the template
    5. upon ini generation, populate the ini-RC.
    */
    template=
        (LTRIM
            get_os <- function(){
            `tsysinf <- Sys.info()
            `tif (!is.null(sysinf)){
            `t`tos <- sysinf['sysname']
            `t`tif (os == 'Darwin')
            `t`t`tos <- "osx"
            `t} else { ## mystery machine
            `t`tos <- .Platform$OS.type
            `t`tif (grepl("^darwin", R.version$os))
            `t`t`tos <- "osx"
            `t`tif (grepl("linux-gnu", R.version$os))
            `t`t`tos <- "linux"
            `t}
            `treturn(tolower(os))
            }

            source("`%GFA_EVALUATIONUTILITY`%")
            if (isTRUE(as.logical(get_os()=='windows'))) { # this is an optimistic approach to the problem, I won't try to anticipate all possible OS-names
            `t# WINDOWS: 
            `tplot_1 <- GFA_main(folder_path = r"(`%GFA_CONFIGLOCATIONFOLDER_WINDOWS`%)",returnDays = `%breturnDays`%,saveFigures = `%bsaveFigures`%,saveExcel = `%bsaveExcel`%,saveRDATA = `%bsaveRDATA`%)
            } else {
            `t# MAC:
            #`tsource("`%GFA_EVALUATIONUTILITY`%")
            `tplot_1 <- GFA_main(folder_path = r"(`%GFA_CONFIGLOCATIONFOLDER_MAC`%)",returnDays = `%breturnDays`%,saveFigures = `%bsaveFigures`%,saveExcel = `%bsaveExcel`%,saveRDATA = `%bsaveRDATA`%)
            }
        )
        /*MAC additions:
    `tsource("/Volumes/Bex-Biotec Hauptordner/Projekte - offen/Praktikum/Claudius/Scripts/Utility/GFA_Evaluation.R")
    `tplot_3 <- GFA_main(r"(/Volumes/Bex-Biotec Hauptordner/Projekte - offen/Praktikum/Claudius/Exp2_Trockenstress Cornetto/Exp2.3/GFA/)",returnDays = F,saveFigures = F,saveExcel = F,saveRDATA = F)
    */
    /*WINDOWS additions:
    `tsource("/Volumes/Bex-Biotec Hauptordner/Projekte - offen/Praktikum/Claudius/Scripts/Utility/GFA_Evaluation.R")
    `tplot_2 <- GFA_main(r"(/Bex-Biotec Hauptordner/Projekte - offen/Praktikum/Claudius/Exp2_Trockenstress Cornetto/Exp2.3/GFA/)",returnDays = T)
    */
    guiObject.RCodeTemplate:=template
        , handleCheckboxes()
        , handleConfig(guiObject.dynGUI,false)
        , fillRC1(template)
        , fillRC2(guiObject.dynGUI.ConfigString)
    return
}

guiCreate() {
    ;; Funktion erstellt die Benutzeroberfläche. Sehr basic, aber reicht für das was gemacht werden muss.
    gui GC: destroy
    if (globalLogicSwitches.DEBUG) {
        ttip([globalLogicSwitches.bIsAuthor,globalLogicSwitches.bIsDebug,globalLogicSwitches.DEBUG])
    }
    ;; get Screen dimensions
    SysGet A, MonitorWorkArea,1
    ABottom2:=ABottom
    SysGet A, MonitorWorkArea,2

    if (script.config.Configurator_settings.SizeSetting="auto") { ; auto
        SysGet A, MonitorWorkArea
        guiHeight:=ABottom - 2*30
            , guiWidth:=A_ScreenWidth - 2*30
    } else if (script.config.Configurator_settings.SizeSetting="1440p") { ; 1440p
        guiWidth:=2560 - 2*30
            , guiHeight:=1392 - 2*30
    } else if (script.config.Configurator_settings.SizeSetting="1080p") { ; 1080p
        guiWidth:=1920 - 2*30
            , guiHeight:=1032 - 2*30
    }
    ttip(["guiWidth: " guiWidth
            ,"guiHeight: " guiHeight
            ,script.config.SizeSetting
            ,"is1080: " (script.config.Configurator_settings.SizeSetting="1080p")
            ,"is1440: " (script.config.Configurator_settings.SizeSetting="1440p")
            ,"isauto: " (script.config.Configurator_settings.SizeSetting="auto")
            ,"height-mwa 1440p: " 1392 - 2*30
            ,"guiWidth 1440p: " 2560 - 2*30
            ,"guiWidth  1080p: " 1920 - 2*30
            ,"height-mwa 1080p: " 1032 - 2*30])
    if (globalLogicSwitches.DEBUG) {
        ttip({guiWidth:guiWidth,guiHeight:guiHeight,A_ScreenHeight:A_ScreenHeight,A_ScreenWidth:A_ScreenWidth},1,2300)
    }

    YMarginWidth:=XMarginWidth:=15
        , NumberofSections:=3
        , WidthMinusMargins:=guiWidth - 4*XMarginWidth + 0
        , HeightMinusMargins:=guiHeight - 4*YMarginWidth + 0
        , SectionWidth:=WidthMinusMargins/NumberofSections + 0
        , SectionHeight:=guiHeight
        , Sections:=[]
        , middleanchor:=guiWidth-4*15-middleWidth
        , groupbox_height:=953
    loop, % NumberofSections {
        if (A_Index>1) {
            Sections[A_Index]:={XAnchor:XMarginWidth*A_Index + SectionWidth*(A_Index-1),YAnchor:3,Width:SectionWidth*1,Height:SectionHeight*1}
        } else {
            Sections[A_Index]:={XAnchor:XMarginWidth*A_Index,YAnchor:3,Width:SectionWidth*1,Height:SectionHeight*1}
        }
    }
    Sections[4]:={XAnchor:Sections[3].XAnchor,YAnchor:Sections[3].YAnchor,Width:Sections[3].Width,Height:Sections[3].Height}

    if (script.config.Configurator_settings.SizeSetting="1080p") {
        ShiftSection1:=0
    } else if (script.config.Configurator_settings.SizeSetting="1440p") {
        ShiftSection1:=50
    } else {
        ShiftSection1:=0
    }
    ShiftSection2:=250
        , Sections[1].Width:=Sections[1].Width-ShiftSection1
        , Sections[2].XAnchor:=Sections[2].XAnchor-ShiftSection1
        , Sections[2].Width:=Sections[2].Width-ShiftSection2
        , Sections[4].XAnchor:=Sections[4].XAnchor-ShiftSection1-ShiftSection2
        , Sections[4].Width:=Sections[4].Width+ShiftSection1+ShiftSection2
        , Sections[2].Height:=230
        , middleanchor:=guiWidth-4*15-middleWidth
        , groupbox_height:=953

    Sections[3].YAnchor:=Sections[2].Height-15
        , Sections[3].XAnchor:=Sections[2].XAnchor
        , Sections[3].Height:=(guiHeight-Sections[3].YAnchor)+3
        , Sections[3].Width:=Sections[2].Width
    global StatusBarMainWindow
        , vUsedConfigLocation
        , vStarterRScriptLocation
        , vreturnDays
        , vSaveFigures
        , vsaveRDATA
        , vSaveExcel
        , vRCRScript
        , vRCConfiguration
        , hwndLV_History
        , vToggleLVReport
    gui GC: new
    gui GC:  +LabelGC +HWNDGCHWND
    minW:=(guiObject["guiWidth"]-(guiObject["Sections"][4]["Width"]+guiObject.XMarginWidth*2))
    minH:=guiObject["guiHeight"]
    gui GC: +Resize +MinSize%minW%x%minH%
    if (globalLogicSwitches.DEBUG) {
        gui -AlwaysOnTop
    }
    Names:=["1. Configuration File","2. R Starter Script Configuration","4. Auxiliary Utilities","3. Preview"]
    ;gui GC: Show, % "w" guiWidth " h" guiHeight

    for each, section in Sections {
        Sections[each].Name:=Names[A_Index]
        gui add, text,% " y0 h0 w" 0 " x" 0, % section.name
    }
    ;; left side
    gui add, text,% "y15 x" Sections[1].XAnchor+5 " h0 w0",leftanchor
    gui add, text,% "y20 x" Sections[1].XAnchor+5 " h40 w350",% "Select the configuration file you want to use. Alternatively, choose a folder containing your data - where you want your configuration file to sit. All '.xlsx'/'.csv'-files in any subfolder will be used."
    ;gui add, button, y60 xp w80 hwndselectConfigLocation,% "Select &Folder"
    gui add, button,% "y60 w80 hwndnewConfigurationBtn x" Sections[1].XAnchor+5,% "New &Config in Folder"
    gui add, button,% "yp w80 hwndeditConfigurationBtn x" Sections[1].XAnchor+95,% "&Edit existing Config"
    gui add, edit,% "yp w160 hwnddropFilesEdit disabled -vscroll -hscroll x" Sections[1].XAnchor+180,% "Drop config file or config destination folder here"
    gui add, edit,% "y100 x" Sections[1].XAnchor+5 " r1 disabled vvUsedConfigLocation w" Sections[1].Width - 3*5,   % "<Location of Configuration-'.ini'-File>"
    global dynGUI:= new gfcGUI("Experiment::blank",script.gfcGUIconfigfile,"-<>-",FALSE)
    dynGUI.GFA_Evaluation_Configfile_Location:=GFA_Evaluation_RScript_Location:=""
    dynGUI.guiVisible:=false
        , dynGUI.GCHWND:=GCHWND
        , dynGUI.GenerateGUI(,,False,"GC:",false,15,Sections[1].Width-15,,9)

    ;; middle
    gui add, text,% "y15 x" Sections[2].XAnchor+5 " h0 w0", middleanchor
    gui add, text,% "y20 x" Sections[2].XAnchor+5 " h40 w350", % "Configure the R-Script used for running the GF-Analysis-Skript"
    gui add, button,% "y60 w80 hwndnewStarterScriptBtn x" Sections[2].XAnchor+5, % "New &R-StarterScript"
    gui add, button,% "y60 w80 hwndeditStarterScriptBtn x" Sections[2].XAnchor+95, % "Edit existing &R-StarterScript"
    gui add, edit,% "y60 w160 hwnddropFilesEdit2 disabled -vscroll -hscroll x" Sections[2].XAnchor+180,% "Drop RScript-file or RScript-destination folder here"
    gui add, edit,% "y100 x" Sections[2].XAnchor+5 " r1 disabled vvStarterRScriptLocation w" Sections[2].Width - 3*5,   % "<Location of Starter-'.R'-Script>"
    gui add, checkbox, y125 xp hwndCheckreturnDays  vvreturnDays, Do you want to evaluate every day on its own?
    gui add, checkbox, y145 xp hwndCheckSaveFigures vvSaveFigures, Do you want to save 'Figures' to disk?
    gui add, checkbox, y165 xp hwndChecksaveRDATA   vvsaveRDATA, Do you want to save 'RData' to disk?
    gui add, checkbox, y185 xp hwndCheckSaveExcel   vvSaveExcel, Do you want to save 'Excel' to disk?
    gui add, text, % "x" Sections[3].XAnchor+5 " y" Sections[3].YAnchor+15 " h0 w0", middlebottomanchor
    gui add, tab3, % "hwndhwndTab3_2 x" Sections[3].XAnchor+5 " y" Sections[3].YAnchor+20 " h" (Sections[3].Height-(1*3 + 20)-2*15) " w" (Sections[3].Width - 3*5), Configurations and Image-renaming||R Scripts
    gui tab, Configurations and Image-renaming
    gui add, checkbox, % "hwndCheckToggleLVReport gtoggle_ReportTip x+5 y+5 vvToggleLVReport", % "Toggle Report-View?"
    gui add, button, % "hwndcsv2xlsxBtn yp-5 xp+130", % "csv2xlsx"
    gui add, button, % "hwndrenameImagesBtn yp xp+60", % "rename Images"
    AddToolTip(CheckToggleLVReport,"Change the view-type for the listview below between report and the traditional list view.`nList view is more compact, but Report-view gives more details on a specific file")
    AddToolTip(csv2xlsxBtn,"If a config-file has been selected (by the ListView below, or any other means), you`ncan use this button to automatically create xlsx-files for any csv-file which does not`nn have an xlsx-version. CSV-files are supported, but heavily discouraged by the author",, GCHWND)
    gui add, Listview, % "hwndhwndLV_History +LV0x400 +LV0x10000 xp-190 y+5 h" ht:=(Sections[3].Height-(1*3 + 20)-2*15-3*5-5-35-20) " w" (Sections[3].Width - 3*5 - 3*5), Experiment's Name in Config|File Name|Full Path

    updateConfigLV(hwndLV_History) 

    ;; right
    RESettings2 :=
        ( LTrim Join Comments
            {
            "TabSize": 4,
            "Indent": "`t",
            "FGColor": 0xEDEDCD,
            "BGColor": 0x3F3F3F,
            "Font": {"Typeface": "Consolas", "Size": 11},
            "WordWrap": True,

            "UseHighlighter": True,
            "HighlightDelay": 200,
            "Colors": {
            "Comments":     0x7F9F7F,
            "Functions":    0x7CC8CF,
            "Keywords":     0xE4EDED,
            "Multiline":    0x7F9F7F,
            "Numbers":      0xF79B57,
            "Punctuation":  0x97C0EB,
            "Strings":      0xCC9893,

            ; AHK
            "A_Builtins":   0xF79B57,
            "Commands":     0xCDBFA3,
            "Directives":   0x7CC8CF,
            "Flow":         0xE4EDED,
            "KeyNames":     0xCB8DD9,

            ; CSS
            "ColorCodes":   0x7CC8CF,
            "Properties":   0xCDBFA3,
            "Selectors":    0xE4EDED,

            ; HTML
            "Attributes":   0x7CC8CF,
            "Entities":     0xF79B57,
            "Tags":         0xCDBFA3,

            ; JS
            "Builtins":     0xE4EDED,
            "Constants":    0xF79B57,
            "Declarations": 0xCDBFA3

            ; INI
            }
            }
        )
    gui tab, R Scripts
    GuiControl Choose, vTab3, % "Configurations and Image-renaming"
    gui tab,
    gui add, text, % "y15 x" Sections[4].XAnchor+5 " h0 w0", rightanchor

    gui add, text, % "y20 x" Sections[4].XAnchor+5 " h40 w" Sections[4].Width - 3*5, R-Script-Preview
    ; global RC:=new GC_RichCode(RESettings2, "y45" " x" Sections[4].XAnchor+5 " w" Sections[4].Width - 3*5 " h" (Sections[4].Height-45-3*5)/4 ,"GC", HighlightBound=Func("HighlightR"))
    global RC:=new GC_RichCode(RESettings2, "y45" " x" Sections[4].XAnchor+5 " w" Sections[4].Width - 3*5 " h489" , HighlightBound=Func("HighlightR"))
    gui add, text, % "y" (45+489+5) " x" Sections[4].XAnchor+5 " h40 w" Sections[4].Width - 3*5, Configuration-Preview
    buttonHeight:=40
    global RC2:=new GC_RichCode(RESettings2,"y" (45+489+5+25) " x" Sections[4].XAnchor+5 " h" (guiHeight-(45+489+5+40+5+5+buttonHeight+5)) " w" Sections[4].Width - 3*5, HighlightBound=Func("HighlightR"))
    gui add, button,% "y" (45+489+5+25+(guiHeight-(45+489+5+40+5+5+buttonHeight+5))+5) " w80 hwndgenerateRScriptBtn x" Sections[4].XAnchor+5, % "Generate R-Script"
    gui add, button,% "y" (45+489+5+25+(guiHeight-(45+489+5+40+5+5+buttonHeight+5))+5) " w80 hwndpreviewConfigurationBtn x" Sections[4].XAnchor+95, % "Preview Configuration"
    gui add, button,% "y" (45+489+5+25+(guiHeight-(45+489+5+40+5+5+buttonHeight+5))+5) " w80 hwndgenerateConfigurationBtn x" Sections[4].XAnchor+185, % "Generate Configuration"
    gui add, button,% "y" (45+489+5+25+(guiHeight-(45+489+5+40+5+5+buttonHeight+5))+5) " w80 hwndEditSettingsBtn gfEditSettings  x" Sections[4].XAnchor+275, % "Open &program settings"
    gui add, button,% "y" (45+489+5+25+(guiHeight-(45+489+5+40+5+5+buttonHeight+5))+5) " w80 hwndExitProgramBtn gexitApp x" Sections[4].XAnchor+365, % "Exit Program"
    if (globalLogicSwitches.bIsAuthor) {
        gui add, button,% "y" (45+489+5+25+(guiHeight-(45+489+5+40+5+5+buttonHeight+5))+5) " w80  gexitApp hwndrecompileBtn x" Sections[4].XAnchor+455, % "Recompile"
    }

    gui add, statusbar, -Theme vStatusBarMainWindow  gfCallBack_StatusBarMainWindow
    if ((bShowDebugPanelINMenuBar) && (script.authorID=A_ComputerName)) {
        SB_SetParts(0,240,100,280,95,70,80,170)
    } Else {
        SB_SetParts(0,240,100,270,95,70,80)
    }
    SB_SetText(script.name " v." script.config.version.GFC_version A_Space script.config.version.build,2)
    SB_SetText(" by " script.author,3)
    SB_SetText("Standard Mode Engaged. Click to enter debug-mode",4)
    SB_SetText("Report a bug",6)
    SB_SetText("Documentation",7)

    onEditConfiguration := Func("editConfiguration").Bind("")
        , onEditStarterScript := Func("editRScript").Bind("")
        , onPreviewConfiguration := Func("handleConfig").Bind(dynGUI,false)
        , onGenerateConfiguration := Func("handleConfig").Bind(dynGUI,true)
        , onCheckreturnDays:=Func("handleCheckboxesWrapper").Bind("")
        , onCheckSaveFigures:=Func("handleCheckboxesWrapper").Bind("")
        , onChecksaveRDATA:=Func("handleCheckboxesWrapper").Bind("")
        , onCheckSaveExcel:=Func("handleCheckboxesWrapper").Bind("")
        , onGenerateRScript:=Func("createRScript").Bind("D:/")
        , onLoadConfigFromLV:=Func("loadConfigFromLV").Bind(dynGUI)
        , oncsv2xlsx := Func("convertCSV2XLSX").Bind(dynGUI)
        , onrenameImages := Func("renameImages").Bind(dynGUI)
    if (globalLogicSwitches.DEBUG) {
        onNewConfiguration := Func("createConfiguration").Bind(A_ScriptDir,guiObject)
        oncreateRScript := Func("createRScript").Bind(A_ScriptDir)
    } else {
        onNewConfiguration := Func("createConfiguration").Bind("D:/",guiObject)
        oncreateRScript := Func("createRScript").Bind("D:/")
    }
    if (globalLogicSwitches.bIsAuthor) {
        onRecompile := Func("prepare_release")
    }
    guiControl GC:+g, %generateRScriptBtn%, % onGenerateRScript
    guiControl GC:+g, %PreviewConfigurationBtn%, % onPreviewConfiguration
    guiControl GC:+g, %generateConfigurationBtn%, % onGenerateConfiguration
    guiControl GC:+g, %EditConfigurationBtn%, % onEditConfiguration
    guiControl GC:+g, %NewConfigurationBtn%, % onNewConfiguration
    guiControl GC:+g, %newStarterScriptBtn%, % oncreateRScript
    guiControl GC:+g, %editStarterScriptBtn%, % onEditStarterScript
    guiControl GC:+g, %hwndLV_History%, % onLoadConfigFromLV
    guiControl GC:+g, %csv2xlsxBtn%, % oncsv2xlsx
    guiControl GC:+g, %renameImagesBtn%, % onrenameImages


    guiControl GC:+g, %CheckreturnDays%, % onCheckreturnDays
    guiControl GC:+g, %CheckSaveFigures%, % onCheckSaveFigures
    guiControl GC:+g, %ChecksaveRDATA%, % onChecksaveRDATA
    guiControl GC:+g, %CheckSaveExcel%, % onCheckSaveExcel
    if (globalLogicSwitches.bIsAuthor) {
        guiControl GC:+g, %recompile%, % onRecompile
    }
    return {guiWidth:guiWidth
            ,guiHeight:guiHeight
            ,dynGUI:dynGUI
            ,Sections:Sections
            ,XMarginWidth:XMarginWidth
            ,YMarginWidth:YMarginWidth}
}
guiShow3(guiObject,ShowThirdPane:=true) {
    if (showThirdPane) {
        gui GC: show,% "w" guiObject["guiWidth"] " h" guiObject["guiHeight"] " x0 y0" , % script.name " - Create new Configuration"
    } else {
        gui GC: show,% "w" (guiObject["guiWidth"]-(guiObject["Sections"][4]["Width"]+guiObject.XMarginWidth*2)) " h" guiObject["guiHeight"] "x0 y0" , % script.name " - Create new Configuration"
    }
    return
}
guiShow2(guiObject) {
    global
    if (WinActive("ahk_id " guiObject.dynGUI.GCHWND)) {
        if (dynGUI.guiVisible) {
            guiHide()
            dynGUI.guiVisible:=false
        } else {
            guiShow(guiObject)
            dynGUI.guiVisible:=true
        }
    } else {
        if (dynGUI.guiVisible) {
            guiHide()
            dynGUI.guiVisible:=false
        } else {
            guiShow(guiObject)
            dynGUI.guiVisible:=true
        }
    }
    return
}
guiShow(guiObject) {
    gui GC: default
    ;gui GC: add,groupbox , y0 x10 w684 h953, Configuration File
    useGroupbox:=1
    ;gui GC: show,% "w" guiObject["guiWidth"]*1 " h" guiObject["guiHeight"]*1  , % script.name " - Create new Configuration"
    for each, section in guiObject.Sections {
        if (useGroupbox) {
            if section.HasKey("YAnchor") {
                gui add, groupbox,% "hwndgb" each " y" section.YAnchor " h" section.Height-2*15 " w" section.Width " x" section.XAnchor-5, % section.name
            } else {
                gui add, groupbox,% "hwndgb" each " y3 h" section.Height-2*15 " w" section.Width " x" section.XAnchor-5, % section.name
            }
            ;gui add, groupbox,% " y3 h" guiObject["guiHeight"]-2*15 " w" section.Width " x" section.XAnchor-5, % section.name
        } else {
            if section.HasKey("YAnchor") {
                gui add, text,% " y" section.YAnchor " h15 w" section.Width " x" section.XAnchor-5, % section.name
            } else {
                gui add, text,% " y3 h15 w" section.Width " x" section.XAnchor-5, % section.name
            }
        }
    }
    if (guiObject.dynGUI.GFA_Evaluation_Configfile_Location="") {
        ;gui GC: show,% "w" (guiObject["guiWidth"]-(guiObject["Sections"][4]["Width"]+guiObject.XMarginWidth*2)) " h" guiObject["guiHeight"] "x0 y0" , % script.name " - Create new Configuration"
        gui GC: show,%   "AutoSize x0 y0" , % script.name " - Create new Configuration"
    } else {
        gui GC: show,% "w" guiObject["guiWidth"] " h" guiObject["guiHeight"] " Center" , % script.name " - Create new Configuration"
    }
    guicontrol GC: hide, % "vExcelSheetPreview"
    dynGUI.guiVisible:=true
    handleCheckboxes(Param)
    handleConfig(dynGUI,false)
    ;handleExcelSheets(dynGUI.Arguments)
    Tabs:=[]
    TabName:="Example-Excel-File No. "
    loop, 12 {
        Tabs[A_Index]:=TabName A_Index
    }
    loop, % Tabs.Count(){
        TabNames.=Tabs[A_Index]
        if (A_Index=1) {
            TabNames.="||"
        } else {
            TabNames.="|"
        }
    }
    gui gc: default
    gui % "GC: " ((script.config.Configurator_settings.AlwaysOnTop)?"+":"-") "AlwaysOnTop"
    if (globalLogicSwitches.DEBUG) {
        gui -AlwaysOnTop
    }
    return
}

guiHide() {
    global
    dynGUI.guiVisible:=false
    GCEscape()
    return 
}
guiResize(guiObject,bHideLastThird,normalOperation:=true) {
    if (normalOperation) {
        if (guiObject.dynGUI.GFA_Evaluation_Configfile_Location="") || (guiObject.dynGUI.GFA_Evaluation_RScript_Location="") {
            guiShow3(guiObject,false)
        } else {
            guiShow3(guiObject,true)
        }
    } else {
        ;gui GC: show,% "w" guiObject["guiWidth"]/2 " h" guiObject["guiHeight"]/2 " x0 y0" , % script.name " - Create new Configuration"
    }
    return
}
GCSize() {
    global
    gui GC: default
    w:=A_GuiWidth/guiObject["guiWidth"]
    h:=A_GuiHeight/guiObject["guiHeight"]
    AutoXYWH("h*", gb1,gb3)
    ;AutoXYWH("h*", gb2)
    AutoXYWH("h*", gb3)
    AutoXYWH("wh*", gb4)

    AutoXYWH("y", EditSettingsBtn, ExitProgramBtn)
    AutoXYWH("y", "Generate Configuration")
    AutoXYWH("y", "Generate R-Script")
    AutoXYWH("y", "Preview Configuration")
    ;AutoXYWH("y", EditSettingsBtn)
    ;AutoXYWH("y", "Exit Program")
    if (globalLogicSwitches.bIsAuthor) {
        AutoXYWH("y", recompileBtn)
    }
    AutoXYWH("w", RC.HWND)
    AutoXYWH("wh", RC2.HWND)
    AutoXYWH("h", hwndLV_History)
    AutoXYWH("h", hwndTab3_2)
    ;guicontrol, MoveDraw, previewConfigurationButton

    ;AutoXYWH("w1 h1", hwndDA)
    ;AutoXYWH(" x" 1.1 " y" 1.1 " h" h " w" w, dropFilesEdit)
    ;AutoXYWH("wh" , gb1)
    ;AutoXYWH("w0.5 h0.75" , "vUsedConfigLocation")
    ;AutoXYWH("w0.5 h 0.75", hEdit, "displayed text", "vLabel", "Button1")
    return
}
GCDropFiles(GuiHwnd, File, CtrlHwnd, X, Y) {

    global dynGUI
    global guiObject
    if (A_GuiControl="Drop config file or config destination folder here") {    ;; ini-file

        if (File.Count()>1) {
            Gui +OwnDialogs
            MsgBox 0x40010, % script.name " - Error occured: 2+ files/folders dropped",% "You have dropped more than either 1 .ini-file or 1 folder on the GUI. This will not work. Please drop either a single file`, or a single folder onto the GUI."
            Gui -OwnDialogs
        }
        if (InStr(FileExist(File[1]),"D")) { ; directory
            ; if directory, check first if ini-files exist
            ; multiple ini-files exist. if true, open a fileselectfile dialogue on that folder prompting to ask 
            iniCount:=0 
            loop, Files, % File[1] "\*.ini"        ;; check number of ini-files
            {
                iniCount:=A_Index
                confPath:=A_LoopFileFullPath
            }
            if (iniCount>1) {                       ;; multiple files, select one
                FileSelectFile configPath, 3, % File[1], % "Please select the ini-file you want to edit.", *.ini
            } else if (iniCount=1) {                ;; select the only one available
                configPath:=confPath
            } else if (iniCount=0) {                ;; create a new one
                FileSelectFile configPath, S8, % File[1], % "Please create the ini-file you want to use.", *.ini
            }
        } else { ; file
            configPath:=File[1]
        }
        loadConfig_Main(configPath,dynGUI)
    } else if (A_GuiControl="Drop RScript-file or RScript-destination folder here") {                                                                    ;; Rscript-file
        if (File.Count()>1) {
            Gui +OwnDialogs
            MsgBox 0x40010, % script.name " - Error occured: 2+ files/folders dropped", You have dropped more than either 1 .Rscript-file or 1 folder on the GUI. This will not work. Please drop either a single file`, or a single folder onto the GUI.
            Gui -OwnDialogs
        }
        if (InStr(FileExist(File[1]),"D")) { ; directory
            ; if directory, check first if Rscript-files exist
            ; multiple Rscript-files exist. if true, open a fileselectfile dialogue on that folder prompting to ask 
            rCount:=0 
            loop, Files, % File[1] "\*.R"        ;; check number of Rscript-files
            {
                rCount:=A_Index
                R_Path:=A_LoopFileFullPath
            }
            if (rCount>1) {                       ;; multiple files, select one
                FileSelectFile rPath, 3, % File[1], % "Please select the Rscript-file you want to edit.", *.R
            } else if (rCount=1) {                ;; select the only one available
                rPath:=R_Path
            } else if (rCount=0) {                ;; create a new one
                FileSelectFile rPath, S8, % File[1], % "Please create the Rscript-file you want to use.", *.R
            }
        } else { ; file
            rPath:=File[1]
        }
        if (rPath="") {
            Gui +OwnDialogs
            MsgBox 0x40010, % script.name " - Error occured: Selection-GUI got cancelled", You have closed the selection-window without selecting an existing or creating a new Rscript-file. Please do either.
            Gui -OwnDialogs
            return
        }

        if RegexMatch(rPath,"\.ini$")  {
            Gui +OwnDialogs
            MsgBox 0x40010, % script.name " - Error occured: Dropped config-file on rscript-dropper", % "You have dropped the config-file`n`n'" rPath "'`n`n on the right selection-window. Please drag-and-drop an Rscript-file here instead."
            Gui -OwnDialogs
            return
        }
        if !RegexMatch(rPath,"\.R$")  {
            rPath.= ".R"
        }
        guicontrol % "GC:",vStarterRScriptLocation, % rPath
        if (rPath!="") {
            dynGUI.GFA_Evaluation_RScript_Location:=rPath
        }
    } else { ;; anywhere else
        if (File.Count()>1) {
            Gui +OwnDialogs
            MsgBox 0x40010, % script.name " - Error occured: 2+ files/folders dropped", You have dropped more than either 1 .ini-file or 1 folder on the GUI. This will not work. Please drop either a single file`, or a single folder onto the GUI.
            Gui -OwnDialogs
        }
        if (InStr(FileExist(File[1]),"D")) { ; directory
            ; if directory, check first if ini-files exist
            ; multiple ini-files exist. if true, open a fileselectfile dialogue on that folder prompting to ask 
            iniCount:=0 
            loop, Files, % File[1] "\*.ini"        ;; check number of ini-files
            {
                iniCount:=A_Index
                confPath:=A_LoopFileFullPath
            }
            if (iniCount>1) {                       ;; multiple files, select one
                FileSelectFile configPath, 3, % File[1], % "Please select the ini-file you want to edit.", *.ini
            } else if (iniCount=1) {                ;; select the only one available
                configPath:=confPath
            } else if (iniCount=0) {                ;; create a new one
                FileSelectFile configPath, S8, % File[1], % "Please create the ini-file you want to use.", *.ini
            }
        } else { ; file
            configPath:=File[1]
        }
        loadConfig_Main(configPath,dynGUI)

        if (File.Count()>1) {
            Gui +OwnDialogs
            MsgBox 0x40010, % script.name " - Error occured: 2+ files/folders dropped", You have dropped more than either 1 .Rscript-file or 1 folder on the GUI. This will not work. Please drop either a single file`, or a single folder onto the GUI.
            Gui -OwnDialogs
        }
        if (InStr(FileExist(File[1]),"D")) { ; directory
            ; if directory, check first if Rscript-files exist
            ; multiple Rscript-files exist. if true, open a fileselectfile dialogue on that folder prompting to ask 
            rCount:=0 
            loop, Files, % File[1] "\*.R"        ;; check number of Rscript-files
            {
                rCount:=A_Index
                R_Path:=A_LoopFileFullPath
            }
            if (rCount>1) {                       ;; multiple files, select one
                FileSelectFile rPath, 3, % File[1], % "Please select the Rscript-file you want to edit.", *.R
            } else if (rCount=1) {                ;; select the only one available
                rPath:=R_Path
            } else if (rCount=0) {                ;; create a new one
                FileSelectFile rPath, S8, % File[1], % "Please create the Rscript-file you want to use.", *.R
                if (rPath!="") {
                    if !RegexMatch(rPath,"\.R$")  {
                        rPath.= ".R"
                    }
                    writeFile(rPath,"`n",Encoding:="UTF-8-RAW",,true)
                }
            }
        } else { ; file
            rPath:=File[1]
        }
        if (rPath="") {
            Gui +OwnDialogs
            MsgBox 0x40010, % script.name " - Error occured: Selection-GUI got cancelled", You have closed the selection-window without selecting an existing or creating a new Rscript-file. Please do either.
            Gui -OwnDialogs
            return
        }

        if RegexMatch(rPath,"\.ini$")  {
            Gui +OwnDialogs
            MsgBox 0x40010, % script.name " - Error occured: Dropped config-file on rscript-dropper", % "You have dropped the config-file`n`n'" rPath "'`n`n on the right selection-window. Please drag-and-drop an Rscript-file here instead."
            Gui -OwnDialogs
            return
        } else if !RegexMatch(rPath,"\.R$")  {
            rPath.= ".R"
        }
        guicontrol % "GC:",vStarterRScriptLocation, % rPath
        if (rPath!="") {
            dynGUI.GFA_Evaluation_RScript_Location:=rPath
        }

    }
    if (rPath!="") {
        dynGUI.GFA_Evaluation_RScript_Location:=rPath
        guiResize(guiObject,false)
    }
    if (configPath!="") {
        dynGUI.GFA_Evaluation_Configfile_Location:=configPath
        guiResize(guiObject,false)
    }
    return  
}
fillRC1(Code) {
    global
    gui GC: default
    Code:=strreplace(Code,"%GFA_EVALUATIONUTILITY%",strreplace(script.config.Configurator_settings.GFA_Evaluation_InstallationPath,"\","/"))
    RC.Settings.Highlighter:= "HighlightR"
        , RC.Value:= Code
    return
}
fillRC2(INI) {
    global
    gui GC: default
    RC2.Settings.Highlighter:= "HighlightINI"
        , RC2.Value:= INI
    return
}
loadConfig_Main(configPath,dynGUI) {
    global hwndLV_History
    global guiObject
    if (configPath="") {
        Gui +OwnDialogs
        MsgBox 0x40010, % script.name " - Error occured: Selection-GUI got cancelled", % "You have closed the selection-window without selecting an existing or creating a new config-file. Please do either."
        Gui -OwnDialogs
        return
    }
    if RegexMatch(configPath,"\.R$")  {
        Gui +OwnDialogs
        MsgBox 0x40010, % script.name " - Error occured: Dropped RScript-file on config-dropper", % "You have dropped the RScript-file`n`n'" configPath "'`n`n on the left selection-window. Please drag-and-drop a configuration-file (.ini) here instead."
        Gui -OwnDialogs
        return
    }
    if !RegexMatch(configPath,"\.ini$") {
        configPath.= ".ini"
    }
    if !FileExist(configPath) {                 ;; create a new config file in the folder, use the current config selections existing in the GUI and write them to file
        dynGUI.generateConfig(0)
        written_config:=dynGUI.ConfigObject
        t_script:=new script()
        t_script.Save(configPath,written_config)
    } else {                                    ;; a config-file exists - load the selections into the dynGUI; while doing so validate that all values are valid and that the ini is not corrupted.
        dynGUI.loadConfigFromFile(configPath)
        dynGUI.validateLoadedConfig()
        dynGUI.populateLoadedConfig()
        handleConfig(dynGUI,false)
        IniRead ExperimentName_Key, % configPath, Experiment, Name, % "Name not specified"
        SplitPath % configPath,,,, FileName
        itemLocation:=LV_EX_FindStringEx( hwndLV_History, configPath)
        if !itemLocation && !IsObject(itemLocation){
            gui listview, hwndLV_History
            LV_Add("",ExperimentName_Key,FileName,configPath)
        }
    }
    guicontrol % "GC:",vUsedConfigLocation, % configPath
    if (configPath!="") {
        dynGUI.GFA_Evaluation_Configfile_Location:=configPath
        guiResize(guiObject,false)
        SplitPath % configPath,, Chosen
        if ((subStr(Chosen,-1)!="\") && (subStr(Chosen,-1)!="/")) {
            Chosen.="\"
        }
        Chosen:=configPath
        WINDOWS:=strreplace(Chosen,"/","\")
        MAC:=strreplace(Chosen,"/","\")
        String:=guiObject.RCodeTemplate
        needle:="GFA_main\(r""\(\%.+\%\)"","
        needle:="GFA_main\((folder_path = r.+""),"
        rep1:="GFA_main(folder_path = r""("
        rep2:=")"","
        Matches:=RegexMatchAll(String, "iU)" needle)
        for _, match in Matches {                                                  ;; star, top
            match_ := match[0]
            if (_<2) {
                String:=strreplace(String,match_,rep1 WINDOWS rep2)
            } else {
                String:=strreplace(String,match_,rep1 MAC rep2)
            }
        }
        guiObject.RCodeTemplate:=String
        handleCheckboxesWrapper(Param:="")
    }
    return
}

handleCheckboxesWrapper(Param:="") {
    fillRC1(handleCheckboxes(Param))
}

handleCheckboxes(Param:="") {
    global
    gui GC: submit, nohide
    template:=guiObject.RCodeTemplate
        , template:=strreplace(template,"returnDays = %breturnDays%","returnDays = " vreturnDays)
        , template:=strreplace(template,"saveFigures = %bSaveFigures%","saveFigures = " vSaveFigures)
        , template:=strreplace(template,"saveRDATA = %bsaveRDATA%","saveRDATA = " vsaveRDATA)
        , template:=strreplace(template,"saveExcel = %bSaveExcel%","saveExcel = " vSaveExcel)
        , template:=strreplace(template,"returnDays = 1","returnDays = " vreturnDays)
        , template:=strreplace(template,"saveFigures = 1","saveFigures = " vSaveFigures)
        , template:=strreplace(template,"saveRDATA = 1","saveRDATA = " vsaveRDATA)
        , template:=strreplace(template,"saveExcel = 1","saveExcel = " vSaveExcel)
        , template:=strreplace(template,"returnDays = 0","returnDays = " vreturnDays)
        , template:=strreplace(template,"saveFigures = 0","saveFigures = " vSaveFigures)
        , template:=strreplace(template,"saveRDATA = 0","saveRDATA = " vsaveRDATA)
        , template:=strreplace(template,"saveExcel = 0","saveExcel = " vSaveExcel)
    return template
}
handleConfig(dynGUI,writetoFile:=false) {
    dynGUI.generateConfig(0)
    if (dynGUI.ConfigString!="") {
        fillRC2(dynGUI.ConfigString)
    }
    if (writetoFile) {
        SplitPath % dynGUI.GFA_Evaluation_Configfile_Location,,,,, OutDrive
        if FileExist(OutDrive) { ;; can't believe this is necessary...
            SplitPath % dynGUI.GFA_Evaluation_Configfile_Location, , SearchPath,
        } else {
            if (globalLogicSwitches.bIsDebug || globalLogicSwitches.Debug) { 
                Elaboration:="CallStack: " A_ThisFunc
            } 
            Gui +OwnDialogs
            MsgBox 0x40010
                ,% script.name " - Error occured: no config-file destination defined"
                ,% "You have not yet selected a location for your configuration file. Please do so before attempting to save your configuration."
                . Elaboration
            Gui -OwnDialogs
        }
        try {
            writeFile(dynGUI.GFA_Evaluation_Configfile_Location,dynGUI.ConfigString,script.config.Configurator_settings.INI_Encoding,,1)
        } catch e {
            throw Exception( "`n" CallStack() )
        }
    }
    return
}
GCSubmit() {
    gui GC: submit
    return
}
GCEscape() {
    gui GC: hide
    ;gui GC: destroy
    return
}

fCallBack_StatusBarMainWindow() {
    gui GC: Submit, NoHide
    ttip(globalLogicSwitches.bIsDebug)
    gui GC: -AlwaysOnTop
    if ((A_GuiEvent="DoubleClick") && (A_EventInfo=1)) {        ; part 0  -  ??

    } else if ((A_GuiEvent="DoubleClick") && (A_EventInfo=2)) { ; part 1  -  build/version - check for updates
        script.Update()
        gui % "GC: "((script.config.Configurator_settings.AlwaysOnTop)?"+":"-") "AlwaysOnTop"
        gui % "GC: Default"
        gui % "GC: +OwnDialogs"
    } else if ((A_GuiEvent="DoubleClick") && (A_EventInfo=3)) { ; part 2  -  Author
        script.About()
    } else if ((A_GuiEvent="DoubleClick") && (A_EventInfo=4)) { ; part 3  -  Mode Toggle
        script.config.Configurator_settings.bDebugSwitch:=!script.config.Configurator_settings.bDebugSwitch

        if (!(script.authorID!=A_ComputerName) & !globalLogicSwitches.bIsDebug) || ((script.authorID!=A_ComputerName) & !globalLogicSwitches.bIsDebug)
        { ;; public display
            SB_SetText("Standard Mode Engaged. Click to enter debug-mode",4)
            SoundBeep 150, 150
            SoundBeep 150, 150
            SoundBeep 150, 150
            ListLines Off
            ; KeyHistory
        }
        else if (!(script.authorID!=A_ComputerName)) || ((script.authorID!=A_ComputerName) && globalLogicSwitches.bIsDebug)
        {
            SoundBeep 1750, 150
            SoundBeep 1750, 150
            SoundBeep 1750, 150
            SB_SetText("Author/Debug Mode Engaged. Click to exit debug-mode",4)
            ListLines On
        }
    } else if ((A_GuiEvent="DoubleClick") && (A_EventInfo=5)) { ; part 4 - Debug Mode

    } else if ((A_GuiEvent="DoubleClick") && (A_EventInfo=6)) { ; part 5 - report bug
        if script.requiresInternet(script.metadataArr.Issues) {
            script.About(1)
            run % "https://www." script.metadataArr.Issues
        }
    } else if ((A_GuiEvent="DoubleClick") && (A_EventInfo=7)) { ; part 6 - documentation
        if script.requiresInternet(script.metadataArr["GH-Repo"]) {
            script.About(1)
            run % "https://www." script.metadataArr.Documentation
        }

    } else if ((A_GuiEvent="DoubleClick") && (A_EventInfo=8)) { ; part 7

    } else if ((A_GuiEvent="DoubleClick") && (A_EventInfo=9)) { ; part 8

    }
    gui % "GC: " ((script.config.Configurator_settings.AlwaysOnTop)?"+":"-") "AlwaysOnTop"
    gui GC: Default
    gui GC: +OwnDialogs
    return
}
~!Esc::Reload

createConfiguration(Path,AA) {
    global
    if (!globalLogicSwitches.DEBUG) {
        SearchPath:="C://"
    }
    if (!FileExist(Path)) {
        SearchPath:="C://"
    } else {
        SearchPath:=Path
    }
    gui -AlwaysOnTop
    FileSelectFile Chosen, S8, % SearchPath, % "Please create the ini-file you want to use.", *ini
    if (Chosen!="") {
        ;@ahk-neko-ignore-fn 1 line; at 4/28/2023, 9:44:47 AM ; case sensitivity
        if !RegexMatch(Chosen,"\.ini$") {
            Chosen.=".ini" 
        }
        guicontrol % "GC:",vUsedConfigLocation, % Chosen
        if (!FileExist(Chosen)) {
            writeFile(Chosen,"",script.config.Configurator_settings.INI_Encoding,,true)
        } else {
            dynGUI.loadConfigFromFile(Chosen)
                , dynGUI.validateLoadedConfig()
                , dynGUI.populateLoadedConfig()
                , handleConfig(dynGUI,false)
            IniRead ExperimentName_Key, % Chosen, Experiment, Name, % "Name not specified"
            SplitPath % Chosen,,,, FileName
            itemLocation:=LV_EX_FindStringEx( hwndLV_History, Chosen)
            if !itemLocation && !IsObject(itemLocation){
                gui listview, hwndLV_History
                LV_Add("",ExperimentName_Key,FileName,Chosen)
            }
        }
    }
    GFA_configurationFile:=Chosen
        , dynGUI.GFA_Evaluation_Configfile_Location:=Chosen
    guiResize(guiObject,false)
    if (Chosen!="") {

        SplitPath % Chosen,, Chosen
        if ((subStr(Chosen,-1)!="\") && (subStr(Chosen,-1)!="/")) {
            Chosen.="\"
        }
        WINDOWS:=strreplace(Chosen,"/","\")
        MAC:=strreplace(Chosen,"/","\")
        String:=guiObject.RCodeTemplate
        needle:="GFA_main\(r""\(\%.+\%\)"","
        needle:="GFA_main\((r.+""),"
        rep1:="GFA_main(r""("
        rep2:=")"","
        Matches:=RegexMatchAll(String, "iU)" needle)
        for _, match in Matches {                                                  ;; star, top
            match_ := match[0]
            if (_<2) {
                String:=strreplace(String,match_,rep1 WINDOWS rep2)
            } else {
                String:=strreplace(String,match_,rep1 MAC rep2)
            }
        }
        guiObject.RCodeTemplate:=String
        handleCheckboxesWrapper(Param:="")
    }
    gui % "GC: " ((script.config.Configurator_settings.AlwaysOnTop)?"+":"-") "AlwaysOnTop"
    return Chosen
}
editConfiguration(configurationFile) {
    global
    gui Submit,NoHide

    if (FileExist(GFA_configurationFile)) {
        run % GFA_configurationFile
    } else if (FileExist(configurationFile)) {
        run % configurationFile
    } else {
        if (globalLogicSwitches.DEBUG) {
            GFA_configurationFile:=createConfiguration(A_ScriptDir,guiObject)

        } else {

            GFA_configurationFile:=createConfiguration("D:/",guiObject)
        }
    }
    gui GC: default
    return
}
editRScript(rScriptFile) {
    global
    gui Submit,NoHide
    if (FileExist(rScriptFile)) {
        run % rScriptFile
    } else if (FileExist(dynGUI.GFA_Evaluation_Configfile_Location)) {
        SplitPath % dynGUI.GFA_Evaluation_Configfile_Location,, OutDir
        GFA_rScriptFile:=createRScript(OutDir,true,true)
    } else {
        if (globalLogicSwitches.DEBUG) {
            GFA_rScriptFile:=createRScript(A_ScriptDir)
        } else {
            GFA_rScriptFile:=createRScript("D:/")
        }
    }
    gui GC: default
    return
}
createRScript(Path,forceSelection:=false,overwrite:=false) {
    global
    static Chosen
    static inputPath
    gui Submit, NoHide


    OutDrive:=0
    SplitPath % dynGUI.GFA_Evaluation_RScript_Location,,OutDir,,, OutDrive
    if (FileExist(OutDrive) && InStr(dynGUI.GFA_Evaluation_Configfile_Location,OutDir)) { ;; can't believe this is necessary...
        writeFile(dynGUI.GFA_Evaluation_RScript_Location,"","UTF-8-RAW",,true)
    } else {
        if FileExist(dynGUI.GFA_Evaluation_Configfile_Location) {
            SplitPath % dynGUI.GFA_Evaluation_Configfile_Location, , SearchPath,
        }
    }
    if (!globalLogicSwitches.DEBUG) {
        SearchPath:="C://"
    }
    if (SearchPath="") {
        if (!FileExist(Path)) {
            if IsObject(Path) {
                if (Path.HasKey("GFA_Evaluation_Configfile_Location")) {
                    SplitPath % Path.GFA_Evaluation_Configfile_Location,, SearchPath
                } else {
                    SearchPath:="C://"
                }
            } else {
                SearchPath:="C://"
            }
        } else {
            SearchPath:=Path
        }
    } else {
        if (FileExist(vStarterRScriptLocation)) {
            Chosen:=vStarterRScriptLocation
            forceSelection:=false
        }
    }
    if (Chosen="" || forceSelection) {
        FileSelectFile Chosen, S8, % SearchPath, % "Please create the Rscript-file you want to use.", *.R
    }
    if (!InStr(Chosen,SearchPath) && (dynGUI.GFA_Evaluation_Configfile_Location!="")) {
        ;; we changed folder away from the initial config folder, so... throw an error to warn the user?!
        ;throw Exception("You tried editing an R-script which is in a different folder than your previously selected configuration-file. ", , "As your newly selected R-Script resides in a different foler which still contains a configuration file, be aware that the script may not handle this scenario well or at all. Data loss may occur, it is not advised to do so. If you want to edit the script of a different GFA, it is advised to first select a config-file which resides in the same folder as the script you want to edit.")
        ;throw Exception("`n" CallStack())
        FileSelectFile Chosen, S8, % SearchPath, % "Please create the Rscript-file you want to use.", *.R
    }
    if (Chosen!="") {
        ;@ahk-neko-ignore-fn 1 line; at 4/28/2023, 9:44:47 AM ; case sensitivity
        if (!InStr(Chosen,".R")) {
            Chosen:=Chosen ".R"
        }
        guicontrol % "GC:",vStarterRScriptLocation, % Chosen
        if (Chosen!="") {
            dynGUI.GFA_Evaluation_RScript_Location:=Chosen
        }
        if (!FileExist(Chosen)) {
            writeFile(Chosen,"`n","UTF-8-RAW",,true)
        }
        guiResize(guiObject,false)
    }
    if (Chosen!="") {
        if (overwrite) {
            ;; TODO:  overwriting file: we come from "Edit existing R Script, and need to first parse the existing script for its settings before we can overwrite it"
            guiObject.RCodeTemplate:=handleCheckboxes()
            ;if InStr(dynGUI.GFA_Evaluation_Configfile_Location,".ini") {
            ;    SplitPath % guiObject.dynGUI.GFA_Evaluation_Configfile_Location, , configLocationFolder
            ;}
            configLocationFolder:=guiObject.dynGUI.GFA_Evaluation_Configfile_Location
            if ((subStr(configLocationFolder,-1)!="\") && (subStr(configLocationFolder,-1)!="/") && (subStr(configLocationFolder,-3)!=".ini")) {
                configLocationFolder.="\"
            }
            WINDOWS:=strreplace(configLocationFolder,"/","\")
            MAC:=strreplace(configLocationFolder,"/","\")
            Code:=strreplace(guiObject.RCodeTemplate,"%GFA_CONFIGLOCATIONFOLDER_WINDOWS%",WINDOWS)
            Code:=strreplace(Code,"%GFA_EVALUATIONUTILITY%",strreplace(script.config.Configurator_settings.GFA_Evaluation_InstallationPath,"\","/"))
            Code:=strreplace(Code,"%GFA_CONFIGLOCATIONFOLDER_MAC%",MAC)
            fillRC1(Code)
            try {
                writeFile(Chosen,Code,"UTF-8-RAW",,true)
            } catch e {
                throw Exception( "`n" CallStack() )
            }
        } else {

            guiObject.RCodeTemplate:=handleCheckboxes()
            ;if InStr(dynGUI.GFA_Evaluation_Configfile_Location,".ini") {
            ;    SplitPath % guiObject.dynGUI.GFA_Evaluation_Configfile_Location, , configLocationFolder
            ;}
            configLocationFolder:=guiObject.dynGUI.GFA_Evaluation_Configfile_Location
            if ((subStr(configLocationFolder,-1)!="\") && (subStr(configLocationFolder,-1)!="/") && (subStr(configLocationFolder,-3)!=".ini")) {
                configLocationFolder.="\"
            }
            WINDOWS:=strreplace(configLocationFolder,"/","\")
            MAC:=strreplace(configLocationFolder,"/","\")
            Code:=strreplace(guiObject.RCodeTemplate,"%GFA_CONFIGLOCATIONFOLDER_WINDOWS%",WINDOWS)
            Code:=strreplace(Code,"%GFA_EVALUATIONUTILITY%",strreplace(script.config.Configurator_settings.GFA_Evaluation_InstallationPath,"\","/"))
            Code:=strreplace(Code,"%GFA_CONFIGLOCATIONFOLDER_MAC%",MAC)
            fillRC1(Code)
            try {
                writeFile(Chosen,Code,"UTF-8-RAW",,true)
            } catch e {
                throw Exception( "`n" CallStack() )
            }
        }
    }
    return Chosen
}
selectConfigLocation(SearchPath) {
    if (!globalLogicSwitches.DEBUG) {
        SearchPath:="C://"
    }
    FileSelectFile Chosen, 3, % SearchPath, % "Please select the ini-file you want to use.", *.R

    SplitPath % Chosen
    if (Chosen!="") {
        ;@ahk-neko-ignore-fn 1 line; at 4/28/2023, 9:44:47 AM ; case sensitivity
        Chosen:=Chosen "\GFA_conf_AG.ini"
        guicontrol % "GC:",vUsedConfigLocation, % Chosen
        if (!FileExist(Chosen)) {
            writeFile(Chosen,"",script.config.Configurator_settings.INI_Encoding,,true)
        } else {
            IniRead ExperimentName_Key, % Chosen, Experiment, Name, % "Name not specified"
            SplitPath % Chosen,,,, FileName
            gui listview, hwndLV_History
            LV_Add("",ExperimentName_Key,FileName,Chosen)
        }
        guiResize(guiObject,false)
    }
    global GFA_configurationFile:=Chosen
    return Chosen
}
updateConfigLV(hwndLV_History) {
    LV_Delete()
    SetExplorerTheme(hwndLV_History)
    TThwnd := DllCall("SendMessage", "ptr", hwndLV_History, "uint", LVM_GETTOOLTIPS := 0x104E, "ptr", 0, "ptr", 0, "ptr")
    for each, File in script.config.LastConfigsHistory {
        if (FileExist(File)) {
            SplitPath % File, , OutDir, , FileName
            oldFileEnc:=A_FileEncoding
            FileEncoding % script.config.Configurator_settings.INI_Encoding
            IniRead ExperimentName_Key, % File, % "Experiment", % "Name", % "Name not specified"
            FileEncoding % oldFileEnc
            LV_Add("",ExperimentName_Key,FileName,File)
        } else {
            script.config.LastConfigsHistory.RemoveAt(each,1)
        }
    }


    LV_EX_SetTileViewLines(hwndLV_History, 2, 310)
    LV_EX_SetTileInfo(hwndLV_History, 0, 2,3, 4)
    ; WM_NOTIFY handler
    OnMessage(0x4E, "On_WM_NOTIFY")
    WinSet AlwaysOnTop, On, % "ahk_id " TThwnd
    script.config.LastConfigsHistory:=buildHistory(script.config.LastConfigsHistory,script.config.Configurator_settings.ConfigHistoryLimit)
    return
}
#if bRunFromVSC
NumpadDot::reload

reload() {
    reload
}
exitApp() {
    ExitApp
}

prepare_release() {
    RunWait % A_ScriptDir "\Excludes\build.ahk"
    ExitApp
}
#Include <script>
#Include <Base64PNG_to_HICON>
#Include <DynamicArguments>
#Include <isDebug>
#Include <MWAGetMonitor>
#Include <OnError>
#Include <OnExit>
#Include <Quote>
#Include <st_stringthings_functions>
#Include <ttip>
#Include <writeFile>
#Include <GFC_GUI>
#Include <Configuration>
#Include <RunAsAdmin>
#Include <AddToolTip>
#Include <RichCode>
#Include <HasVal>
#Include <Obj2Str>
#Include <AutoXYWH>
#Include <History>
#Include <LV_EX>
#Include <SetExplorerTheme>
#Include <RegexMatchAll>
#Include <checkDecimalsOnEdit>
#Include <Deref>
#Include <csv2xlsx>
#Include <UriHandling>
#Include <WinHttpRequest>
#Include <SelectFolder>
#Include <StdErr_Write>
#Include <ClipboardSetFiles>
#Include <CountFilesR>
#Include <renameImages>

