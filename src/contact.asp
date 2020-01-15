<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="views/search.asp" -->
<%
	Dim strName, strEmail, strSubject, strBody, objJMail
	
	
	If Len(Request.Form) > 0 Then

		strName = Request.Form("naam")
		strEmail = Request.Form("blurb")
		strSubject = Request.Form("subject")
		strBody = Request.Form("message")
		
		Set objJMail = Server.CreateObject("JMail.Message")

		objJMail.From = "info@ttkaart.nl"
		objJMail.AddRecipient "info@ttkaart.nl"
		objJMail.Subject = "Bericht verzonden via site"
		objJMail.Body = "Naam:" & strName & vbCrLf & _
						"Email:"  & strEmail & vbCrLf & _
						"Onderwerp:" & strSubject & vbCrLf & _
						"Bericht:" & strBody
						
		objJMail.nq()

		Set objJMail = Nothing
		
		Response.Redirect "bedankt.asp"

	Else
	
	End If
	
	blnShowFaceBook = True
	strPage = "Contact"
	strMetaDescription = "Contactpagina voor ttkaart.nl"
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<table cellspacing="0"><tr><td>
				<div class="floatmain">
					<h1>Contact</h1>

					<p>Opmerkingen? Complimenten? Suggesties? Aanvullingen op gegevens? Vul dan onderstaand formulier in om een bericht achter te laten!</p>
					<p>&nbsp;</p>
					<p>
<form method="post" action="contact.asp">
	<table>
		<tr>
			<td width="100px" style="vertical-align:top;"><b><label for="naam">Naam:</label></b></td>
			<td><input type="text" class="text" name="naam" id="naam" value="" size="35" maxlength="100" /></td>
		</tr>
		<tr>
			<td style="vertical-align:top;"><b><label for="blurb">Emailadres:</label></b></td>
			<td><input type="text" name="blurb" id="blurb" value="" size="35" maxlength="100" /></td>
		</tr>
		<tr>
			<td style="vertical-align:top;"><b><label for="subject">Onderwerp:</label></b></td>
			<td><input type="text" name="subject" id="subject" value="" size="35" maxlength="100" /></td>
		</tr>
		<tr>
			<td style="vertical-align:top;"><b><label for="message">Bericht:</label></b></td>
			<td><textarea name="message" id="message" cols="40" rows="5"></textarea></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" value="Verstuur bericht" /></td>
		</tr>
	</table>
</form>
					</p>
					<p>&nbsp;</p>
					<p>&nbsp;</p>
					<h1>Disclaimer</h1>
					<p>
Disclaimer: Aan de gegevens vermeldt op deze website kunnen geen rechten worden ontleend.<br/>
De weergegeven ratings en licenties zijn puur indicatief bedoeld. 
					</p>
					
				</div>
				
<!-- #include file="views/sidebar.asp" -->

			</td></tr></table>
			
			</div>
						
<!-- #include file="views/footer.asp" -->