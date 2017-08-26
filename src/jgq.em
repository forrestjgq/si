event AppStart()
{
    // SL_TAG is used for indicating where developpers should edit and is the
    //   target between TAB jumping
    //
    
    global SL_TAG
    global g_bMark

    SL_TAG = "`"
    g_bMark = False
}

macro _InputKey()
{
    var key
    var keys
    
	StartMsg("Key Command: Please press command key, or Esc to abort")
	key = getkey()
	EndMsg()
    //msg("keys=@keys@ key=@key@")
    return key
}

macro _IsSameSelection(sel1, sel2)
{
	if (sel1.lnFirst != sel2.lnFirst ||
	    sel1.lnLast != sel2.lnLast ||
	    sel1.ichFirst != sel2.ichFirst ||
	    sel1.ichLim != sel2.ichLim ||
	    sel1.fExtended != sel2.fExtended ||
	    sel1.fRect != sel2.fRect ||
	    sel1.xLeft != sel2.xLeft ||
	    sel1.xRight != sel2.xRight)
    {
    	return False
    }

    return True
}
macro _IsSelectionMultiChars()
{
	var hWnd
	hWnd = GetCurrentWnd()
	if(hWnd == hNil)
	{
		stop
	}

	var sel
	sel = GetWndSel(hWnd)

	if (sel.lnFirst != sel.lnLast || sel.ichFirst != sel.ichLim)
	{
		return True
	}
	return False
}
macro _SetMarkOn()
{
	g_bMark = True
}
macro _SetMarkOff()
{
	g_bMark = False

	var hWnd
	hWnd = GetCurrentWnd()
	if(hWnd == hNil)
	{
		stop
	}

	var sel
	sel = GetWndSel(hWnd)
	if (sel.lnFirst != sel.lnLast || sel.ichFirst != sel.ichLim)
	{
		sel.lnFirst = sel.lnLast
		sel.ichFirst = sel.ichLim
		sel.fExtended = False
		sel.fRect = False
		SetWndSel(hWnd, sel)
	}
}
macro _IsMarkOn()
{
	//msg "mark=@g_bMark@"
	if (g_bMark == True)
	{
		return g_bMark
	}
	else
	{
		var hWnd
		hWnd = GetCurrentWnd()
		if(hWnd == hNil)
		{
			stop
		}

		var sel
		sel = GetWndSel(hWnd)
		if (sel.lnFirst != sel.lnLast || sel.ichFirst != sel.ichLim)
		{
			return True
		}

		return False
	}
}

/* Judge if from str[pos] to str[end] are all white spaces */
macro _AllWSAfter(str, pos)
{
    var len
    len = strlen(str)

    if(pos == len)
        return False
        
    while(pos < len)
    {
        if(!_IsWS(str[pos]))
        {
            return False
        }
        pos = pos + 1
    }

    return True
}
/* Judge if from str[pos] to str[end] are all white spaces */
macro _AllWSBefore(str, pos)
{
    var idx
    if(pos < 1)
        return False
        
    idx = 0
    while(idx < pos)
    {
        if(!_IsWS(str[idx]))
        {
            return False
        }
        idx = idx + 1
    }

    return True
}

/* Clear continours spaces/tabs into one single space for a string */
macro _ClearInnerSpace(str)
{
    var first
    var last
    var len
    var ret 
    var subs

    ret = ""
    first = -1
    last = 0
    len = strlen(str)

    while(last < len)
    {
        if(first == -1)
        {
            if(!_IsWS(str[last]))
            {
                first = last
            }
        }
        else
        {
            if(_IsWS(str[last]))
            {
                //msg("@str@, @first@, @last@")
                subs = strmid(str, first, last)
                if(ret == "")
                {
                    ret = "@subs@"
                }
                else if(_StartWithOneOf(subs,"{[("))
                {
                    ret = "@ret@@subs@"
                }
                else
                {
                    ret = "@ret@ @subs@"
                }
                //msg("subs=@subs@, ret=@ret@")
                first = -1
            }
        }

        last = last + 1
    }

    if(first != -1 && !_IsWS(str[last]))
    {
        subs = strmid(str, first, len)
        if(ret == "")
        {
            ret = "@subs@"
        }
        else if(_StartWithOneOf(subs,"{[("))
        {
            ret = "@ret@@subs@"
        }
        else
        {
            ret = "@ret@ @subs@"
        }
    }

    return ret
}

/* return True if str1 ends with str2 */
macro _EndWith(str1, str2)
{
    var len1
    var len2
    var s
    
    len1 = strlen(str1)
    len2 = strlen(str2)
    if(len1 < len2)
        return False
        
    s = strmid(str1, len1-len2, len1)
    //msg("endwith @s@, @str1@, @str2@")
    if(s == str2)
    {
        return True
    }
    else
    {
        return False
    }
}
/* return True if str1 starts with str2 */
macro _StartWith(str1, str2)
{
    var len1
    var len2
    var s
    
    len2 = strlen(str2)
    len1 = strlen(str1)
    if(len1 < len2)
        return False
        
    s = strmid(str1, 0, len2)
    if(s == str2)
    {
        return True
    }
    else
    {
        return False
    }
}
macro _StartWithOneOf(str, chStr)
{
    if(strlen(str) == 0)
        return False
        
    var chStart
    chStart = str[0]
    
    var len
    len = strlen(chStr)

    var pos
    pos = 0
    while(pos < len)
    {
        if(chStr[pos] == chStart)
            return True

        pos = pos + 1
    }

    return False
}
macro _StrFind(str, ch)
{
    var len
    len = strlen(str)

    var pos
    pos = 0
    while(pos < len)
    {
        if(str[pos] == ch)
        {
            return pos
        }
    }

    return -1
}
macro _EndWithOneOf(str, chStr)
{
    var len
    len = strlen(str)
    if(len == 0)
        return False
        
    var chEnd
    chEnd = str[len - 1]
    
    len = strlen(chStr)

    var pos
    pos = 0
    while(pos < len)
    {
        if(chStr[pos] == chEnd)
            return True

        pos = pos + 1
    }

    return False
}
/* remove spaces and tabs off the string header and tail */
macro _Trim(szStr)
{
    var len
    len = strlen(szStr)
    if(len == 0)
        return szStr
        
    first = 0;
    last = len-1;
    while(_IsWS(szStr[first]))
    {
        first=first+1;
    }
    while(last > first)
    {
        if(_IsWS(szStr[last]))
            last=last-1;
        else
            break;
    }

    if(first > last)
    {
        return ""
    }
    else
    {
        return strmid(szStr, first, last+1)
    }
}
macro _RemovePrefix(str, prefix)
{
    str = _Trim(str)
    if(_StartWith(str, prefix))
    {
        return strmid(str, strlen(prefix), strlen(str))
    }
    return str
}
/* remove tail comment like // comment or /_* comment *_/ */
macro _RemoveTailComment(str)
{
    len = strlen(str)
    pos = len - 1
    while(pos > 0)
    {
        if(str[pos-1] == "/")
        {
            if(str[pos] == "/")
            {
                return strmid(str, 0, pos-1)
            }
        }
        pos = pos - 1
    }

    return str
}
/* Get the spaces/tabs in the header of the string */
macro _GetEmptyPrefix(szStr)
{
    var len
    var first
    len = strlen(szStr)
    first = 0;
    while(first < len)
    {
        if(!_IsWS(szStr[first]))
        {
            break;
        }
        first=first+1;
    }
    if(first > 0)
        return strmid(szStr, 0, first)

    return ""
}

