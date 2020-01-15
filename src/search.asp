<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="include/db.asp" -->
<!-- #include file="include/table.asp" -->
<!-- #include file="include/stringbuilder.asp" -->
<!-- #include file="views/player_list.asp" -->
<!-- #include file="views/club_list.asp" -->
<!-- #include file="views/search.asp" -->
<%
	Dim blnIsBondsNummer, lngIndex
	Dim lngSortField, lngSortDir, strSortDir
	
	strSearchTerm = SafeTrim( Request.QueryString("text") )
	
	If Len(strSearchTerm) > 1 Then
	
		If Len(strSearchTerm) = 7 Then
			blnIsBondsNummer = True
			
			For lngIndex = 1 To 7
				If Not IsNumeric(Mid(strSearchTerm,lngIndex,1) ) Then blnIsBondsNummer = False
			Next
			
			If blnIsBondsNummer = True Then Response.Redirect "player_details.asp?text="&strSearchTerm
		End If
		
		strSearchTerm = "%"&Replace(strSearchTerm,"'","''")&"%"
		
		Dim objDA, rsPlayerData, rsClubData, strQuery
			
		Set objDA = New DbHandler
		objDA.OpenDataBase(strConnectionString)
		
		strQuery = "SELECT player_name, player_nr" & _
					" FROM Player" & _
					" WHERE player_name LIKE '"&strSearchTerm&"'"
					
		Set rsPlayerData = objDA.GetRecordSet(strQuery)
		
		
		strQuery = "SELECT id, club_name, website, twitter, facebook, hyves, nttb, wiki_url " & _
					" FROM Club" & _
					" WHERE club_name LIKE '"&strSearchTerm&"'" & _
					" ORDER BY club_name ASC"
					
		Set rsClubData = objDA.GetRecordSet(strQuery)
		
		If rsPlayerData.RecordCount = 1 And rsClubData.EOF Then
			Response.Redirect "player_details.asp?text=" & rsPlayerData("player_nr")
		End If
		
		If rsPlayerData.EOF And rsClubData.RecordCount = 1 Then
			Response.Redirect "club_seasons.asp?id=" & rsClubData("id")
		End If
		
		If Not rsPlayerData.EOF Then
			strQuery = "SELECT player_name, player_nr, Club.id, club_name, Player.wiki_url, wiki_active " & _
						" FROM Player, PlayerResult, Team, Club" & _
						" WHERE player_name LIKE '"&strSearchTerm&"'" & _
						" AND Player.id=PlayerResult.player_id" & _ 
						" AND PlayerResult.team_id=Team.id" & _
						" AND Team.club_id=Club.id" & _
						" GROUP BY player_name, player_nr, club_name, Club.id, Player.wiki_url, wiki_active" & _
						" ORDER BY player_name ASC"
						
			Set rsPlayerData = objDA.GetRecordSet(strQuery)
		End If
		
		strSearchTerm = SafeTrim( Request.QueryString("text") )
	End If
	
	strPage = ""
	strMetaDescription = "Zoekresultaten voor ingevoerde bondsnummer, naam speler of vereniging"
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<div style="margin:10px;">
					<% If Len(strSearchTerm) < 2 Then %>
					<p>Zoekterm moet minimaal 2 tekens lang zijn!</p>
					<% Else %>
						<% If rsPlayerData.EOF And rsClubData.EOF Then %>
						<p>Geen gegevens gevonden!</p>
						<% End If %>
						<% If Not rsClubData.EOF Then %>
						<p><% =BuildClubList(rsClubData, 0, 0, strSearchTerm) %></p>
						<p>&nbsp;</p>
						<% End If %>
						<% If Not rsPlayerData.EOF Then %>
						<p><% =BuildPlayerList(rsPlayerData, 1, 0, strSearchTerm) %></p>
						<% End If %>
					<% End If %>
				</div>
			</div>
						
<!-- #include file="views/footer.asp" -->