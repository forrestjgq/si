macro eInstall ()
{
  msg("start")
	/* Run_Macro Ctrl+Alt+R */
	AssignKeyToCmd(3154, "Run Macro")

	/* Smart_Rename Ctrl+' */
	AssignKeyToCmd(1063, "Smart Rename")

	/* Drag_Line_Down Ctrl+Alt+N */
	AssignKeyToCmd(3150, "Drag Line Down")

	/* Drag_Line_Up Ctrl+Alt+P */
	AssignKeyToCmd(3152, "Drag Line Up")

	/* Replace Ctrl+H */
	AssignKeyToCmd(1096, "Replace")

	/* Insert_Line_Before_Next Ctrl+I */
	AssignKeyToCmd(1097, "Insert Line Before Next")

	/* Join_Lines Ctrl+J */
	AssignKeyToCmd(1098, "Join Lines")

	/* Renumber Ctrl+R */
	AssignKeyToCmd(1106, "Renumber")

	/* Undo Ctrl+Z */
	AssignKeyToCmd(1114, "Undo")

	/* Indent_Right F10 */
	AssignKeyToCmd(4217, "Indent Right")

	/* Indent_Left F9 */
	AssignKeyToCmd(4216, "Indent Left")

	/* Back_Tab Shift+Tab */
	AssignKeyToCmd(777, "Back Tab")

	/* Simple_Tab Tab */
	AssignKeyToCmd(9, "Simple Tab")

	/* Open Ctrl+O */
	AssignKeyToCmd(1103, "Open")

	/* eGoBack Alt+, */
	AssignKeyToCmd(2092, "eGoBack")

	/* eJumpToDefinition Alt+. */
	AssignKeyToCmd(2094, "eJumpToDefinition")

	/* eGoFwd Alt+/ */
	AssignKeyToCmd(2095, "eGoFwd")

	/* eMoveToPrevWord Alt+B */
	AssignKeyToCmd(2114, "eMoveToPrevWord")

	/* eKillPrevWord Alt+BackSpace */
	AssignKeyToCmd(2056, "eKillPrevWord")

	/* eKillNextWord Alt+D */
	AssignKeyToCmd(2116, "eKillNextWord")

	/* eMoveToNextWord Alt+F */
	AssignKeyToCmd(2118, "eMoveToNextWord")

	/* eKillToLineHead Alt+K */
	AssignKeyToCmd(2123, "eKillToLineHead")

	/* eNaviCmd Alt+N */
	AssignKeyToCmd(2126, "eNaviCmd")

	/* ePrjCmd Alt+P */
	AssignKeyToCmd(2128, "ePrjCmd")

	/* eMoveToBuffHead Alt+Shift+< */
	AssignKeyToCmd(2876, "eMoveToBuffHead")

	/* eMoveToBuffEnd Alt+Shift+> */
	AssignKeyToCmd(2878, "eMoveToBuffEnd")

	/* eGetKey Alt+Shift+K */
	AssignKeyToCmd(2891, "eGetKey")

	/* eMoveToPrevScreen Alt+V */
	AssignKeyToCmd(2134, "eMoveToPrevScreen")

	/* eCopy Alt+W */
	AssignKeyToCmd(2135, "eCopy")

	/* eWndCmd Alt+X */
	AssignKeyToCmd(2136, "eWndCmd")

	/* eEditCmd Alt+E */
	AssignKeyToCmd(2117, "eEditCmd")

	/* eBufCmd Ctrl+X */
	AssignKeyToCmd(1112, "eBufCmd")

	/* eCmtCmd Alt+C */
	AssignKeyToCmd(2115, "eCmtCmd")

	/* eRemovePrevChar BackSpace */
	AssignKeyToCmd(8, "eRemovePrevChar")

	/* eUndo Ctrl+/ */
	AssignKeyToCmd(1071, "eUndo")

	/* eMoveToLineHead Ctrl+A */
	AssignKeyToCmd(1089, "eMoveToLineHead")

	/* InsertIfdef Ctrl+Alt+I */
	AssignKeyToCmd(3145, "InsertIfdef")

	/* eMoveToPrevChar Ctrl+B */
	AssignKeyToCmd(1090, "eMoveToPrevChar")

	/* eRemoveNextChar Ctrl+D */
	AssignKeyToCmd(1092, "eRemoveNextChar")

	/* eMoveToLineEnd Ctrl+E */
	AssignKeyToCmd(1093, "eMoveToLineEnd")

	/* eMoveToNextChar Ctrl+F */
	AssignKeyToCmd(1094, "eMoveToNextChar")

	/* eKillToLineEnd Ctrl+K */
	AssignKeyToCmd(1099, "eKillToLineEnd")

	/* eReCenterTopBottom Ctrl+L */
	AssignKeyToCmd(1100, "eReCenterTopBottom")

	/* eMoveToNextLine Ctrl+N */
	AssignKeyToCmd(1102, "eMoveToNextLine")

	/* eMoveToPrevLine Ctrl+P */
	AssignKeyToCmd(1104, "eMoveToPrevLine")

	/* eDoMark Ctrl+Shift+2 */
	AssignKeyToCmd(1842, "eDoMark")

	/* eMoveToNextScreen Ctrl+V */
	AssignKeyToCmd(1110, "eMoveToNextScreen")

	/* eCut Ctrl+W */
	AssignKeyToCmd(1111, "eCut")

	/* eBufCmd Ctrl+X */
	AssignKeyToCmd(1112, "eBufCmd")

	/* ePaste Ctrl+Y */
	AssignKeyToCmd(1113, "ePaste")

	/* eSmartEnd End */
	AssignKeyToCmd(32803, "eSmartEnd")

	/* eAutoEnter Enter */
	AssignKeyToCmd(13, "eAutoEnter")

	/* eSmartHome Home */
	AssignKeyToCmd(32804, "eSmartHome")

	/* eSearchPrevTag Alt+Q */
	AssignKeyToCmd(2129, "eSearchPrevTag")

	/* eSearchNextTag Ctrl+Q */
	AssignKeyToCmd(1105, "eSearchNextTag")

	/* Select_Function_or_Symbol Alt+- */
	AssignKeyToCmd(2093, "Select Function or Symbol")

	/* Select_Match Alt+= */
	AssignKeyToCmd(2109, "Select Match")

	/* Go_Back_Toggle Alt+M */
	AssignKeyToCmd(2125, "Go Back Toggle")

	/* Select_Line Alt+Shift+L */
	AssignKeyToCmd(2892, "Select Line")

	/* Select_Word Alt+Shift+W */
	AssignKeyToCmd(2903, "Select Word")

	/* Select_Block Ctrl+- */
	AssignKeyToCmd(1069, "Select Block")

	/* Go_To_Previous_Link Ctrl+, */
	AssignKeyToCmd(1068, "Go To Previous Link")

	/* Go_To_Next_Link Ctrl+. */
	AssignKeyToCmd(1070, "Go To Next Link")

	/* Select_Paragraph Ctrl+= */
	AssignKeyToCmd(1085, "Select Paragraph")

	/* Paren_Right Ctrl+0 */
	AssignKeyToCmd(1072, "Paren Right")

	/* Paren_Left Ctrl+9 */
	AssignKeyToCmd(1081, "Paren Left")

	/* Function_Up Ctrl+Alt+- */
	AssignKeyToCmd(3117, "Function Up")

	/* Beginning_Of_Selection Ctrl+Alt+[ */
	AssignKeyToCmd(3163, "Beginning Of Selection")

	/* End_Of_Selection Ctrl+Alt+] */
	AssignKeyToCmd(3165, "End Of Selection")

	/* Function_Down Ctrl+Alt+= */
	AssignKeyToCmd(3133, "Function Down")

	/* Blank_Line_Down Ctrl+Down */
	AssignKeyToCmd(33832, "Blank Line Down")

	/* Go_To_Line Ctrl+G */
	AssignKeyToCmd(1095, "Go To Line")

	/* Block_Up Ctrl+Shift+[ */
	AssignKeyToCmd(1883, "Block Up")

	/* Block_Down Ctrl+Shift+] */
	AssignKeyToCmd(1885, "Block Down")

	/* Blank_Line_Up Ctrl+Up */
	AssignKeyToCmd(33830, "Blank Line Up")

	/* Cursor_Down Down */
	AssignKeyToCmd(32808, "Cursor Down")

	/* Cursor_Left Left */
	AssignKeyToCmd(32805, "Cursor Left")

	/* Cursor_Right Right */
	AssignKeyToCmd(32807, "Cursor Right")

	/* Cursor_Up Up */
	AssignKeyToCmd(32806, "Cursor Up")

	/* Key_Assignments Ctrl+Alt+K */
	AssignKeyToCmd(3147, "Key Assignments")

	/* Search_Files Ctrl+Shift+F */
	AssignKeyToCmd(1862, "Search Files")

	/* Replace_Files Ctrl+Shift+H */
	AssignKeyToCmd(1864, "Replace Files")

	/* Incremental_Search_Backward F11 */
	AssignKeyToCmd(4218, "Incremental Search Backward")

	/* Incremental_Search F12 */
	AssignKeyToCmd(4219, "Incremental Search")

	/* Search_Backward F3 */
	AssignKeyToCmd(4210, "Search Backward")

	/* Search_Forward F4 */
	AssignKeyToCmd(4211, "Search Forward")

	/* Search_Backward_for_Selection Shift+F3 */
	AssignKeyToCmd(4978, "Search Backward for Selection")

	/* Search_Forward_for_Selection Shift+F4 */
	AssignKeyToCmd(4979, "Search Forward for Selection")

	/* Search Ctrl+S */
	AssignKeyToCmd(1107, "Search")

	/* Browse_Project_Symbols Alt+G */
	AssignKeyToCmd(2119, "Browse Project Symbols")

	/* Lookup_References Alt+S */
	AssignKeyToCmd(2131, "Lookup References")

	/* Generate_Call_Tree Ctrl+Alt+T */
	AssignKeyToCmd(3156, "Generate Call Tree")

	/* Browse_Local_File_Symbols F8 */
	AssignKeyToCmd(4215, "Browse Local File Symbols")

	/* Highlight_Word Alt+H */
	AssignKeyToCmd(2120, "Highlight Word")

	/* Clear_Highlights Ctrl+Alt+H */
	AssignKeyToCmd(3144, "Clear Highlights")

	/* Last_Window Ctrl+Tab */
	AssignKeyToCmd(1033, "Last Window")

}
macro eEditCmd ()
{
	var key
	key = _InputKey()

	/* Cut_Line_Left E+Alt+W */
	if(key == 2135 || key == 2167) {
		Cut_Line_Left
		stop
	}

	/* Insert_New_Line E+B */
	if(key == 66 || key == 98) {
		Insert_New_Line
		stop
	}

	/* eCopyLine E+C */
	if(key == 67 || key == 99) {
		eCopyLine
		stop
	}

	/* Copy_Line_Right E+Ctrl+C */
	if(key == 1091 || key == 1123) {
		Copy_Line_Right
		stop
	}

	/* Cut_Line_Right E+Ctrl+W */
	if(key == 1111 || key == 1143) {
		Cut_Line_Right
		stop
	}

	/* Delete_Line E+D */
	if(key == 68 || key == 100) {
		Delete_Line
		stop
	}

	/* Insert_Line E+I */
	if(key == 73 || key == 105) {
		Insert_Line
		stop
	}

	/* Lowercase E+L */
	if(key == 76 || key == 108) {
		Lowercase
		stop
	}

	/* Complete_Symbol E+S */
	if(key == 83 || key == 115) {
		Complete_Symbol
		stop
	}

	/* Toggle_Case E+T */
	if(key == 84 || key == 116) {
		Toggle_Case
		stop
	}

	/* Uppercase E+U */
	if(key == 85 || key == 117) {
		Uppercase
		stop
	}

	/* Cut_Line E+W */
	if(key == 87 || key == 119) {
		Cut_Line
		stop
	}

	/* eBreakToNextLine E+Ctrl+B */
	if(key == 1090 || key == 1122) {
		eBreakToNextLine
		stop
	}

	/* eBreakEighty E+E */
	if(key == 69 || key == 101) {
		eBreakEighty
		stop
	}

}
macro eBufCmd ()
{
	var key
	key = _InputKey()

	/* Exit X+Ctrl+C */
	if(key == 1091 || key == 1123) {
		Exit
		stop
	}

	/* Save_As X+Alt+S */
	if(key == 2131 || key == 2163) {
		Save_As
		stop
	}

	/* Save_All X+Ctrl+A */
	if(key == 1089 || key == 1121) {
		Save_All
		stop
	}

	/* Close_All X+Ctrl+K */
	if(key == 1099 || key == 1131) {
		Close_All
		stop
	}

	/* Save X+Ctrl+S */
	if(key == 1107 || key == 1139) {
		Save
		stop
	}

	/* Close X+K */
	if(key == 75 || key == 107) {
		Close
		stop
	}

	/* New X+Ctrl+N */
	if(key == 1102 || key == 1134) {
		New
		stop
	}

	/* Reload_File X+R */
	if(key == 82 || key == 114) {
		Reload_File
		stop
	}

	/* Show_File_Status X+S */
	if(key == 83 || key == 115) {
		Show_File_Status
		stop
	}

	/* Select_All X+A */
	if(key == 65 || key == 97) {
		Select_All
		stop
	}

	/* Select_Previous_Window X+B */
	if(key == 66 || key == 98) {
		Select_Previous_Window
		stop
	}

	/* Select_Next_Window X+N */
	if(key == 78 || key == 110) {
		Select_Next_Window
		stop
	}

}
macro eCmtCmd ()
{
	var key
	key = _InputKey()

	/* eCommentBlock C+/ */
	if(key == 47) {
		eCommentBlock
		stop
	}

	/* eCommentAllFunc C+A */
	if(key == 65 || key == 97) {
		eCommentAllFunc
		stop
	}

	/* eCommentFunc C+F */
	if(key == 70 || key == 102) {
		eCommentFunc
		stop
	}

	/* eAddFileHdr C+H */
	if(key == 72 || key == 104) {
		eAddFileHdr
		stop
	}

	/* eCommentAllOpenBuf C+O */
	if(key == 79 || key == 111) {
		eCommentAllOpenBuf
		stop
	}

}
macro eWndCmd ()
{
	var key
	key = _InputKey()

	/* Activate_Edit_Menu M+E */
	if(key == 69 || key == 101) {
		Activate_Edit_Menu
		stop
	}

	/* Activate_File_Menu M+F */
	if(key == 70 || key == 102) {
		Activate_File_Menu
		stop
	}

	/* Activate_Help_Menu M+H */
	if(key == 72 || key == 104) {
		Activate_Help_Menu
		stop
	}

	/* Activate_Work_Menu M+K */
	if(key == 75 || key == 107) {
		Activate_Work_Menu
		stop
	}

	/* Activate_Options_Menu M+O */
	if(key == 79 || key == 111) {
		Activate_Options_Menu
		stop
	}

	/* Activate_Project_Menu M+P */
	if(key == 80 || key == 112) {
		Activate_Project_Menu
		stop
	}

	/* Activate_Search_Menu M+S */
	if(key == 83 || key == 115) {
		Activate_Search_Menu
		stop
	}

	/* Activate_View_Menu M+V */
	if(key == 86 || key == 118) {
		Activate_View_Menu
		stop
	}

	/* Activate_Window_Menu M+W */
	if(key == 87 || key == 119) {
		Activate_Window_Menu
		stop
	}

	/* Activate_Symbol_Window M+L */
	if(key == 76 || key == 108) {
		Activate_Symbol_Window
		stop
	}

	/* Activate_Search_Results M+R */
	if(key == 82 || key == 114) {
		Activate_Search_Results
		stop
	}

	/* Display_Options M+D */
	if(key == 68 || key == 100) {
		Display_Options
		stop
	}

	/* Document_Options M+T */
	if(key == 84 || key == 116) {
		Document_Options
		stop
	}

}
macro ePrjCmd ()
{
	var key
	key = _InputKey()

	/* Close_Project P+C */
	if(key == 67 || key == 99) {
		Close_Project
		stop
	}

	/* Remove_Project P+D */
	if(key == 68 || key == 100) {
		Remove_Project
		stop
	}

	/* New_Project P+N */
	if(key == 78 || key == 110) {
		New_Project
		stop
	}

	/* Open_Project P+O */
	if(key == 79 || key == 111) {
		Open_Project
		stop
	}

	/* Remove_File P+R */
	if(key == 82 || key == 114) {
		Remove_File
		stop
	}

	/* Synchronize_Files P+S */
	if(key == 83 || key == 115) {
		Synchronize_Files
		stop
	}

}
macro eNaviCmd ()
{
	var key
	key = _InputKey()

	/* Jump_To_Link N+L */
	if(key == 76 || key == 108) {
		Jump_To_Link
		stop
	}

	/* Jump_To_Match N+M */
	if(key == 77 || key == 109) {
		Jump_To_Match
		stop
	}

	/* Jump_To_Base_Type N+B */
	if(key == 66 || key == 98) {
		Jump_To_Base_Type
		stop
	}

	/* Jump_To_Caller N+C */
	if(key == 67 || key == 99) {
		Jump_To_Caller
		stop
	}

	/* Jump_To_Definition N+D */
	if(key == 68 || key == 100) {
		Jump_To_Definition
		stop
	}

	/* Jump_To_Prototype N+P */
	if(key == 80 || key == 112) {
		Jump_To_Prototype
		stop
	}

}
