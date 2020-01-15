<%
function makechart(title, numarray, labelarray, color, bgcolor, bordersize, maxheight, maxwidth, addvalues, baseratings) 
	'Function makechart version 3

	'Jason Borovoy
	'title: Chart Title
	'numarray: An array of values for the chart
	'labelarray: An array of labels coresponding to the values must me present
	'color If null uses different colors for bars if not null all bars color you specify
	'bgcolor Background color.
	'bordersize: border size or 0 for no border.
	'maxheight: maximum height for chart not including labels
	'maxwidth: width of each column
	'addvalues: true or false depending if you want the actual values shown on the chart
	'when you call the function use : response.write makechart(parameters)

	'actually returnstring would be a better name
	dim tablestring 
	'max value is maximum table value
	dim max 
	'maxlength maximum length of labels
	dim maxlength
	dim tempnumarray
	dim templabelarray
	dim heightarray
	Dim colorarray
	'value to multiplie chart values by to get relitive size 
	Dim multiplier
	Dim stuff, counter, count
	Dim correction
	
	Set tablestring = New StringBuilder
	
	'if data valid
	if maxheight > 0 and maxwidth > 0 and ubound(labelarray) = ubound(numarray) then
		'colorarray: color of each bars if more bars then colors loop through
		'if you don't like my choices change them, add them, delete them.
		colorarray = color	'array("red","blue","yellow","navy","orange","purple","green")
		templabelarray = labelarray
		tempnumarray = numarray
		heightarray = array()
		max = -9999
		maxlength = 0
		correction = 0
		
		tablestring.Append "<TABLE style='background-color:" & bgcolor & ";border:" & bordersize & "px solid grey;'>" & _
							"<tr><td><TABLE style='border:1px solid white;'>" & vbCrLf
		
		'get maximum value
		for each stuff in tempnumarray
			if stuff > max then max = stuff
			if stuff < correction then correction = stuff
		next
		
		for each stuff in baseratings
			if stuff > max then max = stuff
			if stuff < correction then correction = stuff
		next
		
		correction = -correction
		max = max + correction
	
		'calculate multiplier
		if max=0 Then max=1
		
		multiplier = maxheight/max
	
		'populate array
		for counter = 0 to ubound(tempnumarray)
			if tempnumarray(counter) = max then 
				redim preserve heightarray(counter)
				heightarray(counter) = maxheight+correction
			else
				redim preserve heightarray(counter) 
				heightarray(counter) = (tempnumarray(counter)+correction) * multiplier 
			end if 
		next 

		'set title 
		tablestring.Append	"<TR><TH colspan='" & ubound(tempnumarray)+1 & "'>" & _
							"<FONT FACE='Verdana, Arial, Helvetica' SIZE='1'><U>" & title & "</U></FONT></TH></TR>" & _
							vbCrLf & "<TR>" & vbCrLf
	
		dim d
		
		'loop through values
		for counter = 0 to ubound(tempnumarray) 
			tablestring.Append "<TD valign='bottom' align='center' >" & _
								"<FONT FACE='Verdana, Arial, Helvetica' SIZE='1'>"

			if addvalues then tablestring.Append "<BR>" & tempnumarray(counter)
			
			d = CLng( round( heightarray(counter)-((baseratings(counter)+correction)*multiplier),2) )
			
			tablestring.Append "<table border='0' cellpadding='0' width='" & maxwidth & "'>" & _
								"<tr><td valign='bottom' bgcolor='" 
		
			tablestring.Append colorarray(counter)
			
			tablestring.Append "' height='" & d & "'><span></span>" & _
								"</td></tr></table>"
			
			If baseratings(counter) <> 0 Then
				tablestring.Append "<table border='0' cellpadding='0' width='" & maxwidth & "' style='border-top:1px solid black;'>" & _
									"<tr><td valign='bottom' bgcolor='" 
			
				if colorarray(counter) = "black" Then
					tablestring.Append colorarray(counter)
				Else
					tablestring.Append "dark" & colorarray(counter)
				End If
				
				tablestring.Append "' height='" & _
									CLng(round(baseratings(counter)*multiplier,2)) & "'>&nbsp;" & _
									"</td></tr></table>"
			End If
			
			tablestring.Append "</FONT></TD>" & vbCrLf
		next

		tablestring.Append "</TR>" & vbCrLf
		
		'calculate max lenght of labels
		for each stuff in labelarray
			if len(stuff) >= maxlength then maxlength = len(stuff)
		next
		
		'print labels and set each to maxlength
		tablestring.Append "<tr>"
		
		for each stuff in labelarray
			tablestring.Append "<TD align='center'><FONT FACE='Verdana, Arial, Helvetica' SIZE='1'><B>" 
			tablestring.Append stuff 
			tablestring.Append "</B></FONT></TD>" & vbCrLf
		next
		
		tablestring.Append "</tr>"
		tablestring.Append "</TABLE></td></tr></table>" & vbCrLf
		
		makechart = tablestring.ToString()
	else
		Response.Write "Error Function Makechart: maxwidth and maxlength have to be greater " & _
						" then 0 or number of labels not equal to number of values"
	end if 
end function
%>