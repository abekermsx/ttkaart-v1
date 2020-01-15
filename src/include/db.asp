<%
	' db.asp
	' Arjan Bakker
	' arjan@newnerds.com
	' Class for handling database operations

	Class DbHandler
		Private cnnConnection		'connection to database to use
		Private cmdCommand			'command object to use, will be instantiated
		Private arrRecordSets()     'collection of all opende recordsets


       	'initialise variables used
		Private Sub Class_Initialize
			Set cnnConnection = Nothing   
			Set cmdCommand = Nothing
			Redim arrRecordSets(0)
		End Sub


		'clean up data
		Private Sub Class_Terminate
			If Not (cnnConnection Is Nothing) Then CloseDataBase()
		End Sub


		'open database
		Public Sub OpenDataBase( ByVal strDataBase )
      		If Not (cnnConnection Is Nothing) Then CloseDataBase()

			Set cnnConnection = Server.CreateObject("ADODB.Connection")

			cnnConnection.ConnectionString = strDataBase
			cnnConnection.CursorLocation = 3	'adUseClient

			cnnConnection.Open()
		End Sub


		'close database and clean up data
		Public Sub CloseDatabase()
			CloseRecordSets()				'close all opened recordsets

			cnnConnection.Close()           'close connection
				             
			Set cmdCommand = Nothing
			Set cnnConnection = Nothing
		End Sub

                  
		' Execute a command
		Public Function ExecuteCommand( ByRef objQuery )

			objQuery.cmdCommand.ActiveConnection = cnnConnection
			Set ExecuteCommand = objQuery.cmdCommand.Execute()

		End Function


		' Execute a query
		' strQuery: query to execute
       Public Sub ExecuteQuery( strQuery )
       		If cmdCommand Is Nothing Then
				Set cmdCommand = Server.CreateObject("ADODB.Command")
				cmdCommand.ActiveConnection = cnnConnection
			End If

			cmdCommand.CommandText = strQuery

			cmdCommand.Execute()

		End Sub
		

		' Get records from database
		' strQuery: query to execute
       Public Function GetRecordSet( strQuery )
       		If cmdCommand Is Nothing Then
				Set cmdCommand = Server.CreateObject("ADODB.Command")
				cmdCommand.ActiveConnection = cnnConnection
			End If
		'Response.write(strQuery & "<br />")
			cmdCommand.CommandText = strQuery

			Set GetRecordSet = cmdCommand.Execute()

            ReDim Preserve arrRecordSets( UBound(arrRecordSets) + 1 )

            Set arrRecordSets( UBound(arrRecordSets)-1 ) = GetRecordSet

		End Function


		' Get records from database
		' strQuery: query to execute
		' intCursorType: cursortype
		' intLockType: locktype
		' intOptions: options
    	Public Function GetRecordSetEx( strQuery, intCursorType, intLockType, intOptions )
			Set GetRecordSetEx = Server.CreateObject("ADODB.RecordSet")

			GetRecordSetEx.Open strQuery, cnnConnection, intCursorType, intLockType, intOptions
		'Response.write(strQuery & "<br />")
            ReDim Preserve arrRecordSets( UBound(arrRecordSets) + 1 )

            Set arrRecordSets( UBound(arrRecordSets)-1 ) = GetRecordSetEx

		End Function
		

		' Insert data into a table
		' strTable: name of table to insert data to
		' arrFields: Array with names of fields to set
		' arrParams: Array with data to set fields with
        Public Sub InsertRecord( strTable, arrFields, arrParams )
			Dim rs

			Set rs = Server.CreateObject("ADODB.RecordSet")
			rs.ActiveConnection = cnnConnection
			rs.PageSize = 1
			rs.Open strTable,,1,3,2	'adCmdTable
	
			rs.AddNew arrFields, arrParams
		    rs.Update
	
			rs.Close
			Set rs = Nothing
		End Sub


		' Insert data into a table
		' strTable: name of table to insert data to
		' arrFields: Array with names of fields to set
		' arrParams: Array with data to set fields with
		' intId: name of identifier to get
		Public Function InsertRecordId( strTable, arrFields, arrParams, intId )
			Dim rs
			
			Set rs = Server.CreateObject("ADODB.RecordSet")
			rs.ActiveConnection = cnnConnection

			rs.LockType = 2
			rs.Source = "SELECT * FROM " & strTable & " WHERE " & intId & "=0"
			rs.Open()

			rs.AddNew arrFields, arrParams

		    rs.Update
	
			InsertRecordId = rs(intId)
	
			rs.Close
			Set rs = Nothing
		End Function


		'update records
		'table: name of table(s) to update records in
		'fields: array with names of fields to updates
		'params: array with data to set
		'cond: selection condition
		Public Sub UpdateRecords( ByVal table, ByVal fields, ByVal params, ByVal cond )
			Dim strFields, strField, rs, intIndex
	
			cond = Replace(cond,"'","''")

			Set rs = Server.CreateObject("ADODB.RecordSet")
			rs.ActiveConnection = cnnConnection
			rs.PageSize = 1
	                            
			If cond = "" Then
				rs.Open "SELECT * FROM " & table,,1,3,1 	'adCmdText
			Else			
				rs.Open "SELECT * FROM " & table & " WHERE " & cond,,1,3,1 	'adCmdText
			End If

			While not rs.EOF
			   	For intIndex = 0 To UBound(fields)
			   		rs( fields(intIndex) ) = params(intIndex)
			   	Next

				rs.Update()
				rs.MoveNext
			Wend

			rs.Close()
			Set rs = Nothing
		End Sub


		'close a recordset
		Public Sub CloseRecordSet( ByRef rs )
			If Not (rs Is Nothing) Then
				rs.Close()
				
				Dim intIndex
				
				For intIndex = 0 To UBound(arrRecordSets) - 1
				    If arrRecordSets(intIndex) Is rs Then
				    	Set arrRecordSets(intIndex) = Nothing  
				    	
				    	Exit Sub
				    End If
				Next

				Set rs = Nothing
			End If
		End Sub


		'close all recordsets
		Private Sub CloseRecordSets()
			Dim intIndex

			For intIndex = 0 To UBound(arrRecordSets) - 1
			
				If Not (arrRecordSets(intIndex) Is Nothing) Then
					arrRecordSets(intIndex).Close()
			    	Set arrRecordSets(intIndex) = Nothing
				End If

			Next

			ReDim arrRecordSets(0)
		End Sub


	End Class
%>