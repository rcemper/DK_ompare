/// <pre>
/// Copyright (c) Alex Woodhead 2020
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
/// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
/// 
/// License MIT
/// Source: https://github.com/alexatwoodhead/ompare
/// Version: 1.0
/// </pre>
Class ompare.Report.ExportExcelWorkbook Extends %CSP.Page
{

Parameter LineHeight = 15.75;

Parameter MaxLineHeight = 1000;

Parameter eol = "&#10;";

Parameter MaxTRCListLength = 10;

Parameter RPTSame = 1;

Parameter RPTDifferent = 2;

Parameter RPTMissing = 3;

Parameter RPTExtra = 4;

Parameter RPTNotApplicable = 5;

Parameter RPTTypeClasses = "C";

Parameter RPTSubTypeSummary = "S";

Parameter RPTSubTypeStorage = "ST";

Parameter RPTSubTypeParameter = "PR";

Parameter RPTSubTypeProperty = "P";

Parameter RPTSubTypeMethod = "M";

Parameter RPTSubTypeMethodSignature = "MS";

Parameter RPTSubTypeXData = "X";

Parameter RPTTypeRoutines = "R";

Parameter RPTSubTypeLineLabel = "L";

Parameter RPTTypeVirtual = "V";

Parameter RPTSubTypeHL7 = "HL7";

Parameter RPTSubTypeAST = "AST";

Parameter RTPTypeEnsLookup = "LUT";

Parameter RPTSubTypeEnsLookupKey = "Key";

Parameter RPTTypeRules = "RUL";

Parameter RPTTypeDLLS = "DLL";

Parameter RTPTypeSQL = "SQL";

ClassMethod OnPage() As %Status
{
	set workBook=##class(Workbook).%OpenId($G(%request.Data("WorkBook",1)))
	if '$IsObject(workBook) {
		W !,"<h1>Unknown Report Workbook</h1>"
 		Kill ^||Local
 		Quit $$$OK
	}
	
	// Initalise document view
	Do ..BeginDocument()
	
	// Start WorkSheets
 	Do ..WorkSheetOverview(workBook)
 	
 	set worksheetItem="",key=""
 	for {
	 	set worksheetItem=workBook.DefinitionNames.GetNext(.key)
	 	quit:key=""
	 	Do ..WorkSheetReport(worksheetItem,workBook)
 	}
 	
 	Do ..EndDocument()
 	Kill ^||Local
 	
	Quit $$$OK
}

/// Event handler for <b>PreHTTP</b> event: this is invoked before
/// the HTTP headers for a CSP page have been sent.  All changes to the
/// <class>%CSP.Response</class> class, such as adding cookies, HTTP headers,
/// setting the content type etc. must be made from within the OnPreHTTP() method.
/// Also changes to the state of the CSP application such as changing
/// %session.EndSession or %session.AppTimeout must be made within the OnPreHTTP() method.
/// It is prefered that changes to %session.Preserve are also made in the OnPreHTTP() method
/// as this is more efficient, although it is supported in any section of the page.
/// Return <b>0</b> to prevent <method>OnPage</method> from being called.
ClassMethod OnPreHTTP() As %Boolean [ ServerOnly = 1 ]
{
	set workBook=##class(Workbook).%OpenId($G(%request.Data("WorkBook",1)))
	if '$IsObject(workBook) {
		// Default
		set %response.ContentType="text/html"
	} else {
		set %response.ContentType="application/vnd.ms-excel"
		do %response.SetHeader("Content-Disposition", "attachment; filename=ompareReport_"_workBook.Name_"_"_$TR($ZDT($H,3),"- :")_".xls")
	}
	Quit $$$OK
}

