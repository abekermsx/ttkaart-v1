<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="views/search.asp" -->
<%
	If Request.QueryString("allow") = "yes" Then
		Response.Cookies("allowcookies") = "yes"
		Response.Cookies("allowcookies").Domain = ".ttkaart.nl"
		Response.Cookies("allowcookies").Expires = Date + (20*365)
		
		Response.Redirect "default.asp"
	End If
	
	strPage = ""
	strMetaDescription = "Wettelijk verplichte pagina met informatie over gebruik van cookies door ttkaart.nl"
	
	blnIsCookiePage = True
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">			
				<table cellspacing="0"><tr><td>
				<div class="floatmain">

<h1>Informatie omtrent gebruik cookies op ttkaart.nl</h1>
<p>					
Op 5 juni 2012 is de nieuwe Telecomwet van kracht geworden. Volgens deze wet dienen websites haar bezoekers te informeren over de informatie die zij middels cookies op de 
computers van haar bezoekers wilt opslaan en haar bezoekers toestemming te vragen alsvorens deze informatie op te slaan.
</p>
<p>
ttkaart.nl maakt, indien u daar toestemming voor geeft, gebruik van services van onderstaande derde partijen, welke cookies plaatsen op uw computer.
<table>
	<tr>
		<td valign="top"><b>Facebook</b></td>
		<td>
			Om gebruikers van Facebook de mogelijkheid te gegeven ttkaart.nl te 'liken' plaatst Facebook een cookie op uw computer.
			Facebook krijgt hiermee de mogelijkheid om bij te houden welke sites haar leden én niet-leden bezoeken.
		</td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr>
		<td valign="top"><b>Google Analytics</b></td>
		<td>
			Om de kwaliteit van ttkaart.nl te kunnen verbeteren wordt gebruik gemaakt van Google Analytics. 
			Om gebruikers van elkaar te kunnen onderscheiden, wordt een cookie op uw computer geplaatst.
			Hiermee kunnen wij het gebruik van ttkaart.nl door haar bezoekers in kaart brengen en de website optimaliseren.		
		</td>
	</tr>
</table>
</p>
<p>
	Klik op één van onderstaande links om aan te geven of u ttkaart.nl wel of niet toestemming geeft voor het plaatsen van cookies op uw computer.
</p>
<p>
	<a href="cookies.asp?allow=yes" class="free">Ja, ik geef ttkaart.nl toestemming voor het plaatsen van cookies</a>
	<br /><br />
	<a href="default.asp" class="free">Nee, ik wil niet dat ttkaart.nl cookies plaatst op mijn computer </a>
</p>
				</div>

<!-- #include file="views/sidebar.asp" -->
				</td></tr></table>
			</div>
			
<!-- #include file="views/footer.asp" -->