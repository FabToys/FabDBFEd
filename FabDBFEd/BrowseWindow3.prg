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
            
        END CLASS 
END NAMESPACE
