<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="include/db.asp" -->
<!-- #include file="include/table.asp" -->
<!-- #include file="include/license.asp" -->
<!-- #include file="include/stringbuilder.asp" -->
<!-- #include file="include/chart.asp" -->
<!-- #include file="views/search.asp" -->
<%
	Dim objDA
	Dim strBondsNummer, strPlayerName
	Dim strError, lngIndex
	Dim strResult, strQuery, rsPlayerData
	Dim lngSortField, lngSortDir, strSortDir
	Dim arrTableColumns, arrTableColumn
	Dim strRowClass
	Dim objStringBuilder
	Dim strWikiLink, strWikiUrl, strWikiText
	
	Function CreatePlayerWikiBlock(ByVal strBondsnummer)
		Dim rsPlayerWiki, objStringBuilder
		
		Set objStringBuilder = New StringBuilder
		
		Set rsPlayerWiki = objDA.GetRecordSet("SELECT wiki_url, wiki_text, wiki_active FROM Player WHERE player_nr='" & strBondsnummer & "'")
		
		If rsPlayerWiki("wiki_active").Value = True Then
			strWikiUrl = "http://nl.wikipedia.org/wiki/" & rsPlayerWiki("wiki_url").Value
			strWikiLink = rsPlayerWiki("wiki_url").Value
			strWikiText = rsPlayerWiki("wiki_text").Value
	
			strWikiLink = Replace(strWikiLink, "_", " ")
			If InStr(strWikiLink, "(") > 0 Then strWikiLink = Left(strWikiLink, InStr(strWikiLink, "(")-1)
			
			objStringBuilder.Append _
				"<div class='wiki' style='width:900px;'>" & _
					"<h3><a id='wiki'>Wiki " & strWikiLink & "</a></h3>" & _
					strWikiText & _
					"<hr />" & _
					"<p>" & _
					"Lees het originele artikel op <a class='free' href='" & strWikiUrl & "' target='_blank'>" & strWikiUrl & "</a><br /><br />" & _
					"<small>" & _
					"De tekst is beschikbaar onder de licentie <a class='free' href='http://creativecommons.org/licenses/by-sa/3.0/deed.nl' target='_blank'>Creative Commons Naamsvermelding/Gelijk delen</a>," & _
					" er kunnen aanvullende voorwaarden van toepassing zijn. Zie de <a class='free' href='http://wikimediafoundation.org/wiki/Gebruiksvoorwaarden' target='_blank'>gebruiksvoorwaarden</a> voor meer informatie." & _
					"</small>" & _
					"</p>" & _
				"</div>" & _
				"<p>&nbsp;</p>"
		End If
		
		CreatePlayerWikiBlock = objStringBuilder.ToString()
		
		Set objStringBuilder = Nothing
	End Function
	
	
	arrTableColumns = Array(	Array(0, "Team", "club_name ?, team_number ?", "ASC", "DESC"), _
								Array(0, "Seizoen", "season_year ?, season_period ?", "DESC", "ASC"), _
								Array(0, "Jeugd/Senior", "poule_category ?", "ASC", "DESC"), _
								Array(0, "Regio", "region_name ?", "ASC", "DESC"), _
								Array(0, "Klasse", "class_level ?, poule_name ?", "ASC", "DESC"), _
								Array(0, "Gespeeld", "sets_played ?", "DESC", "ASC"), _
								Array(0, "Gewonnen", "sets_won ?", "DESC", "ASC"), _
								Array(0, "Percentage", "percentage ?", "DESC", "ASC"), _
								Array(0, "Basisrating", "base_rating ?", "DESC", "ASC"), _
								Array(0, "Rating*", "rating ?", "DESC", "ASC"), _
								Array(0, "Licentie**", "rating ?", "DESC", "ASC") )
							
	If Len(Request.QueryString) > 0 Then
		strBondsNummer = SafeTrim( Request.QueryString("text") )
		
		lngSortField = GetIntFromQueryString("f")
		If lngSortField = -1 Then lngSortField = 1
		
		arrTableColumn = arrTableColumns(lngSortField)
		
		lngSortDir = GetIntFromQueryString("d")
		If lngSortDir = -1 Then strSortDir = arrTableColumn(3) Else strSortDir = arrTableColumn(4)
	
		If Len(strBondsNummer) <> 7 Then
			strError = "Bondsnummer moet 7 cijfers lang zijn"
		Else
			If Left(strBondsNummer,1) = "W" Then
				For lngIndex = 2 To 7
					If Not IsNumeric(Mid(strBondsNummer,lngIndex,1) ) Then strError = "Bondsnummer moet geheel uit cijfers bestaan"
				Next
				
				If strError = "" Then 
					Set objDA = New DbHandler
					objDA.OpenDataBase(strConnectionString)
			
					strResult = CreatePlayerWikiBlock(strBondsNummer)
					strError = "wiki"
					
					Set objDA = Nothing
				End If
			Else
				For lngIndex = 1 To 7
					If Not IsNumeric(Mid(strBondsNummer,lngIndex,1) ) Then strError = "Bondsnummer moet geheel uit cijfers bestaan"
				Next
			End If
		End If
		
		If strError = "" Then
			Set objDA = New DbHandler
			objDA.OpenDataBase(strConnectionString)
			
			strQuery = "SELECT player_name, sets_played, sets_won, percentage, base_rating, rating," & _
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
						" AND Player.player_nr='" & strBondsNummer & "'" & _
						" ORDER BY " & Replace(arrTableColumn(2),"?", strSortDir)
			
			Set rsPlayerData = objDA.GetRecordSet(strQuery)
	
			If rsPlayerData.EOF Then
				strResult = "Geen speler met dit bondsnummer gevonden!"
			Else			
				strPlayerName = rsPlayerData("player_name").Value
				
				Set objStringBuilder = New StringBuilder
				
				objStringBuilder.Append _
							"<h3><a id='resultaten'>Resultaten " & SafeEncode(strPlayerName) & "</a></h3>" & vbCrLf & _				
							"<table class='result'>" & vbCrLf & _ 
								CreateTableHead(arrTableColumns,"player_details.asp?text="&strBondsNummer,lngSortField,lngSortDir) & _
								"<tbody>"
					
				While Not rsPlayerData.EOF
					If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
										
					objStringBuilder.Append _
									"<tr class='"&strRowClass&"'>" & _
										"<td><a href='team.asp?id=" & rsPlayerData("team_id").Value & "'>" & SafeEncode(rsPlayerData("club_name").Value&" "&rsPlayerData("team_number").Value) & "</a></td>" & _ 
										"<td>" & _
											SafeEncode(rsPlayerData("season_year").Value) & _
											" (" & SafeEncode(IIF(rsPlayerData("season_period").Value=1,"voorjaar","najaar")) & ")" & _
										"</td>" & _ 
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
								"</tbody>" & _
							"</table>" & _
							"<p>* rating op basis competitieresultaat<br/>" & _
							"** licentie op basis van seizoensrating (kan afwijken van daadwerkelijke licentie)<br/>" & _
							"ratings van voorjaar 2006 en eerder zijn gebaseerd op de basisratings van najaar 2006</p>" & _
							"<p>&nbsp;</p>"

								
				rsPlayerData.Filter = "rating<>-9999"
				rsPlayerData.Sort = "season_year ASC, season_period ASC"
				
				If Not (rsPlayerData.BOF And rsPlayerData.EOF) Then
					Dim arrRatings(), arrYears(), arrColors()
				
					If rsPlayerData.RecordCount>2 Then
						Dim lngSumXY, lngSumX, lngSumY, lngSumXSquared
						Dim lngSlope, lngIntercept, lngPrognose
						Dim p,t
						
						rsPlayerData.MoveLast
						If Not rsPlayerData.BOF Then rsPlayerData.MovePrevious
						If Not rsPlayerData.BOF Then rsPlayerData.MovePrevious
						If rsPlayerData.BOF Then rsPlayerData.MoveFirst
						
						lngIndex = 0
						
						While Not rsPlayerData.EOF
							lngIndex = lngIndex + 1
							
							For p = lngIndex To 0 Step - 1
								t = t + 1
								
								lngSumXY = lngSumXY + t*rsPlayerData("rating").Value
								lngSumX = lngSumX + t
								lngSumY = lngSumY + rsPlayerData("rating").Value
								lngSumXSquared = lngSumXSquared + t*t
							Next
							
							rsPlayerData.MoveNext
						Wend
						
						lngSlope = (t * lngSumXY - lngSumX * lngSumY) / (t * lngSumXSquared - lngSumX * lngSumX)
						lngIntercept = (lngSumY - lngSlope * lngSumX) / t
						lngPrognose = CLng(lngSlope*(t+1)+lngIntercept)
												
						ReDim Preserve arrRatings(rsPlayerData.RecordCount)
						ReDim Preserve arrBaseRatings(rsPlayerData.RecordCount)
						ReDim Preserve arrYears(rsPlayerData.RecordCount)
						ReDim Preserve arrColors(rsPlayerData.RecordCount)
					Else
						ReDim Preserve arrRatings(rsPlayerData.RecordCount-1)
						ReDim Preserve arrBaseRatings(rsPlayerData.RecordCount-1)
						ReDim Preserve arrYears(rsPlayerData.RecordCount-1)
						ReDim Preserve arrColors(rsPlayerData.RecordCount-1)	
					End If
					
					rsPlayerData.MoveFirst
					
					
					lngIndex = 0
					While Not rsPlayerData.EOF
						arrRatings(lngIndex) = rsPlayerData("rating").Value
						arrBaseRatings(lngIndex) = rsPlayerData("base_rating").Value
						arrYears(lngIndex) = rsPlayerData("season_year").Value & " " & IIF(rsPlayerData("season_period").Value=1,"vj","nj")
						
						arrColors(lngIndex) = "blue"
						If rsPlayerData("poule_category").Value = 2 Then arrColors(lngIndex)="green"
						If rsPlayerData("region_name").Value = "Landelijk Meisjes" Then arrColors(lngIndex)="red"
						If rsPlayerData("region_name").Value = "Landelijk Dames" Then arrColors(lngIndex)="magenta"
						
						lngIndex = lngIndex + 1
						rsPlayerData.MoveNext
					Wend
								
					If rsPlayerData.RecordCount>2 Then
						arrBaseRatings(lngIndex) = 0
						arrRatings(lngIndex) = lngPrognose
						arrYears(lngIndex) = "&nbsp;"
						arrColors(lngIndex) = "black"
					End If
					
					objStringBuilder.Append "<h3><a id='progressie'>Progressie " & SafeEncode(strPlayerName) & "</a></h3>" & vbCrLf	
					objStringBuilder.Append "<p><table><tr><td>" & makechart("", arrRatings, arrYears, arrColors, "#eeeeee", 1, 250, 50, true, arrBaseRatings)
					objStringBuilder.Append "</td></tr></table></p>"
					
					objStringBuilder.Append "<p><b>Betekenis kleuren:</b> <span style='color:blue;'>Heren</span> / <span style='color:magenta;'>Dames</span> / " & _
											"<span style='color:green;'>Jongens</span> / <span style='color:red;'>Meisjes</span>"
					If rsPlayerData.RecordCount>2 Then objStringBuilder.Append " / Prognose volgend seizoen"
					objStringBuilder.Append "</p>" & _
											"<p>&nbsp;</p>"

				End If
				
				
				objStringBuilder.Append _
						CreatePlayerWikiBlock(strBondsnummer)
				
				
				
				strQuery = "SELECT player_name, player_nr, rating, season_year, season_period, team_id, team_number, club_name" & _
							" FROM Player, PlayerResult, Team, Club, Poule, Season" & _
							" WHERE Player.id=PlayerResult.player_id" & _
							" AND PlayerResult.team_id=Team.id" & _
							" AND Team.club_id=Club.id" & _
							" AND Team.poule_id=Poule.id" & _
							" AND Poule.season_id=Season.id" & _
							" AND team_id IN (SELECT Team.id FROM Team, PlayerResult, Player" & _
							" 				  WHERE Team.id=PlayerResult.team_id" & _
							" 				  AND PlayerResult.player_id=Player.id" & _
							"                 AND player_nr='" & strBondsNummer & "')" & _
							" ORDER BY season_year DESC, season_period DESC, team_id ASC, player_name ASC"
							
				Set rsPlayerData = objDA.GetRecordSet(strQuery)
								
				objStringBuilder.Append _
							"<h3><a id='teamgenoten'>Teamgenoten " & SafeEncode(strPlayerName) & "</a></h3>" & _
							"<table class='result'>" & _
								"<thead><tr><th>Team</th><th>Seizoen</th><th>Teamrating*</th><th>Teamgenoten</th></tr></thead>" & vbCrLf & _
								"<tbody>"
				
				Dim lngTeamId, blnFirstTeamMember, lngTotalTeamRating, lngTeamPlayerCount, strTeamMembers, strChartSeason
				
				lngTeamId = -1
				blnFirstTeamMember = True
				lngTotalTeamRating = 0
				lngTeamPlayerCount = 0
				strTeamMembers = ""
				
				
				Dim arrSeasons(), arrTeamRatings(), lngTeamRatingCount
				lngTeamRatingCount = 0
				
				While Not rsPlayerData.EOF
					If lngTeamId <> rsPlayerData("team_id").Value Then
						If lngTeamId <> -1 Then
							objStringBuilder.Append _
									"<td>"
						
							If lngTeamPlayerCount <> 0 Then
								objStringBuilder.Append _
										Round( lngTotalTeamRating / lngTeamPlayerCount + 0.0001 )
										
								Redim Preserve arrSeasons(lngTeamRatingCount)
								Redim Preserve arrTeamRatings(lngTeamRatingCount)
								
								arrSeasons(lngTeamRatingCount) = strChartSeason
								arrTeamRatings(lngTeamRatingCount) = Round( lngTotalTeamRating / lngTeamPlayerCount + 0.0001 )
								
								lngTeamRatingCount = lngTeamRatingCount + 1
							Else
								objStringBuilder.Append "-"
							End If
							
							objStringBuilder.Append _
									"</td>"
							
							objStringBuilder.Append _
									"<td>" & _
										strTeamMembers & _
									"</td>" & _
								"</tr>" & vbCrLf
								
						End If
					
						If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
					
						lngTeamId = rsPlayerData("team_id").Value
						blnFirstTeamMember = True
						
						lngTotalTeamRating = 0
						lngTeamPlayerCount = 0
						strTeamMembers = ""
						strChartSeason = rsPlayerData("season_year").Value & " " & IIF(rsPlayerData("season_period").Value=1,"vj","nj")
						
						objStringBuilder.Append _
							"<tr class='" & strRowClass & "'>" & _
								"<td><a href='team.asp?id=" & lngTeamId & "'>" & SafeEncode(rsPlayerData("club_name").Value) & " " & rsPlayerData("team_number").Value & "</a></td>" & _
								"<td>" & _
									SafeEncode(rsPlayerData("season_year").Value) & _
									" (" & SafeEncode(IIF(rsPlayerData("season_period").Value=1,"voorjaar","najaar")) & ")" & _
								"</td>"							
					End If
					
					If rsPlayerData("rating").Value <> -9999 Then
						lngTotalTeamRating = lngTotalTeamRating + rsPlayerData("rating").Value
						lngTeamPlayerCount = lngTeamPlayerCount + 1
					End If
					
					If strBondsNummer <> rsPlayerData("player_nr").Value Then
						If Not blnFirstTeamMember Then strTeamMembers = strTeamMembers & ", "
						
						blnFirstTeamMember = False
						
						strTeamMembers = strTeamMembers & "<a href='player_details.asp?text=" & rsPlayerData("player_nr").Value & "'>" & SafeEncode(rsPlayerData("player_name").Value) & "</a>"
					End If
					
					rsPlayerData.MoveNext
				Wend
				
				objStringBuilder.Append _
						"<td>"
			
				If lngTeamPlayerCount <> 0 Then
					objStringBuilder.Append _
							Round( lngTotalTeamRating / lngTeamPlayerCount + 0.0001 )
							
					Redim Preserve arrSeasons(lngTeamRatingCount)
					Redim Preserve arrTeamRatings(lngTeamRatingCount)

					arrSeasons(lngTeamRatingCount) = strChartSeason
					arrTeamRatings(lngTeamRatingCount) = Round( lngTotalTeamRating / lngTeamPlayerCount + 0.0001 )
					
					lngTeamRatingCount = lngTeamRatingCount + 1
				Else
					objStringBuilder.Append "-"
				End If
				
				objStringBuilder.Append _
						"</td>"
				
				objStringBuilder.Append _
						"<td>" & _
							strTeamMembers & _
						"</td>" & _
					"</tr>" & vbCrLf & _
				"</tbody></table>" & _
				"<p>* Teamrating op basis van gemiddelde rating spelers in team</p>" & _
				"<p>&nbsp;</p>"

				If lngTeamRatingCount > 0 Then				
					Dim temp
									
					For lngIndex = LBound(arrTeamRatings) To UBound(arrTeamRatings) / 2
						temp = arrSeasons(lngIndex)
						arrSeasons(lngIndex) = arrSeasons(UBound(arrTeamRatings)-lngIndex)
						arrSeasons(UBound(arrTeamRatings)-lngIndex) = temp
					
						temp = arrTeamRatings(lngIndex)
						arrTeamRatings(lngIndex) = arrTeamRatings(UBound(arrTeamRatings)-lngIndex)
						arrTeamRatings(UBound(arrTeamRatings)-lngIndex) = temp
					Next
					
					objStringBuilder.Append "<h3><a id='teamratings'>Teamratings</a></h3>" & vbCrLf	
					objStringBuilder.Append "<p><table><tr><td>" & makechart("", arrTeamRatings, arrSeasons, arrColors, "#eeeeee", 1, 250, 50, true, arrTeamRatings)
					objStringBuilder.Append "</td></tr></table></p>"
								
					objStringBuilder.Append "<p><b>Betekenis kleuren:</b> <span style='color:blue;'>Heren</span> / <span style='color:magenta;'>Dames</span> / " & _
											"<span style='color:green;'>Jongens</span> / <span style='color:red;'>Meisjes</span>" & _
											"</p>" & _
											"<p>&nbsp;</p>"
				End If
											
				strResult = objStringBuilder.ToString()
			
											
				Set objStringBuilder = Nothing			
			End If			
			
			Set objDA = Nothing
		End If
	End If
		
	strPage = "Spelers"
	strMetaDescription = "Alle resultaten van " & strPlayerName & " in een handig overzicht. Bekijk het verloop van resultaten, percentages, ratings en licenties"
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<span style="margin:10px;padding:6px;width:auto;background-color:white;border:1px solid #ccc;">
				Ga naar:
				<a href="#resultaten" class="free">Resultaten</a> |
				<a href="#progressie" class="free">Progressie</a> |
<% If strWikiUrl <> "" Then %>				
				<a href="#wiki" class="free">Wiki</a> |
<% End If %>
				<a href="#teamgenoten" class="free">Teamgenoten</a> |
				<a href="#teamratings" class="free">Teamratings</a>
				</span>
				<div style="margin:10px;"><% Response.Write strResult %></div>
			</div>
						
<!-- #include file="views/footer.asp" -->