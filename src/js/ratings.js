

	var ratingsSeniors =
						[ 
							{ 	r:"Landelijk Heren", 
								l:[ {n:"eredivisie",r:575}, {n:"1e divisie",r:525}, {n:"2e divisie",r:475}, {n:"3e divisie",r:425} ] },
							{	r:"Landelijk Dames",
								l:[ {n:"eredivisie#",r:410}, {n:"1e divisie",r:340}, {n:"2e divisie#",r:230}, {n:"3e divisie#",r:180} ] },
							{	r:"Oost", l:[ {n:"hoofdklasse",r:375} ] },
							{	r:"Oost/Zwolle",
								l:[ {n:"1e klasse",r:320},{n:"2e klasse",r:260},{n:"3e klasse",r:200},{n:"4e klasse",r:160},{n:"5e klasse",r:120},{n:"6e klasse",r:75} ] },
							{	r:"Oost/Ijsselstreek",
								l:[ {n:"1e klasse",r:325},{n:"2e klasse",r:275},{n:"3e klasse",r:225},{n:"4e klasse",r:180},{n:"5e klasse",r:130},{n:"6e klasse",r:75} ] },
							{	r:"Oost/Twente",
								l:[ {n:"1e klasse",r:320},{n:"2e klasse",r:260},{n:"3e klasse",r:200},{n:"4e klasse",r:160},{n:"5e klasse",r:120},{n:"6e klasse",r:75} ] },
							{	r:"Noord",
								l:[ {n:"noordelijke 1e divisie",r:375},{n:"noordelijke 2e divisie",r:325} ] },
							{	r:"Noord/Groningen",
								l:[ {n:"1e klasse",r:300},{n:"2e klasse",r:250},{n:"3e klasse",r:200},{n:"4e klasse",r:160},{n:"5e klasse",r:100},{n:"6e klasse",r:75} ] },
							{	r:"Noord/Drenthe",
								l:[ {n:"1e klasse",r:300},{n:"2e klasse",r:250},{n:"3e klasse",r:200},{n:"4e klasse",r:160},{n:"5e klasse",r:100},{n:"6e klasse",r:75} ] },
							{	r:"Noord/Friesland",
								l:[ {n:"1e klasse",r:290},{n:"2e klasse",r:230},{n:"3e klasse",r:180},{n:"4e klasse",r:160},{n:"5e klasse",r:75} ] },
							{	r:"West",
								l:[ {n:"hoofdklasse",r:375},{n:"1e klasse",r:325},{n:"2e klasse",r:275},{n:"3e klasse",r:225},{n:"4e klasse",r:180},{n:"5e klasse",r:130},{n:"6e klasse",r:75} ] },
							{	r:"Holland Noord",
								l:[ {n:"hoofdklasse",r:375},{n:"1e klasse",r:325},{n:"2e klasse",r:275},{n:"3e klasse",r:225},{n:"4e klasse",r:180},{n:"5e klasse",r:140},{n:"6e klasse",r:90},{n:"7e klasse",r:50} ] },
							{	r:"Midden",
								l:[ {n:"hoofdklasse",r:375},{n:"1e klasse",r:325},{n:"2e klasse",r:275},{n:"3e klasse",r:225},{n:"4e klasse",r:180},{n:"5e klasse",r:130},{n:"6e klasse",r:75} ] },
							{	r:"Limburg",
								l:[ {n:"hoofdklasse",r:375},{n:"1e klasse",r:325},{n:"2e klasse",r:275},{n:"3e klasse",r:225},{n:"4e klasse",r:170},{n:"5e klasse",r:120} ] },
						]
						
	var ratingsJuniors =
						[
							{	r:"Landelijk Jongens",
								l:[ {n:"kampioensgroep",r:390},{n:"landelijk a",r:340},{n:"landelijk b",r:300},{n:"landelijk c",r:250} ] },
							{	r:"Landelijk Meisjes",
								l:[	{n:"kampioensgroep",r:230},{n:"landelijk a",r:180},{n:"landelijk b#",r:100} ] },
							{	r:"Oost",
								l:[ {n:"hoofdklasse",r:210},{n:"1e klasse",r:160},{n:"2e klasse",r:120},{n:"3e klasse",r:70},{n:"4e klasse",r:20},{n:"5e klasse",r:-10},{n:"pupillen/welpenklasse",r:-40} ] },
							{	r:"Noord",
								l:[	{n:"noordelijke jeugd divisie",r:210},{n:"1e klasse",r:160},{n:"2e klasse",r:120},{n:"3e klasse",r:70},{n:"4e klasse",r:30},{n:"pupillen",r:-10}] },
							{	r:"West",
								l:[	{n:"hoofdklasse",r:225},{n:"1e klasse",r:190},{n:"2e klasse",r:155},{n:"3e klasse",r:105},{n:"4e klasse",r:55},{n:"5e klasse",r:5},
									{n:"pupillen a",r:105},{n:"pupillen b",r:55},{n:"pupillen c",r:5},{n:"pupillen d",r:-25} ] },
							{	r:"Holland Noord",
								l:[	{n:"hoofdklasse",r:225},{n:"1e klasse",r:190},{n:"2e klasse",r:140},{n:"3e klasse",r:90},{n:"4e klasse",r:40},{n:"5e klasse",r:-10},{n:"6e klasse",r:-40}] },
							{	r:"Midden",
								l:[	{n:"1e klasse",r:210},{n:"2e klasse",r:140},{n:"3e klasse",r:90},{n:"4e klasse",r:-10},{n:"6e klasse",r:-40}] },
							{	r:"Limburg",
								l:[	{n:"hoofdklasse",r:225},{n:"1e klasse",r:190},{n:"2e klasse",r:155},{n:"3e klasse",r:105},{n:"4e klasse",r:55},{n:"6e klasse",r:5}] }
						]

					
	function calculateRating(p,r,l)
	{
		var a;
		var i = 0;
		var r;
		
		if ( document.getElementById("competition").selectedIndex<2 )
			a = ratingsSeniors;
		else
			a = ratingsJuniors;
				
		while ( a[i].r != r ) i++;
			
		a = a[i].l;
		
		i = 0;
		
		while ( a[i].n.replace(/#/gi,"") != l )	i++;
		
		r = a[i].r;
		
		if ( a[i].n.indexOf("#")>0 )
		{
			r = r + 2 * p;
		}
		else
		{
			if ( p < 25 )
				r = r + 2 * p;
			else if ( p < 75 )
				r = r + p + 25;
			else
				r = r + 2 * p - 50;
		}
		
		return r;
	}
	
	
		

	function createPercentageList(rating,region)
	{
		var result = "";
		var a;
		var i = 0;
		var p;
		var br;
				
		if ( document.getElementById("competition").selectedIndex<2 )
			a = ratingsSeniors;
		else
			a = ratingsJuniors;

		while ( a[i].r != region ) i++;
			
		a = a[i].l;
		
		for ( i = 0; i < a.length; i++ )
		{
			br = a[i].r;
			
			if ( rating < br )
				p = 0;
			else if ( a[i].n.indexOf("#") > 0 )
				p = (rating - br)/2;
			else if ( rating < br+50 )
				p = (rating - br)/2;
			else if ( rating < br+100 )
				p = rating - br - 25;
			else
				p = (rating+50-br)/2;
			
			if ( p > 100 ) p = 100;
						
			result = result + "<tr><td>" + a[i].n + "</td><td>" + p + "%</td></tr>";
		}
		
		return result.replace(/#/gi,"");
	}
	
	function displayPercentageList()
	{
		var result = "<table><tr><td><b>Klasse</b></td><td><b>Percentage</b></td>";
		var rating = parseInt(document.getElementById("rating").value);
		var competition = document.getElementById("competition").value;
		var region = document.getElementById("region").value;
				
		if ( region == "Landelijk" )
		{
			region += ( " " + competition );
		}
		else
		{
			if ( region.substr(0,9) != "Landelijk" )
				result += createPercentageList(rating, "Landelijk " + competition);
					
			if ( document.getElementById("competition").selectedIndex<2)
			{				
				if ( region.length>4 && region.substr(0,4)=="Oost" )
					result += createPercentageList(rating, "Oost");
				
				if ( region.length>5 && region.substr(0,5)=="Noord" )
					result += createPercentageList(rating, "Noord");
			}
		}
		
		result += createPercentageList(rating, region);
		
		result += "</table>";
				
		document.getElementById("percentagelist").innerHTML = result;
	}
	
				
	function setCombobox(id, items)
	{
		var options = document.getElementById(id).options;

		options.length = items.length;
		
		for ( var i = 0; i < items.length; i++ )
		{
			options[i].text=items[i];
			options[i].value=items[i];
		}
	}
	
	
	function changeRegionList()
	{
		if ( document.getElementById("competition").selectedIndex < 2 )
		{
			setCombobox( "region", [ "Landelijk", "Holland Noord", "Limburg", "Midden", 
									"Noord","Noord/Drenthe", "Noord/Friesland", "Noord/Groningen",
									"Oost","Oost/Ijsselstreek", "Oost/Twente", "Oost/Zwolle",
									"West"] );
		}
		else
		{
			setCombobox( "region", [ "Landelijk", "Holland Noord", "Limburg", "Midden", 
									"Noord",
									"Oost",
									"West"] );		
		}
	}
	
	
	