<%
	Function CreateCombobox(ByVal strName, ByRef arrDisplay, ByRef arrValues, ByVal strSelected, ByVal strEventHandler)
		Dim lngIndex
	
		If IsNull(arrValues) Then arrValues = arrDisplay
	
		CreateCombobox = "<select id='" & strName & "' name='" & strName & "' " & strEventHandler & ">"
		
		For lngIndex = LBound(arrDisplay) To UBound(arrDisplay)
		
			CreateCombobox = CreateCombobox & "<option value='" & arrValues(lngIndex) & "'"
			If strSelected = arrValues(lngIndex) Then CreateCombobox = CreateCombobox & " selected='selected'"
			CreateCombobox = CreateCombobox & ">" & SafeEncode(arrDisplay(lngIndex)) & "</option>"
		
		Next		
		
		CreateCombobox = CreateCombobox & "</select>"
	
	End Function
%>