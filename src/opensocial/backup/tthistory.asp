<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="../include/db.asp" -->
<!-- #include file="../include/data.asp" -->
<!-- #include file="../include/functions.asp" -->
<!-- #include file="../include/license.asp" -->
<%
	Dim objDA, rs, strQuery, strResult, lngRow, strClass
	Dim strId, lngIndex, strError, strBanner
	
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
		Response.Write "<br /><div id='error'>Sorry, dit bondsnummer komt niet voor in het systeem...</div>"
		Response.End	
	End If
	
	rs.Sort = "rating DESC"
		
	strResult = "<div id='player'><img id='avatar' src='http://www.ttkaart.nl/opensocial/empty.png' width='44px' height='48px' /><div id='name'>Speler: " & SafeEncode(rs("player_name").Value) & "</div><div id='best'>Beste seizoen: "
	strResult = strResult & SafeEncode(IIF(rs("season_period")=1,"voorjaar","najaar")) & " " & rs("season_year") & "</div></div>"
	
	rs.Sort = "season_year DESC, season_period DESC"
	
	strResult = strResult & "<table cellspacing='0' class='details'>" & _
								"<tr class='header'>"
								
	If InStr(strColumns, "Team")>0 Then strResult = strResult & "<td>Team</td>"
	If InStr(strColumns, "Seizoen")>0 Then strResult = strResult & "<td>Seizoen</td>"
	If InStr(strColumns, "JS")>0 Then strResult = strResult & "<td>Jeugd/Senior</td>"
	If InStr(strColumns, "Regio")>0 Then strResult = strResult & "<td>Regio</td>"
	If InStr(strColumns, "Niveau")>0 Then strResult = strResult & "<td>Niveau</td>"
	If InStr(strColumns, "Resultaat")>0 Then strResult = strResult & "<td>Resultaat</td>"
	If InStr(strColumns, "Gewonnen")>0 Then strResult = strResult & "<td>Gewonnen</td>"
	If InStr(strColumns, "Gespeeld")>0 Then strResult = strResult & "<td>Gespeeld</td>"
	If InStr(strColumns, "Percentage")>0 Then strResult = strResult & "<td>Percentage</td>"
	If InStr(strColumns, "Rating")>0 Then strResult = strResult & "<td>Rating*</td>"
	If InStr(strColumns, "Licentie")>0 Then strResult = strResult & "<td>Licentie**</td>"
	
	strResult = strResult &	"</tr>"
	
	lngRow = 0
	While Not rs.EOF
		lngRow = 1- lngRow
		strClass = IIF(lngRow = 1, "class='even'", "")
	
		strResult = strResult & _
				"<tr " & strClass & ">"
				
		If InStr(strColumns, "Team")>0 Then strResult = strResult & "<td>" & SafeEncode(rs("club_name") & " " & rs("team_number")) & "</td>"
		If InStr(strColumns, "Seizoen")>0 Then strResult = strResult & "<td>" & SafeEncode(rs("season_year")) & " (" & SafeEncode(IIF(rs("season_period")=1,"voorjaar","najaar")) & ")</td>"
		If InStr(strColumns, "JS")>0 Then strResult = strResult & "<td>" & SafeEncode(IIF(rs("poule_category")=1,"Senioren","Junioren")) & "</td>"
		If InStr(strColumns, "Regio")>0 Then strResult = strResult & "<td>" & SafeEncode(rs("region_name")) & "</td>"
		If InStr(strColumns, "NiveauShort")>0 Then strResult = strResult & "<td>" & SafeEncode(rs("class_name")) & "</td>"
		If InStr(strColumns, "NiveauLong")>0 Then strResult = strResult & "<td>" & SafeEncode(rs("class_name") & " / " & rs("poule_name")) & "</td>"
		If InStr(strColumns, "Resultaat")>0 Then strResult = strResult & "<td>" & rs("sets_won") & " / " & rs("sets_played") & "</td>"
		If InStr(strColumns, "Gewonnen")>0 Then strResult = strResult & "<td>" & rs("sets_won") & "</td>"
		If InStr(strColumns, "Gespeeld")>0 Then strResult = strResult & "<td>" & rs("sets_played") & "</td>"
		If InStr(strColumns, "Percentage")>0 Then strResult = strResult & "<td>" & rs("percentage") & "%</td>"
		If InStr(strColumns, "Rating")>0 Then strResult = strResult & "<td>" & IIF(rs("rating")=CLng(-9999),"-",rs("rating")) & "</td>"
		If InStr(strColumns, "Licentie")>0 Then strResult = strResult & "<td>" & CalculateLicense(rs("rating"),rs("region_name"),rs("poule_category")) & "</td>"
	
		strResult = strResult & _
				"</tr>"
	
		rs.MoveNext
	Wend
	
	strResult = strResult & "</table>"
			
	Set objDA = Nothing
	
	Response.Write strResult
%>