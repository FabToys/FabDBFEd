USING System
USING System.Collections.Generic
USING System.ComponentModel
USING System.Data
USING System.Drawing
USING System.Text
USING System.Windows.Forms
BEGIN NAMESPACE FabDBFEd
	PUBLIC PARTIAL CLASS FieldWindow ;
		INHERIT System.Windows.Forms.Form
		PROPERTY FieldName AS STRING GET SELF:nameTextBox:Text SET SELF:nameTextBox:Text := VALUE
			
		PROPERTY FieldType AS STRING
			GET
				RETURN SELF:typeCombo:Items[SELF:typeCombo:SelectedIndex]:ToString() 
			END GET
			SET
				VAR pos := SELF:typeCombo:FindStringExact( VALUE )
				IF pos > - 1
					SELF:typeCombo:SelectedIndex := pos
				ENDIF
			END SET
		END PROPERTY
		
		PROPERTY FieldLength AS STRING GET SELF:lengthTextBox:Text SET SELF:lengthTextBox:Text := VALUE
		PROPERTY FieldDecimals AS STRING GET SELF:decTextBox:Text SET SELF:decTextBox:Text := VALUE
		
		
		PUBLIC CONSTRUCTOR() STRICT //FieldWindow
			InitializeComponent()
			// Dialect Dependent ??
			
			
		RETURN
		PRIVATE METHOD lengthTextBox_Validating(sender AS OBJECT, e AS System.ComponentModel.CancelEventArgs) AS VOID STRICT
			LOCAL isOk := FALSE AS LOGIC
			LOCAL result :=0 AS INT
			//
			If int32.TryParse( Self:lengthTextBox:Text, Ref result )
				isOk := ( Result > 0 )
			ENDIF
			//
			e:Cancel := !isOk
			IF !isOk
				SELF:labelError:Text := "Field Length is incorrect"
			ELSE
				SELF:labelError:Text := ""
			ENDIF
		RETURN
		PRIVATE METHOD decTextBox_Validating(sender AS OBJECT, e AS System.ComponentModel.CancelEventArgs) AS VOID STRICT
			LOCAL isOk := FALSE AS LOGIC
			LOCAL result :=0 AS INT
			LOCAL fLength := 0AS INT
			//
			IF int32.TryParse( SELF:decTextBox:Text, REF result )
				IF int32.TryParse( SELF:lengthTextBox:Text, REF fLength )
					IF result > 0
						isOk := ( fLength - (result+1) > 0 )
					ELSEIF result == 0
						isOk := TRUE
					ENDIF
				ENDIF
			ENDIF
			//
			e:Cancel := !isOk
			IF !isOk
				SELF:labelError:Text := "Field Decimals is incorrect"
			ELSE
				SELF:labelError:Text := ""
			ENDIF
		RETURN
		PRIVATE METHOD nameTextBox_Validating(sender AS OBJECT, e AS System.ComponentModel.CancelEventArgs) AS VOID STRICT
			LOCAL toCheck := nameTextBox:Text AS STRING
			LOCAL isOk := TRUE AS LOGIC
			//
			toCheck := toCheck:Trim()
			IF ( toCheck.Length > 0 ) .AND. ( toCheck.Length <= 10 )
					//
					FOR VAR i := 0 TO toCheck:Length-1
						LOCAL car := toCheck[i] AS CHAR
						IF CHAR.IsLetterOrDigit( car )
							LOOP
						ENDIF
						IF car == '_'
							LOOP
						ENDIF
						isOk := FALSE
						EXIT
				NEXT
			ELSE
				isOk := FALSE
			ENDIF
			//
			e:Cancel := !isOk
			IF !isOk
				SELF:labelError:Text := "Field Name is incorrect"
			ELSE
				SELF:labelError:Text := ""
			ENDIF
		RETURN
		PRIVATE METHOD okButton_Click(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			SELF:DialogResult := DialogResult.OK
		RETURN
		PUBLIC METHOD FillTypeCombo( dbfRDD AS STRING) AS VOID
			LOCAL typeList AS List<STRING>
			typeList := List<STRING>{}
			// Standard Field Type
			typeList:Add( "C" )
			typeList:Add( "D" )
			typeList:Add( "N" )
			typeList:Add( "L" )
			typeList:Add( "M" )
			//
			//            SWITCH dbfRDD
			//                CASE "DBFCDX"
			//                    
			//            END 
			//
			FOREACH VAR t IN typeList
				typeCombo:Items:Add(t)
			NEXT
		typeCombo:SelectedIndex := 0
		PRIVATE METHOD typeCombo_SelectedIndexChanged(sender AS OBJECT, e AS System.EventArgs) AS VOID STRICT
			IF SELF:FieldType == "D"
					SELF:FieldLength := "8"
					SELF:FieldDecimals := "0"
					SELF:lengthTextBox:Enabled := FALSE
				SELF:decTextBox:Enabled := FALSE
			ELSEIF SELF:FieldType == "M"
				SELF:FieldLength := "10"
				SELF:FieldDecimals := "0"
				SELF:lengthTextBox:Enabled := FALSE
				SELF:decTextBox:Enabled := FALSE
			ELSEIF SELF:FieldType == "L"
				SELF:FieldLength := "1"
				SELF:FieldDecimals := "0"
				SELF:lengthTextBox:Enabled := FALSE
				SELF:decTextBox:Enabled := FALSE
			ELSE
				SELF:FieldLength := "10"
				SELF:FieldDecimals := "0"
				SELF:lengthTextBox:Enabled := TRUE
				SELF:decTextBox:Enabled := TRUE
			ENDIF
			RETURN
			
		END CLASS 
END NAMESPACE
