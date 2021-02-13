USING System
USING System.Collections.Generic
USING System.ComponentModel
USING System.Data
USING System.Drawing
USING System.Text
USING System.Windows.Forms
USING XSharp.RDD
USING XSharp.Rdd.Support
BEGIN NAMESPACE FabDBFEd
	PUBLIC PARTIAL CLASS DBFStructWindow ;
		INHERIT System.Windows.Forms.Form
	PRIVATE autoInc AS INT
	PRIVATE lFilled AS LOGIC
		
		PUBLIC CONSTRUCTOR() STRICT //DBFStructWindow
			InitializeComponent()
			//
			SELF:dbfRDD:Items:Add( "DBFVFP" )
			SELF:dbfRDD:Items:Add( "DBFCDX" )
			SELF:dbfRDD:Items:Add( "DBFNTX" )
			//
			SELF:dbfRDD:SelectedIndex := 0
			//
			SELF:autoInc := 1
		RETURN
		PRIVATE METHOD addBtn_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			LOCAL fldDlg AS FieldWindow
			fldDlg := FieldWindow{ }
			fldDlg:FillTypeCombo( SELF:dbfRDD:SelectedText )
			//
			fldDlg:FieldName := "Field" + ( SELF:autoInc++ ):ToString() 
			fldDlg:FieldType := "C"
			fldDlg:FieldLength := "10"
			fldDlg:FieldDecimals := "0"
			//
			IF fldDlg:ShowDialog() == DialogResult.Ok
				//
				LOCAL lvi AS ListViewItem
				//
				lvi := ListViewItem{ fldDlg:FieldName }
				lvi:SubItems:Add( fldDlg:FieldType )
				lvi:SubItems:Add( fldDlg:FieldLength )
				lvi:SubItems:Add( fldDlg:FieldDecimals )
				//
				SELF:fieldListView:Items:Add( lvi )
			ENDIF
		RETURN
		
		PRIVATE METHOD editBtn_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
		SELF:editField()
		
		PRIVATE METHOD editField() AS VOID STRICT			
			LOCAL sel AS INT
			LOCAL indexes := SELF:fieldListView:SelectedIndices AS ListView.SelectedIndexCollection
			//
			IF ( indexes:Count > 0 )
				LOCAL lvi AS ListViewItem
				sel := indexes[0]
				lvi := SELF:fieldListView:Items[ sel ]
				//
				LOCAL fldDlg AS FieldWindow
				fldDlg := FieldWindow{ }
				fldDlg:FillTypeCombo( SELF:dbfRDD:SelectedText )
				//
				fldDlg:FieldName := lvi:Text
				fldDlg:FieldType := lvi:SubItems[1]:Text
				fldDlg:FieldLength := lvi:SubItems[2]:Text
				fldDlg:FieldDecimals := lvi:SubItems[3]:Text
				//
				IF fldDlg:ShowDialog() == DialogResult.Ok
					//
					lvi:Text := fldDlg:FieldName
					lvi:SubItems[1]:Text := fldDlg:FieldType
					lvi:SubItems[2]:Text := fldDlg:FieldLength
					lvi:SubItems[3]:Text := fldDlg:FieldDecimals
				ENDIF
			ENDIF
			
		RETURN        
		
		PRIVATE METHOD deleteBtn_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			LOCAL sel AS INT
			LOCAL indexes := SELF:fieldListView:SelectedIndices AS ListView.SelectedIndexCollection
			//
			IF ( indexes:Count > 0 )
				sel := indexes[0]
				SELF:fieldListView:Items:RemoveAt( sel )
			ENDIF
		RETURN
		PRIVATE METHOD saveBtn_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			LOCAL sfd AS SaveFileDialog
			//
			IF SELF:lFilled
				SELF:Close()
				RETURN
			ENDIF
			IF SELF:fieldListView:Items:Count == 0
				RETURN
			ENDIF
			//
			sfd := SaveFileDialog{}
			sfd:DefaultExt := "dbf"
			sfd:Filter := "Dbf files (*.dbf)|*.dbf|All files (*.*)|*.*"
			sfd:OverwritePrompt := TRUE
			IF sfd:ShowDialog() == DialogResult.OK
				//
				LOCAL rddInfo AS List<RddFieldInfo>
				rddInfo := List<RddFieldInfo>{}
				FOREACH lvi AS ListViewItem IN fieldListView:Items
					// 
					LOCAL currentField AS RddFieldInfo
					currentField := RddFieldInfo{ lvi:Text, lvi:SubItems[1]:Text, Convert.ToInt32(lvi:SubItems[2]:Text), Convert.ToInt32(lvi:SubItems[3]:Text) }
					rddInfo:Add( currentField)
				NEXT
				IF CoreDB.Create( sfd:FileName, rddInfo:ToArray(), dbfRDD:Items[dbfRDD:SelectedIndex]:ToString(), TRUE, "Dummy", "",FALSE,FALSE)
					SELF:DialogResult := DialogResult.OK
				ELSE
					MessageBox.Show("Error creating DBF file", "Save DBF File", MessageBoxButtons.OK, MessageBoxIcon.Error )
				ENDIF
			ENDIF
		RETURN
		
		METHOD FillDbStruct( fileName AS STRING, rdd AS STRING, modify AS LOGIC ) AS LOGIC
			//
			TRY
					VAR alias := fileName+DateTime.Now:ToString()
					DbUseArea(TRUE, rdd,fileName, alias )
					//
					LOCAL fieldData AS STRING
					FOR VAR i := 1 UPTO FCount()
						LOCAL lvi AS ListViewItem
						//
						fieldData := FIELDNAME((DWORD)i)
						lvi := ListViewItem{ fieldData }
						VAR infoType := DbFieldInfo( DBS_TYPE, i )
						lvi:SubItems:Add(infoType:ToString()  )
						VAR infoLen := DbFieldInfo( DBS_LEN, i )
						lvi:SubItems:Add(infoLen:ToString()  )
						VAR infoDec := DbFieldInfo( DBS_DEC, i )
						lvi:SubItems:Add(infoDec:ToString()  )
						//
						SELF:fieldListView:Items:Add( lvi )
					NEXT
					//
				DbCLoseArea( alias )
			CATCH e AS Exception
				MessageBox.Show( "Error opening file." + Environment.NewLine + e:Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error )
				RETURN FALSE
			END TRY
			IF !modify
				SELF:lFilled := TRUE
				SELF:saveBtn:Visible := FALSE
				SELF:panel1:Visible := FALSE
			ENDIF
			RETURN TRUE
		PRIVATE METHOD modelBtn_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			LOCAL sfd AS SaveFileDialog
			//
			IF SELF:fieldListView:Items:Count == 0
				RETURN
			ENDIF
			//
			sfd := SaveFileDialog{}
			sfd:DefaultExt := "prg"
			sfd:Filter := "PRG files (*.prg)|*.prg|All files (*.*)|*.*"
			sfd:OverwritePrompt := TRUE
			IF sfd:ShowDialog() == DialogResult.OK
				//
				LOCAL rddInfo AS List<RddFieldInfo>
				rddInfo := List<RddFieldInfo>{}
				FOREACH lvi AS ListViewItem IN fieldListView:Items
					// 
					LOCAL currentField AS RddFieldInfo
					currentField := RddFieldInfo{ lvi:Text, lvi:SubItems[1]:Text, Convert.ToInt32(lvi:SubItems[2]:Text), Convert.ToInt32(lvi:SubItems[3]:Text) }
					rddInfo:Add( currentField)
				NEXT
				IF ModelCreate( sfd:FileName, rddInfo, dbfRDD:Items[dbfRDD:SelectedIndex]:ToString() )
					SELF:DialogResult := DialogResult.OK
				ELSE
					MessageBox.Show("Error creating DBF file", "Save DBF File", MessageBoxButtons.OK, MessageBoxIcon.Error )
				ENDIF
			ENDIF    
		RETURN
		PRIVATE METHOD fieldListView_SelectedIndexChanged(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			LOCAL indexes := SELF:fieldListView:SelectedIndices AS ListView.SelectedIndexCollection
			//
			IF ( indexes:Count > 0 )
					SELF:editBtn:Enabled := TRUE
				SELF:deleteBtn:Enabled := TRUE
			ELSE
				SELF:editBtn:Enabled := FALSE
				SELF:deleteBtn:Enabled := FALSE                
			ENDIF    
		RETURN
		
		
		
		PRIVATE METHOD closeBtn_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			SELF:Close()
		RETURN
		
		
		
		PRIVATE METHOD fieldListView_MouseDoubleClick(sender AS OBJECT, e AS System.Windows.Forms.MouseEventArgs) AS VOID STRICT
			SELF:editField()
		RETURN
		
		
		
		METHOD FillOpenStruct( ) AS LOGIC
			//
			TRY
					//
					LOCAL fieldData AS STRING
					FOR VAR i := 1 UPTO FCount()
						LOCAL lvi AS ListViewItem
						//
						fieldData := FIELDNAME((DWORD)i)
						lvi := ListViewItem{ fieldData }
						VAR infoType := DbFieldInfo( DBS_TYPE, i )
						lvi:SubItems:Add(infoType:ToString()  )
						VAR infoLen := DbFieldInfo( DBS_LEN, i )
						lvi:SubItems:Add(infoLen:ToString()  )
						VAR infoDec := DbFieldInfo( DBS_DEC, i )
						lvi:SubItems:Add(infoDec:ToString()  )
						//
						SELF:fieldListView:Items:Add( lvi )
					NEXT
				//
			CATCH e AS Exception
				MessageBox.Show( "Error opening file." + Environment.NewLine + e:Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error )
				RETURN FALSE
			END TRY
			SELF:lFilled := TRUE
			SELF:saveBtn:Visible := FALSE
			SELF:panel1:Visible := FALSE
			RETURN TRUE			
			END CLASS 
END NAMESPACE
