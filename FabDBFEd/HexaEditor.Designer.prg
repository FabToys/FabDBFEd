﻿//------------------------------------------------------------------------------
//  <auto-generated>
//     This code was generated by a tool.
//     Runtime version: 4.0.30319.42000
//     Generator      : XSharp.CodeDomProvider 2.6.0.0
//     Timestamp      : 15/02/2021 16:49:31
//     
//     Changes to this file may cause incorrect behavior and may be lost if
//     the code is regenerated.
//  </auto-generated>
//------------------------------------------------------------------------------
BEGIN NAMESPACE FabDBFEd

    PUBLIC PARTIAL CLASS HexaEditor ;
        INHERIT System.Windows.Forms.Form
        PRIVATE components := NULL AS System.ComponentModel.IContainer

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        PROTECTED METHOD Dispose(disposing AS LOGIC) AS VOID STRICT

            IF (disposing .and. (components != null))
                components:Dispose()
            ENDIF
            SUPER:Dispose(disposing)
            RETURN

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        PRIVATE METHOD InitializeComponent() AS VOID STRICT
            SELF:SuspendLayout()
            // 
            // HexaEditor
            // 
            SELF:AutoScaleDimensions := System.Drawing.SizeF{8, 16}
            SELF:AutoScaleMode := System.Windows.Forms.AutoScaleMode.Font
            SELF:ClientSize := System.Drawing.Size{932, 353}
            SELF:MaximizeBox := false
            SELF:MinimizeBox := false
            SELF:Name := "HexaEditor"
            SELF:StartPosition := System.Windows.Forms.FormStartPosition.CenterParent
            SELF:Text := "Hexa Editor"
            SELF:ResumeLayout(false)

        #endregion
    END CLASS 
END NAMESPACE