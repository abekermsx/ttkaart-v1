<%

	Function CalculateLicense(ByVal lngRating, ByVal strRegion, ByVal lngCategory)
		Dim arr, lngIndex
		
		CalculateLicense = "-"
		
		If lngCategory = 2 Then Exit Function
		If lngRating = -9999 Then Exit Function
		
		If strRegion = "Landelijk Dames" Then
		'	arr = Array(515,360,290,210,-10000)
'			arr = Array(525,380,310,230,-10000) ' t/m najaar 2011?
			arr = Array(505,415,345,255,185,-10000) ' maar kan F licentie bij dames?
		Else
		'	arr = Array(660,540,485,395,325,235,165,-10000)
			arr = Array(660,560,505,415,345,255,185,-10000)
		End If
		
		lngIndex = 0
		
		While arr(lngIndex) > lngRating
			lngIndex = lngIndex + 1
		Wend
		
		CalculateLicense = Chr(65+lngIndex)	
	End Function
	
%>