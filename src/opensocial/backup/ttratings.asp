<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="../include/db.asp" -->
<!-- #include file="../include/data.asp" -->
<!-- #include file="../include/functions.asp" -->
<%
	Dim objDA, rs, strIdList, arrIdList, lngIndex, lngIndex2
	Dim strError, strQuery, strResult, strBondsnummer
	
	strIdList = Request.QueryString("idlist")
	arrIdList = Split(strIdList,",")
	
	For lngIndex = LBound(arrIdList) To UBound(arrIdList)
		If Len( arrIdList(lngIndex) ) <> 7 Then Response.End

		For lngIndex2 = 1 To 7
			If Not IsNumeric( Mid( arrIdList(lngIndex),lngIndex2,1) ) Then Response.End
		Next
	Next

	strIdList = Join(arrIdList, "' OR Player.player_nr='")
	
	Set objDA = New DbHandler
	objDA.OpenDataBase( strConnectionString )

	strQuery = "SELECT player_nr,rating" & _
			" FROM Player, PlayerResult, Team, Poule, Season" & _
			" WHERE Player.id=PlayerResult.player_id" & _
			" AND PlayerResult.team_id=Team.id" & _
			" AND Team.poule_id=Poule.id" & _
			" AND Poule.season_id=Season.id" & _
			" AND (Player.player_nr='" & strIdList & "')" & _
			" ORDER BY player_nr ASC, season_year DESC, season_period DESC, rating DESC"

	Set rs = objDA.GetRecordSet(strQuery)
		
	strBondsnummer = ""
	While Not rs.EOF
		If rs("player_nr").Value <> strBondsnummer Then
			strBondsnummer = rs("player_nr").Value
			strResult = strResult & "r"&strBondsnummer & ":" & rs("rating").Value & ","
		End If
		
		rs.MoveNext
	Wend
	
	Set objDA = Nothing
	
	Response.Write "({"&Left(strResult,Len(strResult)-1)&"})"
%>