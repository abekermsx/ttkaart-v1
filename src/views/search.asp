<%
	Sub DisplaySearchForm(ByVal strSearchTerm)
		Dim strStyle
		
		If strSearchTerm = "" Then
			strSearchTerm = "Bondsnummer, achternaam of vereniging"
			strStyle = "style=""color:#aaa;font-style:italic;width:263px;"""
		Else
			strStyle = "style=""width:263px;"""			
		End If
%>
		<form name="search" method="get" action="search.asp">
			<input type="text" name="text" maxlength="50" value="<%=strSearchTerm%>" <%=strStyle%> onfocus="setInput();" onblur="releaseInput();" />
			<input type="submit" name="submit" value="zoeken" />		
		</form>
<%	
	End Sub
%>	