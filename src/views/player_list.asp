<%
	Dim arrPlayerTableColumns

	arrPlayerTableColumns = Array(	Array(0,"Bondsnr.","player_nr ?", "ASC","DESC"), _
									Array(220,"Speler","player_name ?", "ASC", "DESC"), _
									Array(0,"Vereniging",""), _
									Array(0,"", "", "ASC", "DESC")  )
								
	Function BuildPlayerList(ByRef rsPlayerData, ByVal lngSortField, ByVal lngSortDir, ByVal strPlayerName)
		Dim objStringBuilder, strRowClass, strClubListing, strBondsnummer, strWikiUrl, strWikiUrlText, blnNextPlayer
		Dim objPlayerId, objPlayerNr, objPlayerName, objPlayerClub, objPlayerWikiUrl, objPlayerWikiActive
		
		Set objStringBuilder = New StringBuilder
		
		objStringBuilder.Append _
						"<h3>Gevonden spelers</h3>" & _				
						"<table class='result'>" & _
							CreateTableHead(arrPlayerTableColumns,"player_list.asp?text="&Server.URLEncode(strPlayerName),lngSortField,lngSortDir) & _
							"<tbody>"
									
		Set objPlayerId = rsPlayerData("id")
		Set objPlayerNr = rsPlayerData("player_nr")
		Set objPlayerName = rsPlayerData("player_name")
		Set objPlayerClub = rsPlayerData("club_name")
		Set objPlayerWikiUrl = rsPlayerData("wiki_url")
		Set objPlayerWikiActive = rsPlayerData("wiki_active")
									
		While Not rsPlayerData.EOF
			If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
			
			objStringBuilder.Append _
								"<tr class='"&strRowClass&"'>" & _
									"<td><a href='player_details.asp?text=" & objPlayerNr & "'>" & SafeEncode(objPlayerNr) & "</a></td>" & _
									"<td><a href='player_details.asp?text=" & objPlayerNr & "'>" & SafeEncode(objPlayerName) & "</a></td>"
									
			strClubListing = "<a href='club_seasons.asp?id="&rsPlayerData("id").Value&"'>" & SafeEncode(objPlayerClub) & "</a>"
			strBondsnummer = objPlayerNr
			strWikiUrl = ""
			If objPlayerWikiActive Then strWikiUrl = objPlayerWikiUrl
			
			rsPlayerData.MoveNext
			
			blnNextPlayer = False
						
			While Not blnNextPlayer
				If Not rsPlayerData.EOF Then
					If strBondsNummer = objPlayerNr Then
						If strWikiUrl = "" And objPlayerWikiActive Then
							strWikiUrl = objPlayerWikiUrl
						End If
					
						strClubListing = strClubListing & ", " & "<a href='club_seasons.asp?id="&objPlayerId&"'>" & SafeEncode(objPlayerClub) & "</a>"
						rsPlayerData.MoveNext
					Else
						blnNextPlayer = True
					End If
				Else
					blnNextPlayer = True
				End If
			Wend
			
			objStringBuilder.Append _					
									"<td>" & strClubListing & "</td>" & _
									"<td>"
				
			If strWikiUrl <> "" Then
				strWikiUrlText = "Wikipedia pagina " & SafeEncode(Replace(strWikiUrl, "_", " "))
				objStringBuilder.Append _
					"<a href='http://nl.wikipedia.org/wiki/"&strWikiUrl&"' target='_blank' title='" & strWikiUrlText & "'><img src='/images/icon_wikipedia.png' alt='" & strWikiUrlText & "' style='vertical-align:middle;' /></a>"
			End If
			
			objStringBuilder.Append _
									"</td>" & _
								"</tr>" & vbCrLf
		Wend
		
		objStringBuilder.Append _
						"</tbody></table>"
						
		BuildPlayerList = objStringBuilder.ToString()
		
		Set objStringBuilder = Nothing
	End Function

%>