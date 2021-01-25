USING System
USING System.Collections.Generic
USING System.ComponentModel
USING System.Data
USING System.Drawing
USING System.Linq
USING System.Text
USING System.Threading.Tasks
USING System.Windows.Forms
USING FabDBFEd
BEGIN NAMESPACE FabDBFEd
    PUBLIC PARTIAL CLASS Form1 ;
        INHERIT System.Windows.Forms.Form
        PUBLIC CONSTRUCTOR()   STRICT//Form1
            InitializeComponent()
            //
            SELF:toolStripComboRDD:Items:Add( "DBFVFP" )
            SELF:toolStripComboRDD:Items:Add( "DBFNTX" )
            SELF:toolStripComboRDD:Items:Add( "DBFCDX" )
            SELF:toolStripComboRDD:SelectedIndex := 0
            //
        RETURN
        PRIVATE METHOD createToolStripMenuItem_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
            LOCAL dbfWin AS DBFStructWindow
            //
            dbfWin := DBFStructWindow{}
            dbfWin:Text := "Create a DBF"
            dbfWin:ShowDialog()
        RETURN
        PRIVATE METHOD quitToolStripMenuItem_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
            SELF:QuitApp()
        RETURN
        PRIVATE METHOD OpenDBF1() AS VOID
            LOCAL ofd AS OpenFileDialog
            //
            ofd := OpenFileDialog{}
            ofd:CheckFileExists := TRUE
            ofd:DefaultExt := "Dbf"
            ofd:Filter := "Dbf files (*.dbf)|*.dbf|All files (*.*)|*.*"
            IF ( ofd:ShowDialog() == DialogResult.OK )
                //
                LOCAL mdi AS BrowseWindow
                //
                mdi := BrowseWindow{}
                IF mdi:OpenDBF( ofd:FileName, SELF:toolStripComboRDD:SelectedItem:ToString() )
                    mdi:MdiParent := SELF
                    mdi:Text := SELF:toolStripComboRDD:SelectedItem:ToString() + " - " + ofd:FileName
                    mdi:Show()
                ENDIF
            ENDIF
        PRIVATE METHOD OpenDBF2() AS VOID
            LOCAL ofd AS OpenFileDialog
            //
            ofd := OpenFileDialog{}
            ofd:CheckFileExists := TRUE
            ofd:DefaultExt := "Dbf"
            ofd:Filter := "Dbf files (*.dbf)|*.dbf|All files (*.*)|*.*"
            IF ( ofd:ShowDialog() == DialogResult.OK )
                //
                LOCAL mdi AS BrowseWindow2
                //
                mdi := BrowseWindow2{}
                IF mdi:OpenDBF( ofd:FileName, SELF:toolStripComboRDD:SelectedItem:ToString() )
                    mdi:MdiParent := SELF
                    mdi:Text := SELF:toolStripComboRDD:SelectedItem:ToString() + " - " + ofd:FileName
                    mdi:Show()
                ENDIF
            ENDIF
            
        PRIVATE METHOD toolStripButtonQuit_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
            SELF:QuitApp()
        RETURN
        PRIVATE METHOD QuitApp() AS VOID
            IF MessageBox.Show( "Are you sure ?", "Close Application", MessageBoxButtons.YesNo, MessageBoxIcon.Question ) == DialogResult.Yes
                SELF:Close()
        ENDIF
        PRIVATE METHOD toolStripButton1_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
            SELF:OpenDBF2()
            RETURN
PRIVATE METHOD Form1_FormClosing(sender AS OBJECT, e AS System.Windows.Forms.FormClosingEventArgs) AS VOID STRICT
        RETURN
PRIVATE METHOD inBrowserV1ToolStripMenuItem_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
        SELF:OpenDBF1()
        RETURN
PRIVATE METHOD inBrowserV2ToolStripMenuItem_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
        SELF:OpenDBF2()
        RETURN
        
    END CLASS 
END NAMESPACE
