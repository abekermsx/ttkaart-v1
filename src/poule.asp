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
	Dim lngPouleId
	Dim strError, lngIndex
	Dim strResult, strQuery, rsPlayerData
	Dim lngSortField, lngSortDir, strSortDir
	Dim arrTableColumns, arrTableColumn
	Dim strRowClass
	Dim objStringBuilder
	Dim rsTeamRatings
	Dim strSeason
	
	arrTableColumns = Array(	Array(0,"Bondsnr.","player_nr ?", "ASC", "DESC"), _
								Array(210,"Speler", "player_name ?", "ASC", "DESC"), _
								Array(230,"Team", "club_name ?, team_number ?", "ASC", "DESC"), _
								Array(0,"Gespeeld", "sets_played ?", "DESC", "ASC"), _
								Array(0,"Gewonnen", "sets_won ?", "DESC", "ASC"), _
								Array(0,"Percentage", "percentage ?", "DESC", "ASC"), _
								Array(0, "Basisrating*", "base_rating ?", "DESC", "ASC"), _
								Array(0, "Rating*", "rating ?", "DESC", "ASC"), _
								Array(0, "Licentie**", "rating ?", "DESC", "ASC") )

	If Len(Request.QueryString) > 0 Then
		lngPouleId = GetIntFromQueryString("poule")		
		
		lngSortField = GetIntFromQueryString("f")
		If lngSortField = -1 Then lngSortField = 5
		
		arrTableColumn = arrTableColumns(lngSortField)
		
		lngSortDir = GetIntFromQueryString("d")
		If lngSortDir = -1 Then strSortDir = arrTableColumn(3) Else strSortDir = arrTableColumn(4)
		
		If strError = "" Then
			Set objDA = New DbHandler
			objDA.OpenDataBase(strConnectionString)
			
			strQuery = "SELECT player_name, player_nr, sets_played, sets_won, percentage, rating, base_rating, " & _
						"      team_id, club_name, team_number, " & _
						"      season_year, season_period," & _
						"      Team.poule_id, class_name, poule_name, poule_category, region_name" & _
						" FROM Player, PlayerResult, Team, Club, Poule, Class, Season, Region" & _
						" WHERE Player.id=PlayerResult.player_id" & _
						" AND PlayerResult.team_id=Team.id" & _
						" AND Team.club_id=Club.id" & _
						" AND Team.poule_id=Poule.id" & _
						" AND Poule.season_id=Season.id" & _
						" AND Poule.class_id=Class.id" & _
						" AND Poule.region_id=Region.id" & _
						" AND Team.poule_id=" & lngPouleId
						
			strQuery = strQuery & _
						" ORDER BY " & Replace(arrTableColumn(2),"?", strSortDir)
						
			Set rsPlayerData = objDA.GetRecordSet(strQuery)
			
			
			If rsPlayerData.EOF Then
				strError = "Seizoen bestaat niet"
			Else				
				Set objStringBuilder = New StringBuilder
				
				strSeason = rsPlayerData("class_name").Value & " " & rsPlayerData("poule_name").Value & _
							" (" & IIF(rsPlayerData("poule_category").Value=1,"Senioren","Junioren") & "), " & _
							IIF(rsPlayerData("season_period").Value=1,"voorjaar","najaar") & " " & rsPlayerData("season_year").Value & ", " & _
							"afdeling " & rsPlayerData("region_name").Value
				
				objStringBuilder.Append _
							"<h3>Resultaten " & SafeEncode(IIF(rsPlayerData("season_period")=1,"voorjaar","najaar")) & " " & SafeEncode(rsPlayerData("season_year")) & _
										   " / " & SafeEncode(IIF(rsPlayerData("poule_category")=1,"Senioren","Junioren")) & _
										   " / " & SafeEncode(rsPlayerData("region_name")) & " / " & SafeEncode(rsPlayerData("class_name") & " " & rsPlayerData("poule_name")) & _
							"</h3>" & _				
							"<table class='result'>" & _
								CreateTableHead(arrTableColumns,"poule.asp?poule="&lngPouleId,lngSortField,lngSortDir) & _
								"<tbody>"

				While Not rsPlayerData.EOF
					If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
					
					objStringBuilder.Append _
											"<tr class='"&strRowClass&"'>" & _
												"<td><a href='player_details.asp?text=" & rsPlayerData("player_nr") & "'>" & SafeEncode(rsPlayerData("player_nr")) & "</a></td>" & _
												"<td><a href='player_details.asp?text=" & rsPlayerData("player_nr") & "'>" & SafeEncode(rsPlayerData("player_name")) & "</a></td>" & _
												"<td><a href='team.asp?id=" & rsPlayerData("team_id") & "'>" & SafeEncode(rsPlayerData("club_name")&" "&rsPlayerData("team_number")) & "</a></td>" & _ 
												"<td>" & rsPlayerData("sets_played") & "</td>" & _ 
												"<td>" & rsPlayerData("sets_won") & "</td>" & _ 
												"<td>" & rsPlayerData("percentage") & "</td>" & _ 
												"<td>" & IIF(rsPlayerData("base_rating")=CLng(-9999),"-",rsPlayerData("base_rating")) & "</td>" & _ 
												"<td>" & IIF(rsPlayerData("rating")=CLng(-9999),"-",rsPlayerData("rating")) & "</td>" & _ 
												"<td>" & CalculateLicense(rsPlayerData("rating"),rsPlayerData("region_name"),rsPlayerData("poule_category")) & "</td>" & _
											"</tr>" & vbCrLf
				
					rsPlayerData.MoveNext
				Wend
				
				objStringBuilder.Append _
								"</tbody></table><p>* rating op basis competitieresultaat<br/>** licentie op basis van seizoensrating</p><p>&nbsp;</p>"
				
				
				strQuery = "SELECT SUM(rating) / COUNT(rating) AS average_rating, team_id, club_name, team_number FROM PlayerResult, Team, Club, Poule" & _
							" WHERE PlayerResult.team_id=Team.id" & _
							" AND Team.club_id=Club.id" & _
							" AND Team.poule_id=Poule.id" & _
							" AND Poule.id=" & lngPouleId & _
							" GROUP BY team_id, club_name, team_number"
				
				Set rsTeamRatings = objDA.GetRecordSet(strQuery)
				
				rsTeamRatings.Sort = "average_rating DESC"
				
				If Not rsTeamRatings.EOF Then
					If rsTeamRatings("average_rating").Value > -1000 Then
				
						strRowClass = "odd"
				
						objStringBuilder.Append _
							"<h3>Teamratings</h3>" & _
							"<table class='result'>" & _
								"<thead><tr><th>Team</th><th>Teamrating*</th></thead>" & vbCrLf & _
								"<tbody>"
							
						While Not rsTeamRatings.EOF
						
							If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
					
							objStringBuilder.Append _
								"<tr class='"&strRowClass&"'>" & _
									"<td><a href='team.asp?id=" & rsTeamRatings("team_id").Value & "'>" & rsTeamRatings("club_name").Value & " " & rsTeamRatings("team_number").Value & "</a></td>" & _
									"<td>" & Round(rsTeamRatings("average_rating").Value+0.00001) & "</td>" & _
								"</tr>"
							
							rsTeamRatings.MoveNext
						Wend
						
						objStringBuilder.Append _
							"</tbody></table>" & _
							"<p>* Teamrating op basis van gemiddelde rating spelers in team</p>" & _
							"<p>&nbsp;</p>"
					End If
				End If
				
				strResult = objStringBuilder.ToString()
				
				Set objStringBuilder = Nothing
			End If			
			
			Set objDA = Nothing
		End If
	End If
	
	strPage = ""
	strMetaDescription = "Overzicht van alle spelers, resultaten, percentages, ratings, licenties voor de competitie " & strSeason
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<div style="margin:10px;"><% Response.Write strResult %></div>
			</div>
						
<!-- #include file="views/footer.asp" -->