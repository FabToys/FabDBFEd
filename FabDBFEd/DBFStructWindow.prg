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
        PRIVATE hit AS System.Windows.Forms.ListViewHitTestInfo
        PRIVATE autoInc AS INT
        PUBLIC CONSTRUCTOR() STRICT //DBFStructWindow
            InitializeComponent()
            //
            SELF:dbfRDD:Items:Add( "DBFNTX" )
            SELF:dbfRDD:Items:Add( "DBFCDX" )
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

END CLASS 
END NAMESPACE