/* Check if szPart is the start of szFull */
macro _CompareKeywords(szPart, szFull)
{
    var lenPart
    var lenFull
    var szMid
    
    lenPart = strlen(szPart)
    lenFull = strlen(szFull)
    if(lenPart > lenFull)
    {
        return False
    }

    szMid = strmid(szFull, 0, lenPart)
    if(szPart == szMid)
    {
        return True
    }

    return False;
}
/* Check if szPart is the end of szFull */
macro _CompareKeywordsReverse(szPart, szFull)
{
    var lenPart
    var lenFull
    var szMid
    
    lenPart = strlen(szPart)
    lenFull = strlen(szFull)
    if(lenPart < lenFull)
    {
        return False
    }

    szMid = strmid(szPart, lenPart-lenFull, lenPart)
    if(szFull == szMid)
    {
        return True
    }
    return False;
}

/* Check if char is a space like char */
macro _IsWS(ch)
{
    if(ch != " " && ch != "	")
    {
        return False
    }

    return True
}
macro _IsEmptyLine(str)
{
    str = _Trim(str)
    if(str == "")
        return True

    return False
}
macro _GetTabChar()
{
	charFromAscii(9)
}
macro _GetEnterChar()
{
    var chR
    var chN
    var strReturn

    chR = charFromAscii(13)
    chN = charFromAscii(10)
	return "@chR@@chN@"
}


macro _GetContext()
{
    var context
    
    /* Current window & buffer handler */
    var hwnd
    var hbuf
    /* Current Selection */
    var sel
    /* First Full line string selected */
    var szLine
    /* White spaces of the header of szLine */
    var szPrefix
    /* Trimed string of szLine */
    var szTrimLine
    /* All continuous white spaces whill be removed */
    var szRealLine
    /* The amount of lines in current buffer */
    var nrLine
    /* Is cursor at the end */
    var fInEnd
    /* Is cursor at the real end, (may followed by a few white spaces */
    var fInRealEnd
    /* Full path like c:\a\b\c.c */
    var szFullPath
    /* File name like c.c */
    var szFileName
    /* File Directory like c:\a\b */
    var szDir

    context.hwnd    = GetCurrentWnd()
    context.hbuf    = GetWndBuf(context.hwnd)
    context.szFullPath  = GetBufName(context.hbuf)
    szFullPath          = context.szFullPath

    var len
    var pos
    len = strlen(context.szFullPath)
    pos = len - 1 
    while(pos >= 0)
    {
        if(szFullPath[pos] == "\\")
            break;
        pos = pos - 1
    }

    if(pos > 0 && pos < len - 1)
    {
        context.szFileName  = strmid(context.szFullPath, pos + 1, len)
        context.szDir       = strmid(context.szFullPath, 0, pos)
    }
    else
    {
        context.szFileName  = ""
        context.szDir       = ""
    }
    context.sel     = GetWndSel(context.hwnd)
    context.nrLine  = GetBufLineCount(context.hbuf)
    
    sel                 = context.sel
    context.szLine      = GetBufLine(context.hbuf, sel.lnFirst)
    context.szPrefix    = _GetEmptyPrefix(context.szLine)
    context.szTrimLine  = _Trim(context.szLine)
    context.szRealLine  = _RemoveTailComment(context.szTrimLine)
    context.szRealLine  = _ClearInnerSpace(context.szRealLine)

    context.fInEnd      = False
    if(sel.ichFirst == strlen(context.szLine))
    {
        context.fInEnd = True
    }

    if(context.fInEnd)
    {
        context.fInRealEnd = True
    }
    else
    {
        context.fInRealEnd  = _AllWSAfter(context.szLine, sel.ichFirst)
    }

    return context
}
/*
    Check the buffer is supported file type or not
    we support C/H files only
    if srcOnly is true, H is not supported(sometimes the command will only 
    effective for C file)
*/
macro _IsBufferSupported(hbuf, srcOnly)
{
    var szFile
    var len
    var str
    
    szFile = GetBufName(hbuf)
    len = strlen(szFile)
    if(len > 2)
    {   
        str = szFile[len-2]
        if(str == ".")
        {
            str = szFile[len-1]
            if( str == "c" || str == "C")
            {
                return True
            }
            if(!srcOnly)
            {
                if( szFile[len-1] == "h" || szFile[len-1] == "H")
                {
                    return True
                }
            }
        }
    }

    return False
}

macro eMoveToNextChar()
{
	if (_IsMarkOn())
	{
		Select_Char_Right
	}
	else
	{
		Cursor_Right
	}
}
macro eMoveToPrevChar()
{
	if (_IsMarkOn())
	{
		Select_Char_Left
	}
	else
	{
		Cursor_Left
	}
}
macro eMoveToNextWord()
{
	if (_IsMarkOn())
	{
		Select_Word_Right
	}
	else
	{
		Word_Right
	}
}
macro eMoveToPrevWord()
{
	if (_IsMarkOn())
	{
		Select_Word_Left
	}
	else
	{
		Word_Left
	}
}
macro eMoveToPrevLine()
{
	if (_IsMarkOn())
	{
		Select_Line_Up
	}
	else
	{
		Cursor_Up
	}
}
macro eMoveToNextLine()
{
	if (_IsMarkOn())
	{
		Select_Line_Down
	}
	else
	{
		Cursor_Down
	}
	
}
macro eMoveToLineHead()
{
	if (_IsMarkOn())
	{
		Select_To_Start_Of_Line
	}
	else
	{
		Beginning_Of_Line
	}
	
	
}
macro eMoveToLineEnd()
{
	if (_IsMarkOn())
	{
		Select_To_End_Of_Line
	}
	else
	{
		End_Of_Line
	}
	
}
macro eMoveToNextScreen()
{
	if (_IsMarkOn())
	{
		Select_Page_Down
	}
	else
	{
		Page_Down
	}
	

}
macro eMoveToPrevScreen()
{
	if (_IsMarkOn())
	{
		Select_Page_Up
	}
	else
	{
		Page_Up
	}
	
}
macro eMoveToBuffEnd()
{
	if (_IsMarkOn())
	{
		Select_To_End_Of_File
	}
	else
	{
		Bottom_Of_File
	}
	
}
macro eMoveToBuffHead()
{
	if (_IsMarkOn())
	{
		Select_To_Top_Of_File
	}
	else
	{
		Top_Of_File
	}
}
macro eReCenterTopBottom()
{
	var hWnd
	var currSel
	var currSelYPos
	var rect
	var line

	hWnd = GetCurrentWnd()
	if(hWnd == hNil)
	{
		return
	}

	currSel = GetWndSel(hWnd)
	currSelYPos = YposFromLine(hWnd, currSel.lnLast)
	rect = GetWndClientRect(hWnd)
	
	/* Selection out of window, do nothing */
	if (rect.Bottom <= currSelYPos || rect.Top > currSelYPos)
	{
		return
	}

	var centerYPos
	centerYPos = ( rect.Top + rect.Bottom ) / 2
	if (currSelYPos < centerYPos) // Top half
	{
		if (currSelYPos - rect.Top < centerYPos - currSelYPos)
		{
			/* near top, center it */
			line = currSel.lnLast - GetWndLineCount(hWnd)/2
			if(line < 0)
			{
				line = 0
			}
		}
		else
		{
			/* near center, bottom it */
			line = currSel.lnLast - GetWndLineCount(hWnd) + 1
			if(line < 0)
			{
				line = 0
			}
		}
	}
	else // Bottom half
	{
		if (rect.Bottom - currSelYPos < currSelYPos - centerYPos)
		{
			/* near bottom, top it */
			line = currSel.lnLast
		}
		else
		{
			/* near center, bottom it */
			line = currSel.lnLast - GetWndLineCount(hWnd) + 1
			if(line < 0)
			{
				line = 0
			}
		}
	}

	ScrollWndToLine(hWnd, line)
}
macro eDoMark()
{
	if (_IsMarkOn())
	{
		_SetMarkOff()
	}
	else
	{
		_SetMarkOn()
	}
}

