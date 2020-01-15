<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="include/db.asp" -->
<!-- #include file="include/table.asp" -->
<!-- #include file="include/license.asp" -->
<!-- #include file="include/stringbuilder.asp" -->
<!-- #include file="views/search.asp" -->
<%
	Dim objDA
	Dim lngClubId, strClubName, lngSeasonId, strSeason
	Dim strError, lngIndex
	Dim strResult, strQuery, strClubClause, rsPlayerData, rsClubData
	Dim lngSortField, lngSortDir, strSortDir
	Dim arrTableColumns, arrTableColumn
	Dim strRowClass
	Dim objStringBuilder
	
	arrTableColumns = Array(	Array(0, "Bondsnr.", "player_nr ?", "ASC", "DESC"), _
								Array(0, "Speler", "player_name ?", "ASC", "DESC"), _
								Array(0, "Team", "team_number ?", "ASC", "DESC"), _
								Array(100, "Jeugd/Senior", "poule_category ?", "ASC", "DESC"), _
								Array(150, "Regio", "region_name ?", "ASC", "DESC"), _
								Array(250, "Klasse", "class_level ?, poule_name ?", "ASC", "DESC"), _
								Array(0, "Gespeeld", "sets_played ?", "DESC", "ASC"), _
								Array(0, "Gewonnen", "sets_won ?", "DESC", "ASC"), _
								Array(0, "Percentage", "percentage ?", "DESC", "ASC"), _
								Array(0, "Basisrating*", "base_rating ?", "DESC", "ASC"), _
								Array(0, "Rating*", "rating ?", "DESC", "ASC"), _
								Array(0, "Licentie**", "rating ?", "DESC", "ASC") )
							
	If Len(Request.QueryString) > 0 Then
		lngClubId = CLng(Request.QueryString("id"))
		lngSeasonId = CLng(Request.QueryString("season"))
		
		lngSortField = GetIntFromQueryString("f")
		If lngSortField = -1 Then lngSortField = 1
		
		arrTableColumn = arrTableColumns(lngSortField)
		
		lngSortDir = GetIntFromQueryString("d")
		If lngSortDir = -1 Then strSortDir = arrTableColumn(3) Else strSortDir = arrTableColumn(4)
			
		Set objDA = New DbHandler
		objDA.OpenDataBase(strConnectionString)
			
		Set rsClubData = objDA.GetRecordSet("SELECT id FROM Club WHERE id=" & lngClubId)
		
		If rsClubData.EOF Then
			strResult = "Het overzicht van spelers bij deze vereniging is niet meer via deze link in te zien."
			strMetaDescription = strResult
			Response.Status = "404 Not found"
		Else
			strClubClause = GetClubClause(lngClubId)
						
			strQuery = "SELECT player_name, player_nr, sets_played, sets_won, percentage, rating, base_rating, " & _
						"      team_id, club_name, team_number, " & _
						"      season_id, season_year, season_period," & _
						"      Team.poule_id, class_name, class_level, poule_name, poule_category, region_name" & _
						" FROM Player, PlayerResult, Team, Club, Poule, Class, Season, Region" & _
						" WHERE Player.id=PlayerResult.player_id" & _
						" AND PlayerResult.team_id=Team.id" & _
						" AND Team.club_id=Club.id" & _
						" AND Team.poule_id=Poule.id" & _
						" AND Poule.class_id=Class.id" & _
						" AND Poule.season_id=Season.id" & _
						" AND Poule.region_id=Region.id" & _
						" AND " & strClubClause & _ 
						" AND Season.id=" & lngSeasonId & _
						" ORDER BY " & Replace(arrTableColumn(2),"?", strSortDir)
			
			Set rsPlayerData = objDA.GetRecordSet(strQuery)
	
			If rsPlayerData.EOF Then
				strError = "Geen speler met dit bondsnummer gevonden"
			Else				
				strClubName = rsPlayerData("club_name").Value	' should be clubname player searched for?
				strSeason = IIF(rsPlayerData("season_period")=1,"voorjaar", "najaar") & " " & rsPlayerData("season_year") 
			
				Set objStringBuilder = New StringBuilder
								
				objStringBuilder.Append _
							"<h3>Resultaten " & SafeEncode(strClubName) & _
											" (" & strSeason & ")</h3>" & vbCrLf & _				
							"<table class='result'>" & vbCrLf & _ 
								CreateTableHead(arrTableColumns,"club_players.asp?id="&lngClubId&"&amp;season="&lngSeasonId,lngSortField,lngSortDir) & _
								"<tbody>"
					
				While Not rsPlayerData.EOF
					If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
										
					objStringBuilder.Append _
									"<tr class='"&strRowClass&"'>" & _
										"<td><a href='player_details.asp?text="&rsPlayerData("player_nr").Value&"'>" & rsPlayerData("player_nr").Value & "</a></td>" & _
										"<td><a href='player_details.asp?text="&rsPlayerData("player_nr").Value&"'>" & SafeEncode(rsPlayerData("player_name").Value) & "</a></td>" & _
										"<td><a href='team.asp?id=" & rsPlayerData("team_id").Value & "'>" & SafeEncode(rsPlayerData("club_name").Value&" "&rsPlayerData("team_number").Value) & "</a></td>" & _ 
										"<td>" & SafeEncode(IIF(rsPlayerData("poule_category").Value=1,"Senioren","Junioren")) & "</td>" & _ 
										"<td>" & SafeEncode(rsPlayerData("region_name").Value) & "</td>" & _ 
										"<td><a href='poule.asp?poule="&rsPlayerData("poule_id").Value & "'>" & _
											SafeEncode(rsPlayerData("class_name").Value & IIF(rsPlayerData("poule_name").Value<>""," - ","") & rsPlayerData("poule_name").Value) & "</a>" & _ 
										"</td>" & _
										"<td>" & rsPlayerData("sets_played").Value & "</td>" & _ 
										"<td>" & rsPlayerData("sets_won").Value & "</td>" & _ 
										"<td>" & rsPlayerData("percentage").Value & "</td>" & _ 
										"<td>" & IIF(rsPlayerData("base_rating").Value=CLng(-9999),"-",rsPlayerData("base_rating").Value) & "</td>" & _ 
										"<td>" & IIF(rsPlayerData("rating").Value=CLng(-9999),"-",rsPlayerData("rating").Value) & "</td>" & _ 
										"<td>" & CalculateLicense(rsPlayerData("rating").Value,rsPlayerData("region_name").Value,rsPlayerData("poule_category").Value) & "</td>" & _
									"</tr>" & vbCrLf
				
					rsPlayerData.MoveNext
				Wend
				
				objStringBuilder.Append _
								"</tbody></table>* rating op basis competitieresultaat<br/>** licentie op basis van seizoensrating"
						
				strResult = objStringBuilder.ToString()
						
				Set objStringBuilder = Nothing
			End If			
		
			strMetaDescription = "Overzicht van alle spelers van " & strClubName & " die tijdens het seizoen " & strSeason & " competitie hebben gespeeld"
		End If
		
		Set objDA = Nothing
	End If
	
	strPage = ""
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<div style="margin:10px;"><% Response.Write strResult %></div>
			</div>
						
<!-- #include file="views/footer.asp" -->