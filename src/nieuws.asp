<% @LANGUAGE="VBScript" %>
<% Option Explicit %>
<!-- #include file="include/data.asp" -->
<!-- #include file="include/functions.asp" -->
<!-- #include file="views/search.asp" -->
<%
	blnShowFaceBook = True
	strPage = ""
	strMetaDescription = "Overzicht van nieuwsitems op ttkaart.nl"
%>
<!-- #include file="views/header.asp" -->

			<div class="maincontent">
				<table cellspacing="0"><tr><td>
				<div class="floatmain">
				    <h1>Nieuws</h1>
					<p>
						<table>		
							<tr><td width="80px" valign="top">08/12/2013 :</td><td>Alle persoonlijke resultaten najaar 2013 online!</td></tr>
							<tr><td valign="top">06/11/2013 :</td><td>Basisratings najaar 2013 bijgewerkt!</td></tr>
							<tr><td valign="top">24/10/2013 :</td><td>Tussentijdse resultaten najaar 2013 online!</td></tr>
							<tr><td valign="top">18/09/2013 :</td><td>Basisratings Pupillen B/C/D afdeling West t/m najaar 2009 gecorrigeerd!</td></tr>
							<tr><td valign="top">26/05/2013 :</td><td>Alle definitieve persoonlijke resultaten voorjaar 2013 online!</td></tr>
							<tr><td valign="top">05/05/2013 :</td><td>Wikipedia-pagina's spelers en verenigingen toegevoegd!</td></tr>
							<tr><td valign="top">24/04/2013 :</td><td>Persoonlijke resultaten voorjaar 2013 online!</td></tr>
							<tr><td valign="top">08/12/2012 :</td><td>Persoonlijke resultaten najaar 2012 online!</td></tr>
							<tr><td valign="top">26/10/2012 :</td><td>Verenigingen voorzien van links naar website en social media</td></tr>
							<tr><td valign="top">18/10/2012 :</td><td>Tussentijdse resultaten najaar 2012 online!</td></tr>
							<tr><td valign="top">01/09/2012 :</td><td>Officieuze teamratings toegevoegd</td></tr>		
							<tr><td valign="top">14/06/2012 :</td><td>ttkaart.nl voldoet aan nieuwe wetgeving omtrent cookie-gebruik</td></tr>		
							<tr><td valign="top">28/05/2012 :</td><td>Definitieve persoonlijke resultaten voorjaar 2012 online!</td></tr>
							<tr><td valign="top">23/04/2012 :</td><td>Pagina <a href="http://www.facebook.com/ttkaart" class="free" target="_blank">ttkaart.nl</a> op facebook aangemaakt</td></tr>
							<tr><td valign="top">23/04/2012 :</td><td>Persoonlijke resultaten voorjaar 2012 online!</td></tr>
							<tr><td valign="top">14/03/2012 :</td><td>Tussentijdse resultaten voorjaar 2012 online!</td></tr>
							<tr><td valign="top">18/12/2011 :</td><td>Basisratings najaar 2011 bijgewerkt!</td></tr>
							<tr><td valign="top">11/12/2011 :</td><td>Persoonlijke resultaten najaar 2011 online!</td></tr>
							<tr><td valign="top">02/11/2011 :</td><td>Tussentijdse resultaten najaar 2011 online!</td></tr>
							<tr><td valign="top">25/04/2011 :</td><td>Basisratings toegevoegd aan tabellen en grafieken</td></tr>
							<tr><td valign="top">20/04/2011 :</td><td>Persoonlijke resultaten voorjaar 2011 online!</td></tr>
							<tr><td valign="top">17/03/2011 :</td><td>Tussentijdse resultaten voorjaar 2011 online!</td></tr>
							<tr><td valign="top">06/12/2010 :</td><td>Persoonlijke resultaten najaar 2010 online!</td></tr>
							<tr><td valign="top">23/10/2010 :</td><td>Tussentijdse resultaten najaar 2010 online!</td></tr>
							<tr><td valign="top">18/10/2010 :</td><td>Resultaten Gelre (najaar 2009/voorjaar 2010) online!</td></tr>
							<tr><td valign="top">11/08/2010 :</td><td>Resultaten Limburg (voorjaar 2010) online!</td></tr>
							<tr><td valign="top">09/08/2010 :</td><td>Resultaten junioren ZuidWest (voorjaar 2010) online!</td></tr>
							<tr><td valign="top">04/07/2010 :</td><td>Resultaten voorjaar 2010 online!</td></tr>
							<tr><td valign="top">07/04/2010 :</td><td>Tussentijdse voorjaar 2010 online!</td></tr>
							<tr><td valign="top">13/01/2010 :</td><td>Statistieken senioren Midden najaar 2009 online!</td></tr>
							<tr><td valign="top">29/12/2009 :</td><td>Meer statistieken najaar 2009 online!</td></tr>
							<tr><td valign="top">29/12/2009 :</td><td>Volg ttkaart.nl op twitter: <a href="http://twitter.com/ttkaart/" class="free" target="_blank">twitter.com/ttkaart</a></td></tr>
							<tr><td valign="top">16/10/2009 :</td><td>Statistieken najaar 2009 toegevoegd</td></tr>
							<tr><td valign="top">18/09/2009 :</td><td>Statistieken 5 seizoenen landelijke competitie toegevoegd</td></tr>
							<tr><td valign="top">26/07/2009 :</td><td>Statistieken afdeling Zuid-West gedeeltelijk toegevoegd</td></tr>
							<tr><td valign="top">17/07/2009 :</td><td>Statistieken nu ook beschikbaar op <a href="http://www.hyves.nl/gadgetgallery/450/Tafeltennisresultaten/" class="free" target="_blank">hyves</a>!</td></tr>
							<tr><td valign="top">28/05/2009 :</td><td>Statistieken senioren Midden toegevoegd</td></tr>
							<tr><td valign="top">25/05/2009 :</td><td>Statistieken junioren Midden toegevoegd</td></tr>
							<tr><td valign="top">17/05/2009 :</td><td>Statistieken DDW-competitie Limburg toegevoegd</td></tr>
							<tr><td valign="top">04/05/2009 :</td><td>Statistieken Duo-competitie West toegevoegd</td></tr>
							<tr><td>01/05/2009 :</td><td>Statistieken Limburg toegevoegd</td></tr>
							<tr><td>28/04/2009 :</td><td>Resultaten voorjaar 2009 toegevoegd</td></tr>
							<tr><td valign="top">24/02/2009 :</td><td>Resultaten Eredivise najaar 2008 toegevoegd</td></tr>
							<tr><td>17/02/2009 :</td><td>Contactformulier toegevoegd</td></tr>
							<tr><td>15/02/2009 :</td><td>Nieuwe layout</td></tr>
							<tr><td>01/02/2009 :</td><td>Progressie spelers toegevoegd</td></tr>
							<tr><td>01/02/2009 :</td><td>Ratings &amp; licenties toegevoegd</td></tr>
							<tr><td>01/02/2009 :</td><td>Overzicht spelers per vereniging</td></tr>
							<tr><td>01/02/2009 :</td><td>Zoeken op speler/vereniging</td></tr>
							<tr><td>18/01/2009 :</td><td>Site online!</td></tr>
						</table>
						<br />
					</p>					
				</div>

<!-- #include file="views/sidebar.asp" -->
				</td></tr></table>
			</div>
			
<!-- #include file="views/footer.asp" -->