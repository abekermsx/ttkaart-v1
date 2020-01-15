<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="include/db.asp" -->
<!-- #include file="include/table.asp" -->
<!-- #include file="include/stringbuilder.asp" -->
<!-- #include file="views/search.asp" -->
<!-- #include file="views/club_list.asp" -->
<%
	Dim objDA
	Dim strClubName
	Dim strError, lngIndex
	Dim strResult, strQuery, rsPlayerData
	Dim lngSortField, lngSortDir, strSortDir
	Dim arrTableColumn
	Dim objStringBuilder
	
	
	If Len(Request.QueryString) > 0 Then
		strClubName = SafeTrim(Request.QueryString("text"))
		If strClubName = "" Then strError = "Voer een clubnaam in"
		
		lngSortField = GetIntFromQueryString("f")
		If lngSortField = -1 Then lngSortField = 0
		
		arrTableColumn = arrClubTableColumns(lngSortField)
		
		lngSortDir = GetIntFromQueryString("d")
		If lngSortDir = -1 Then strSortDir = arrTableColumn(3) Else strSortDir = arrTableColumn(4)
		
		If strError = "" Then
			Set objDA = New DbHandler
			objDA.OpenDataBase(strConnectionString)
			
			If Len(strClubName)=1 Then
				strSearchTerm = Replace(strClubName,"'","''")&"%"
			Else
				strSearchTerm = "%"&Replace(strClubName,"'","''")&"%"
			End If
			
			strQuery = "SELECT id, club_name, website, twitter, facebook, hyves, nttb, wiki_url" & _
						" FROM Club" & _
						" WHERE club_name LIKE '"&strSearchTerm&"'" & _
						" ORDER BY " & Replace(arrTableColumn(2),"?", strSortDir)
						
			Set rsPlayerData = objDA.GetRecordSet(strQuery)
						
			If rsPlayerData.EOF Then
				strError = "Geen vereniging gevonden met deze naam"
			Else								
				strResult = BuildClubList(rsPlayerData, lngSortField, lngSortDir, strClubName)
			End If			
			
			Set objDA = Nothing
		End If
	End If
	
	strSearchTerm = ""
	strPage = "Verenigingen"
	strMetaDescription = "Zoek verenigingen op die in het systeem van ttkaart.nl geregistreerd zijn"
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<div style="margin:10px;">
					<p>
						<table class="list">
							<tr>
								<td>Overzicht verenigingen beginnend met:</td>
<%
	Dim strChar
	
	For strChar = Asc("A") To Asc("Z")
		Response.Write "<td><a href='club_list.asp?text="&Chr(strChar)&"'" & IIF(strClubName=Chr(strChar)," style='background-color:#bbb;padding:4px;'","") & ">"&Chr(strChar)&"</a></td>"
	Next
%>
							</tr>
						</table>
					</p>
					<p><% Response.Write strResult %></p>
					<p>&nbsp;</p>
				</div>
			</div>	
			
<!-- #include file="views/footer.asp" -->