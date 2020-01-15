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
	Dim lngTeamId
	Dim strError, lngIndex
	Dim strResult, strQuery, rsPlayerData
	Dim lngSortField, lngSortDir, strSortDir
	Dim arrTableColumns, arrTableColumn
	Dim strRowClass
	Dim objStringBuilder
	Dim strTeamName, strSeason
	
	arrTableColumns = Array(	Array(100,"Bondsnr.","player_nr ?", "ASC", "DESC"), _
								Array(210,"Speler","player_name ?", "ASC", "DESC"), _
								Array(100,"Gespeeld","sets_played ?", "DESC", "ASC"), _
								Array(100,"Gewonnen","sets_won ?", "DESC", "ASC"), _
								Array(110,"Percentage","percentage ?", "DESC", "ASC"), _
								Array(130,"Basisrating*", "base_rating ?", "DESC", "ASC") , _
								Array(80,"Rating*", "rating ?", "DESC", "ASC") , _
								Array(100,"Licentie**", "rating ?", "DESC", "ASC"))
	
	If Len(Request.QueryString) > 0 Then
		lngTeamId = GetIntFromQueryString("id")
		If lngTeamId = -1 Then strError = "Geen geldig team id"
		
		lngSortField = GetIntFromQueryString("f")
		If lngSortField = -1 Then lngSortField = 0
		
		arrTableColumn = arrTableColumns(lngSortField)
		
		lngSortDir = GetIntFromQueryString("d")
		If lngSortDir = -1 Then strSortDir = arrTableColumn(3) Else strSortDir = arrTableColumn(4)
		
		If strError = "" Then
			Set objDA = New DbHandler
			objDA.OpenDataBase(strConnectionString)
			
			strQuery = "SELECT player_name, player_nr, " & _
						" 		club_name, team_number, " & _
						"		season_year, season_period, class_name, poule_name, poule_category, region_name, sets_played, sets_won, percentage, rating, base_rating" & _
						" FROM Player, PlayerResult, Team, Club, Poule, Class, Season, Region" & _
						" WHERE Player.id=PlayerResult.player_id" & _
						" AND PlayerResult.team_id=Team.id" & _
						" AND Team.club_id=Club.id" & _
						" AND Team.poule_id=Poule.id" & _
						" AND Poule.class_id=Class.id" & _
						" AND Poule.region_id=Region.id" & _
						" AND Poule.season_id=Season.id" & _
						" AND Team.id=" & lngTeamId & _
						" ORDER BY " & Replace(arrTableColumn(2),"?", strSortDir)
						
			Set rsPlayerData = objDA.GetRecordSet(strQuery)
						
			If rsPlayerData.EOF Then
				strError = "Team bestaat niet"
			Else				
				Set objStringBuilder = New StringBuilder
				
				strTeamName = rsPlayerData("club_name").Value & " " & rsPlayerData("team_number").Value
				
				strSeason = rsPlayerData("class_name").Value & " " & rsPlayerData("poule_name").Value & _
							" (" & IIF(rsPlayerData("poule_category").Value=1,"Senioren","Junioren") & "), " & _
							IIF(rsPlayerData("season_period").Value=1,"voorjaar","najaar") & " " & rsPlayerData("season_year").Value & ", " & _
							"afdeling " & rsPlayerData("region_name").Value
							
				objStringBuilder.Append _
								"<h3>Resultaten " & SafeEncode(strTeamName) & _
												" (" & SafeEncode(IIF(rsPlayerData("season_period")=1,"voorjaar","najaar")) & _
												" " & SafeEncode(rsPlayerData("season_year")) & _
												" / " & SafeEncode(rsPlayerData("class_name")) & _
												" " & SafeEncode(rsPlayerData("poule_name")) & _
												" / " & SafeEncode(IIF(rsPlayerData("poule_category")=1,"Senioren","Junioren")) & _
												" / " & SafeEncode(rsPlayerData("region_name")) & ")</h3>" & _				
								"<table class='result'>" & _
									CreateTableHead(arrTableColumns,"team.asp?id="&lngTeamId,lngSortField,lngSortDir) & _
									"<tbody>"
											
				While Not rsPlayerData.EOF
					If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
					
					objStringBuilder.Append _ 
											"<tr class='"&strRowClass&"'>" & _
												"<td><a href='player_details.asp?text=" & rsPlayerData("player_nr") & "'>" & SafeEncode(rsPlayerData("player_nr")) & "</a></td>" & _
												"<td><a href='player_details.asp?text=" & rsPlayerData("player_nr") & "'>" & SafeEncode(rsPlayerData("player_name")) & "</a></td>" & _
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
									"</tbody></table>* rating op basis competitieresultaat<br/>** licentie op basis van seizoensrating"
				
				strResult = objStringBuilder.ToString()
				
				Set objStringBuilder = Nothing
			End If			
			
			Set objDA = Nothing
		End If
	End If
	
	strPage = ""
	strMetaDescription = "Overzicht van alle spelers in team " & strTeamName & " in de competitie " & strSeason
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<div style="margin:10px;"><% Response.Write strResult %></div>
			</div>
						
<!-- #include file="views/footer.asp" -->