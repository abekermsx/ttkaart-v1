<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/db.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="include/stringbuilder.asp" -->
<!-- #include file="views/search.asp" -->
<%
	blnShowFaceBook = True
	strPage = "Wiki"
	strMetaDescription = "Overzicht van alle tafeltennissers en tafeltennisverenigingen met Wikipediapagina's"
	
	Dim objDA, rsPlayers, rsClubs, objStringBuilder, strPlayers, strClubs, strRowClass
	
	Set objDA = New DbHandler
	objDA.OpenDataBase(strConnectionString)
	
	Set rsPlayers = objDA.GetRecordSet("SELECT id, player_name, player_nr FROM Player WHERE wiki_url<>'' AND wiki_active=true ORDER BY player_name ASC")
	Set rsClubs = objDA.GetRecordSet("SELECT id, club_name FROM Club WHERE wiki_url<>'' ORDER BY club_name ASC")
	
	Set objStringBuilder = New StringBuilder
	
	strRowClass = "odd"
	While Not rsPlayers.EOF
		If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
					
		objStringBuilder.Append _
			"<tr class='"&strRowClass&"'>" & _
				"<td><a href='player_details.asp?text=" & rsPlayers("player_nr").Value & "'>" & SafeEncode(rsPlayers("player_name").Value) & "</td>" & _
			"</tr>"
	
		rsPlayers.MoveNext
	Wend
	
	strPlayers = objStringBuilder.ToString()
	
	Set objStringBuilder = Nothing
	
	
	Set objStringBuilder = New StringBuilder
	
	strRowClass = "odd"
	While Not rsClubs.EOF
		If strRowClass = "even" Then strRowClass="odd" Else strRowClass="even"
					
		objStringBuilder.Append _
			"<tr class='"&strRowClass&"'>" & _
				"<td><a href='club_seasons.asp?id=" & rsClubs("id").Value & "'>" & SafeEncode(rsClubs("club_name").Value) & "</td>" & _
			"</tr>"
	
		rsClubs.MoveNext
	Wend
	
	strClubs = objStringBuilder.ToString()
	
	Set objStringBuilder = Nothing
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<table cellspacing="0"><tr><td>
				<div class="floatmain">
<h1>Wiki</h1>
<table width="100%" cellpadding="4" class='result'>
	<tr>
		<td width="50%"><b>Spelers</b></td>
		<td width="50%"><b>Verenigingen</b></td>
	</tr>
	<tr>
		<td style="vertical-align:top;">
			<table class='result' width="100%" cellpadding="1"><%=strPlayers%></table>
		</td>
		<td style="vertical-align:top;">
			<table class='result' width="100%" cellpadding="1"><%=strClubs%></table>
		</td>
	</tr>
</table>		
				</div>

<!-- #include file="views/sidebar.asp" -->
				</td></tr></table>
			</div>
			
<!-- #include file="views/footer.asp" -->