ClassMethod BeginDocument()
{
 W "<?xml version=""1.0""?>"
 W !,"<?mso-application progid=""Excel.Sheet""?>"
 W !,"<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet"" "
 W "xmlns:o=""urn:schemas-microsoft-com:office:office"" "
 W "xmlns:x=""urn:schemas-microsoft-com:office:excel"" "
 W "xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet"" "
 W "xmlns:html=""http://www.w3.org/TR/REC-html40"">"
 W !,"<DocumentProperties xmlns=""urn:schemas-microsoft-com:office:office"">"
 W !,"<Created>",$TR($ZDT($H,3)," ","T"),"Z</Created>"
 W !,"<LastSaved>",$TR($ZDT($H,3)," ","T"),"Z</LastSaved>"
 W !,"<Version>14.00</Version>"
 W !,"</DocumentProperties>"
 W !,"<OfficeDocumentSettings xmlns=""urn:schemas-microsoft-com:office:office"">"
 W !,"<AllowPNG/>"
 W !,"<RemovePersonalInformation/>"
 W !,"</OfficeDocumentSettings>"
 W !,"<ExcelWorkbook xmlns=""urn:schemas-microsoft-com:office:excel"">"
 W !,"<WindowHeight>7950</WindowHeight>"
 W !,"<WindowWidth>14805</WindowWidth>"
 W !,"<WindowTopX>240</WindowTopX>"
 W !,"<WindowTopY>165</WindowTopY>"
 W !,"<ProtectStructure>False</ProtectStructure>"
 W !,"<ProtectWindows>False</ProtectWindows>"
 W !,"</ExcelWorkbook>"
 W !,"<Styles>"
 W !,"<Style ss:ID=""Default"" ss:Name=""Normal"">"
 W !,"<Alignment ss:Vertical=""Top""/>"
 W !,"<Borders/>"
 W !,"<Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11"" ss:Color=""#000000""/>"
 W !,"<Interior/>"
 W !,"<NumberFormat/>"
 W !,"<Protection/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s62"">"
 W !,"<Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s64"">"
 W !,"<Borders>"
 W !,"<Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"</Borders>"
 W !,"<Interior ss:Color=""#B8CCE4"" ss:Pattern=""Solid""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s65"">"
 W !,"<Borders>"
 W !,"<Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"<Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1""/>"
 W !,"</Borders>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s66"">"
 W !,"<Interior ss:Color=""#D8E4BC"" ss:Pattern=""Solid""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s67"">"
 W !,"<Alignment ss:Vertical=""Top"" ss:WrapText=""1""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s68"" ss:Name=""Hyperlink"">"
 W !,"<Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11"" ss:Color=""#0000FF"" ss:Underline=""Single""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""sNoWrap"">"
 W !,"<Alignment ss:Vertical=""Top"" ss:WrapText=""0""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s135"">"
 W !,"<Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""48"" ss:Color=""#366092""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s137"">"
 W !,"<Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""12"" ss:Color=""#366092""/>"
 W !,"</Style>"
 W !,"<Style ss:ID=""s139"">"
 W !,"<Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11""/>"
 W !,"</Style>"
 W !,"</Styles>"
}

ClassMethod EndDocument()
{
 w !,"</Workbook>"
}

ClassMethod XMLO(val) [ CodeMode = expression ]
{
$ZCVT(val,"O","XML")
}

ClassMethod TrakCareEnvironmentName() [ CodeMode = expression ]
{
$p($g(^CF("SM",1)),"^",5)
}

