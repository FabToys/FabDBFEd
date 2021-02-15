USING System
USING System.Collections.Generic
USING System.ComponentModel
USING System.Data
USING System.Drawing

USING System.Text

USING System.Windows.Forms

BEGIN NAMESPACE FabDBFEd

    PUBLIC PARTIAL CLASS MemoEditor ;
        INHERIT System.Windows.Forms.Form
        PUBLIC HasChanged AS LOGIC

        PUBLIC CONSTRUCTOR() STRICT 
            InitializeComponent()
			SELF:textEditor:ActiveTextAreaControl:Dock := System.Windows.Forms.DockStyle.Fill
            RETURN
PRIVATE METHOD textEditor_TextChanged(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
    SELF:HasChanged := TRUE
        RETURN

    END CLASS 
END NAMESPACE
