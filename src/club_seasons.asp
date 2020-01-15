<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="include/db.asp" -->
<!-- #include file="include/table.asp" -->
<!-- #include file="include/stringbuilder.asp" -->
<!-- #include file="views/search.asp" -->
<%
	Dim objDA
	Dim lngClubId, strClubName
	Dim lngIndex
	Dim strResult, strQuery, strClubClause, rsClubData, strClubNames
	Dim lngSortField, lngSortDir, strSortDir
	Dim arrTableColumns, arrTableColumn
	Dim strRowClass
	Dim objStringBuilder
	Dim lngWikiId, strWikiUrl, strWikiLink, strWikiText
	
	arrTableColumns = Array(	Array(100, "Seizoen", "season_year ?, season_period ?", "DESC", "ASC"), _
								Array(0, "Teams", "tc ?", "DESC", "ASC"), _
								Array(0, "Speelnamen", "", "DESC", "ASC")  )
							
	If Len(Request.QueryString) > 0 Then
		lngClubId = CLng(Request.QueryString("id"))
		lngWikiId = -1
		
		lngSortField = GetIntFromQueryString("f")
		If lngSortField = -1 Then lngSortField = 0
		
		arrTableColumn = arrTableColumns(lngSortField)
		
		lngSortDir = GetIntFromQueryString("d")
		If lngSortDir = -1 Then strSortDir = arrTableColumn(3) Else strSortDir = arrTableColumn(4)
			
		Set objDA = New DbHandler
		objDA.OpenDataBase(strConnectionString)
				
		Set rsClubData = objDA.GetRecordSet("SELECT id FROM Club WHERE id=" & lngClubId)
		
		If rsClubData.EOF Then
			strResult = "De gegevens van de opgevraagde vereniging zijn niet meer via deze link in te zien."
			strMetaDescription = strResult
			Response.Status = "404 Not found"
		Else
			strClubClause = GetClubClause(lngClubId)
			strClubNames = GetClubNames(lngClubId)				
			
			strQuery = "SELECT Club.id As ClubId, club_name, website, twitter, facebook, hyves, nttb, wiki_url, season_year, season_period, Season.id As SeasonId, COUNT(Team.id) as tc" & _
						" FROM Club, Team, Poule, Season" & _
						" WHERE " & strClubClause & _
						" AND Club.id=Team.club_id" & _
						" AND Team.poule_id=Poule.id" & _
						" AND Poule.season_id=Season.id" & _
						" GROUP BY season_year, season_period, Season.id, Club.id, club_name, website, twitter, facebook, hyves, nttb, wiki_url"
						
			If lngSortField = 0 Then strQuery = strQuery & " ORDER BY " & Replace(arrTableColumn(2),"?", strSortDir)
						
			Set rsClubData = objDA.GetRecordSet(strQuery)
		
			If lngSortField = 1 Then rsClubData.Sort = "tc " & strSortDir
			
			strClubName = rsClubData("club_name").Value
		
			Set objStringBuilder = New StringBuilder
			
			objStringBuilder.Append _
						"<h3>Clubgegevens</h3>" & _
						"<table>" & _
							"<tr><td><b>Vereniging:</b></td><td>" & SafeEncode(strClubName) & "</td></tr>"
						
			If rsClubData("website").Value <> "" Then
				objStringBuilder.Append _		
							"<tr><td><b>Website:</b></td><td>" & DisplayUrlLink(rsClubData("website").Value) & "</td></tr>"
			End If
			
			If rsClubData("twitter").Value <> "" Then
				objStringBuilder.Append _				
							"<tr>" & _
								"<td style=""vertical-align:top;""><b>Twitter:</b></td>" & _
								"<td><a href="""&rsClubData("twitter").Value&""" target=""_blank""><img src=""/images/icon_twitter.png"" alt=""Twitter account " & SafeEncode(strClubName) & """ style=""vertical-align:middle;"" /></a> " & DisplayUrlLink(rsClubData("twitter").Value) & "</td>" & _
							"</tr>"
			End If
			
			If rsClubData("facebook").Value <> "" Then
				objStringBuilder.Append _		
							"<tr>" & _
								"<td style=""vertical-align:top;""><b>Facebook:</b></td>" & _
								"<td><a href="""&rsClubData("facebook").Value&""" target=""_blank""><img src=""/images/icon_facebook.png"" alt=""Facebook pagina " & SafeEncode(strClubName) & """ style=""vertical-align:middle;"" /></a> " & DisplayUrlLink(rsClubData("facebook").Value) & "</td>" & _
							"</tr>"
			End If
			
			' If rsClubData("hyves").Value <> "" Then
				' objStringBuilder.Append _	
							' "<tr>" & _
								' "<td style=""vertical-align:top;""><b>Hyves:</b></td>" & _
								' "<td><a href="""&rsClubData("hyves").Value&""" target=""_blank""><img src=""/images/icon_hyves.png"" alt=""Hyves pagina " & SafeEncode(strClubName) & """ style=""vertical-align:middle;"" /></a> " & DisplayUrlLink(rsClubData("hyves").Value) & "</td>" & _
							' "</tr>"
			' End If
			
			' If rsClubData("nttb").Value <> "" Then
				' objStringBuilder.Append _	
							' "<tr>" & _
								' "<td style=""vertical-align:top;""><b>NTTB:</b></td>" & _
								' "<td><a href="""&rsClubData("nttb").Value&""" target=""_blank""><img src=""/images/icon_nttb.png"" alt=""NTTB pagina " & SafeEncode(strClubName) & """ style=""vertical-align:middle;"" /></a></td>" & _
							' "</tr>"
			' End If
			objStringBuilder.Append "[[wiki]]"
			
			objStringBuilder.Append _
						"</table>" & _
						"<br />"		
			
			objStringBuilder.Append strClubNames
										
			objStringBuilder.Append _
						"<h3>Overzicht seizoenen " & SafeEncode(strClubName) & "</h3>" & vbCrLf & _				
						"<table class=""result"">" & vbCrLf & _ 
							CreateTableHead(arrTableColumns,"club_seasons.asp?id="&lngClubId,lngSortField,lngSortDir) & _
							"<tbody>"
				
			While Not rsClubData.EOF
				If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
				
				Dim lngTeamCount, lngSeasonid, lngSeasonYear, lngSeasonPeriod, blnLoop
				
				lngTeamCount = rsClubData("tc").Value
				lngClubId = rsClubData("ClubId").Value
				lngSeasonId = rsClubData("SeasonId").Value
				lngSeasonYear = rsClubData("season_year").Value
				lngSeasonPeriod = rsClubData("season_period").Value
				strClubNames = rsClubData("club_name").Value
				
				If Not IsNull(rsClubData("wiki_url").Value) Then
					If rsClubData("wiki_url").Value <> "" Then lngWikiId = lngClubId
				End If
				
				blnLoop = True
				
				While blnLoop				
					rsClubData.MoveNext
					If rsClubData.EOF Then
						blnLoop = False
					Else
						If lngWikiId = -1 Then
							If Not IsNull(rsClubData("wiki_url").Value) Then
								If rsClubData("wiki_url").Value <> "" Then lngWikiId = rsClubData("ClubId").Value
							End If
						End If
						
						If rsClubData("SeasonId").Value <> lngSeasonId Then
							blnLoop = False
						Else
							lngTeamCount = lngTeamCount + rsClubData("tc").Value
							strClubNames = strClubNames & ", " & rsClubData("club_name").Value
						End If
					End If
				Wend					
				
				objStringBuilder.Append _
								"<tr class="""&strRowClass&""">" & _
									"<td>" & _
										"<a href=""club_players.asp?id=" & lngClubId & "&amp;season=" & lngSeasonId & """>" & _
											lngSeasonYear & " " & IIF(lngSeasonPeriod=1,"voorjaar", "najaar") & _
										"</a>" & _
									"</td>" & _ 
									"<td>" & lngTeamCount & "</td>" & _ 
									"<td>" & strClubNames & "</td>" & _ 
								"</tr>" & vbCrLf
			
			Wend
			
			objStringBuilder.Append _
							"</tbody></table>"
			
			strResult = objStringBuilder.ToString()
			
			Set objStringBuilder = Nothing
			
			strMetaDescription = "Overzicht van alle seizoenen waarin spelers van de club " & strClubName & " deelgenomen hebben aan de tafeltenniscompetitie"
		End If
				
		If lngWikiId <> -1 Then
			Set rsClubData = objDA.GetRecordSet("SELECT id, wiki_url, wiki_text FROM Club WHERE id=" & lngWikiId)
			
			strWikiUrl = "http://nl.wikipedia.org/wiki/" & rsClubData("wiki_url").Value
			strWikiLink = rsClubData("wiki_url").Value
			strWikiText = rsClubData("wiki_text").Value
			
			strWikiLink = Replace(strWikiLink, "_", " ")
			If InStr(strWikiLink, "(") > 0 Then strWikiLink = Left(strWikiLink, InStr(strWikiLink, "(")-1)
			
			strResult = Replace(strResult, "[[wiki]]", _
							"<tr>" & _
								"<td style=""vertical-align:top;""><b>Wikipedia:</b></td>" & _
								"<td><a href="""&strWikiUrl&""" target=""_blank""><img src=""/images/icon_wikipedia.png"" alt=""Wikipedia pagina " & SafeEncode(strClubName) & """ style=""vertical-align:middle;"" /></a> " & _
									DisplayUrlLink(strWikiUrl) & "</td>" & _
							"</tr>")
		Else
			strResult = Replace(strResult, "[[wiki]]", "")			
		End If
		
		Set objDA = Nothing
	End If
	
	blnShowFaceBook = True
	strPage = "Verenigingen"
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<table><tr><td>
				<div class="floatmain">
					<% Response.Write strResult %>
					<p>&nbsp;</p>
				</div>
<% 	If strWikiLink <> "" Then %>				
					<div class="wiki" style="float:left;width:675px;">
<h3><%=strWikiLink%></h3>	
<%=strWikiText%>

<hr />
<p>
Lees het originele artikel op <a class="free" href="<%=strWikiUrl%>" target="_blank"><%=strWikiUrl%></a><br /><br />
<small>
De tekst is beschikbaar onder de licentie <a class="free" href="http://creativecommons.org/licenses/by-sa/3.0/deed.nl" target="_blank">Creative Commons Naamsvermelding/Gelijk delen</a>,
 er kunnen aanvullende voorwaarden van toepassing zijn. Zie de <a class="free" href="http://wikimediafoundation.org/wiki/Gebruiksvoorwaarden" target="_blank">gebruiksvoorwaarden</a> voor meer informatie.
</small>
</p>
					</div>
<% End If %>
				
				</td></tr></table>
			</div>
						
<!-- #include file="views/footer.asp" -->