/// Excel WorkSheet Report<br/>
/// Summary of Edition Security Groups
ClassMethod WorkSheetOverview(workBook As Workbook)
{
 // Unpack WorkBook Description for display
 set workbookDescriptionLines=0
 // Strip some illegal characters for XML
 set workbookDescription=$TR(workBook.Description,$C(0,1,2,3,4,5,6,7,8,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31))
 // Default if needed
 set:workbookDescription="" workbookDescription="A composite report to identify specific Source Code and Integration configuration differences between deployment environments."_$C(10)_"Each Worksheet represents output for a named ompare configured report."
 // Rearrange line formatting.
 // Read the words in, break on whole words
 set len=$L(workbookDescription)
 set endLastWord=0
 set charCount=0
 set char=" "
 for i=1:1:len {
	set prev=char
	set char=$E(workbookDescription,i)
	quit:char=""
	if char=" ",prev'=" " set endLastWord=i-1
	set charCount=charCount+1
	// Hit new line so reset counters
	if char=$C(10) {
		set endLastWord=i+1
		// Reset lette count
		set charCount=0
	} elseif charCount>90 {
		set workbookDescription=$E(workbookDescription,1,endLastWord)_$C(10)_$E(workbookDescription,endLastWord+1,*)
		set len=len+1
		set charCount=i-endLastWord
	}
 }
 
 set workbookDescriptionLines=$L(workbookDescription,$C(10))
 // Escape content for XML
 //set workbookDescriptionLines=..XMLO(workbookDescriptionLines)
 // Swap new lines for XML entities for multi-line formatting
 set workbookDescription=$REPLACE(workbookDescription,$C(10),..#eol)
 
 set WorkSheetName="Overview"
 
 W !,"<Worksheet ss:Name=""",..XMLO(WorkSheetName),""">"
  
 // Start of worksheet content ****************
 
 
 W !,"<Table ss:ExpandedColumnCount=""3"" x:FullColumns=""1"" x:FullRows=""1"" ss:DefaultRowHeight=""15"">"
 W !,"<Column ss:Index=""2"" ss:AutoFitWidth=""0"" ss:Width=""137.25""/>"
 W !,"<Column ss:AutoFitWidth=""0"" ss:Width=""530.25""/>"
 W !,"<Row ss:AutoFitHeight=""0""/>"
 W !,"<Row ss:AutoFitHeight=""0"">"
 W !,"<Cell ss:Index=""3"" ss:StyleID=""s139""><Data ss:Type=""String"">",..XMLO(workBook.Vendor),"</Data></Cell>"
 W !,"</Row>"
 W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""70.5"">"
 W !,"<Cell ss:Index=""3"" ss:StyleID=""s135""><ss:Data ss:Type=""String"" xmlns=""http://www.w3.org/TR/REC-html40"">"
 
 set productStr=workBook.Product
 set productStrLen=$L(productStr)
 set capPrev=-1
 for pos=1:1:productStrLen {
	set letter=$E(productStr,pos)
	set cap=($ZCVT(letter,"U")=letter)
	if cap'=capPrev {
		w:(capPrev>-1) "</Font>"
		set capPrev=cap
		if cap {
			W "<Font html:Color=""#366092"">"	
		} else {
			W "<Font html:Size=""36"" html:Color=""#366092"">"
		}
	}
	W ..XMLO($ZCVT(letter,"U"))
	W:pos=productStrLen "</Font>"
 }
 
 set cap=1
 
 /*
 W "<Font html:Color=""#366092"">T</Font><Font "
 W "html:Size=""36"" html:Color=""#366092"">RAK</Font><Font html:Color=""#366092"">C</Font><Font "
 W "html:Size=""36"" html:Color=""#366092"">ARE</Font><Font html:Color=""#366092"">L</Font><Font "
 W "html:Size=""36"" html:Color=""#366092"">AB</Font><Sup><Font html:Size=""28"" "
 W "html:Color=""#366092"">&#00174;</Font></Sup>" */
 
 W "</ss:Data></Cell>"
 W !,"</Row>"
 W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",..#LineHeight,""">"
 W !,"<Cell ss:Index=""3"" ss:StyleID=""s137""><Data ss:Type=""String"">   ",..XMLO(workBook.CustomerSite),"</Data></Cell>"
 W !,"</Row>"
 W !,"<Row ss:AutoFitHeight=""0""/>"
 //W !,"<Row ss:AutoFitHeight=""0"">"
 //W !,"<Cell ss:Index=""2""><Data ss:Type=""String"">Source Environment</Data></Cell>"
 //W !,"<Cell><Data ss:Type=""String"">",..XMLO(..TrakCareEnvironmentName()),"</Data></Cell>"
 //W !,"</Row>"
 W !,"<Row ss:AutoFitHeight=""0"">"
 W !,"<Cell ss:Index=""2""><Data ss:Type=""String"">Report System</Data></Cell>"
 W !,"<Cell><Data ss:Type=""String"">",..XMLO(##class(%SYS.System).GetNodeName(1)),"</Data></Cell>"
 W !,"</Row>"
 
 W !,"<Row ss:AutoFitHeight=""0"">"
 W !,"<Cell ss:Index=""2""><Data ss:Type=""String"">Creation Date Time</Data></Cell>"
 W !,"<Cell><Data ss:Type=""String"">",..XMLO($ZDT($H,3)),"</Data></Cell>"
 W !,"</Row>"
 
 W !,"<Row ss:Index=""10"" ss:AutoFitHeight=""0"" ss:Height=""",..CapLineHeight(workbookDescriptionLines*..#LineHeight),""">"
 W !,"<Cell></Cell>"
 W !,"<Cell></Cell>"
 W !,"<Cell ss:StyleID=""s67""><Data ss:Type=""String"">",workbookDescription,"</Data></Cell>"
 W !,"</Row>"
 
 W !,"<Row ss:Index=""20"" ss:AutoFitHeight=""0"">"
 W !,"<Cell ss:Index=""3""><Data ss:Type=""String"">&#00169; ",..XMLO(workBook.Vendor)_". All Rights Reserved.</Data></Cell>"
 W !,"</Row>"
 
 // End of Worksheet content ******************
 
 W !,"</Table>"
 w !,"<WorksheetOptions xmlns=""urn:schemas-microsoft-com:office:excel"">"
 w !,"<PageSetup>"
 w !,"<Header x:Margin=""0.3""/>"
 w !,"<Footer x:Margin=""0.3""/>"
 w !,"<PageMargins x:Bottom=""0.75"" x:Left=""0.7"" x:Right=""0.7"" x:Top=""0.75""/>"
 w !,"</PageSetup>"
 w !,"<Unsynced/>"
 w !,"<Selected/>"
 
 w !,"<ProtectObjects>False</ProtectObjects>"
 w !,"<ProtectScenarios>False</ProtectScenarios>"
 w !,"</WorksheetOptions>"
 w !,"</Worksheet>"
}

ClassMethod WorkSheetDLLS(reportname)
{
	set WorkSheetName=reportname
 
 	set missingDefinition=0
 	set definition=##class(LabTechUK.SourceUtil.Report.Definition).%OpenId(reportname)
 	if '$IsObject(definition) {
		set definition=##class(LabTechUK.SourceUtil.Report.Definition).%New()
		set missingDefinition=1
		// TODO - Default Page for Missing Report
		//Quit  // Nothing to process
 	}
 
 	set numberofenvironments=0
 	set env=""
 	for {
		set env=$Order(definition.Environments(env))
		quit:env=""
		set numberofenvironments=numberofenvironments+1
 	}
}

/// Parameters:<ul>
/// <li>reportname - Report that is being rendered as a Worksheet</li>
/// <li>TRCLinks - Boolean to indicate whether TRC numbers should be rendered as Hyperlinks or as a plain list.</li>
/// </ul>
ClassMethod WorkSheetReport(reportname = "", workBook As Workbook)
{
	#define defintion as Definition
 set WorkSheetName=reportname
 set missingDefinition=0
 set definition=##class(Definition).%OpenId(reportname)
 //set definition=##class(LabTechUK.SourceUtil.Report.Definition).%OpenId(reportname)
 if '$IsObject(definition) {
	set missingDefinition=1
	// Nothing to process
 }
 
 set numberofenvironments=0
 set env="",key=""
 if 'missingDefinition {
 	for {
		set env=definition.Environments.GetNext(.key)
		quit:key=""
		continue:env=""
		set numberofenvironments=numberofenvironments+1
 	}
 }
 
 // Use the WorkSheet TagName Alias on the report if defined.
 // Else use the first 31 characters of the Report name
 set tWorksheetname=""
 if missingDefinition {
	//W !,"<Worksheet ss:Name=""ERROR"">"
	set tWorksheetname="ERROR"
 } elseif definition.WorksheetTabName'="" {
	//W !,"<Worksheet ss:Name=""",..XMLO(definition.WorksheetTabName),""">"
	set tWorksheetname=definition.WorksheetTabName
 } else { 
 	//W !,"<Worksheet ss:Name=""",..XMLO($E(WorkSheetName,1,31)),""">"
 	set tWorksheetname=reportname
 }
 Quit:tWorksheetname=""
 set tWorksheetname=$E(tWorksheetname,1,31)
 // TODO - Normalize the TAG name
 do {
 	Set num=$I(^||Local("ReportName",tWorksheetname))
 	set:num>1 tWorksheetname=tWorksheetname_num
 } while (num>1)
 set WorkSheetName=$E(tWorksheetname,*-30,*)
 W !,"<Worksheet ss:Name=""",..XMLO(WorkSheetName),""">"
 
 
 W !,"<Table x:FullColumns=""1"" "
 W !,"x:FullRows=""1"" ss:DefaultRowHeight=""15"">"
 // Sequence number column
 W !,"<Column ss:Index=""1"" ss:AutoFitWidth=""0"" ss:Width=""65""/>"
 // Classname column
 W !,"<Column ss:Index=""2"" ss:AutoFitWidth=""0"" ss:Width=""200""/>"
 // Column for From Environment
 W !,"<Column ss:Index=""3"" ss:AutoFitWidth=""0"" ss:Width=""100""/>"
 for i=3:1:numberofenvironments+1 {
 	W !,"<Column ss:Index=""",i+1,""" ss:AutoFitWidth=""0"" ss:Width=""300""/>"
 }
 
 if missingDefinition {
	W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",..#LineHeight,""">"
	W !,"<Cell><Data ss:Type=""String"">",..XMLO("The Report called """_reportname_""" cannot be found. It may have been deleted or renamed."),"</Data></Cell>"
	W !,"</Row>"
	goto end
 }
 
 // Empty configured report warning
 if definition.IsEmptyReport()
 {
	// Empty Report Section
	// No Classes, Routines, Ensemble Lookups,
	W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",..#LineHeight,""">"
	W !,"<Cell><Data ss:Type=""String"">",..XMLO("The Report called """_definition.ReportName_""" is not configured to include information."),"</Data></Cell>"
	W !,"</Row>"
	goto end
 }
 
 set tSC=definition.ProcessReport()
 if $$$ISERR(tSC)
 {
	
	W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",..#LineHeight,""">"
	W !,"<Cell><Data ss:Type=""String"">",..XMLO("There was a problem processing the Report called """_definition.ReportName_"""."),"</Data></Cell>"
	W !,"</Row>"
	W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",..#LineHeight,""">"
	W !,"<Cell><Data ss:Type=""String"">",..XMLO($SYSTEM.Status.GetOneErrorText(tSC)),"</Data></Cell>"
	W !,"</Row>"
	goto end	
 }
  
 // Extensible mechanism
 // Implement DrawExcelReportSection for ReportType to Participate in Excel Workbook reports
 // Itterate over subclasses of ompare.ReportType.Base
 /*
 set rs=##class(%ResultSet).%New()
 set rs.ClassName="%Dictionary.ClassDefinition"
 set rs.QueryName="SubclassOf"
 if rs.Execute("ompare.ReportType.Base") {
	while rs.Next() {
		set reportType=rs.Data("Name")
		set perNamespace=$PARAMETER(reportType,"ReportOrder")
		set documentType=$PARAMETER(reportType,"DocumentType")
		if 'definition.IsEmptyReportType(documentType) {
			try {
				do $CLASSMETHOD(reportType,"DrawExcelReportSection",definition)
			} catch {
				W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",..#LineHeight,""">"
				W !,"<Cell><Data ss:Type=""String"">Error processing ReportType ",..XMLO(reportType)," at DrawExcelReportSection</Data></Cell>"
				W !,"</Row>"	
			}
			// Spacer needed if following data - Harmless if there is no subsequent data
 			//W !,"<Row></Row>"
		}
	}
 } */
 
 set key=""
 for {
	set reportType=definition.ReportTypes.GetNext(.key)
	quit:key=""
	continue:'$IsObject(reportType)
	do:'reportType.IsEmptyReport() reportType.DrawExcelReportSection(definition,numberofenvironments,reportType)

 }
end
 w !,"</Table>"
 w !,"<WorksheetOptions xmlns=""urn:schemas-microsoft-com:office:excel"">"
 w !,"<PageSetup>"
 w !,"<Header x:Margin=""0.3""/>"
 w !,"<Footer x:Margin=""0.3""/>"
 w !,"<PageMargins x:Bottom=""0.75"" x:Left=""0.7"" x:Right=""0.7"" x:Top=""0.75""/>"
 w !,"</PageSetup>"
 w !,"<Unsynced/>"
 w !,"<Selected/>"
 w !,"<FreezePanes/>"
 W !,"<FrozenNoSplit/>"
 W !,"<SplitVertical>2</SplitVertical>"
 W !,"<LeftColumnRightPane>1</LeftColumnRightPane>"
 W !,"<ActivePane>1</ActivePane>"
 W !,"<Panes>"
 W !,"<Pane>"
 W !,"<Number>3</Number>"
 W !,"</Pane>"
 W !,"<Pane>"
 W !,"<Number>1</Number>"
 W !,"<ActiveRow>3</ActiveRow>"
 W !,"<ActiveCol>2</ActiveCol>"
 W !,"</Pane>"
 W !,"</Panes>"
 w !,"<ProtectObjects>False</ProtectObjects>"
 w !,"<ProtectScenarios>False</ProtectScenarios>"
 w !,"</WorksheetOptions>"
 w !,"</Worksheet>"
 
 // Tidy up process
 kill ^||ReportData
}

ClassMethod RTPEnumToText(val) [ CodeMode = expression ]
{
$Case(val,..#RPTSame:"Same",..#RPTDifferent:"Different",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - ")
}

ClassMethod CapLineHeight(val = 0) [ CodeMode = expression ]
{
$Select((val>..#MaxLineHeight):(..#MaxLineHeight),1:val)
}

ClassMethod ReportIfEmptySection(same = 0, differences = 0, missing = 0, extra = 0)
{
	Quit:(same+differences+missing+extra)=0
	set count=same+differences+missing+extra
	Quit:count=0

	set message="No Reportable information to display for categor"_$S(count=1:"y",1:"ies")
	set item=0
	
	if same {
		set item=item+1
		set:item>1 message=message_($S(item=count:" and",1:","))
		set message=message_" ""same"""
	}
	if differences {
		set item=item+1
		set:item>1 message=message_($S(item=count:" and",1:","))
		set message=message_" ""differences"""
	}
	if missing {
		set item=item+1
		set:item>1 message=message_($S(item=count:" and",1:","))
		set message=message_" ""missing"""
	}
	if extra {
		set item=item+1
		set:item>1 message=message_($S(item=count:" and",1:","))
		set message=message_" ""extra"""
	}
	set message=message_"."	
		
	W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",..#LineHeight,""">"
			//W !,"<Row>"  // TODO - Do we need to know the expanded row height?
	W !,"<Cell><Data ss:Type=""String"">",..XMLO(message),"</Data></Cell>"
	W !,"</Row>"
}

}

