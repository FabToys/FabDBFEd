﻿//------------------------------------------------------------------------------
//  <auto-generated>
//     This code was generated by a tool.
//     Runtime version: 4.0.30319.42000
//     Generator      : XSharp.CodeDomProvider 2.6.0.0
//     Timestamp      : 12/10/2020 14:49:02
//     
//     Changes to this file may cause incorrect behavior and may be lost if
//     the code is regenerated.
//  </auto-generated>
//------------------------------------------------------------------------------
BEGIN NAMESPACE FabDBFEd
    PUBLIC PARTIAL CLASS FieldWindow ;
        INHERIT System.Windows.Forms.Form
        PRIVATE label1 AS System.Windows.Forms.Label
        PRIVATE label2 AS System.Windows.Forms.Label
        PRIVATE label3 AS System.Windows.Forms.Label
        PRIVATE label4 AS System.Windows.Forms.Label
        PRIVATE nameTextBox AS System.Windows.Forms.TextBox
        PRIVATE typeCombo AS System.Windows.Forms.ComboBox
        PRIVATE lengthTextBox AS System.Windows.Forms.TextBox
        PRIVATE decTextBox AS System.Windows.Forms.TextBox
        PRIVATE labelError AS System.Windows.Forms.Label
        PRIVATE okButton AS System.Windows.Forms.Button
        PRIVATE components := NULL AS System.ComponentModel.IContainer
                                                                                                                                                                        
        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        PROTECTED METHOD Dispose(disposing AS LOGIC) AS VOID STRICT

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
            SELF:nameTextBox := System.Windows.Forms.TextBox{}
            SELF:label1 := System.Windows.Forms.Label{}
            SELF:label2 := System.Windows.Forms.Label{}
            SELF:label3 := System.Windows.Forms.Label{}
            SELF:lengthTextBox := System.Windows.Forms.TextBox{}
            SELF:label4 := System.Windows.Forms.Label{}
            SELF:decTextBox := System.Windows.Forms.TextBox{}
            SELF:okButton := System.Windows.Forms.Button{}
            SELF:typeCombo := System.Windows.Forms.ComboBox{}
            SELF:labelError := System.Windows.Forms.Label{}
            SELF:SuspendLayout()
            // 
            // nameTextBox
            // 
            SELF:nameTextBox:Location := System.Drawing.Point{115, 14}
            SELF:nameTextBox:MaxLength := 10
            SELF:nameTextBox:Name := "nameTextBox"
            SELF:nameTextBox:Size := System.Drawing.Size{155, 22}
            SELF:nameTextBox:TabIndex := 0
            SELF:nameTextBox:Validating += System.ComponentModel.CancelEventHandler{ SELF, @nameTextBox_Validating() }
            // 
            // label1
            // 
            SELF:label1:AutoSize := true
            SELF:label1:Font := System.Drawing.Font{"Microsoft Sans Serif", 7.8, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((BYTE)(0))}
            SELF:label1:Location := System.Drawing.Point{12, 17}
            SELF:label1:Name := "label1"
            SELF:label1:Size := System.Drawing.Size{89, 17}
            SELF:label1:TabIndex := 1
            SELF:label1:Text := "Field Name"
            // 
            // label2
            // 
            SELF:label2:AutoSize := true
            SELF:label2:Location := System.Drawing.Point{12, 48}
            SELF:label2:Name := "label2"
            SELF:label2:Size := System.Drawing.Size{74, 17}
            SELF:label2:TabIndex := 3
            SELF:label2:Text := "Field Type"
            // 
            // label3
            // 
            SELF:label3:AutoSize := true
            SELF:label3:Location := System.Drawing.Point{12, 81}
            SELF:label3:Name := "label3"
            SELF:label3:Size := System.Drawing.Size{86, 17}
            SELF:label3:TabIndex := 5
            SELF:label3:Text := "Field Length"
            // 
            // lengthTextBox
            // 
            SELF:lengthTextBox:Location := System.Drawing.Point{115, 78}
            SELF:lengthTextBox:MaxLength := 3
            SELF:lengthTextBox:Name := "lengthTextBox"
            SELF:lengthTextBox:Size := System.Drawing.Size{155, 22}
            SELF:lengthTextBox:TabIndex := 4
            SELF:lengthTextBox:Validating += System.ComponentModel.CancelEventHandler{ SELF, @lengthTextBox_Validating() }
            // 
            // label4
            // 
            SELF:label4:AutoSize := true
            SELF:label4:Location := System.Drawing.Point{12, 114}
            SELF:label4:Name := "label4"
            SELF:label4:Size := System.Drawing.Size{99, 17}
            SELF:label4:TabIndex := 7
            SELF:label4:Text := "Field Decimals"
            // 
            // decTextBox
            // 
            SELF:decTextBox:Location := System.Drawing.Point{115, 111}
            SELF:decTextBox:MaxLength := 2
            SELF:decTextBox:Name := "decTextBox"
            SELF:decTextBox:Size := System.Drawing.Size{155, 22}
            SELF:decTextBox:TabIndex := 6
            SELF:decTextBox:Validating += System.ComponentModel.CancelEventHandler{ SELF, @decTextBox_Validating() }
            // 
            // okButton
            // 
            SELF:okButton:Location := System.Drawing.Point{195, 152}
            SELF:okButton:Name := "okButton"
            SELF:okButton:Size := System.Drawing.Size{75, 23}
            SELF:okButton:TabIndex := 8
            SELF:okButton:Text := "&Ok"
            SELF:okButton:UseVisualStyleBackColor := true
            SELF:okButton:Click += System.EventHandler{ SELF, @okButton_Click() }
            // 
            // typeCombo
            // 
            SELF:typeCombo:DropDownStyle := System.Windows.Forms.ComboBoxStyle.DropDownList
            SELF:typeCombo:FormattingEnabled := true
            SELF:typeCombo:Location := System.Drawing.Point{115, 45}
            SELF:typeCombo:Name := "typeCombo"
            SELF:typeCombo:Size := System.Drawing.Size{121, 24}
            SELF:typeCombo:TabIndex := 9
            SELF:typeCombo:SelectedIndexChanged += System.EventHandler{ SELF, @typeCombo_SelectedIndexChanged() }
            // 
            // labelError
            // 
            SELF:labelError:AutoSize := true
            SELF:labelError:ForeColor := System.Drawing.Color.Red
            SELF:labelError:Location := System.Drawing.Point{12, 158}
            SELF:labelError:Name := "labelError"
            SELF:labelError:Size := System.Drawing.Size{0, 17}
            SELF:labelError:TabIndex := 10
            // 
            // FieldWindow
            // 
            SELF:AcceptButton := SELF:okButton
            SELF:AutoScaleDimensions := System.Drawing.SizeF{8, 16}
            SELF:AutoScaleMode := System.Windows.Forms.AutoScaleMode.Font
            SELF:ClientSize := System.Drawing.Size{282, 192}
            SELF:Controls:Add(SELF:labelError)
            SELF:Controls:Add(SELF:typeCombo)
            SELF:Controls:Add(SELF:okButton)
            SELF:Controls:Add(SELF:label4)
            SELF:Controls:Add(SELF:decTextBox)
            SELF:Controls:Add(SELF:label3)
            SELF:Controls:Add(SELF:lengthTextBox)
            SELF:Controls:Add(SELF:label2)
            SELF:Controls:Add(SELF:label1)
            SELF:Controls:Add(SELF:nameTextBox)
            SELF:FormBorderStyle := System.Windows.Forms.FormBorderStyle.FixedDialog
            SELF:MaximizeBox := false
            SELF:MinimizeBox := false
            SELF:Name := "FieldWindow"
            SELF:StartPosition := System.Windows.Forms.FormStartPosition.CenterParent
            SELF:Text := "Field Information"
            SELF:ResumeLayout(false)
            SELF:PerformLayout()
                            
        #endregion
    
    END CLASS 
END NAMESPACE
