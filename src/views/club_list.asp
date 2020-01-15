<%
	Dim arrClubTableColumns
		
	arrClubTableColumns = Array( _
									Array(0,"Vereniging","club_name ?", "ASC", "DESC"), _
									Array(0,"Website", "website ?", "ASC", "DESC"), _
									Array(0,"", "", "ASC", "DESC"), _
									Array(0,"", "", "ASC", "DESC"), _
									Array(0,"", "", "ASC", "DESC") _
								)
					
	
	Function BuildClubList(ByRef rsData, lngSortField, lngSortDir, strClubName)
		Dim objStringBuilder, strRowClass, strWikiUrlText
	
		Set objStringBuilder = New StringBuilder
		
		objStringBuilder.Append _
						"<h3>Gevonden verenigingen</h3>" & _				
						"<table class=""result"">" & _
							CreateTableHead(arrClubTableColumns,"club_list.asp?text="&Server.URLEncode(strClubName),lngSortField,lngSortDir) & _
							"<tbody>"
									
		While Not rsData.EOF
			If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
			
			objStringBuilder.Append _
								"<tr class="""&strRowClass&""">" & _
									"<td><a href=""club_seasons.asp?id=" & rsData("id").Value & """>" & SafeEncode(rsData("club_name").Value) & "</a></td>" & _
									"<td style=""padding-right:40px;"">" & DisplayUrlLink(rsData("website").Value) & "</td>" & _
									"<td style=""padding-right:0px;"">"
									
			If rsData("twitter").Value <> "" Then
				objStringBuilder.Append _
					"<a href="""&rsData("twitter").Value&""" target=""_blank"" title=""Twitter " & SafeEncode(rsData("club_name").Value) & """><img src=""/images/icon_twitter.png"" alt=""Twitter account " & SafeEncode(rsData("club_name").Value) & """ style=""vertical-align:middle;"" /></a>"
			End If
			
			objStringBuilder.Append _
						"</td><td style=""padding-right:0px;"">"
						
			If rsData("facebook").Value <> "" Then
				objStringBuilder.Append _
					"<a href="""&rsData("facebook").Value&""" target=""_blank"" title=""Facebook pagina " & SafeEncode(rsData("club_name").Value) & """><img src=""/images/icon_facebook.png"" alt=""Facebook pagina " & SafeEncode(rsData("club_name").Value) & """ style=""vertical-align:middle;"" /></a>"
			End If
			
			objStringBuilder.Append _
						"</td><td style=""padding-right:0px;"">"
						
			If rsData("wiki_url").Value <> "" Then
				strWikiUrlText = "Wikipedia pagina " & SafeEncode(Replace(rsData("wiki_url").Value, "_", " "))
				objStringBuilder.Append _
					"<a href=""http://nl.wikipedia.org/wiki/"&rsData("wiki_url").Value&""" target=""_blank"" title=""" & strWikiUrlText & """><img src=""/images/icon_wikipedia.png"" alt=""" & strWikiUrlText & """ style=""vertical-align:middle;"" /></a>"
			End If
			
			' objStringBuilder.Append _
						' "</td><td style=""padding-right:0px;"">"
			
			' If rsData("hyves").Value <> "" Then
				' objStringBuilder.Append _
					' "<a href="""&rsData("hyves").Value&""" target=""_blank"" title=""Hyves pagina " & SafeEncode(rsData("club_name").Value) & """><img src=""/images/icon_hyves.png"" alt=""Hyves pagina " & SafeEncode(rsData("club_name").Value) & """ style=""vertical-align:middle;"" /></a>"
			' End If
			
			'objStringBuilder.Append _
			'			"</td><td>"
			
			' If rsData("nttb").Value <> "" Then
				' objStringBuilder.Append _
					' "<a href="""&rsData("nttb").Value&""" target=""_blank""><img src=""/images/icon_nttb.png"" alt=""NTTB pagina " & SafeEncode(strClubName) & """ style=""vertical-align:middle;"" /></a>"
			' End If
			
			objStringBuilder.Append _
						"</td>" & _
					"</tr>" & vbCrLf
		
			rsData.MoveNext
		Wend
		
		objStringBuilder.Append _
							"</tbody></table>"
		
		BuildClubList = objStringBuilder.ToString()
		
		Set objStringBuilder = Nothing
	End Function
%>