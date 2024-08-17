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
	PUBLIC PARTIAL CLASS BrowseWindow2 ;
			INHERIT System.Windows.Forms.Form
		PRIVATE fields AS List<STRING>
		PRIVATE oDT AS System.Data.DataTable
			
		PUBLIC CONSTRUCTOR() STRICT //BrowseWindow
			InitializeComponent()
			SELF:statusLabel:Text := ""
			SELF:fields := List<STRING>{}
			RETURN
			
		PUBLIC METHOD OpenDBF(fileName AS STRING, rdd AS STRING ) AS LOGIC
			//LOCAL row AS DataRow
			//LOCAL fieldDef AS STRING
			LOCAL Result AS LOGIC
			// Open the File, and keep it open
			Result := FALSE
			// The CLosing event will take care of that
			TRY
				// Create a Dbf Alias based on fileName AND the current Date Time
				DbUseArea(TRUE, rdd,fileName, fileName+DateTime.Now:ToString())
				//
				oDT := FabDbDataTable()
				// Now attach the DataTable to the DataGridView as DataSource
				SELF:dbfBrowseView:DataSource := oDT
				// Special behaviour for the Deleted Column
				SELF:dbfBrowseView:Columns[0]:ReadOnly := TRUE
				SELF:dbfBrowseView:Columns[0]:Frozen := TRUE
				SELF:dbfBrowseView:Columns[0]:Width := 15
				//
				Result := TRUE
			CATCH ex AS Exception
				MessageBox.Show( ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error )
			END TRY
			RETURN Result
			
			
		PRIVATE METHOD dbfBrowseView_RowEnter(sender AS OBJECT, e AS System.Windows.Forms.DataGridViewCellEventArgs) AS VOID STRICT
			LOCAL row AS DataGridViewRow
			LOCAL dtRow AS FabDbDataRow
			// Get the current row
			row := SELF:dbfBrowseView:Rows[ e:RowIndex ]
			dtRow := (FabDbDataRow)((DataRowView)row.DataBoundItem).Row
			//
			SELF:statusLabel:Text := "RecNo : " + dtRow:RecNo:ToString() + " / " + "Deleted : " + IIF( row:Cells[ "Deleted"]:Value:ToString()=="*", "Yes", "")
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
			//LOCAL lastRecNo AS INT
			//
			//LastRecno := 0
			//
			LOCAL newRow := oDT:NewRow() AS DataRow
			//
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
				//
				SELF:dbfBrowseView:Columns[0]:Readonly := FALSE
				SELF:dbfBrowseView:CurrentRow:Cells["Deleted"]:Value := isDel
				
				SELF:dbfBrowseView:Columns[0]:Readonly := TRUE
				//
				LOCAL row AS DataGridViewRow
				LOCAL dtRow AS FabDbDataRow
				// Get the current row
				row := SELF:dbfBrowseView:CurrentRow
				dtRow := (FabDbDataRow)((DataRowView)row.DataBoundItem).Row        
				SELF:statusLabel:Text := "RecNo : " + dtRow:RecNo:ToString() + " / " + "Deleted : " + IIF( row:Cells[ "Deleted"]:Value:ToString()=="*", "Yes", "")
			ENDIF
			RETURN
			
		PRIVATE METHOD BrowseWindow_FormClosing(sender AS OBJECT, e AS System.Windows.Forms.FormClosingEventArgs) AS VOID STRICT
			//
			TRY
				FOREACH row AS FabDbDataRow IN SELF:oDT:Rows
					// Internal row State
					SWITCH row:RowState
					CASE DataRowState.Added
						//
						DbAppend()
						FOR VAR i := 1 TO fields:Count
							//
							FieldPut( i, row:Item[i+1] )
						NEXT
					CASE DataRowState.Modified
						// Go to the corresponding Record
						DbGoto( row:RecNo )
						// Now, get the Data in the row and push changes
						// First, Deleted ?
						IF row["Deleted"]:ToString() == "*"
							DbDelete()
						ELSE
							DbRecall()
						ENDIF
						// Now, what about Fields Value ?
						FOR VAR i := 1 TO fields:Count
							//
							FieldPut( i, row:Item[i+1] )
						NEXT
					END
				NEXT
            Catch
                NOP
			END TRY
			// Close the DBF file
			DbCloseArea()
			RETURN
		PRIVATE METHOD dbfBrowseView_CellFormatting(sender AS OBJECT, e AS System.Windows.Forms.DataGridViewCellFormattingEventArgs) AS VOID STRICT
			// Deleted Column ?
			IF (e:ColumnIndex == 0 )
				IF SELF:oDT:Rows[ e:RowIndex ]:Item[0]:ToString() == "*"
					e.CellStyle.BackColor := Color.Black
				ELSE
					// So we don't see the "*" char
					e.CellStyle.BackColor := Color.White
					e.CellStyle.ForeColor := Color.White
				ENDIF
			ENDIF
			RETURN
		PRIVATE METHOD dbfBrowseView_EditingControlShowing(sender AS OBJECT, e AS System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) AS VOID STRICT
			IF SELF:dbfBrowseView:CurrentCell != NULL .AND. e:Control IS DataGridViewTextBoxEditingControl
				// Move caret to the last non space char
				LOCAL currentTextBox AS System.Windows.Forms.DataGridViewTextBoxEditingControl
				// :( Doesn't seems to work...
				currentTextBox := (DataGridViewTextBoxEditingControl)e:Control
				//
				currentTextBox:Text := currentTextBox:Text:TrimEnd()
				currentTextBox:PrepareEditingControlForEdit(false)
				//            VAR moveTo := currentTextBox:Text:TrimEnd():Length
				//            currentTextBox:SelectionStart := 0
				//            currentTextBox:SelectionLength := 1
				//            currentTextBox:Focus()
				//            currentTextBox:ScrollToCaret()
			ENDIF
			RETURN
			
	END CLASS 
END NAMESPACE
