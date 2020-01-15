<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="../include/db.asp" -->
<!-- #include file="../include/data.asp" -->
<!-- #include file="../include/functions.asp" -->
<!-- #include file="../include/license.asp" -->
<!-- #include file="../include/stringbuilder.asp" -->
<%
	Dim objDA, rs, strQuery, strResult, lngRow, strClass
	Dim strId, lngIndex, strError, strBanner
	Dim objResult
	
	Dim strProfileColumns
	Dim strCanvasColumns
	Dim strHomeColumns
	Dim strColumns
	
	strProfileColumns = "Seizoen/NiveauShort/Resultaat/Percentage"
	strCanvasColumns = "Team/Seizoen/JS/Regio/NiveauLong/Gespeeld/Gewonnen/Percentage/Rating/Licentie"
		
	strColumns = strProfileColumns
	If Request.QueryString("view")="canvas" Then strColumns = strCanvasColumns
	
	strId = SafeTrim(Request.QueryString("id"))
	
	If Len(strId) <> 7 Then 
		strResult = "Bondsnummer moet geheel uit cijfers bestaan!"
	Else
		For lngIndex = 1 To 7
			If Not IsNumeric(Mid(strId,lngIndex,1) ) Then strResult = "Bondsnummer moet geheel uit cijfers bestaan!"
		Next
	End If
	
	If strResult <> "" Then
		Response.Write "<br /><div id='error'>" & strResult & "</div>"
		Response.End
	End If
	
	Set objDA = New DbHandler
	objDA.OpenDataBase( strConnectionString )
	
	strQuery = "SELECT player_name, sets_played, PlayerResult.sets_won, percentage, rating," & _
			"      team_id, team_number, club_name, " & _
			"      season_id, season_year, season_period," & _
			"      Team.poule_id, class_name, class_level, poule_name, poule_category, region_name" & _
			" FROM Player, PlayerResult, Team, Club, Poule, Class, Season, Region" & _
			" WHERE Player.id=PlayerResult.player_id" & _
			" AND PlayerResult.team_id=Team.id" & _
			" AND Team.poule_id=Poule.id" & _
			" AND Team.club_id=Club.id" & _ 
			" AND Poule.class_id=Class.id" & _
			" AND Poule.season_id=Season.id" & _
			" AND Poule.region_id=Region.id" & _
			" AND Player.player_nr='" & strId & "'" & _
			" ORDER BY season_year DESC, season_period DESC"
			
	Set rs = objDA.GetRecordSet(strQuery)
	
	If rs.EOF Then
		Response.Write "<div id='error'>Sorry, dit bondsnummer komt niet voor in het systeem...</div>"
		Response.End	
	End If
	
	rs.Sort = "rating DESC"

	Set objResult = New StringBuilder
	
	objResult.Append "<div id='player'>" & _
						"<img id='avatar' src='http://www.ttkaart.nl/opensocial/empty.png' width='44px' height='48px' />" & _
						"<div id='name'>Speler: " & SafeEncode(rs("player_name").Value) & "</div>" & _
						"<div id='best'>Beste seizoen: " & _
							SafeEncode(IIF(rs("season_period").Value=1,"voorjaar","najaar")) & " " & rs("season_year").Value & _
						"</div>" & _
					"</div>"
	
	rs.Sort = "season_year DESC, season_period DESC"
	
	objResult.Append "<table cellspacing='0' class='details'>" & _
						"<tr class='header'>"
								
	If InStr(strColumns, "Team")>0 Then objResult.Append "<td>Team</td>"
	If InStr(strColumns, "Seizoen")>0 Then objResult.Append "<td>Seizoen</td>"
	If InStr(strColumns, "JS")>0 Then objResult.Append "<td>Jeugd/Senior</td>"
	If InStr(strColumns, "Regio")>0 Then objResult.Append "<td>Regio</td>"
	If InStr(strColumns, "Niveau")>0 Then objResult.Append "<td>Niveau</td>"
	If InStr(strColumns, "Resultaat")>0 Then objResult.Append "<td>Resultaat</td>"
	If InStr(strColumns, "Gewonnen")>0 Then objResult.Append "<td>Gewonnen</td>"
	If InStr(strColumns, "Gespeeld")>0 Then objResult.Append "<td>Gespeeld</td>"
	If InStr(strColumns, "Percentage")>0 Then objResult.Append "<td>Percentage</td>"
	If InStr(strColumns, "Rating")>0 Then objResult.Append "<td>Rating*</td>"
	If InStr(strColumns, "Licentie")>0 Then objResult.Append "<td>Licentie**</td>"
	
	objResult.Append "</tr>"
	
	lngRow = 0
	While Not rs.EOF
		lngRow = 1- lngRow
		strClass = IIF(lngRow = 1, "class='even'", "")
	
		objResult.Append "<tr " & strClass & ">"
				
		If InStr(strColumns, "Team")>0 Then objResult.Append "<td>" & SafeEncode(rs("club_name").Value & " " & rs("team_number").Value) & "</td>"
		If InStr(strColumns, "Seizoen")>0 Then objResult.Append "<td>" & SafeEncode(rs("season_year").Value) & " (" & SafeEncode(IIF(rs("season_period").Value=1,"voorjaar","najaar")) & ")</td>"
		If InStr(strColumns, "JS")>0 Then objResult.Append "<td>" & SafeEncode(IIF(rs("poule_category").Value=1,"Senioren","Junioren")) & "</td>"
		If InStr(strColumns, "Regio")>0 Then objResult.Append "<td>" & SafeEncode(rs("region_name").Value) & "</td>"
		If InStr(strColumns, "NiveauShort")>0 Then objResult.Append "<td>" & SafeEncode(rs("class_name").Value) & "</td>"
		If InStr(strColumns, "NiveauLong")>0 Then objResult.Append "<td>" & SafeEncode(rs("class_name").Value & " / " & rs("poule_name").Value) & "</td>"
		If InStr(strColumns, "Resultaat")>0 Then objResult.Append "<td>" & rs("sets_won").Value & " / " & rs("sets_played").Value & "</td>"
		If InStr(strColumns, "Gewonnen")>0 Then objResult.Append "<td>" & rs("sets_won").Value & "</td>"
		If InStr(strColumns, "Gespeeld")>0 Then objResult.Append "<td>" & rs("sets_played").Value & "</td>"
		If InStr(strColumns, "Percentage")>0 Then objResult.Append "<td>" & rs("percentage").Value & "%</td>"
		If InStr(strColumns, "Rating")>0 Then objResult.Append "<td>" & IIF(rs("rating").Value=CLng(-9999),"-",rs("rating").Value) & "</td>"
		If InStr(strColumns, "Licentie")>0 Then objResult.Append "<td>" & CalculateLicense(rs("rating").Value,rs("region_name").Value,rs("poule_category").Value) & "</td>"
	
		objResult.Append "</tr>"
	
		rs.MoveNext
	Wend
	
	objResult.Append "</table>"
			
	Set objDA = Nothing
	
	Response.Write objResult.ToString()
%>