//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//

USING System
USING System.Data
USING XSharp.RDD
USING System.Reflection



FUNCTION FabDbDataTable() AS FabDbDataTable
LOCAL oResult := NULL AS OBJECT
IF CoreDb.Info(DBI_RDD_OBJECT,REF oResult)
    // Read the current RDD Object (The current WorkArea)
    VAR oRDD := (IRdd) oResult
    // Create a FabDbDataTable object for this WorkArea
    RETURN FabDbDataTable{oRDD}
ENDIF
RETURN NULL

/// <summary>This class is used to create a System.Data.DataTable from a workarea</summary>
/// <remarks>The data in this table is detached from the workarea. So if you make changes to the
/// data you will have to write that back to the workarea yourself.
/// </remarks>
CLASS FabDbDataTable INHERIT DataTable
    PROTECT _nAdding AS LONG
    PROTECT _nArea   AS LONG

    PRIVATE DELEGATE DbGetData() AS OBJECT[]

    /// <summary>Create a datatable from an IRdd object</summary>
    /// <remarks>The structure of the table will be derived from the structure of the workarea.
    /// and for each row in the workarea there will be a DbDataRow added to the table
    /// You can use the normal events for the DataTable class to monitor changes.
    /// and use the GetChanges() method from the DataTable class to retrieve a subset of the table with changed rows.
    /// </remarks>
    CONSTRUCTOR(oRDD AS IRdd)
        SUPER(oRDD:Alias)
        SELF:_nArea := (INT) oRDD:Area
        SELF:BuildColumns(oRDD)
        SELF:AddData(oRDD)
        SELF:AcceptChanges()


    // Read all the Columns/Fields, and Add a Deleted Column
    PRIVATE METHOD BuildColumns(oRDD AS IRdd) AS VOID
        LOCAL nI AS LONG
        LOCAL aColumns AS DbColumnInfo[]
        aColumns := DbColumnInfo[]{oRDD:FieldCount}
        IF oRDD:Driver == "DBFVFPSQL"
            FOR nI := 1 TO aColumns:Length
                LOCAL oResult AS OBJECT
                oResult := oRDD:FieldInfo(nI, DBS_COLUMNINFO,NULL)
                IF oResult IS DbColumnInfo VAR info
                    aColumns[nI] := info
                ELSE
                    LOCAL cField := oRDD:FieldName(nI) AS STRING
                    LOCAL cType  := (STRING) oRDD:FieldInfo(nI, DBS_TYPE,NULL) AS STRING
                    LOCAL nLen   := (LONG) oRDD:FieldInfo(nI, DBS_LEN,NULL) AS LONG
                    LOCAL nDec   := (LONG) oRDD:FieldInfo(nI, DBS_DEC,NULL) AS LONG
                    VAR oColumn := DbColumnInfo{cField, cType+":0", nLen, nDec}
                    oColumn:Ordinal := nI
                    aColumns[nI] := oColumn
                ENDIF
            NEXT
        ELSE
            FOR nI := 1 TO aColumns:Length
                LOCAL cField := oRDD:FieldName(nI) AS STRING
                LOCAL cType  := (STRING) oRDD:FieldInfo(nI, DBS_TYPE,NULL) AS STRING
                LOCAL nLen   := (LONG) oRDD:FieldInfo(nI, DBS_LEN,NULL) AS LONG
                LOCAL nDec   := (LONG) oRDD:FieldInfo(nI, DBS_DEC,NULL) AS LONG
                VAR oColumn := DbColumnInfo{cField, cType+":0", nLen, nDec}
                oColumn:Ordinal := nI
                aColumns[nI] := oColumn
            NEXT
		ENDIF
		// Add a Deleted Column
		LOCAL delColumn AS DbDataColumn
		delColumn := DbDataColumn{ DbColumnInfo{ "Deleted", "C:0", 1,0 } }
		//delColumn:ReadOnly := TRUE
		SELF:Columns:Add( delColumn )
		//
        FOREACH oDbCol AS DbColumnInfo IN aColumns
            SELF:Columns:Add(DbDataColumn{oDbCol})
        NEXT
        RETURN


    // Read ALL the records for the current DBF (oRDD) 
    // Read a Line/Record
    // Copy all the Fields data to the oData array
    // and copy the oData to the DataTable (to the Rows collection)
    PRIVATE METHOD AddData(oRDD AS IRdd) AS VOID
        VAR nOld := oRDD:RecNo
        oRDD:GoTop()
        VAR nFldCount := oRDD:FieldCount
        DO WHILE ! oRDD:EoF
            LOCAL oData AS OBJECT[]
            oData := OBJECT[]{nFldCount+1}
			oData[1] := IIF( oRDD:Deleted, "*", " " )
            FOR VAR nI := 1 TO nFldCount
                oData[nI+1] := oRDD:GetValue(nI)
            NEXT
            SELF:_AddRow(oData,oRDD:RecNo)
            oRDD:Skip(1)
        ENDDO
        oRDD:GoTo(nOld)

    
    OVERRIDE PROTECTED METHOD NewRowFromBuilder(builder AS DataRowBuilder ) AS DataRow
        RETURN FabDbDataRow{builder, SELF:_nAdding}
    
    PRIVATE METHOD _AddRow(oData AS OBJECT[], nRecord AS LONG) AS VOID
        SELF:_nAdding := nRecord
        SELF:Rows:Add(oData)
        RETURN
    

END CLASS




