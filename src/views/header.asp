<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link rel="stylesheet" type="text/css" href="css/style.css?20130505" />
		<title>TTKAART.NL - Tafeltennis Statistieken</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="description" content="<%=strMetaDescription%>" />
		<meta name="keywords" content="ttkaart,tafeltennis,statistieken,tafeltennisstatistieken,tafeltennis statistieken,tafeltennis percentages,table tennis,ping pong,table,tennis,percentages,ratings,licenties,nttb,verenigingen,spelers,percentage,rating,licentie,vereniging,club,speler,competitie,statistics,team,poule,stats,teamrating,overzicht,lijst,progressie" />
		<meta name="robot" content="INDEX, FOLLOW"/>
		<meta property="og:title" content="ttkaart.nl" />
		<meta property="og:description" content="Dé site met tafeltennisstatistieken, overzicht van persoonlijke resultaten door de jaren heen" />
		<meta property="og:type" content="sport" />
		<meta property="og:url" content="http://www.ttkaart.nl/" />
		<meta property="og:image" content="http://www.ttkaart.nl/images/ttlogo.png" />
		<meta property="og:site_name" content="ttkaart.nl" />
		<meta property="fb:admins" content="1282899289" />		
		<script type="text/javascript" src="js/search.js"></script>
		<!--[if lt IE 7.]>
		<script defer type="text/javascript" src="js/pngfix.js"></script>
		<![endif]-->
<% If blnIsCrawler Or blnAllowCookies Then %>		
		<script type="text/javascript">
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-319985-6']);
		  _gaq.push(['_setDomainName', '.ttkaart.nl']);
		  _gaq.push(['_trackPageview']);

		  (function() {
			var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();
		</script>
<% End If %>		
	</head>
	<body>	
<% If blnIsCrawler Or blnAllowCookies Then %>
<% If blnShowFaceBook = True Then %>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=268184522773";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<% End If %>
<% End If %>

<% If blnIsCrawler = False And blnAllowCookies = False And blnIsCookiePage = False Then %>
		<div class="cookiebar">
Om alle functionaliteit van deze site te kunnen gebruiken, moet er toestemming gegeven worden voor het plaatsen van zogenaamde 'cookies'.
<a href="cookies.asp" class="free">Lees meer</a>
		</div>
<% End If %>
		<div id="container">
			<div class="header">
				<div style="width:936px;">
					<div class="logo">&nbsp;</div>
					<div class="slogan"><a href="http://www.ttkaart.nl/"><b>TTKAART.NL</b><br /><span style="font-size:10pt;font-style:italic;">tafeltennisresultaten in kaart gebracht</span></a></div>
					<div class="banner" style="text-align:right;">
						<a href="https://twitter.com/ttkaart" target="_blank" title="Volg ttkaart.nl op Twitter"><img src="/images/icon_twitter_big.png" alt="Twitter ttkaart" /></a>
						<a href="https://facebook.com/ttkaart" target="_blank" title="Bezoek de Facebookpagina van ttkaart.nl"><img src="/images/icon_facebook_big.png" alt="Facebookpagina ttkaart" /></a>
<% If 1=0 Then %>
<% If Instr(Request.ServerVariables("HTTP_HOST"), "ttkaart.nl") > 0 Then %>
<% If blnIsCrawler Or blnAllowCookies Then %>
<script type="text/javascript"><!--
google_ad_client = "ca-pub-0942512061416336";
/* Header add */
google_ad_slot = "7283311778";
google_ad_width = 468;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>		
<% End If %>			
<% End If %>
<% End If %>
					</div>
				</div>
			</div>
			<div id="navbg">
				<div style="float:left;width:34px;">&nbsp;</div>
				<a href="default.asp" <% If strPage = "Home" Then Response.Write " id=""current""" %>>Home</a>
				<a href="player_list.asp" <% If strPage = "Spelers" Then Response.Write " id=""current""" %>>Spelers</a>
				<a href="club_list.asp" <% If strPage = "Verenigingen" Then Response.Write " id=""current""" %>>Verenigingen</a>
				<a href="wiki.asp" <% If strPage = "Wiki" Then Response.Write " id=""current""" %>>Wiki</a>
				<a href="links.asp" <% If strPage = "Links" Then Response.Write " id=""current""" %>>Links</a>
				<a href="contact.asp" <% If strPage = "Contact" Then Response.Write " id=""current""" %>>Contact</a>
				<span style="position:relative;left:118px;top:3px;"><% DisplaySearchForm strSearchTerm %></span>
			</div>