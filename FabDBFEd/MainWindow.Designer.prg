﻿//------------------------------------------------------------------------------
//  <auto-generated>
//     This code was generated by a tool.
//     Runtime version: 4.0.30319.42000
//     Generator      : XSharp.CodeDomProvider 2.20.0.3
//     Timestamp      : 2024/8/17 7:39:16
//     
//     Changes to this file may cause incorrect behavior and may be lost if
//     the code is regenerated.
//  </auto-generated>
//------------------------------------------------------------------------------
Begin Namespace FabDBFEd
    Public Partial Class Form1 ;
        Inherit System.Windows.Forms.Form
        Private fileToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private openToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private toolStripSeparator1 As System.Windows.Forms.ToolStripSeparator
        Private quitToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private mainStatusStrip As System.Windows.Forms.StatusStrip
        Private mainToolStrip As System.Windows.Forms.ToolStrip
        Private databaseToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private createToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private modifyToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private toolStripButtonQuit As System.Windows.Forms.ToolStripButton
        Private toolStripSeparator2 As System.Windows.Forms.ToolStripSeparator
        Private toolStripComboRDD As System.Windows.Forms.ToolStripComboBox
        Private toolStripButton1 As System.Windows.Forms.ToolStripButton
        Private viewToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private mainMenu As System.Windows.Forms.MenuStrip
        Private windowToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private cascadeToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private tileVerticallyToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
        Private toolStripButtonReadOnly As System.Windows.Forms.ToolStripButton
        Private components := Null As System.ComponentModel.IContainer
                                                                                                                
        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        Protected Method Dispose(disposing As Logic) As Void  Strict

            If (disposing .AND. (components != NULL))
                components:Dispose()
            Endif
            Super:Dispose(disposing)
            Return

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
                        Private Method InitializeComponent() As Void Strict
            Local resources := System.ComponentModel.ComponentResourceManager{Typeof(Form1)} As System.ComponentModel.ComponentResourceManager
            Self:mainMenu := System.Windows.Forms.MenuStrip{}
            Self:fileToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:openToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:toolStripSeparator1 := System.Windows.Forms.ToolStripSeparator{}
            Self:quitToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:databaseToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:createToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:modifyToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:viewToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:windowToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:cascadeToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:tileVerticallyToolStripMenuItem := System.Windows.Forms.ToolStripMenuItem{}
            Self:mainStatusStrip := System.Windows.Forms.StatusStrip{}
            Self:mainToolStrip := System.Windows.Forms.ToolStrip{}
            Self:toolStripButtonQuit := System.Windows.Forms.ToolStripButton{}
            Self:toolStripButton1 := System.Windows.Forms.ToolStripButton{}
            Self:toolStripSeparator2 := System.Windows.Forms.ToolStripSeparator{}
            Self:toolStripComboRDD := System.Windows.Forms.ToolStripComboBox{}
            Self:toolStripButtonReadOnly := System.Windows.Forms.ToolStripButton{}
            Self:mainMenu:SuspendLayout()
            Self:mainToolStrip:SuspendLayout()
            Self:SuspendLayout()
            // 
            // mainMenu
            // 
            Self:mainMenu:GripMargin := System.Windows.Forms.Padding{2, 2, 0, 2}
            Self:mainMenu:ImageScalingSize := System.Drawing.Size{20, 20}
            Self:mainMenu:Items:AddRange(<System.Windows.Forms.ToolStripItem>{ Self:fileToolStripMenuItem, Self:databaseToolStripMenuItem, Self:windowToolStripMenuItem })
            resources:ApplyResources(Self:mainMenu, "mainMenu")
            Self:mainMenu:MdiWindowListItem := Self:windowToolStripMenuItem
            Self:mainMenu:Name := "mainMenu"
            // 
            // fileToolStripMenuItem
            // 
            Self:fileToolStripMenuItem:DropDownItems:AddRange(<System.Windows.Forms.ToolStripItem>{ Self:openToolStripMenuItem, Self:toolStripSeparator1, Self:quitToolStripMenuItem })
            Self:fileToolStripMenuItem:Name := "fileToolStripMenuItem"
            resources:ApplyResources(Self:fileToolStripMenuItem, "fileToolStripMenuItem")
            // 
            // openToolStripMenuItem
            // 
            resources:ApplyResources(Self:openToolStripMenuItem, "openToolStripMenuItem")
            Self:openToolStripMenuItem:Name := "openToolStripMenuItem"
            Self:openToolStripMenuItem:Click += System.EventHandler{ Self, @openToolStripMenuItem_Click() }
            // 
            // toolStripSeparator1
            // 
            Self:toolStripSeparator1:Name := "toolStripSeparator1"
            resources:ApplyResources(Self:toolStripSeparator1, "toolStripSeparator1")
            // 
            // quitToolStripMenuItem
            // 
            Self:quitToolStripMenuItem:Name := "quitToolStripMenuItem"
            resources:ApplyResources(Self:quitToolStripMenuItem, "quitToolStripMenuItem")
            Self:quitToolStripMenuItem:Click += System.EventHandler{ Self, @quitToolStripMenuItem_Click() }
            // 
            // databaseToolStripMenuItem
            // 
            Self:databaseToolStripMenuItem:DropDownItems:AddRange(<System.Windows.Forms.ToolStripItem>{ Self:createToolStripMenuItem, Self:modifyToolStripMenuItem, Self:viewToolStripMenuItem })
            Self:databaseToolStripMenuItem:Name := "databaseToolStripMenuItem"
            resources:ApplyResources(Self:databaseToolStripMenuItem, "databaseToolStripMenuItem")
            // 
            // createToolStripMenuItem
            // 
            Self:createToolStripMenuItem:Name := "createToolStripMenuItem"
            resources:ApplyResources(Self:createToolStripMenuItem, "createToolStripMenuItem")
            Self:createToolStripMenuItem:Click += System.EventHandler{ Self, @createToolStripMenuItem_Click() }
            // 
            // modifyToolStripMenuItem
            // 
            Self:modifyToolStripMenuItem:Name := "modifyToolStripMenuItem"
            resources:ApplyResources(Self:modifyToolStripMenuItem, "modifyToolStripMenuItem")
            Self:modifyToolStripMenuItem:Click += System.EventHandler{ Self, @modifyToolStripMenuItem_Click() }
            // 
            // viewToolStripMenuItem
            // 
            Self:viewToolStripMenuItem:Name := "viewToolStripMenuItem"
            resources:ApplyResources(Self:viewToolStripMenuItem, "viewToolStripMenuItem")
            Self:viewToolStripMenuItem:Click += System.EventHandler{ Self, @viewToolStripMenuItem_Click() }
            // 
            // windowToolStripMenuItem
            // 
            Self:windowToolStripMenuItem:DropDownItems:AddRange(<System.Windows.Forms.ToolStripItem>{ Self:cascadeToolStripMenuItem, Self:tileVerticallyToolStripMenuItem })
            Self:windowToolStripMenuItem:Name := "windowToolStripMenuItem"
            resources:ApplyResources(Self:windowToolStripMenuItem, "windowToolStripMenuItem")
            // 
            // cascadeToolStripMenuItem
            // 
            Self:cascadeToolStripMenuItem:Name := "cascadeToolStripMenuItem"
            resources:ApplyResources(Self:cascadeToolStripMenuItem, "cascadeToolStripMenuItem")
            Self:cascadeToolStripMenuItem:Click += System.EventHandler{ Self, @cascadeToolStripMenuItem_Click() }
            // 
            // tileVerticallyToolStripMenuItem
            // 
            Self:tileVerticallyToolStripMenuItem:Name := "tileVerticallyToolStripMenuItem"
            resources:ApplyResources(Self:tileVerticallyToolStripMenuItem, "tileVerticallyToolStripMenuItem")
            Self:tileVerticallyToolStripMenuItem:Click += System.EventHandler{ Self, @tileVerticallyToolStripMenuItem_Click() }
            // 
            // mainStatusStrip
            // 
            Self:mainStatusStrip:ImageScalingSize := System.Drawing.Size{20, 20}
            resources:ApplyResources(Self:mainStatusStrip, "mainStatusStrip")
            Self:mainStatusStrip:Name := "mainStatusStrip"
            // 
            // mainToolStrip
            // 
            Self:mainToolStrip:ImageScalingSize := System.Drawing.Size{20, 20}
            Self:mainToolStrip:Items:AddRange(<System.Windows.Forms.ToolStripItem>{ Self:toolStripButtonQuit, Self:toolStripButton1, Self:toolStripSeparator2, Self:toolStripComboRDD, Self:toolStripButtonReadOnly })
            resources:ApplyResources(Self:mainToolStrip, "mainToolStrip")
            Self:mainToolStrip:Name := "mainToolStrip"
            // 
            // toolStripButtonQuit
            // 
            Self:toolStripButtonQuit:DisplayStyle := System.Windows.Forms.ToolStripItemDisplayStyle.Image
            resources:ApplyResources(Self:toolStripButtonQuit, "toolStripButtonQuit")
            Self:toolStripButtonQuit:Name := "toolStripButtonQuit"
            Self:toolStripButtonQuit:Click += System.EventHandler{ Self, @toolStripButtonQuit_Click() }
            // 
            // toolStripButton1
            // 
            Self:toolStripButton1:DisplayStyle := System.Windows.Forms.ToolStripItemDisplayStyle.Image
            resources:ApplyResources(Self:toolStripButton1, "toolStripButton1")
            Self:toolStripButton1:Name := "toolStripButton1"
            Self:toolStripButton1:Click += System.EventHandler{ Self, @toolStripButton1_Click() }
            // 
            // toolStripSeparator2
            // 
            Self:toolStripSeparator2:Name := "toolStripSeparator2"
            resources:ApplyResources(Self:toolStripSeparator2, "toolStripSeparator2")
            // 
            // toolStripComboRDD
            // 
            Self:toolStripComboRDD:DropDownStyle := System.Windows.Forms.ComboBoxStyle.DropDownList
            Self:toolStripComboRDD:Name := "toolStripComboRDD"
            resources:ApplyResources(Self:toolStripComboRDD, "toolStripComboRDD")
            // 
            // toolStripButtonReadOnly
            // 
            resources:ApplyResources(Self:toolStripButtonReadOnly, "toolStripButtonReadOnly")
            Self:toolStripButtonReadOnly:Name := "toolStripButtonReadOnly"
            Self:toolStripButtonReadOnly:Click += System.EventHandler{ Self, @toolStripButtonReadOnly_Click() }
            // 
            // Form1
            // 
            resources:ApplyResources(Self, "$this")
            Self:AutoScaleMode := System.Windows.Forms.AutoScaleMode.Font
            Self:Controls:Add(Self:mainToolStrip)
            Self:Controls:Add(Self:mainStatusStrip)
            Self:Controls:Add(Self:mainMenu)
            Self:IsMdiContainer := true
            Self:Name := "Form1"
            Self:FormClosing += System.Windows.Forms.FormClosingEventHandler{ Self, @Form1_FormClosing() }
            Self:mainMenu:ResumeLayout(false)
            Self:mainMenu:PerformLayout()
            Self:mainToolStrip:ResumeLayout(false)
            Self:mainToolStrip:PerformLayout()
            Self:ResumeLayout(false)
            Self:PerformLayout()
        End Method
                                
        #endregion
    
    End Class 
End Namespace
