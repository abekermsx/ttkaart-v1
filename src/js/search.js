
			function setInput()
			{
				var searchBox = document.forms.search.text;
				
				if ( searchBox.value == "Bondsnummer, achternaam of vereniging" )
				{
					searchBox.value = "";
					searchBox.style["color"] = "black";
					searchBox.style["fontStyle"] = "normal";
				}
			}
			
			function releaseInput()
			{
				var searchBox = document.forms.search.text;
				
				if ( searchBox.value == "" )
				{
					searchBox.style["color"] = "#aaa";
					searchBox.style["fontStyle"] = "italic";
					searchBox.value = "Bondsnummer, achternaam of vereniging";
				}
			}
			
			window.onload = function() {
				var searchBox = document.forms.search.text;
				
				if ( searchBox.value != "Bondsnummer, achternaam of vereniging" )
				{
					searchBox.style["color"] = "black";
					searchBox.style["fontStyle"] = "normal";
				}
			}