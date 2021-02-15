USING System
USING System.Collections.Generic
USING System.ComponentModel
USING System.Data
USING System.Drawing
USING System.Text
USING System.Windows.Forms
USING System.IO
USING XSharp




BEGIN NAMESPACE FabDBFEd
	PUBLIC PARTIAL CLASS BrowseWindow ;
		INHERIT System.Windows.Forms.Form
	PRIVATE fields AS List<STRING>
	PRIVATE fieldDefs AS List<STRING>
	PRIVATE oDT AS System.Data.DataTable
		PUBLIC CONSTRUCTOR() STRICT //BrowseWindow
			InitializeComponent()
			SELF:statusLabel:Text := ""
			SELF:listViewFields:AfterEdit += System.Windows.Forms.LabelEditEventHandler{ SELF, @listViewFields_AfterLabelEdit() }
		RETURN
		PUBLIC METHOD OpenDBF(fileName AS STRING, rdd AS STRING ) AS LOGIC
			LOCAL row AS DataRow
			LOCAL fieldDef AS STRING
			LOCAL Result AS LOGIC
            // Open the File, and keep it open
			Result := FALSE
			// Create a DataTable
			oDT := DataTable{ Path.GetFileName(fileName )}
			fields := List<STRING>{}
			fieldDefs := List<STRING>{}
			// Open the File, and keep it open
			// THe CLosing event will take care of that
			TRY
					DbUseArea(TRUE, rdd,fileName, fileName+DateTime.Now:ToString())
					// Create the Columns
					FOR VAR i := 1 UPTO FCount()
						// Add a column to the DataTable...Always a Type String
						oDT:Columns:Add( FIELDNAME((DWORD)i), TYPEOF(STRING) )
						// Create a String with the Field Definition
						fields:Add( FIELDNAME((DWORD)i) )
						fieldDef := FIELDNAME((DWORD)i)
						VAR infoType := DbFieldInfo( DBS_TYPE, i ) 
						fieldDef += "," + infoType:ToString()
						VAR infoLen := DbFieldInfo( DBS_LEN, i ) 
						fieldDef += "," + infoLen:ToString()
						VAR infoDec := DbFieldInfo( DBS_DEC, i ) 
						fieldDef += "," + infoDec:ToString()
						// Save the Field Definition
						fieldDefs:Add( fieldDef )
						// listViewFields is the ListView shown in the "Fields View" TabControl Page
						// Create a Field definition Information text
						LOCAL lvi AS ListViewItem
						lvi := ListViewItem{}
						lvi:SubItems:Add( fieldDef )
						// and add it to that TabControl Page
						SELF:listViewFields:Items:Add( lvi )
					NEXT
					// Add special info column
					oDT:Columns:Add( "_FabDBFED_", TYPEOF(INT) )
					// Add Deleted and RecNo cols
					oDT:Columns:Add( "Deleted", TYPEOF(STRING) )
					oDT:Columns:Add( "RecNo", TYPEOF(STRING) )
					// Now load the DataTable with data
					DbGotop()
					DO WHILE ! EOF()
						// Create a new row
						row := oDT:NewRow()
						//
						row["_FabDBFED_"] := DataRowState.Unchanged
						row["RecNo"] := AsString( RecNo() )
						row["Deleted"] := IIF( Deleted(), "*", " " )
						// Put data into the columns in the row
						FOR VAR i := 1 UPTO fields.Count
							row[ fields[i-1] ] := AsString(FieldGet(i))
						NEXT
						// Add the row to the table
						oDT:Rows:Add(row)
						// Move to next record
						DbSkip()
					ENDDO
					oDT:AcceptChanges()
					// Now attach the DataTable to the DataGridView as DataSource
					SELF:dbfBrowseView:DataSource := oDT
					// Hide the specials columns
					SELF:dbfBrowseView:Columns["_FabDBFED_"]:Visible := FALSE
					SELF:dbfBrowseView:Columns["Deleted"]:Visible := FALSE
				SELF:dbfBrowseView:Columns["RecNo"]:Visible := FALSE
				Result := TRUE
			CATCH ex AS Exception
				MessageBox.Show( ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error )
				
			END TRY
		RETURN Result
		
		
		PRIVATE METHOD dbfBrowseView_RowEnter(sender AS OBJECT, e AS System.Windows.Forms.DataGridViewCellEventArgs) AS VOID STRICT
			LOCAL row AS DataGridViewRow
			// Get the current row
			row := SELF:dbfBrowseView:Rows[ e:RowIndex ]
			FOR VAR i := 1 UPTO fields.Count
				LOCAL lvi AS ListViewItem
				lvi := SELF:listViewFields:Items[ i-1 ]
				lvi:Text := row:Cells[ fields[i-1] ]:Value:ToString()
			NEXT
			//
			SELF:statusLabel:Text := "RecNo : " + row:Cells[ "RecNo"]:Value:ToString() + " / " + "Deleted : " + row:Cells[ "Deleted"]:Value:ToString()
		RETURN
		PRIVATE METHOD leftButton_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
		IF SELF:dbfBrowseView:CurrentRow != NULL
			LOCAL rowIndex := SELF:dbfBrowseView:CurrentRow:Index - 1 AS INT
			IF rowIndex >= 0
				LOCAL nextRow := SELF:dbfBrowseView:Rows[rowIndex] AS DataGridViewRow
				// 
				SELF:dbfBrowseView:CurrentCell := nextRow:Cells[0]
				END IF        
			ENDIF
		RETURN
		PRIVATE METHOD rightButton_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
		IF SELF:dbfBrowseView:CurrentRow != NULL
			LOCAL rowIndex := SELF:dbfBrowseView:CurrentRow:Index + 1 AS INT
			IF rowIndex <= SELF:dbfBrowseView:Rows:Count - 1
				LOCAL nextRow := SELF:dbfBrowseView:Rows[rowIndex] AS DataGridViewRow
				// 
				SELF:dbfBrowseView:CurrentCell := nextRow:Cells[0]
				END IF
			ENDIF
		RETURN
		PRIVATE METHOD topButton_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			IF SELF:dbfBrowseView:Rows:Count > 0
				LOCAL nextRow := SELF:dbfBrowseView:Rows[0] AS DataGridViewRow
				// 
				SELF:dbfBrowseView:CurrentCell := nextRow:Cells[0]
			ENDIF
		RETURN
		PRIVATE METHOD bottomButton_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			IF SELF:dbfBrowseView:Rows:Count > 0
				LOCAL nextRow := SELF:dbfBrowseView:Rows[SELF:dbfBrowseView:Rows:Count - 1] AS DataGridViewRow
				// 
				SELF:dbfBrowseView:CurrentCell := nextRow:Cells[0]
			ENDIF
		RETURN
		PRIVATE METHOD appendButton_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			LOCAL lastRecNo AS INT
			//
			IF SELF:dbfBrowseView:Rows:Count > 0
					LOCAL lastRow := SELF:dbfBrowseView:Rows[SELF:dbfBrowseView:Rows:Count - 1] AS DataGridViewRow
				lastRecno := Convert.ToInt32(lastRow:Cells[ "RecNo"]:Value )
			ELSE
				LastRecno := 0
			ENDIF
			//
			LOCAL newRow := oDT:NewRow() AS DataRow
			//
			newRow["_FabDBFED_"] := DataRowState.Added
			newRow[ "RecNo" ]:= AsString( LastRecno+1 )
			newRow[ "Deleted" ] := " "
			oDT:Rows:Add( newRow )
			//
			LOCAL nextRow := SELF:dbfBrowseView:Rows[SELF:dbfBrowseView:Rows:Count - 1] AS DataGridViewRow
			// 
			SELF:dbfBrowseView:CurrentCell := nextRow:Cells[0]
		RETURN
		PRIVATE METHOD deleteButton_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			IF SELF:dbfBrowseView:CurrentRow != NULL
				LOCAL isDel := SELF:dbfBrowseView:CurrentRow:Cells["Deleted"]:Value:ToString() AS STRING
				IF isDel == "*"
					isDel := " "
				ELSE
					isDel := "*"
				ENDIF
				SELF:dbfBrowseView:CurrentRow:Cells["Deleted"]:Value := isDel
				SELF:statusLabel:Text := "RecNo : " +  SELF:dbfBrowseView:CurrentRow:Cells[ "RecNo"]:Value:ToString() + " / " + "Deleted : " +  SELF:dbfBrowseView:CurrentRow:Cells[ "Deleted"]:Value:ToString()
			ENDIF
		RETURN
		PRIVATE METHOD listViewFields_AfterLabelEdit(sender AS OBJECT, e AS System.Windows.Forms.LabelEditEventArgs) AS VOID STRICT
			//
			IF ( e:Label == NULL )
				RETURN
			ENDIF
			IF SELF:dbfBrowseView:CurrentRow != NULL
				// This is the Number of the Label that has been edited, so for us, the Field Number
				//  We have the fields, then : FabDFBED, Deleted, Recno
				SELF:dbfBrowseView:CurrentRow:Cells[ e:Item ]:Value := e:Label
				SELF:dbfBrowseView:CurrentRow:Cells[ "_FabDBFED_" ]:Value := DataRowState.Modified
			ENDIF
		RETURN
		PRIVATE METHOD BrowseWindow_FormClosing(sender AS OBJECT, e AS System.Windows.Forms.FormClosingEventArgs) AS VOID STRICT
			LOCAL RecNo AS INT
			LOCAL irs AS INT
			//
			TRY
				FOREACH row AS DataRow IN SELF:oDT:Rows
					// Internal row State
					irs := Convert.ToInt32( row["_FabDBFED_"] )
					IF ( irs != DataRowState.Unchanged )
						SWITCH irs
							CASE DataRowState:Added
								//
								DbAppend()
								FOR VAR i := 1 TO fields:Count
									LOCAL fieldValue AS STRING
									fieldValue := row:Item[i]:ToString()
									//
									FieldPut( i, fieldValue )
								NEXT
							CASE DataRowState:Modified
								// Go to the corresponding Record
								RecNo := Convert.ToInt32(row["RecNo"])
								DbGoto( RecNo )
								// Now, get the Data in the row and push changes
								// First, Deleted ?
								IF row["Deleted"]:ToString() == "*"
									DbDelete()
								ELSE
									DbRecall()
								ENDIF
								// Now, what about Fields Value ?
								FOR VAR i := 1 TO fields:Count
									LOCAL fieldValue AS STRING
									fieldValue := row:Item[i]:ToString()
									//
									FieldPut( i, fieldValue )
								NEXT
						END
					ENDIF
				NEXT
			CATCH
			END TRY
			// Close the DBF file
			DbCloseArea()
			RETURN
			
		END class 
END NAMESPACE
