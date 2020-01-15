			<div>&nbsp;</div>
			<div class="footer">
				<p>Ontwikkeld door <a href="contact.asp" class="free">Arjan Bakker</a></p>
				<p>Grafisch ontwerp door <a href="contact.asp" class="free">Arjan Bakker &amp; Antwa-chan </a></p>
			</div>
		</div>
	</body>
</html>
<%
	lngEndTimer = Timer
	
	Response.Write "<!-- Generated at " & dtmStartDate & " -->" & vbCrLf
	Response.Write "<!-- Generated in " & FormatNumber(lngEndTimer-lngStartTimer,10) & " seconds -->"
%>