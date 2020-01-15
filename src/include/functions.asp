<%
	Dim strPage, strMetaDescription, strSearchTerm, blnShowFaceBook
	
	blnShowFaceBook = False

	Dim dtmStartDate, lngStartTimer, lngEndTimer
	
	dtmStartDate = Now
	lngStartTimer = Timer

	Dim blnIsCrawler, blnAllowCookies, blnIsCookiePage
	
	blnIsCrawler = IsCrawler()
	blnAllowCookies = AllowCookies()
	blnIsCookiePage = False
		
	If blnAllowCookies = False Then RemoveCookies
	
	Function IsCrawler()
		Dim strUserAgent, lngCrawlerIndex
		
		strUserAgent = UCASE( Request.ServerVariables("HTTP_USER_AGENT") )
	
		For lngCrawlerIndex = LBound(arrCrawlerUserAgents) To UBound(arrCrawlerUserAgents)
			If InStr(strUserAgent, arrCrawlerUserAgents(lngCrawlerIndex)) <> 0 Then
				IsCrawler = True
				Exit Function
			End If
		Next
					
		IsCrawler = False
	End Function
	
	Function AllowCookies()
		Dim Cookie
		
		For Each Cookie In Response.Cookies		
			If Cookie = "allowcookies" Then
				AllowCookies = (Request.Cookies(Cookie) = "yes")
				Exit Function
			End If		
		Next
		
		AllowCookies = False
	End Function
	
	Function RemoveCookies()
		Dim Cookie
		
		For Each Cookie In Response.Cookies		
			If InStr(Cookie, "ASPSESSION") = 0 Then
