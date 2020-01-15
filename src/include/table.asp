<%
	Function CreateTableHead(ByRef arrTableColumns, ByVal strURL, ByVal lngSortField, ByVal lngSortDir)
		Dim arrTableColumn
	
		CreateTableHead = 	"<thead>" & _
								"<tr>" 
								
				For lngIndex = LBound(arrTableColumns) To UBound(arrTableColumns)
					arrTableColumn = arrTableColumns(lngIndex)
					
					If arrTableColumn(0) <> 0 Then
						CreateTableHead = CreateTableHead & _
									"<th width='" & arrTableColumn(0) & "px'>"
					Else
						CreateTableHead = CreateTableHead & "<th>"
					End If
					
					If arrTableColumn(2) <> "" Then
						CreateTableHead = CreateTableHead & _
										"<a href='" & strURL & "&amp;f=" & lngIndex
					
						If lngIndex = lngSortField And lngSortDir = -1 Then CreateTableHead = CreateTableHead & "&amp;d=1"
					
						CreateTableHead = CreateTableHead & _
										"'>" & _
											SafeEncode( arrTableColumn(1) ) & _
										"</a>"
										
						If lngIndex = lngSortField And strSortDir = "DESC" Then CreateTableHead = CreateTableHead & " v"
						If lngIndex = lngSortField And strSortDir = "ASC" Then CreateTableHead = CreateTableHead & " ^"
					Else
						CreateTableHead = CreateTableHead & _
											SafeEncode( arrTableColumn(1) )
					End If
										
					CreateTableHead = CreateTableHead & _
									"</th>" & vbCrLf
				Next
				
				CreateTableHead = CreateTableHead & _
								"</tr>" & _
							"</thead>"
	End Function							
%>