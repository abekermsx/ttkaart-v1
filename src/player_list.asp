<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="include/db.asp" -->
<!-- #include file="include/table.asp" -->
<!-- #include file="include/stringbuilder.asp" -->
<!-- #include file="views/search.asp" -->
<!-- #include file="views/player_list.asp" -->
<%
	Dim objDA
	Dim strPlayerName
	Dim strError, lngIndex
	Dim strResult, strQuery, rsPlayerData
	Dim lngSortField, lngSortDir, strSortDir
	Dim arrTableColumn
	Dim strRowClass
	Dim objStringBuilder
	Dim strBondsnummer, strClubListing, blnNextPlayer
	
	
	If Len(Request.QueryString) > 0 Then
		strPlayerName = SafeTrim(Request.QueryString("text"))
		If strPlayerName = "" Then strError = "Voer een spelernaam in"
		
		lngSortField = GetIntFromQueryString("f")
		If lngSortField = -1 Then lngSortField = 1
		
		arrTableColumn = arrPlayerTableColumns(lngSortField)
		
		lngSortDir = GetIntFromQueryString("d")
		If lngSortDir = -1 Then strSortDir = arrTableColumn(3) Else strSortDir = arrTableColumn(4)
		
		If strError = "" Then
			Set objDA = New DbHandler
			objDA.OpenDataBase(strConnectionString)
			
			If Len(strPlayerName)=1 Then
				strSearchTerm = Replace(strPlayerName,"'","''")&"%"
			Else
				strSearchTerm = "%"&Replace(strPlayerName,"'","''")&"%"
			End If
			
			strQuery = "SELECT player_name, player_nr, Player.wiki_url, Player.wiki_active, Club.id, club_name " & _
						" FROM Player, PlayerResult, Team, Club" & _
						" WHERE player_name LIKE '"&strSearchTerm&"'" & _
						" AND Player.id=PlayerResult.player_id" & _ 
						" AND PlayerResult.team_id=Team.id" & _
						" AND Team.club_id=Club.id" & _
						" GROUP BY player_name, player_nr, Player.wiki_url, Player.wiki_active, club_name, Club.id" & _
						" ORDER BY " & Replace(arrTableColumn(2),"?", strSortDir)
						
			Set rsPlayerData = objDA.GetRecordSet(strQuery)
						
			If rsPlayerData.EOF Then
				strError = "Geen speler gevonden met deze naam"
			Else		
				strResult = BuildPlayerList(rsPlayerData, lngSortField, lngSortDir, strPlayerName)
			End If			
			
			Set objDA = Nothing
		End If
	End If
		
	strSearchTerm = ""
	strPage = "Spelers"
	strMetaDescription = "Zoek spelers op die in het systeem van ttkaart.nl geregistreerd zijn"
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<div style="margin:10px;">
					<p>
						<table class="list">
							<tr>
								<td>Overzicht spelers beginnend met:</td>
<%
	Dim strChar
	
	For strChar = Asc("A") To Asc("Z")
		Response.Write "<td><a href='player_list.asp?text="&Chr(strChar)&"'" & IIF(strPlayerName=Chr(strChar)," style='background-color:#bbb;padding:4px;'","") & ">"&Chr(strChar)&"</a></td>"
	Next
%>
							</tr>
						</table>
					</p>
					<p><% Response.Write strResult %></p>
				</div>
			</div>
						
<!-- #include file="views/footer.asp" -->