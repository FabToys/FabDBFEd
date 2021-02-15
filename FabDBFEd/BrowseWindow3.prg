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
    PUBLIC PARTIAL CLASS BrowseWindow3 ;
        INHERIT System.Windows.Forms.Form
        PRIVATE oDT AS XSharp.DbDataSource
        PRIVATE alias AS STRING
        
        PUBLIC CONSTRUCTOR() STRICT //BrowseWindow
            InitializeComponent()
            SELF:statusLabel:Text := ""
        RETURN
        
        PUBLIC METHOD OpenDBF(fileName AS STRING, rdd AS STRING ) AS LOGIC
            LOCAL Result AS LOGIC
            // Open the File, and keep it open
            Result := FALSE
            // The CLosing event will take care of that
            TRY
                    alias := fileName+DateTime.Now:ToString()
                    // Create a Dbf Alias based on fileName AND the current Date Time
                    DbUseArea(TRUE, rdd,fileName, alias)
                    
                    //
                    oDT := DbDataSource()
                    // Special behaviour for the Deleted Column
                    //oDT:ShowDeleted := FALSE
                    //oDT:ShowRecno := FALSE
                    // Now attach the DataTable to the DataGridView as DataSource
                    SELF:bindingSource1:DataSource := oDT
                    SELF:dbfBrowseView:DataSource := SELF:bindingSource1
                    //
                    // Special behaviour for Recno & Column
                    SELF:dbfBrowseView:Columns[0]:Frozen := TRUE
                    SELF:dbfBrowseView:Columns[0]:Width := 30
                    SELF:dbfBrowseView:Columns[0]:DefaultCellStyle:Alignment := DataGridViewContentAlignment.MiddleRight
                    
                    SELF:dbfBrowseView:Columns[1]:Frozen := TRUE
                    SELF:dbfBrowseView:Columns[1]:Width := 45
                    //
                Result := TRUE
            CATCH ex AS Exception
                MessageBox.Show( ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error )
            END TRY
        RETURN Result
        
        
        PRIVATE METHOD dbfBrowseView_RowEnter(sender AS OBJECT, e AS System.Windows.Forms.DataGridViewCellEventArgs) AS VOID STRICT
            LOCAL row AS DataGridViewRow
            LOCAL rowRecord AS XSharp.DbRecord
            // Get the current row
            row := SELF:dbfBrowseView:Rows[ e:RowIndex ]
            rowRecord := (XSharp.DbRecord)row.DataBoundItem
            //
            SELF:statusLabel:Text := "RecNo : " + rowRecord:RecNo:ToString() + " / " + "Deleted : " + IIF( rowRecord:Deleted , "Yes", "")
        RETURN
        
        PRIVATE METHOD BrowseWindow_FormClosing(sender AS OBJECT, e AS System.Windows.Forms.FormClosingEventArgs) AS VOID STRICT
            DbCloseArea( SELF:alias )
        RETURN
        
        PRIVATE METHOD bindingNavigatorViewStructure_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
            LOCAL dbfWin AS DBFStructWindow
            dbfWin := DBFStructWindow{}
            dbfWin:Text := "View DBF Structure"
            IF dbfWin:FillOpenStruct( )
                dbfWin:ShowDialog()
            ENDIF    
        RETURN
        PRIVATE METHOD dbfBrowseView_EditingControlShowing(sender AS OBJECT, e AS System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) AS VOID STRICT
            
            VAR cellPoint := SELF:dbfBrowseView:CurrentCellAddress
            VAR currentCol := SELF:dbfBrowseView:Columns[ cellPoint:X ]
            //
            VAR pos := FieldPos( currentCol:Name )
            IF pos > 0
                VAR infoType := DbFieldInfo( DBS_TYPE, pos )
                VAR sType := infoType:ToString()
                IF sType:SubString(0,1) == "M" 
                    VAR flags := DbFieldInfo( DBS_FLAGS, pos )
                    VAR lBinary := flags:IsBinary
                    IF sType:IndexOf(":") > 0
                        lBinary := ( sType:Substring(sType:IndexOf(":")+1) == "B" )
                    ENDIF
                    IF lBinary
                        VAR currentCell := SELF:dbfBrowseView:CurrentCell
                        LOCAL fieldBytes AS BYTE[]
                        LOCAL lOk AS LOGIC
                        TRY
                            fieldBytes := (BYTE[])currentCell:Value
                            IF fieldBytes:Length > 0 
                                lOk := TRUE
                            ENDIF
                        CATCH
                            lOk := FALSE
                        END TRY
                        IF lOk
                            
                            VAR editor := HexaEditor{}
                            editor:SetBytes( fieldBytes  )
                            editor:ShowDialog()
                        ENDIF
                        SELF:dbfBrowseView:EndEdit() 
                    ELSE
                        VAR currentCell := SELF:dbfBrowseView:CurrentCell    
                        VAR text := currentCell:Value:ToString()
                        
                        VAR editor := MemoEditor{}
                        editor:textEditor:Text := text
                        editor:HasChanged := FALSE
                        editor:ShowDialog()
                        
                        SELF:dbfBrowseView:BeginInvoke(    ;
                        (MethodInvoker){ => 
                        SELF:dbfBrowseView:EndEdit() 
                        IF editor:HasChanged
                            currentCell:Value := editor:TextEditor:Text 
                        ENDIF
                        } )
                    ENDIF
                ENDIF
            ENDIF
            
            
            RETURN
            
        END CLASS 
END NAMESPACE