macro eRemoveNextChar()
{
	_SetMarkOff()
	Delete_Character
}
macro eRemovePrevChar()
{
	_SetMarkOff()
	Backspace
}
macro eKillNextWord()
{
	_SetMarkOff()
	Select_Word_Right
	if (_IsSelectionMultiChars())
	{
		Cut
	}
	
}
macro eKillPrevWord()
{
	_SetMarkOff()
	Select_Word_Left
	if (_IsSelectionMultiChars())
	{
		Cut
	}
}
macro eKillToLineEnd()
{
	_SetMarkOff()
	Select_To_End_Of_Line
	if (_IsSelectionMultiChars())
	{
		Cut
	}
	else
	{
		eRemoveNextChar()
	}
	
}
macro eKillToLineHead()
{
	_SetMarkOff()
	Select_To_Start_Of_Line

	if (_IsSelectionMultiChars())
	{
		Cut
	}
	else
	{
		eMoveToPrevLine
        Join_Lines
	}
}
macro eSearchPrevTag()
{
    LoadSearchPattern(SL_TAG, False, False, False);
    Search_Backward
}
macro eSearchNextTag()
{
    LoadSearchPattern(SL_TAG, False, False, False);
    Search_Forward
}
macro eCopyLine()
{
	Copy_Line
	_SetMarkOff()
}
macro eUndo()
{
	//MSG "UNDO"
	Undo
	Undo
    _SetMarkOff()
}
macro eCut()
{
	if(!_IsSelectionMultiChars())
	{
		select_word
	}
	Cut
    _SetMarkOff()
}
macro eCopy()
{
	if(!_IsSelectionMultiChars())
	{
		select_word
	}
	Copy
    _SetMarkOff()
}
macro ePaste()
{
	Paste
    _SetMarkOff()
}

macro eBreakToNextLine()
{
	Insert_New_Line
    eMoveToNextLine	
}
macro eBreakEighty()
{
	hwnd = GetCurrentWnd()
	sel  = GetWndSel(hwnd)
	sel.ichFirst = 80
	sel.ichLim = 80
	sel.lnFirst = sel.lnLast

	SetWndSel(hwnd, sel)
}

macro eJumpToDefinition()
{
	Jump_To_Definition
	_SetMarkOff()
}
macro eGoBack()
{
	Go_Back
	_SetMarkOff()
}
macro eGoFwd()
{
	Go_Forward
	_SetMarkOff()
}

macro eGetKey()
{
    var key
	
	StartMsg("Press your key")
	key = getkey()
	EndMsg()
	msg key
}


/*
    Created by Forrest Jiang
    2014-3-24

    Version: 1.1

    Macro Interface:
        CommentFunc
        CommentAllFunc
        CommentAllOpenBuf
        AutoTab
        
    History:
    who     when            what/where/why
    ======================================================================
    jgq     2013-3-23       CommentFunc complete
    jgq     2013-3-24       AutoTab complete
    jgq     2013-3-24       CommentAllFunc complete
    jgq     2013-3-24       CommentAllOpenBuf complete
    ======================================================================
*/

macro _SelectFirstFunc(hwnd)
{
    _SelectFirstLine(hwnd)
    Function_Down
}
macro _SelectLastFunc(hwnd)
{
    _SelectLastLine(hwnd)
    Function_Up
}
macro _SelectFirstLine(hwnd)
{
    var sel
    var cnt

    sel = GetWndSel(hwnd)
    
    sel.lnFirst = 0
    sel.lnLast = 0
    sel.ichFirst = 0
    sel.ichLim = 0
    sel.fExtended = False
    sel.fRect = False

    /* Select to end */
    SetWndSel(hwnd, sel)
}
macro _SelectLastLine(hwnd)
{
    var sel
    var cnt

    sel = GetWndSel(hwnd)
    cnt = GetWndLineCount(hwnd)
    
    sel.lnFirst = cnt-1
    sel.lnLast = cnt-1
    sel.ichFirst = 0
    sel.ichLim = 0
    sel.fExtended = False
    sel.fRect = False

    /* Select to end */
    SetWndSel(hwnd, sel)
}
macro _GetNextLine(hbuf, line)
{
    return GetBufLine(hbuf, line+1)
}
macro _GetNextNonEmptyLine(context)
{
    var sel
    var line

    sel = context.sel
    line = sel.lnFirst

    while(line+1 < context.nrLine)
    {
        var str
        str = _GetNextLine(context.hbuf, line)
        
        if(!_IsEmptyLine(str))
            return str

        line = line + 1
    }

    return ""
}
/* Select window to sel and if it is outside of the window view, 
    scroll window down to let it be inside
*/
macro _ScrollDownTo(hwnd, sel)
{    
    ln = sel.lnFirst
    //msg("@ln@")
    SetWndSel(hwnd, sel)

    pos = YposFromLine(hwnd, sel.lnFirst)
    if(pos < 0)
    {
        ScrollWndToLine(hwnd, sel.lnFirst - 10)
    }
}

/* Select window to sel and if it is outside of the window view, 
    scroll window up to let it be inside
*/
macro _ScrollUpTo(hwnd, sel)
{    
    SetWndSel(hwnd, sel)

    pos = YposFromLine(hwnd, sel.lnFirst)
    if(pos < 0)
    {
        ScrollWndToLine(hwnd, sel.lnFirst - 10)
    }
}

