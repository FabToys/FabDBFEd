﻿//------------------------------------------------------------------------------
//  <auto-generated>
//     This code was generated by a tool.
//     Runtime version: 4.0.30319.42000
//     Generator      : XSharp.CodeDomProvider 2.6.0.0
//     Timestamp      : 11/02/2021 19:13:44
//     
//     Changes to this file may cause incorrect behavior and may be lost if
//     the code is regenerated.
//  </auto-generated>
//------------------------------------------------------------------------------
BEGIN NAMESPACE FabDBFEd
    PUBLIC PARTIAL CLASS Form1 ;
        INHERIT System.Windows.Forms.Form
        PRIVATE mainMenuStrip AS System.Windows.Forms.MenuStrip
        PRIVATE fileToolStripMenuItem AS System.Windows.Forms.ToolStripMenuItem
        PRIVATE openToolStripMenuItem AS System.Windows.Forms.ToolStripMenuItem
        PRIVATE toolStripSeparator1 AS System.Windows.Forms.ToolStripSeparator
        PRIVATE quitToolStripMenuItem AS System.Windows.Forms.ToolStripMenuItem
        PRIVATE mainStatusStrip AS System.Windows.Forms.StatusStrip
        PRIVATE mainToolStrip AS System.Windows.Forms.ToolStrip
        PRIVATE databaseToolStripMenuItem AS System.Windows.Forms.ToolStripMenuItem
        PRIVATE createToolStripMenuItem AS System.Windows.Forms.ToolStripMenuItem
        PRIVATE modifyToolStripMenuItem AS System.Windows.Forms.ToolStripMenuItem
        PRIVATE toolStripButtonQuit AS System.Windows.Forms.ToolStripButton
        PRIVATE toolStripSeparator2 AS System.Windows.Forms.ToolStripSeparator
        PRIVATE toolStripComboRDD AS System.Windows.Forms.ToolStripComboBox
        PRIVATE toolStripButton1 AS System.Windows.Forms.ToolStripButton
        PRIVATE viewToolStripMenuItem AS System.Windows.Forms.ToolStripMenuItem
        PRIVATE components := NULL AS System.ComponentModel.IContainer
                                                                                                                
        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        PROTECTED METHOD Dispose(disposing AS LOGIC) AS VOID  STRICT

            IF (disposing .AND. (components != NULL))
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
            LOCAL resources := System.ComponentModel.ComponentResourceManager{TYPEOF(Form1)} AS System.ComponentModel.ComponentResourceManager
            SELF:mainMenuStrip := System.Windows.Forms.MenuStrip{}
            SELF:fileToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            SELF:openToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            SELF:toolStripSeparator1 := System.Windows.Forms.ToolStripSeparator{}
            SELF:quitToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            SELF:databaseToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            SELF:createToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            SELF:modifyToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            SELF:viewToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            SELF:mainStatusStrip := System.Windows.Forms.StatusStrip{}
            SELF:mainToolStrip := System.Windows.Forms.ToolStrip{}
            SELF:toolStripButtonQuit := System.Windows.Forms.ToolStripButton{}
            SELF:toolStripButton1 := System.Windows.Forms.ToolStripButton{}
            SELF:toolStripSeparator2 := System.Windows.Forms.ToolStripSeparator{}
            SELF:toolStripComboRDD := System.Windows.Forms.ToolStripComboBox{}
            SELF:mainMenuStrip:SuspendLayout()
            SELF:mainToolStrip:SuspendLayout()
            SELF:SuspendLayout()
            // 
            // mainMenuStrip
            // 
            SELF:mainMenuStrip:ImageScalingSize := System.Drawing.Size{20, 20}
            SELF:mainMenuStrip:Items:AddRange(<System.Windows.Forms.ToolStripItem>{ SELF:fileToolStripMenuItem, SELF:databaseToolStripMenuItem })
            SELF:mainMenuStrip:Location := System.Drawing.Point{0, 0}
            SELF:mainMenuStrip:Name := "mainMenuStrip"
            SELF:mainMenuStrip:Size := System.Drawing.Size{1083, 28}
            SELF:mainMenuStrip:TabIndex := 0
            SELF:mainMenuStrip:Text := "menuStrip1"
            // 
            // fileToolStripMenuItem
            // 
            SELF:fileToolStripMenuItem:DropDownItems:AddRange(<System.Windows.Forms.ToolStripItem>{ SELF:openToolStripMenuItem, SELF:toolStripSeparator1, SELF:quitToolStripMenuItem })
            SELF:fileToolStripMenuItem:Name := "fileToolStripMenuItem"
            SELF:fileToolStripMenuItem:Size := System.Drawing.Size{44, 24}
            SELF:fileToolStripMenuItem:Text := "&File"
            // 
            // openToolStripMenuItem
            // 
            SELF:openToolStripMenuItem:Name := "openToolStripMenuItem"
            SELF:openToolStripMenuItem:Size := System.Drawing.Size{120, 26}
            SELF:openToolStripMenuItem:Text := "&Open"
            SELF:openToolStripMenuItem:Click += System.EventHandler{ SELF, @openToolStripMenuItem_Click() }
            // 
            // toolStripSeparator1
            // 
            SELF:toolStripSeparator1:Name := "toolStripSeparator1"
            SELF:toolStripSeparator1:Size := System.Drawing.Size{117, 6}
            // 
            // quitToolStripMenuItem
            // 
            SELF:quitToolStripMenuItem:Name := "quitToolStripMenuItem"
            SELF:quitToolStripMenuItem:Size := System.Drawing.Size{120, 26}
            SELF:quitToolStripMenuItem:Text := "&Quit"
            SELF:quitToolStripMenuItem:Click += System.EventHandler{ SELF, @quitToolStripMenuItem_Click() }
            // 
            // databaseToolStripMenuItem
            // 
            SELF:databaseToolStripMenuItem:DropDownItems:AddRange(<System.Windows.Forms.ToolStripItem>{ SELF:createToolStripMenuItem, SELF:modifyToolStripMenuItem, SELF:viewToolStripMenuItem })
            SELF:databaseToolStripMenuItem:Name := "databaseToolStripMenuItem"
            SELF:databaseToolStripMenuItem:Size := System.Drawing.Size{84, 24}
            SELF:databaseToolStripMenuItem:Text := "Database"
            // 
            // createToolStripMenuItem
            // 
            SELF:createToolStripMenuItem:Name := "createToolStripMenuItem"
            SELF:createToolStripMenuItem:Size := System.Drawing.Size{216, 26}
            SELF:createToolStripMenuItem:Text := "Create"
            SELF:createToolStripMenuItem:Click += System.EventHandler{ SELF, @createToolStripMenuItem_Click() }
            // 
            // modifyToolStripMenuItem
            // 
            SELF:modifyToolStripMenuItem:Name := "modifyToolStripMenuItem"
            SELF:modifyToolStripMenuItem:Size := System.Drawing.Size{216, 26}
            SELF:modifyToolStripMenuItem:Text := "Modify"
            SELF:modifyToolStripMenuItem:Click += System.EventHandler{ SELF, @modifyToolStripMenuItem_Click() }
            // 
            // viewToolStripMenuItem
            // 
            SELF:viewToolStripMenuItem:Name := "viewToolStripMenuItem"
            SELF:viewToolStripMenuItem:Size := System.Drawing.Size{216, 26}
            SELF:viewToolStripMenuItem:Text := "View"
            SELF:viewToolStripMenuItem:Click += System.EventHandler{ SELF, @viewToolStripMenuItem_Click() }
            // 
            // mainStatusStrip
            // 
            SELF:mainStatusStrip:ImageScalingSize := System.Drawing.Size{20, 20}
            SELF:mainStatusStrip:Location := System.Drawing.Point{0, 587}
            SELF:mainStatusStrip:Name := "mainStatusStrip"
            SELF:mainStatusStrip:Size := System.Drawing.Size{1083, 22}
            SELF:mainStatusStrip:TabIndex := 1
            SELF:mainStatusStrip:Text := "statusStrip1"
            // 
            // mainToolStrip
            // 
            SELF:mainToolStrip:ImageScalingSize := System.Drawing.Size{20, 20}
            SELF:mainToolStrip:Items:AddRange(<System.Windows.Forms.ToolStripItem>{ SELF:toolStripButtonQuit, SELF:toolStripButton1, SELF:toolStripSeparator2, SELF:toolStripComboRDD })
            SELF:mainToolStrip:Location := System.Drawing.Point{0, 28}
            SELF:mainToolStrip:Name := "mainToolStrip"
            SELF:mainToolStrip:Size := System.Drawing.Size{1083, 28}
            SELF:mainToolStrip:TabIndex := 2
            SELF:mainToolStrip:Text := "toolStrip1"
            // 
            // toolStripButtonQuit
            // 
            SELF:toolStripButtonQuit:DisplayStyle := System.Windows.Forms.ToolStripItemDisplayStyle.Image
            SELF:toolStripButtonQuit:Image := ((System.Drawing.Image)(resources:GetObject("toolStripButtonQuit.Image")))
            SELF:toolStripButtonQuit:ImageTransparentColor := System.Drawing.Color.Magenta
            SELF:toolStripButtonQuit:Name := "toolStripButtonQuit"
            SELF:toolStripButtonQuit:Size := System.Drawing.Size{24, 25}
            SELF:toolStripButtonQuit:Text := "Quit Application"
            SELF:toolStripButtonQuit:Click += System.EventHandler{ SELF, @toolStripButtonQuit_Click() }
            // 
            // toolStripButton1
            // 
            SELF:toolStripButton1:DisplayStyle := System.Windows.Forms.ToolStripItemDisplayStyle.Image
            SELF:toolStripButton1:Image := ((System.Drawing.Image)(resources:GetObject("toolStripButton1.Image")))
            SELF:toolStripButton1:ImageTransparentColor := System.Drawing.Color.Magenta
            SELF:toolStripButton1:Name := "toolStripButton1"
            SELF:toolStripButton1:Size := System.Drawing.Size{24, 25}
            SELF:toolStripButton1:Text := "toolStripButtonOpen"
            SELF:toolStripButton1:Click += System.EventHandler{ SELF, @toolStripButton1_Click() }
            // 
            // toolStripSeparator2
            // 
            SELF:toolStripSeparator2:Name := "toolStripSeparator2"
            SELF:toolStripSeparator2:Size := System.Drawing.Size{6, 28}
            // 
            // toolStripComboRDD
            // 
            SELF:toolStripComboRDD:DropDownStyle := System.Windows.Forms.ComboBoxStyle.DropDownList
            SELF:toolStripComboRDD:Name := "toolStripComboRDD"
            SELF:toolStripComboRDD:Size := System.Drawing.Size{121, 28}
            SELF:toolStripComboRDD:ToolTipText := "RDD used to open file"
            // 
            // Form1
            // 
            SELF:AutoScaleDimensions := System.Drawing.SizeF{8, 16}
            SELF:AutoScaleMode := System.Windows.Forms.AutoScaleMode.Font
            SELF:ClientSize := System.Drawing.Size{1083, 609}
            SELF:Controls:Add(SELF:mainToolStrip)
            SELF:Controls:Add(SELF:mainStatusStrip)
            SELF:Controls:Add(SELF:mainMenuStrip)
            SELF:IsMdiContainer := true
            SELF:Name := "Form1"
            SELF:StartPosition := System.Windows.Forms.FormStartPosition.CenterScreen
            SELF:Text := "FabDBFEd"
            SELF:FormClosing += System.Windows.Forms.FormClosingEventHandler{ SELF, @Form1_FormClosing() }
            SELF:mainMenuStrip:ResumeLayout(false)
            SELF:mainMenuStrip:PerformLayout()
            SELF:mainToolStrip:ResumeLayout(false)
            SELF:mainToolStrip:PerformLayout()
            SELF:ResumeLayout(false)
            SELF:PerformLayout()
                                
        #endregion
    
    END CLASS 
END NAMESPACE
