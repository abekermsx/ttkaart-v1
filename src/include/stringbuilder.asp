<%

	Class StringBuilder
		Private arr
		Private itemCount

		Private Sub Class_Initialize()
			itemCount = 0
			ReDim arr(100)
		End Sub

		Public Sub Append(ByVal strValue)
			If itemCount > UBound(arr) Then
				ReDim Preserve arr(itemCount * 2)
			End If

			arr(itemCount) = strValue
			itemCount = itemCount + 1
		End Sub

		Public Function ToString() 
			ToString = Join(arr, "")
		End Function
	End Class
	
%>