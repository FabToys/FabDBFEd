// ToolStripCheckedBox.prg
// Created by    : fabri
// Creation Date : 5/17/2021 5:31:00 PM
// Created for   : 
// WorkStation   : FABXPS


USING System
USING System.Collections.Generic
USING System.Text
USING System.Windows.Forms
USING System.Windows.Forms.Design
USING System.ComponentModel


	/// <summary>
    /// The ToolStripCheckedBox class.
    /// </summary>
	[ToolStripItemDesignerAvailability(ToolStripItemDesignerAvailability.ToolStrip | ToolStripItemDesignerAvailability.StatusStrip)];
	PUBLIC CLASS ToolStripCheckedBox INHERIT ToolStripControlHost
 
    CONSTRUCTOR()
		SUPER( CheckBox{} )
         RETURN

    [DesignerSerializationVisibility( DesignerSerializationVisibility.Content)];
        PUBLIC PROPERTY MyCheckBox AS CheckBox
            GET 
				RETURN (CheckBox)SELF:Control
			END GET
		END PROPERTY

    END CLASS
