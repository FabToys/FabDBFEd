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
		PRIVATE METHOD OpenDBF() AS VOID
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
			SELF:OpenDBF()
			RETURN
		PRIVATE METHOD Form1_FormClosing(sender AS OBJECT, e AS System.Windows.Forms.FormClosingEventArgs) AS VOID STRICT
			RETURN
		PRIVATE METHOD openToolStripMenuItem_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			SELF:OpenDBF()
			RETURN
		PRIVATE METHOD viewToolStripMenuItem_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			LOCAL ofd AS OpenFileDialog
			//
			ofd := OpenFileDialog{}
			ofd:Title := "View DBF Structure"
			ofd:CheckFileExists := TRUE
			ofd:DefaultExt := "Dbf"
			ofd:Filter := "Dbf files (*.dbf)|*.dbf|All files (*.*)|*.*"
			IF ( ofd:ShowDialog() == DialogResult.OK )
				//
				LOCAL dbfWin AS DBFStructWindow
				dbfWin := DBFStructWindow{}
				dbfWin:Text := "View DBF Structure"
				IF dbfWin:FillDbStruct( ofd:FileName, SELF:toolStripComboRDD:SelectedItem:ToString(), FALSE )
					dbfWin:ShowDialog()
				ENDIF
			ENDIF         
			RETURN
		PRIVATE METHOD modifyToolStripMenuItem_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			LOCAL ofd AS OpenFileDialog
			//
			ofd := OpenFileDialog{}
			ofd:Title := "Modify DBF Structure"
			ofd:CheckFileExists := TRUE
			ofd:DefaultExt := "Dbf"
			ofd:Filter := "Dbf files (*.dbf)|*.dbf|All files (*.*)|*.*"
			IF ( ofd:ShowDialog() == DialogResult.OK )
				//
				LOCAL dbfWin AS DBFStructWindow
				dbfWin := DBFStructWindow{}
				dbfWin:Text := "Modify DBF Structure"
				IF dbfWin:FillDbStruct( ofd:FileName, SELF:toolStripComboRDD:SelectedItem:ToString(), TRUE )
					dbfWin:ShowDialog()
				ENDIF
			ENDIF         
			RETURN
		PRIVATE METHOD cascadeToolStripMenuItem_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			SELF:LayoutMdi(System.Windows.Forms.MdiLayout.Cascade)
			RETURN
		PRIVATE METHOD tileVerticallyToolStripMenuItem_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			SELF:LayoutMdi(System.Windows.Forms.MdiLayout.TileVertical)
			RETURN
		PRIVATE METHOD toolStripButtonReadOnly_Click(sender AS System.Object, e AS System.EventArgs) AS VOID STRICT
			IF SELF:toolStripButtonReadOnly:Checked
				SELF:toolStripButtonReadOnly:Checked := FALSE
				SELF:toolStripButtonReadOnly:Image := GLOBAL::FabDBFEd.Properties.Resources.CheckBoxUnchecked_16x
			ELSE
				SELF:toolStripButtonReadOnly:Checked := TRUE
				SELF:toolStripButtonReadOnly:Image := GLOBAL::FabDBFEd.Properties.Resources.CheckBoxChecked_16x
			ENDIF
			RETURN
			
END CLASS 
END NAMESPACE
