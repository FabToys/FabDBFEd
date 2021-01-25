// FabListView.prg
// Created by    : fabri
// Creation Date : 4/7/2020 11:23:31 AM
// Created for   : 
// WorkStation   : FABPORTABLE


USING System
USING System.Collections.Generic
USING System.Text
using System.Drawing
using System.Windows.Forms


BEGIN NAMESPACE FabDBFEd

	public class FabListView inherit ListView
		private const WM_HSCROLL := 0x114 as Long
		private const WM_VSCROLL := 0x115 as Long
		private const ALL_SCROLL := 0x000c2c9 as Long
		
		private SelectedLSI as ListViewItem.ListViewSubItem
		private ItemIndex AS INT
		
		private TxtEdit as TextBox
		
		public EVENT Scroll AS EventHandler
		
		public EVENT AfterEdit AS LabelEditEventHandler
		
		
		public constructor()
			self:MouseDown += TestListView_MouseDown
			self:MouseUp += TestListView_MouseUp
			self:Scroll += TestListView_Scroll
			//
			self:TxtEdit := TextBox{}
			self:TxtEdit:Location := Point{0, 0}
			self:TxtEdit:Size := Size{1, 1}
			self:TxtEdit:Visible := false
			self:TxtEdit:Text := ""
			self:TxtEdit:Leave += TxtEdit_Leave
			self:TxtEdit:KeyUp += TxtEdit_KeyUp
			//
			SELF:Controls:Add( SELF:TxtEdit )
			//
			
		
		protected method OnScroll() as void
			if (self:Scroll != null)
				self:Scroll(self, EventArgs.Empty)
			endif
			
		
		protected override method WndProc(m ref Message ) as void
			super:WndProc(ref m)
			if ((m:Msg == 276) .OR. (m:Msg == 277))
				self:OnScroll()
			endif
			if (m:Msg == 49865)
				self:OnScroll()
			endif
			
		
		private method TestListView_MouseUp(sender as Object , e as MouseEventArgs ) as void
			local CellWidth as Long
			local CellHeight as Long
			local CellLeft as Long
			local CellTop as Long
			LOCAL li AS ListViewItem
			//
			li := GetItemAt(e:X, e:Y)
			IF ( li == NULL )
				RETURN
			ENDIF
			ItemIndex = li:Index
			self:SelectedLSI := li:SubItems[0]
			if (self:SelectedLSI != null)
				// Only edit the First Column
				CellWidth := SELF:Columns[0]:Width
				CellHeight := self:SelectedLSI:Bounds:Height
				CellLeft := self:SelectedLSI:Bounds:X
				CellTop := self:SelectedLSI:Bounds:Y
				self:TxtEdit:Location := Point{CellLeft, CellTop}
				self:TxtEdit:Size := Size{CellWidth, CellHeight}
				self:TxtEdit:Visible := true
				self:TxtEdit:BringToFront()
				self:TxtEdit:Text := self:SelectedLSI:Text
				self:TxtEdit:Select()
				self:TxtEdit:SelectAll()
			endif
			
		
		private method TestListView_MouseDown(sender as Object , e as MouseEventArgs ) as void
			self:HideTextEditor()
			
		
		private method TestListView_Scroll(sender as Object , e as EventArgs ) as void
			self:HideTextEditor()
			
		
		private method TxtEdit_Leave(sender as Object , e as EventArgs ) as void
			self:HideTextEditor()
			
		
		private method TxtEdit_KeyUp(sender as Object , e as KeyEventArgs ) as void
			if ((e:KeyCode == Keys.@@Return) .OR. (e:KeyCode == Keys.@@Return))
				self:HideTextEditor()
			endif
			
		
		private method HideTextEditor() as void
			if (self:TxtEdit:Visible)
				self:TxtEdit:Visible := false
				if (self:SelectedLSI != null)
					self:SelectedLSI:Text := self:TxtEdit:Text
				endif
				//
				IF ( Self:AfterEdit != NULL )
					LOCAL e AS LabelEditEventArgs
					e := LabelEditEventArgs{ ItemIndex, self:TxtEdit:Text }
					SELF:AfterEdit( SELF, e )
				ENDIF
				//
				self:SelectedLSI := null
				self:TxtEdit:Text := ""
			endif
			
		
	end class
	
END NAMESPACE // FabDBFEd