/* Check function in the sel postion is _Commented or not */
macro _Commented(hbuf, sel)
{
    nrLine = sel.lnFirst-1
    while(nrLine >= 0)
    {
        szLine = GetBufLine(hbuf, nrLine)
        szLine = _Trim(szLine)
        len = strlen(szLine)
        //msg("line=@szLine@ len = @len@")
        if(szLine == "")
        {
        //msg("2")
            nrLine = nrLine - 1
            continue
        }

        if(szLine == "*/")
        {
        //msg("3")
            nrLine = nrLine - 1
            while(nrLine >= 0)
            {
        //msg("4")
                szLine = GetBufLine(hbuf, nrLine)
                if(_StartWith(szLine, " *"))
                {
        //msg("5")
                    nrLine = nrLine - 1
                    continue
                }

                if(szLine == "/*!")
                {
        //msg("6")
                    return True
                }

                break;
                
            }
        }

        break;
    }

    return False
}

macro _RemoveCommented(hbuf, sel)
{
    line = sel.lnFirst - 1
    while(1)
    {
        szLine = GetBufLine(hbuf, line)
        DelBufLine(hbuf, line)
        
        if(szLine == "/*!")
        {
            return
        }
        line = line - 1
    }
}

/* Insert a common block, for, i.e., while clause
   return line number inserted
*/
macro _InsertBufBlock(context, tail)
{
    var sel
    sel = context.sel
    prefix = context.szPrefix
    InsBufLine(context.hbuf, sel.lnFirst+1, "@prefix@{")
    InsBufLine(context.hbuf, sel.lnFirst+2, "@prefix@    @SL_TAG@")
    InsBufLine(context.hbuf, sel.lnFirst+3, "@prefix@}@tail@")

    return 3
}
/* Match Clause keywords and extends its block
   return True:Succeed/False:Fail
*/
macro _TryClause(context)
{
    var str
    var tail
    var res
    var sel
    var szPrefix
    var szWord
    var csel

    res         = False
    tail        = ""
    sel         = context.sel
    szPrefix    = context.szPrefix
    szWord      = context.szTrimLine
    
    
    if(strlen(szWord) < 2)
    {
        return False
    }

    csel = context.sel
    if(szWord == "else if")
    {
        res = True
        str = "@szPrefix@else if (@SL_TAG@)"
    }
    else if(_CompareKeywords(szWord, "while"))
    {
        res = True
        str = "@szPrefix@while (@SL_TAG@)"
    }
    else if(_CompareKeywords(szWord, "do"))
    {
        res = True
        str = "@szPrefix@do"
        tail = " while (@SL_TAG@)"
    }
    else if(_CompareKeywords(szWord, "if"))
    {
        res = True
        str = "@szPrefix@if (@SL_TAG@)"
    }
    else if(_CompareKeywords(szWord, "else"))
    {
        res = True
        str = "@szPrefix@else"
    }

    else if(_CompareKeywords(szWord, "switch"))
    {
        res = True
        str = "@szPrefix@switch (@SL_TAG@)"
        PutBufLine(context.hbuf, sel.lnFirst, str)
        
        InsBufLine(context.hbuf, sel.lnFirst+1, "@szPrefix@{")
        InsBufLine(context.hbuf, sel.lnFirst+2, "@szPrefix@case @SL_TAG@:")
        InsBufLine(context.hbuf, sel.lnFirst+3, "@szPrefix@    @SL_TAG@")
        InsBufLine(context.hbuf, sel.lnFirst+4, "@szPrefix@    break;")
        InsBufLine(context.hbuf, sel.lnFirst+5, "@szPrefix@default:")
        InsBufLine(context.hbuf, sel.lnFirst+6, "@szPrefix@    break;")
        InsBufLine(context.hbuf, sel.lnFirst+7, "@szPrefix@}")
    
        _TryJump()
        return True
    }
    else  if(_CompareKeywords(szWord, "case"))
    {
        str = "@szPrefix@case @SL_TAG@:"
        PutBufLine(context.hbuf, sel.lnFirst, str)
        str = "@szPrefix@    @SL_TAG@"
        InsBufLine(context.hbuf, sel.lnFirst+1, str)
        str = "@szPrefix@    break;"
        InsBufLine(context.hbuf, sel.lnFirst+2, str)
        _TryJump()
        return True
    }
    else if(_CompareKeywords(szWord, "for"))
    {
        res = True
        str = "@szPrefix@for (@SL_TAG@, @SL_TAG@, @SL_TAG@)"
    }
    else if(_CompareKeywordsReverse(szWord, "/*"))
    {
        PutBufLine(context.hbuf, sel.lnFirst, "@szPrefix@@szWord@  */")
        sel.ichFirst = sel.ichFirst+1
        sel.ichLim = sel.ichFirst
        _ScrollDownTo(context.hwnd, sel)
        return True
    }
    else if(_CompareKeywords(szWord, "#include"))
    {
        PutBufLine(context.hbuf, sel.lnFirst, "@szPrefix@#include \"@SL_TAG@\"")
        _TryJump()
        return True
    }
    else if(_CompareKeywords(szWord, "struct"))
    {
        res = True
        str = "@szPrefix@typedef struct"
        tail = " @SL_TAG@;"
        csel.lnFirst = csel.lnFirst+3
        csel.ichLim = 0
    }

    else if(_CompareKeywords(szWord, "enum"))
    {
        res = True
        str = "@szPrefix@typedef enum"
        tail = " @SL_TAG@;"
        csel.lnFirst = csel.lnFirst+3
        csel.ichLim = 0
    }

    else if(_CompareKeywords(szWord, "union"))
    {
        res = True
        str = "@szPrefix@typedef union"
        tail = " @SL_TAG@;"
        csel.lnFirst = csel.lnFirst+3
        csel.ichLim = 0
    }

    if(res)
    {
        PutBufLine(context.hbuf, sel.lnFirst, str)
        _InsertBufBlock(context, tail)
        cnt = GetBufLineCount(context.hbuf)
        //msg("cnt=@cnt@, csel=@csel@")
        //SearchInBuf(context.hbuf, SL_TAG, csel.lnFirst, csel.ichLim, 1, 0, 1)
        csel = SearchInBuf(context.hbuf, SL_TAG, csel.lnFirst, csel.ichLim, 1, 0, 1)
        _ScrollDownTo(context.hwnd, csel)
        return True
    }

    return False
}
/* Search lines before current for SL_TAG */
macro _SearchBackTag(context)
{
    var csel
    csel = context.sel
    var first
    first = csel.lnFirst - 80
    if(first < 0) first = 0
    

    sel = SearchInBuf(context.hbuf, SL_TAG, first, 0, 1, 0, 1)
    
    if(sel != "")
    {
        if(sel.lnFirst - csel.lnFirst > 80) 
            return False
            
        _ScrollUpTo(context.hwnd, sel)
        return True
    }
    return False
}
/* Check if this is a right part of a parentheses */
macro _IsSupportedRightParentheses(ch)
{
    if(ch == "]" || ch == ")" || ch == "}" || ch == "\"")
    {
        return True
    }
    return False
}
/* Get the right part of a parentheses per its right part */
macro _GetLeftParentheses(ch)
{
    if(ch == "]")
    {
        return "["
    }
    
    if(ch == "}")
    {
        return "{"
    }
    
    if(ch == ")")
    {
        return "("
    }
    
    if(ch == "\"")
    {
        return "\""
    }

    return ""
}
/* Check if this is the left and right char of the same parentheses */
macro _MatchParentheses(chStart, chEnd)
{
    var ch 
    ch = _GetLeftParentheses(chEnd)
    if(ch == chStart)
    {
        return True
    }

    return False
}
/* Check if index is in the edge of a quote mark */
macro _MatchQuote(line, index)
{
    var even
    var pos
    var trans
    var ch 
    
    even = True
    pos = 0
    trans = False
    while(pos <= index)
    {
        if(trans)
        {
            trans = False
        }
        else
        {
            if(line[pos] == "\\")
            {
                trans = True
            }
            else if(line[pos] == "\""
            {
                even = !even
            }
        }
        ch = line[pos]
        //msg("ch=@ch@ trans=@trans@ even=@even@")
        pos = pos + 1
    }

    return even
    
}
/* Jump out of a parentheses like {} */
macro _TryJumpParentheses(context, sel)
{
    var ret
    var followCh;
    var len 
    var line
    var index
    ret = False
    
    /* if cursor is just before the right parentheses, jump out of it
       supporting bracing is:
            []
            {}
            ()
            ""
    */
    if(sel.ichFirst != sel.ichLim || sel.lnFirst != sel.lnLast) 
    {
        return ret
    }
    index = sel.ichFirst
    line = context.szLine
    len = strlen(line)
    followCh = ""
    /* Search the char following the cursor */
    while(index < len)
    {
        if(_IsWS(line[index]))
        {
            index = index + 1
        }
        else
        {
            followCh = line[index]
            break;
        }
    }
    if(!_IsSupportedRightParentheses(followCh))
    {
        return ret
    }

    if(followCh == "\"")
    {
        ret = _MatchQuote(line, index)
    }
    else
    {
        var pos
        pos = sel.ichFirst-1
        while(pos >= 0)
        {
            if(_MatchParentheses(line[pos], followCh))
            {
                ret = True
                break;
            }
            pos = pos - 1
        }
        
    }

    if(ret)
    {
        var csel
        csel = sel
        csel.ichFirst = index+1
        csel.ichLim = index+1
        _ScrollDownTo(context.hwnd, csel)
    }

    return ret

    
}
/* Jump between SL_TAGs or out of a parentheses
*/
macro _TryJump()
{
    eSearchNextTag() 
}

macro _GetWord(str, startIdx, endIdx)
{
    var rec
    rec.fEnd = False
    rec.strWord = ""

    var begin
    begin = -1

    while(startIdx < endIdx)
    {
        var ch
        ch = str[startIdx]
        if(begin == -1)
        {
            if(!_IsWS(ch))
            {
                begin = startIdx
            }
        }
        else
        {
            if(_IsWS(ch))
            {
                rec.fEnd = False
                rec.strWord = strmid(str, begin, startIdx)
                return rec
            }
        }
        startIdx = startIdx + 1
    }
    if(startIdx == endIdx)
    {
        rec.fEnd = True
    }
    if(begin != -1)
    {
        rec.strWord = strmid(str, begin, endIdx)
    }
    return rec
}

//
// Comment the selected block of text using single line comments and indent it
//
macro eCommentBlock()
{
    var hbuf
    var hwnd
    var sel
    var cmt
    var iLine
    var szLine
    var len
    var trmLine
    var pos
    
	hbuf = GetCurrentBuf();
	hwnd = GetCurrentWnd();

	sel = GetWndSel(hwnd);
	cmt = True

	iLine = sel.lnFirst;
	
	while (iLine <= sel.lnLast)
	{
		szLine = _Trim(GetBufLine(hbuf, iLine));

		if(_StartWith(szLine, "//"))
		{
		    cmt = False
		    break
		}
		iLine = iLine + 1;
	}

	iLine = sel.lnFirst;
	while (iLine <= sel.lnLast)
	{
		szLine = GetBufLine(hbuf, iLine);
	    len = strlen(szLine)
		trmLine = _Trim(szLine)
		if(_StartWith(trmLine, "//")) // must be cmt == False
		{
		    pos = 0
		    while(pos < len-1)
		    {
		        if(szLine[pos] == "/" && szLine[pos+1] == "/")
		        {
		            break;
		        }
		        pos = pos + 1
		    }
		    if(pos == 0)
		    {
		        szLine = strmid(szLine, pos+2, len)
		    }
		    else
		    {
		        szLine = cat(strmid(szLine, 0, pos), strmid(szLine, pos+2, len))
		    }
		    
		}
		else if(cmt)
		{
    		szLine = cat("//", szLine);
		}
		else
		{
		    if(_StartWith(szLine, "  "))
		    {
		        szLine = strmid(szLine, 2, len)
		    }
		    else if(_StartWith(szLine, " ") || _StartWith(szLine, "	"))
		    {
		        szLine = strmid(szLine, 1, len)
		    }
		}
		PutBufLine(hbuf, iLine, szLine);
		iLine = iLine + 1;
	}

	if (sel.lnFirst == sel.lnLast)
	{
	    if(cmt)
	    {
    		sel.ichFirst = sel.ichFirst + 2;
    		sel.ichLim = sel.ichLim + 2;
	    }
	    else
	    {
	        sel.ichFirst = 0
	        sel.ichLim = 0
	    }
	}
	SetWndSel(hwnd, sel);
}
/* Comment the function where cursor is focus on
*/
macro eCommentFunc()
{


    /* locate function name */
    eMoveToNextLine
    Function_Down
    Function_Up
        
        
    context = _GetContext()
    
    if(!_IsBufferSupported(context.hbuf, False))
    {
        Enter
        stop
    }

    return _DoComment(context)
}
macro eCommentAllFunc()
{
    var context
    var sel
    var lsel
    var szBakLine
    var szLine
    
    context = _GetContext()

    if(!_IsBufferSupported(context.hbuf, True))
    {
        stop
    }
        
    sel = context.sel    

    sel.lnFirst = context.nrLine - 1
    sel.lnLast = context.nrLine - 1
    sel.ichFirst = 0
    sel.ichLim = 0
    sel.fExtended = False
    sel.fRect = False

    /* Select to end */
    SetWndSel(context.hwnd, sel)

    /* Find last function and remember the declaration as watchdog */
    Function_Up
    lsel = GetWndSel(context.hwnd)
    szBakLine = GetBufLine(context.hbuf, lsel.lnFirst)

    /* select to first line */
    sel.lnFirst = 0
    sel.lnLast = 0
    sel.ichFirst = 0
    sel.ichLim = 0
    sel.fExtended = False
    sel.fRect = False
    
    SetWndSel(context.hwnd, sel)    

    while(1)
    {
        /* Find next function and comment */
        Function_Down

        /* Now the buffer is changed, so update the context */
        context = _GetContext()
        eCommentFunc()
        
        sel = GetWndSel(context.hwnd)
        szLine = GetBufLine(context.hbuf, sel.lnFirst)
        if(szLine == szBakLine)
            break
    }

    //msg("done")
    return True
    
}
/* For each opened buffer, comment all functions it contains */
macro eCommentAllOpenBuf()
{
    var hbuf
    var cbuf
    var ibuf
    
    cbuf = BufListCount()
    ibuf = 0
    while (ibuf < cbuf)
    {
        hbuf = BufListItem(ibuf)

        SetCurrentBuf(hbuf)

        if(_IsBufferSupported(hbuf, True))
        {
            CommentAllFunc()
        }
        ibuf = ibuf + 1
        //msg("ibuf=@ibuf@, cbuf=@cbuf@")
    }
    
}

/*  Function 1: Create clause
        if a line
            looks like [a few spaces/tabs][keyword][a few spaces/tabs]
            the [keyword] is the beginning of:
                do, while, switch, case, for, if, else, else if, 
                union, enum, struct, #include
            the length of [keyword] is at least 2 chars, 
            for "else if", the lenght should be 7
        then
            Auto complete the clause, like:
            for (@SL_TAG@, @SL_TAG@, @SL_TAG@)
            {
                @SL_TAG@
            }
        And the first @SL_TAG@ will be selected
        
    Function 2: Complete comments
        if you write /* and then call this, the comment will be automatically 
        appended to: /* [cursor position] * /

    Function 3: Jump between @SL_TAG@s

    Function 4: Jump out of {} () [] ""

    Note: Designed for c/h files
        
*/
macro eAutoTab()
{
    var cmd

    var context
    var res
    var sel
    var szLine
    var len
    var index
    var szFile
    
    context = _GetContext()

    if(!_IsBufferSupported(context.hbuf, False))
    {
        Tab
        stop
    }
    
    sel     = context.sel
    szLine  = context.szLine

    if(sel.ichFirst != sel.ichLim) 
    {
        if(sel.lnFirst == sel.lnLast)
        {
        
            if(_TryJump()) stop
        }
        Tab
        stop
    }
    
    
    len = strlen(szLine)
    index = sel.ichFirst+1
    while(index < len)
    {
        ch = szLine[index]
        if(ch != " " && ch != "	")
        {
            if(!_TryJump()) Tab
            
            stop
        }
        else
            index=index+1
    }
    

    /* Only for .c/.h file */
    if(_IsBufferSupported(context.hbuf, False))
    {
        if(_TryClause(context)) stop
        if(_TryJump()) stop
    }
    
    
    Tab
}

/* Automatically Finish clauses by enter
*/
macro eAutoEnter()
{
    var context
    var sel 
    var szPrefix
    var str
    
    context = _GetContext()

    if(!_IsBufferSupported(context.hbuf, False))
    {
        Enter
        stop
    }
    
    sel = context.sel
    szPrefix = context.szPrefix

    str = _GetNextNonEmptyLine(context)
	
    if(_StartWith(context.szTrimLine, "/**"))
    {
        if(_EndWith(context.szTrimLine, "*/"))
        {
            Enter
            return
        }

	    var pos
	    len = strlen(context.szLine)
	    var ourLine
	    ourLine = context.szLine
	    pos = 0 
	    while(pos < len)
	    {
	    	if(ourLine[pos] == "/")
    	   {
    	   	  break
    	   } 
    	   	 pos = pos + 1
	    }

		
	    var prefix
	    var prefix1
	    prefix = strmid(context.szLine, 0, pos)
	    prefix1 = cat(prefix, " * ");
	    
	    var sel
	    sel = context.sel
    	InsBufLine(context.hbuf, sel.lnFirst+1, prefix1)

    	prefix1 = cat(prefix, " */")
    	InsBufLine(context.hbuf, sel.lnFirst+2, prefix1)
    	sel.lnFirst = sel.lnFirst+1
    	sel.lnLast = sel.lnFirst
    	sel.ichLim = pos + 3
    	sel.ichFirst = sel.ichLim 

    	SetWndSel(context.hWnd, sel) 
    }
    else if(_StartWith(context.szTrimLine, "*"))
    {
        if(_EndWith(context.szTrimLine, "*/"))
        {
            Enter
            return
        }

	    var pos
	    len = strlen(context.szLine)
	    var ourLine
	    ourLine = context.szLine
	    pos = 0 
	    while(pos < len)
	    {
	    	ch = ourLine[pos]
	    	if(ch != CharFromAscii(9) && 
	    	   ch != " " &&
	    	   ch != "*")
    	   {
    	   	  break
    	   } 
    	   	 pos = pos + 1
	    }
	    var prefix
	    prefix = strmid(context.szLine, 0, pos)

	    var sel
	    sel = context.sel
		if(sel.ichLim < len)
		{
		    eKillToLineEnd()
	    	InsBufLine(context.hbuf, sel.lnFirst+1, prefix)
	    	sel.lnFirst = sel.lnFirst+1
	    	sel.lnLast = sel.lnFirst
	    	sel.ichLim = pos 
	    	sel.ichFirst = sel.ichLim 

	    	SetWndSel(context.hWnd, sel) 
	    	ePaste()
	    	eMoveToLineHead()
	    	SetWndSel(context.hWnd, sel) 
		}
		else
		{
	    	InsBufLine(context.hbuf, sel.lnFirst+1, prefix)
	    	sel.lnFirst = sel.lnFirst+1
	    	sel.lnLast = sel.lnFirst
	    	sel.ichLim = pos 
	    	sel.ichFirst = sel.ichLim 

	    	SetWndSel(context.hWnd, sel) 
		}
    }
    else if(context.fInRealEnd && !_StartWith(str, "{"))
    {
        if(_EndWith(context.szRealLine, ")"))
        {
            if( _StartWith(context.szRealLine, "while(") ||
                _StartWith(context.szRealLine, "if(") ||
                _StartWith(context.szRealLine, "else if(") ||
                _StartWith(context.szRealLine, "for(") )
            {
                _InsertBufBlock(context, "")
                _TryJump()
            }
            else if(_StartWith(context.szRealLine, "switch("))
            {
                InsBufLine(context.hbuf, sel.lnFirst+1, "@szPrefix@{")
                InsBufLine(context.hbuf, sel.lnFirst+2, "@szPrefix@case @SL_TAG@:")
                InsBufLine(context.hbuf, sel.lnFirst+3, "@szPrefix@    @SL_TAG@")
                InsBufLine(context.hbuf, sel.lnFirst+4, "@szPrefix@    break;")
                InsBufLine(context.hbuf, sel.lnFirst+5, "@szPrefix@default:")
                InsBufLine(context.hbuf, sel.lnFirst+6, "@szPrefix@    break;")
                InsBufLine(context.hbuf, sel.lnFirst+7, "@szPrefix@}")
            
                _TryJump()
            }
            else
            {
                Enter
            }
        }
        else if(_EndWith(context.szRealLine, ":") && _StartWith(context.szRealLine, "case "))
        {
            InsBufLine(context.hbuf, sel.lnFirst+1, "@szPrefix@    @SL_TAG@")
            InsBufLine(context.hbuf, sel.lnFirst+2, "@szPrefix@    break;")
            _TryJump()
        }
        else if(context.szRealLine == "do")
        {
            _InsertBufBlock(context, " while (@SL_TAG@)")
            _TryJump()
        }
        else if(context.szRealLine == "else")
        {
            _InsertBufBlock(context, "")
            _TryJump()
        }
        else
        {
            Enter
        }
    }
    else
    {
        Enter
    }
}
/* SmartEnd
    Jump to the Non-White-Space beginning, if already be there, jump to the beginning of the line
*/
macro eSmartHome()
{
    var context
    var allWS
    
    context = _GetContext()
    sel = context.sel
    if(sel.ichFirst == 0)
        return False
        
    allWS = True
    
    if(_AllWsBefore(context.szLine, sel.ichFirst))
    {
        allWS = False
    }

    if(allWS)
    {
        Beginning_Of_Line 
    }
    else
    {
        Smart_Beginning_Of_Line
    }

    return True
    
}
/* SmartEnd
    Jump to the Non-White-Space end, if already be there, jump to the end of line
*/
macro eSmartEnd()
{
    var context
    var allWS
    
    context = _GetContext()
    sel = context.sel
    if(context.fInEnd)
        return False
        
    allWS = True
    
    if(!context.fInRealEnd)  
    {
        allWS = False
    }

    if(allWS)
    {
        End_Of_Line
    }
    else
    {
        Smart_End_Of_Line
    }

    return True
}


/*!
 *  \file           @szFileName@
 *  \brief          @brf@
 *  \version        1.0
 *  \author         Jiang Guoqing
 *  \date           2014-04-04
 *  \copyright
 *  Copyright (C) 2006--2014 by SimpLight Nanoelectronics, Ltd.\n
 *                 All rights reserved.\n
 * This material constitutes the trade secrets and confidential,\n
 * proprietary information of SimpLight.  This material is not to\n
 * be disclosed, reproduced, copied, or used in any manner  not\n
 * permitted under license from SimpLight Nanoelectronics Ltd.\n
 *
 */

/******************************************************************************
 **                        Edit History
 ** -------------------------------------------------------------------------
 ** DATE                NAME             DESCRIPTION
 ** 2014/04/04          GQ.Jiang         Create
 *****************************************************************************/
macro eAddFileHdr()
{
    var hbuf
    var cbuf
    var ibuf
    var szFullPath
    var szFileName
    var brf
    var line
    
    cbuf = BufListCount()
    ibuf = 0
    while (ibuf < cbuf)
    {
        hbuf = BufListItem(ibuf)

        SetCurrentBuf(hbuf)

        if(_IsBufferSupported(hbuf, False))
        {
            szFullPath = GetBufName(hbuf)

            var len
            var pos
            len = strlen(szFullPath)
            pos = len - 1 
            while(pos >= 0)
            {
                if(szFullPath[pos] == "\\")
                    break;
                pos = pos - 1
            }

            if(pos > 0 && pos < len - 1)
            {
                szFileName  = strmid(szFullPath, pos + 1, len)
            }
            else
            {
                continue
            }
    
            brf = ask("Enter brief for @szFileName@")

            line = 0;
            InsBufLine(hbuf,line, "/*!")
            line = line + 1
            InsBufLine(hbuf,line, " *  \\file           @szFileName@")
            line = line + 1
            InsBufLine(hbuf,line, " *  \\brief          @brf@")
            line = line + 1
            InsBufLine(hbuf,line, " *  \\version        1.0")
            line = line + 1
            InsBufLine(hbuf,line, " *  \\author         Jiang Guoqing")
            line = line + 1
            InsBufLine(hbuf,line, " *  \\date           2015-07-23")
            line = line + 1
            InsBufLine(hbuf,line, " *  \\copyright")
            line = line + 1
            InsBufLine(hbuf,line, " *  Copyright (C) 2006--2014 by SimpLight Nanoelectronics, Ltd.\\n")
            line = line + 1
            InsBufLine(hbuf,line, " *                 All rights reserved.\\n")
            line = line + 1
            InsBufLine(hbuf,line, " * This material constitutes the trade secrets and confidential,\\n")
            line = line + 1
            InsBufLine(hbuf,line, " * proprietary information of SimpLight.  This material is not to\\n")
            line = line + 1
            InsBufLine(hbuf,line, " * be disclosed, reproduced, copied, or used in any manner  not\\n")
            line = line + 1
            InsBufLine(hbuf,line, " * permitted under license from SimpLight Nanoelectronics Ltd.\\n")
            line = line + 1
            InsBufLine(hbuf,line, " *")
            line = line + 1
            InsBufLine(hbuf,line, " */")
            line = line + 1
            InsBufLine(hbuf,line, "  ")
            line = line + 1
            InsBufLine(hbuf,line, "/******************************************************************************")
            line = line + 1
            InsBufLine(hbuf,line, " **                        Edit History")
            line = line + 1
            InsBufLine(hbuf,line, " ** -------------------------------------------------------------------------")
            line = line + 1
            InsBufLine(hbuf,line, " ** DATE                NAME             DESCRIPTION")
            line = line + 1
            InsBufLine(hbuf,line, " ** 2015/07/23          GQ.Jiang         Create")
            line = line + 1
            InsBufLine(hbuf,line, " *****************************************************************************/")
            line = line + 1
            
        }
        ibuf = ibuf + 1
        //msg("ibuf=@ibuf@, cbuf=@cbuf@")
    }
    
}

macro _DoComment(context)
{
    var sel
    var line
    var szFn
    var len
    var first
    var loop 
    var start
    var scLen
    var pos
    var szSc
    var ret
    var parm
    var next
        
    sel = context.sel

    /* Function already _Commented */
    if(_Commented(context.hbuf, sel)) 
        return False
    
    line = sel.lnFirst
     
    szFn = context.szRealLine
    
    if(_StartWith(szFn, "#")) // #define, not a function
        return False 

    /* Check if it looks like void func(void) and  */
    if(_EndWith(szFn, "{"))
    {
        len = strlen(szFn)
        szFn = strmid(szFn, 0, len-1);
        szFn = _Trim(szFn);
    }
    /* Multi-line function definition process */
    else if(!_EndWith(szFn, ")"))
    {
        var bCmt
        var nextLen 
        var bCmt;
        var cnStart
        var cnEnd
        var idx
        var rdLine
        var str1
        var ch
        
        bCmt = False
        loop = 1
        
        while(loop < 20 && loop+line < context.nrLine) /* check at most 20 lines */
        {
            next = ""
            rdLine = GetBufLine(context.hbuf, line+loop)
            rdLine = _RemoveTailComment(rdLine)
            len = strlen(rdLine);
            idx = 0;
            cnStart = -1
            cnEnd = -1
            
            while(idx < len)
            {
                ch = rdLine[idx]
                //msg("@idx@<@len@ ch = @ch@ bCmt = @bCmt@ cnStart = @cnStart@ cnEnd = @cnEnd@")
                if(bCmt)
                {
                    if(idx < len - 1 && rdLine[idx] == "*" && rdLine[idx+1] == "/")
                    {
                        bCmt = False
                        idx = idx + 1
                    }
                }
                else
                {
                    if(idx < len - 1 && rdLine[idx] == "/" && rdLine[idx+1] == "*")
                    {
                        bCmt = True
                        if(cnStart != -1)
                        {
                            cnEnd = idx-1;
                            str1 = strmid(rdLine, cnStart, cnEnd+1);
                            next = "@next@ @str1@"
                            
                            cnStart = -1
                            cnEnd = -1
                        }
                        
                        idx = idx + 1
                    }
                    else
                    {
                        if(cnStart == -1) 
                        {
                            cnStart = idx
                        }
                    }
                }

                
                idx = idx+1
            }
            

            if(cnStart != -1 && cnEnd == -1)
            {
                str1 = strmid(rdLine, cnStart, len);
                next = "@next@ @str1@"
            }
            //msg(next)
            next = _RemoveTailComment(next)
            next = _Trim(next)
            szFn = "@szFn@@next@"
            szFn = _RemoveTailComment(szFn)
            szFn = _Trim(szFn);
            
            if(_EndWith(szFn, "{"))
            {
                len = strlen(szFn)
                szFn = strmid(szFn, 0, len-1);
                szFn = _Trim(szFn);
            }
            
            if(_EndWith(szFn, ")"))
            {
                break;
            }
            loop = loop + 1
        }
        
        if(loop >= 20 || loop+line >= context.nrLine) /* Not a multiline function */
        {
            return False
        }
    }

    szFn = _ClearInnerSpace(szFn)
    
    first = 0
    /* Locate first as the index of ( */
    len = strlen(szFn)
    while(first < len)
    {
        if(szFn[first] == "(")
        {
            break;
        }
        first = first+1
    }

    if(first == len) 
        return False


    saveLine=line
    InsBufLine(context.hbuf, line, "/*!")
    line=line+1
//    InsBufLine(context.hbuf, line, " * \\fn @szFn@")
//    line=line+1
    InsBufLine(context.hbuf, line, " * \\brief @SL_TAG@")
    line=line+1

    loop = first + 1 /* loop is after ( */
    start = loop
    //msg("start = @start@ loop = @loop@")
    while(loop < len)
    {
        if(szFn[loop] == "," || loop == len-1)
        {
            parm = strmid(szFn, start, loop)
            parm = _Trim(parm)
            paraLen = strlen(parm)
            paraPos = paraLen - 1
            while(paraPos > 0)
            {
                if(_IsWS(parm[paraPos]))
                {
                  parm = strmid(parm, paraPos+1, paraLen)
                  break
                }
                paraPos = paraPos-1
            }
            if(parm != "void") parm = "[in] @parm@ @SL_TAG@"
            InsBufLine(context.hbuf, line, " * \\param @parm@")
            line=line+1
            start = loop+1
        }

        loop=loop+1
    }

    szFn = strmid(szFn, 0, first) /* remove all parameters () */
    szFn = _Trim(szFn)
    
    /* remove prefixed static */
    szFn = _RemovePrefix(szFn, "static")
    szFn = _RemovePrefix(szFn, "__MEMORY_DRAM__")
    szFn = _RemovePrefix(szFn, "__MEMORY_IRAM__")
    szFn = _RemovePrefix(szFn, "inline")

    /* remove function name */
    loop = strlen(szFn)-1
    while(loop > 0)
    {
        if(szFn[loop] == " ")
        {
            szFn = strmid(szFn, 0, loop)
            break;
        }
        
        loop=loop-1
    }
    if(loop <= 0) /* parsing fail */
        return False

    
    ret = _Trim(szFn)
    //msg("ret=@ret@")
    if(ret != "void") ret = "@SL_TAG@"
    //msg("ret=@ret@")
    InsBufLine(context.hbuf, line, " * \\return @ret@")
    line=line+1
    
    InsBufLine(context.hbuf, line, "*/")
    line=line+1

    sel.lnFirst = saveLine
    sel.lnLast = saveLine
    sel.ichFirst = 0
    sel.ichLim = 0
    SetWndSel(context.hwnd, sel)
    _TryJump()

    return True
}


macro _GetFileName(path)
{

	len = strlen(path)
	if(len == 0)
	{
		return ""
	}

	idx = len - 1
	while(idx > 0)
	{
		if ( path[idx] == "\\" )
		{
			return strmid(path, idx+1, len)
		}
		idx = idx - 1
	}

	return path
}

/* remove spaces and tabs off the string header and tail */
macro JumpBuf()
{
	idxFound = 0
	foundCnt = 0
	bufFound = hNil
	cbuf = BufListCount()
	target = ""
	
	while(true)
	{
		if(strlen(target) > 10)
		{
			return
		}
		foundFileName = ""
		if(bufFound != hNil)
		{
			foundFileName = GetBufName(bufFound)
			foundFileName = _GetFileName(foundFileName)
		}
		if(target == "")
		{
			StartMsg("Type to search")
		}
		else if(foundFileName == "")
		{
	 		StartMsg("Srch @target@")
	 	}
	 	else
	 	{
	 		StartMsg("Srch @target@ -> @foundFileName@")
	 	}
		key = getkey()
		EndMsg()

		if(key == 9)//tab
		{
			if(foundCnt == 0)
			{
				continue
			}

			idxFound = idxFound + 1
			if(idxFound >= foundCnt)
			{
				idxFound = 0
			}
		}

		else if(key == 13)//enter
		{
			if(bufFound != hNil)
			{
				SetCurrentBuf(bufFound)
				return
			}
			continue
		}
		else
		{
			if(key >= 97 && key <= 122)//a-z
			{
				key = key -97 + 65
			}

			if(key < 65 || key > 90)
			{
				continue
			}
			
			ch = CharFromAscii(key)
			target = "@target@@ch@"
		}
		//msg target
		
		ibuf = 1
		bufFound = hNil
		foundCnt = 0
		while (ibuf < cbuf)
	    {
		    hbuf = BufListItem(ibuf)
		    fname = GetBufName(hbuf)
		    fname = toupper(fname)
		    len = strlen(fname)

		    idx = len-1;

		    c = fname[idx]
		    //msg "fname=@fname@ c=@c@"
		    if(c != "C" && c != "H")
		    {
		    	ibuf = ibuf + 1
		    	continue
		    }
		    
		    while(idx > 0)
		    {
		    	c = fname[idx]
		    	//msg "fname=@fname@ idx=@idx@ fname[@idx@]=@c@"
		    	if(c == "\\")
		    	{
		    		break
		    	}
		    	idx = idx - 1
		    }
		    //msg "idx=@idx@"
		    if(idx > 0)
		    {
		    	name = strmid(fname, idx+1, len)
		    	//msg "name=@name@, target=@target@"
		    	if(_StartWith(name, target))
		    	{
		    		//msg "foundCnt @foundCnt@ idxFound @idxFound@ name @name@"
		    		if(foundCnt == idxFound)
		    		{
		    			bufFound = hbuf
		    		}
		    		foundCnt = foundCnt + 1
		    	}
		    }
		    
		    
		    ibuf = ibuf + 1
	    }

		//msg "buf cnt @foundCnt@, hbuf @bufFound@"
	    if(foundCnt == 0)
	    {
	    	return
	    }

	    if(foundCnt == 1)
	    {
	    	SetCurrentBuf(hbuf)
	    	return
	    }
	}

}


