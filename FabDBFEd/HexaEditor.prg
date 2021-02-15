USING System
USING System.Collections.Generic
USING System.ComponentModel
USING System.ComponentModel.Design
USING System.Data
USING System.Drawing

USING System.Text

USING System.Windows.Forms

BEGIN NAMESPACE FabDBFEd

    PUBLIC PARTIAL CLASS HexaEditor ;
        INHERIT System.Windows.Forms.Form
        PRIVATE byteView AS System.ComponentModel.Design.ByteViewer
    
        PUBLIC CONSTRUCTOR() STRICT 
            InitializeComponent()
            // Initialize the ByteViewer.
            SELF:byteView := ByteViewer{}
            SELF:byteView:Dock := System.Windows.Forms.DockStyle.Fill
            SELF:byteView:Location := System.Drawing.Point{0, 0}            
            SELF:byteView:SetBytes( <BYTE>{ } )
            SELF:Controls:Add( SELF:byteView )         
            RETURN
            
        METHOD SetBytes( bytes AS BYTE[] ) AS VOID
            SELF:byteView:SetBytes( bytes )

    END CLASS 
END NAMESPACE
