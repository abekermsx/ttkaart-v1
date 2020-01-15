<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="views/search.asp" -->
<!-- #include file="views/combobox.asp" -->
<%
	strPage = "Tools"
	
%>
<!-- #include file="views/header.asp" -->

		<div class="maincontent">
			<table cellspacing="0"><tr><td>
			<div class="floatmain">
				<h1>Percentage naar rating</h1>
				<h1>Rating naar percentage</h1>
				<p>
					
					<table cellspacing="0">
						<tr>
							<td width="100px">Rating:</td>
							<td><input type="text" id="rating" name="rating" value="" size="4" maxlength="4" /></td>
						</tr>
						<tr>
							<td>Competitie:</td>
							<td><% =CreateComboBox("competition", Array("Heren","Dames","Jongens","Meisjes"), null, "", "onchange='changeRegionList();'")%></td>
						</tr>
						<tr>
							<td>Regio</td>
							<td>
								<% =CreateComboBox("region", Array("Holland Noord", "Limburg", "Midden", _
																"Noord","Noord/Drenthe", "Noord/Friesland", "Noord/Groningen", _
																"Oost","Oost/Ijsselstreek", "Oost/Twente", "Oost/Zwolle", _
																"West", "Landelijk"), null, "", "") %>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><input type="button" value="bereken" onclick="displayPercentageList();" /></td>
						</tr>

					</table>
				</p>
				<p id="percentagelist">&nbsp;</p>
			</div>
		
<!-- #include file="views/sidebar.asp" -->
		</td></tr></table>
		
		</div>			
		
		<script type="text/javascript" src="js/ratings.js"></script>
		
<!-- #include file="views/footer.asp" -->