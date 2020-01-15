<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="../include/db.asp" -->
<!-- #include file="../include/data.asp" -->
<!-- #include file="../include/functions.asp" -->
<!-- #include file="../include/license.asp" -->
<%
	Dim objDA, rs, strQuery, strResult
	Dim strId, lngIndex, strError

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
	
		
	strResult = "{ player:'" & SafeEncode(rs("player_name").Value) & "'," & _
				"  season:'" & SafeEncode(IIF(rs("season_period")=1,"voorjaar","najaar")) & " " & rs("season_year") & "'," & _
				"  bannerlink:'" & SafeEncode("http://www.dilemmamanager.nl") & "," & _
				"  bannerimage:'" & SafeEncode("http://www.ttkaart.nl/opensocial/dilemmamanager_banner.png") & "," & vbCrLf & _
				"  data: ["
				
	rs.Sort = "season_year DESC, season_period DESC"
	
	While Not rs.EOF
		strResult = strResult & "["
				
		strResult = strResult & "'" & SafeEncode(rs("club_name") & " " & rs("team_number")) & "',"
		strResult = strResult & "'" & SafeEncode(rs("season_year")) & " (" & SafeEncode(IIF(rs("season_period")=1,"voorjaar","najaar")) & ")',"
		strResult = strResult & "'" & SafeEncode(IIF(rs("poule_category")=1,"Senioren","Junioren")) & "',"
		strResult = strResult & "'" & SafeEncode(rs("region_name")) & "',"
		strResult = strResult & "'" & SafeEncode(rs("class_name")) & "',"
		strResult = strResult & "'" & SafeEncode(rs("poule_name")) & "',"
		strResult = strResult & "'" & rs("sets_won") & "',"
		strResult = strResult & "'" & rs("sets_played") & "',"
		strResult = strResult & "'" & rs("percentage") & "%',"
		strResult = strResult & "'" & IIF(rs("rating")=CLng(-9999),"-",rs("rating")) & "',"
		strResult = strResult & "'" & CalculateLicense(rs("rating"),rs("region_name"),rs("poule_category")) & "'"
	
		strResult = strResult & "]"
	
		rs.MoveNext
		
		If Not rs.EOF Then strResult = strResult & "," & vbCrLf
	Wend
	
	strResult = strResult & "]};"
			
	Set objDA = Nothing
	
	Response.Write strResult
%>