'				Response.Cookies(Cookie) = ""
'				Response.Cookies(Cookie).Domain = ".ttkaart.nl"
'				Response.Cookies(Cookie).Expires = Date-1
'				Response.Cookies(Cookie).Path = "/"

				' write header instead of using cookies collection, classic asp cookies collection doesn't like cookie names with underscores...
				Response.AddHeader "Set-Cookie", Cookie & "=deleted; path=/; domain=.ttkaart.nl; expires=" & Date-1 & ";"
			End If
		Next
	End Function
	
	Function SafeEncode( ByVal str )
    	SafeEncode = ""

		If Len( str ) > 0 Then SafeEncode = Trim( str )
		If Len( SafeEncode ) > 0 Then SafeEncode = Server.HTMLEncode( SafeEncode )

	End Function
                         
	Function SafeEscape( ByVal str )
    	SafeEscape = ""

		If Len( str ) > 0 Then SafeEscape = Trim( str )
		If Len( SafeEscape ) > 0 Then SafeEscape = Escape( SafeEscape )

	End Function
	               
	Function SafeJSEscape(ByVal str)
		SafeJSEscape = ""

		If Len(str) > 0 Then
			SafeJSEscape = Replace(str, "\", "\\")
			SafeJSEscape = Replace(SafeJSEscape, """", "\""")
			SafeJSEscape = Replace(SafeJSEscape, "'", "\'")
		End If
	End Function
				
	Function EscapeQuery( ByVal str )
    	EscapeQuery = ""

		If Len( str ) > 0 Then EscapeQuery = Trim( str )
		If Len( EscapeQuery ) > 0 Then EscapeQuery = Replace(EscapeQuery,"'","''")
		
	End Function	

	Function SafeTrim( ByVal str )
    	SafeTrim = ""

		If Len( str ) > 0 Then str = Replace( str, vbTab, "" )
		If Len( str ) > 0 Then SafeTrim = Trim( str )
		
	End Function


	Function GetStringFromQueryString(ByVal QS_string)
		Dim strUserId

		strUserId = trim(Request.QueryString(QS_string))

		if strUserId = null then strUserId = ""
		GetStringFromQueryString = strUserId
	End Function
	
	Function GetIntFromQueryString(ByVal QS_int)
		Dim lngUserId

		lngUserId = Request.QueryString(QS_int)

		If lngUserId = "" Then lngUserId = -1
		If Not IsNumeric(lngUserId) Then lngUserId = -1

		GetIntFromQueryString = CLng(lngUserId)
	End Function		

	Public Function DisplayDate( ByVal d )
		Dim arrMonths
		
		arrMonths = Array("","januari","februari","maart","april","mei","juni","juli", _
							 "augustus", "september", "oktober", "november", "december")

		DisplayDate = Day(d) & " " & arrMonths( Month(d) ) & " " & Year(d)
	End Function
                   
	Public Function DateToString( ByVal d )
		DateToString = Month(d) & "/" & Day(d) & "/" & Year(d)
	End Function

	Function SpecialTrim(str)
		Dim strTemp
		strTemp = str
		strTemp = Right(strTemp,(Len(strTemp)-3))
		strTemp = Left(strTemp,(Len(strTemp)-2))
		SpecialTrim = strTemp
	End Function

	'Response.Write GetDateDiff( CDate("24/08/2005 12:34:11"), CDate("27/08/2006 14:12:11") )

	Private Function GetDateDiff(dtStartDate, dtEndDate)
    	Dim T, sOut, lVal, arrPeriods

    	arrPeriods = Array("yyyy", "jaar", "jaren", "m", "maand", "maanden", _
							"d", "dag", "dagen", "h", "uur", "uren", "n", "minuut", "minuten", "s", _
							"seconde", "seconden")

    	For T = 0 To UBound(arrPeriods) Step 3
        	lVal = DateDiff(arrPeriods(T), dtStartDate, dtEndDate)
        
			If DateAdd(arrPeriods(T), lVal, dtStartDate) > dtEndDate Then lVal = lVal - 1
        	dtStartDate = DateAdd(arrPeriods(T), lVal, dtStartDate)
        	sOut = sOut & IIF(lVal>0,lVal & " " & arrPeriods(IIf(lVal = 1, T + 1, T + 2)) & " ","")
    	Next

    	GetDateDiff = Trim(sOut)

	End Function

	Private Function IIF(bCondition, vExp1, vExp2)
	    If bCondition then IIF = vExp1 else IIF = vExp2
	End Function
	
	
	Function ReplaceUBB(ByVal str)

		ReplaceUBB = Replace(str, "[B]", "<b>",1,-1,1)
		ReplaceUBB = Replace(ReplaceUBB, "[/B]", "</b>",1,-1,1)
		ReplaceUBB = Replace(ReplaceUBB, "[I]", "<i>",1,-1,1)
		ReplaceUBB = Replace(ReplaceUBB, "[/I]", "</i>",1,-1,1)
		ReplaceUBB = Replace(ReplaceUBB, "[U]", "<u>",1,-1,1)
		ReplaceUBB = Replace(ReplaceUBB, "[/U]", "</u>",1,-1,1)


		ReplaceUBB = LinkURLs(ReplaceUBB)
                                              
		ReplaceUBB = Replace(ReplaceUBB, vbCrLf, "<br />" )
	End Function

    
    function LinkURLs(ByRef asContent)
    	Dim loRegExp	' Regular Expression Object (Requires vbScript 5.0 and above)
    	
    	' if no content was received, Exit the function
    	if asContent = "" Then Exit function
    	
    	' Create Regular Expression object
    	Set loRegExp = New RegExp
    	
    	' Keep finding links after the first one.				
    	loRegExp.Global = True
    	
    	' Ignore upper/lower Case
    	loRegExp.IgnoreCase = True
    	' Look For URLs
    	loRegExp.Pattern = "((ht|f)tps?://\S+[/]?[^\.])([\.]?.*)"
    	' Link URLs
    	LinkURLs = loRegExp.Replace(asContent, "<a href=""$1"">$1</a>$3")
    	' Look For email addresses
    	loRegExp.Pattern = "(\S+@\S+.\.\S\S\S?)"
    	' Link email addresses
    	LinkURLs = loRegExp.Replace(LinkURLs, "<a href=""mailto:$1"">$1</a>")
    	' Release regular expression object
    	Set loRegExp = Nothing
    	
    End function
    
	Function CheckEmail(ByVal strEmailAddress)
		Dim regEx
			
		Set regEx = New RegExp

		regEx.Global = True
		regEx.IgnoreCase = True
		regEx.Pattern = "(^[\-_\.a-zA-Z0-9]+)@((([0-9]{1,3}\.){3}([0-9]{1,3})((:[0-9])*))|(([a-zA-Z0-9\-]+)(\.[a-zA-Z]{2,})+(\.[a-zA-Z]{2})?((:[0-9])*)))"
			
		CheckEmail = regEx.Test(strEmailAddress)
				
		Set regEx = Nothing
	End Function	
	
	
				
	Function DisplayUrlLink(ByVal strUrl)
		If IsNull(strUrl) Then 
			DisplayUrlLink = "&nbsp;"
			Exit Function
		End If
		
		If strUrl = "" Then
			DisplayUrlLink = "&nbsp;"
			Exit Function
		End If
	
		DisplayUrlLink = "<a href=""" & strUrl & """ target=""_blank"">"
		
		strUrl = Replace(strUrl, "https://twitter.com/", "@")
		
		strUrl = Replace(strUrl, "https://", "")
		strUrl = Replace(strUrl, "http://", "")
		strUrl = Replace(strUrl, "www.", "")
		
		If Mid( strUrl, Len(strUrl)) = "/" Then strUrl = Left(strUrl, Len(strUrl)-1)
		
		DisplayUrlLink = DisplayUrlLink & SafeEncode(strUrl)
		
		DisplayUrlLink = DisplayUrlLink & "</a>"
	End Function
	
	
	
	Function GetClubClause(ByVal lngClubId)
		Dim rsData
		
		GetClubClause = "Club.id=" & lngClubId
			
		Set rsData = objDA.GetRecordSet("SELECT website FROM Club WHERE id=" & lngClubId)
		
		If rsData("website").Value <> "" Then
			Set rsData = objDA.GetRecordSet("SELECT id, club_name FROM Club WHERE website='" & rsData("website").Value & "'")
			If rsData.RecordCount > 1 Then
				GetClubClause = " (Club.id=" & rsData("id").Value
				
				rsData.MoveNext
					
				While Not rsData.EOF
					GetClubClause = GetClubClause & " OR Club.id=" & rsData("id").Value
				
					rsData.MoveNext
				Wend
				GetClubClause = GetClubClause & ")"
			End If
		End If		
	End Function	
	
	
	Function GetClubNames(ByVal lngClubId)
		Dim rsData, lngPosition
		
		Set rsData = objDA.GetRecordSet("SELECT website FROM Club WHERE id=" & lngClubId)
		
		If rsData("website").Value <> "" Then
			Set rsData = objDA.GetRecordSet("SELECT id, club_name FROM Club WHERE website='" & rsData("website").Value & "'")
			If rsData.RecordCount > 1 Then
				GetClubNames = "<div style='font-size:10px;'>(Heeft gespeeld onder de namen " & SafeEncode(rsData("club_name").Value)
				
				rsData.MoveNext
					
				While Not rsData.EOF
					GetClubNames = GetClubNames & ", " & SafeEncode(rsData("club_name").Value)
				
					rsData.MoveNext
				Wend
				GetClubNames = GetClubNames & ")</div><br />"
				
				lngPosition = InStrRev(GetClubNames, ",")
				
				GetClubNames = Left(GetClubNames, lngPosition-1) & " en " & Mid(GetClubNames, lngPosition+1)
			End If
		End If		
	End Function	
%>