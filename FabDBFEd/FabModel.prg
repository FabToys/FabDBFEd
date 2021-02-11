// FabModel.prg
// Created by    : fabri
// Creation Date : 2/11/2021 7:53:40 PM
// Created for   : 
// WorkStation   : FABPORTABLE


USING System
USING System.Collections.Generic
USING System.Text
USING XSharp.RDD.Support
USING System.IO
USING XSharp.RDD.Enums

BEGIN NAMESPACE FabDBFEd
	
	FUNCTION ModelCreate( fileName AS STRING, rddInfo AS List<RddFieldInfo>, rdd AS STRING ) AS LOGIC
		LOCAL model AS FabModel
		//
		model := FabModel{ rddInfo, rdd }
		RETURN model:Save( fileName )
	
	/// <summary>
	/// The FabModel class.
	/// </summary>
	CLASS FabModel
		PROPERTY Container AS STRING GET File.ReadAllText( "RecordModel.prg" )
		
	PRIVATE fields AS List<RddFieldInfo>
		
		CONSTRUCTOR(rddInfo AS List<RddFieldInfo>, rdd AS STRING )
			SELF:fields := rddInfo
			RETURN
		
		METHOD Save( fileName AS STRING ) AS LOGIC
			LOCAL code AS StringBuilder
			code := StringBuilder{ SELF:Container }
			//
			VAR dbName := Path.GetFileNameWithoutExtension( fileName )
			code:Replace( "<@modelclass@>", dbName )
			//
			VAR props := StringBuilder{}
			FOREACH fieldInfo AS RddFieldInfo IN fields
				//
				props:Append( "// " )
				props:Append( fieldInfo:Name )
				props:Append( "," )
				props:Append( fieldInfo:FieldTypeStr )
				props:Append( "," )
				props:Append( fieldInfo:Length )
				props:Append( "," )
				props:Append( fieldInfo:Decimals )
				props:Append( Environment.NewLine )
				props:Append( "PROPERTY " )
				props:Append( fieldInfo:Name )
				props:Append( " AS " )
				props:Append( SELF:GetType( fieldInfo ))
				props:Append( " AUTO" )
				props:Append( Environment.NewLine )
			NEXT
			//
			code:Replace( "<@properties@>", props:ToString())
			//
			VAR inits := StringBuilder{}
			FOREACH fieldInfo AS RddFieldInfo IN fields
				//
				inits:Append( "SELF:" )
				inits:Append( fieldInfo:Name )
				inits:Append( " := FieldGet(FieldPos(" )
				inits:Append( '"')
				inits:Append( fieldInfo:Name )
				inits:Append( '"')
				inits:Append( "))")
				inits:Append( Environment.NewLine )
			NEXT
			//
			code:Replace( "<@inits@>", inits:ToString())
			//
			inits := StringBuilder{}
			FOREACH fieldInfo AS RddFieldInfo IN fields
				//
				inits:Append( "SELF:" )
				inits:Append( fieldInfo:Name )
				inits:Append( " := itemToCopy:" )
				inits:Append( fieldInfo:Name )
				inits:Append( Environment.NewLine )
			NEXT
			//
			code:Replace( "<@initcopy@>", inits:ToString())
			//						
			LOCAL dest AS StreamWriter
			dest := StreamWriter{ fileName }
			dest:Write(code:ToString())
			dest:Close()
			//
			RETURN TRUE
		
		METHOD GetType( fieldInfo AS RddFieldInfo ) AS STRING
			// Commented out types are Harbour specific
			SWITCH fieldInfo:FieldType
				CASE DbFieldType.Character   // C
				CASE DbFieldType.VarChar     // 'V'
				CASE DbFieldType.VarBinary   // 'Q'
					RETURN "String"
				CASE DbFieldType.DateTime      // 'T'					
				CASE DbFieldType.Date        // D
					RETURN "DateTime"
				CASE DbFieldType.Number      // N
					IF fieldInfo:Decimals > 0
						RETURN "Double"
					ENDIF
					RETURN "INT"
				CASE DbFieldType.Memo        // M
					RETURN "STRING"
				CASE DbFieldType.Picture        // 'P'
				CASE DbFieldType.General        // 'G'
				CASE DbFieldType.Blob           // 'W'
					RETURN "OBJECT"
				CASE DbFieldType.Logic       // L
					RETURN "LOGIC"
				CASE DbFieldType.Integer    // 'I' 
					RETURN "INT"
				CASE DbFieldType.Float          // 'F'					
				CASE DbFieldType.Double         // 'B'
					RETURN "Double"
				CASE DbFieldType.VOObject       // 'O'
				CASE DbFieldType.Unknown        // 'O'
				OTHERWISE
					RETURN "OBJECT"
			END SWITCH		
			RETURN "OBJECT"
			
			END CLASS
END NAMESPACE // FabDBFEd