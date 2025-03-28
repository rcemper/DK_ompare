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
Class ompare.ReportType.HL7 Extends ompare.ReportType.Base
{

/// Ensure this Code doesn't collide with other sub-class implementations of Base
/// Eg: "C" abbreviation for class
Parameter DocumentType As %String = "hl7";

Parameter RPTTypeHL7 = "HL7";

Parameter RPTSubTypeCategory = "HL7CAT";

Parameter RPTSubTypeMessageGroup = "HL7MG";

Parameter RPTSubTypeMessageEvent = "HL7ME";

Parameter RPTSubTypeMessageType = "HL7MT";

Parameter RPTSubTypeMessageStructure = "HL7MS";

Parameter RPTSubTypeSegmentStructure = "HL7SS";

Parameter RPTSubTypeDataType = "HL7DT";

Parameter RPTSubTypeCodeTable = "HL7CT";

Property SummaryShowSameHL7 As %Boolean [ InitialExpression = 0 ];

Property SummaryShowDifferentHL7 As %Boolean [ InitialExpression = 1 ];

Property SummaryShowMissingHL7 As %Boolean [ InitialExpression = 1 ];

Property SummaryShowExtraHL7 As %Boolean [ InitialExpression = 1 ];

Property SummaryIncludeMappedHL7 As %Boolean [ InitialExpression = 1 ];

Property SummaryIncludeUncontrolledHL7 As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameCategory As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentCategory As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingCategory As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraCategory As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameMessageGroup As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentMessageGroup As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingMessageGroup As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraMessageGroup As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameMessageEvent As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentMessageEvent As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingMessageEvent As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraMessageEvent As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameMessageType As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentMessageType As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingMessageType As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraMessageType As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameMessageStructure As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentMessageStructure As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingMessageStructure As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraMessageStructure As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameSegmentStructure As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentSegmentStructure As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingSegmentStructure As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraSegmentStructure As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameDataType As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentDataType As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingDataType As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraDataType As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameCodeTable As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentCodeTable As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingCodeTable As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraCodeTable As %Boolean [ InitialExpression = 1 ];

/// Subscript 3 = pattern
Property PatternHL7Exclude As list Of %String(MAXLEN = 10000);

/// Subscript 4 = pattern
Property PatternHL7Include As list Of %String(MAXLEN = 10000);

Parameter PageAnchor = "HL7";

Parameter ReportOrder = 10;

/// Called from ompare.Report.Defintion on subclass on ompare.ReportType.Base
/// Override in subclass
ClassMethod CreateDynamicReport(name As %String) As ompare.ReportType.Base
{
	set obj=..%New()
	set obj.SummaryShowSameHL7=1
	set obj.SummaryShowDifferentHL7=1
	set obj.SummaryShowMissingHL7=1
	set obj.SummaryShowExtraHL7=1
	set obj.SummaryIncludeMappedHL7=1
	set obj.SummaryIncludeUncontrolledHL7=1
	set obj.DetailShowSameCategory=0
	set obj.DetailShowDifferentCategory=1
	set obj.DetailShowMissingCategory=1
	set obj.DetailShowExtraCategory=1
	set obj.DetailShowSameMessageGroup=0
	set obj.DetailShowDifferentMessageGroup=1
	set obj.DetailShowMissingMessageGroup=1
	set obj.DetailShowExtraMessageGroup=1
	set obj.DetailShowSameMessageEvent=0
	set obj.DetailShowDifferentMessageEvent=1
	set obj.DetailShowMissingMessageEvent=1
	set obj.DetailShowExtraMessageEvent=1
	set obj.DetailShowSameMessageType=0
	set obj.DetailShowDifferentMessageType=1
	set obj.DetailShowMissingMessageType=1
	set obj.DetailShowExtraMessageType=1
	set obj.DetailShowSameMessageStructure=0
	set obj.DetailShowDifferentMessageStructure=1
	set obj.DetailShowMissingMessageStructure=1
	set obj.DetailShowExtraMessageStructure=1
	set obj.DetailShowSameSegmentStructure=0
	set obj.DetailShowDifferentSegmentStructure=1
	set obj.DetailShowMissingSegmentStructure=1
	set obj.DetailShowExtraSegmentStructure=1
	set obj.DetailShowSameDataType=0
	set obj.DetailShowDifferentDataType=1
	set obj.DetailShowMissingDataType=1
	set obj.DetailShowExtraDataType=1
	set obj.DetailShowSameCodeTable=0
	set obj.DetailShowDifferentCodeTable=1
	set obj.DetailShowMissingCodeTable=1
	set obj.DetailShowExtraCodeTable=1
	
	do obj.PatternHL7Exclude.Insert("*")
	do obj.PatternHL7Include.Insert(name)
	quit obj
}

/// Called from ompare.Report.Defintion on subclass on ompare.ReportType.Base
/// Override in subclass
Method PopulateReportParams(ByRef config, ByRef summary, ByRef detail, ByRef exclude, ByRef include)
{
	set:..SummaryShowSameHL7 summary(..#RPTTypeHL7,..#RPTSame)=""
	set:..SummaryShowDifferentHL7 summary(..#RPTTypeHL7,..#RPTDifferent)=""
	set:..SummaryShowMissingHL7 summary(..#RPTTypeHL7,..#RPTMissing)=""
	set:..SummaryShowExtraHL7 summary(..#RPTTypeHL7,..#RPTExtra)=""
	set:..SummaryIncludeMappedHL7 config(..#RPTTypeHL7,..#RPTMapped)=""
	set:..SummaryIncludeUncontrolledHL7 config(..#RPTTypeHL7,..#RPTSourceControlled)=""
	
	set:..DetailShowSameCategory detail(..#RPTSubTypeCategory,..#RPTSame)=""
	set:..DetailShowDifferentCategory detail(..#RPTSubTypeCategory,..#RPTDifferent)=""
	set:..DetailShowMissingCategory detail(..#RPTSubTypeCategory,..#RPTMissing)=""
	set:..DetailShowExtraCategory detail(..#RPTSubTypeCategory,..#RPTExtra)=""
	
	set:..DetailShowSameMessageGroup detail(..#RPTSubTypeMessageGroup,..#RPTSame)=""
	set:..DetailShowDifferentMessageGroup detail(..#RPTSubTypeMessageGroup,..#RPTDifferent)=""
	set:..DetailShowMissingMessageGroup detail(..#RPTSubTypeMessageGroup,..#RPTMissing)=""
	set:..DetailShowExtraMessageGroup detail(..#RPTSubTypeMessageGroup,..#RPTExtra)=""
	
	set:..DetailShowSameMessageEvent detail(..#RPTSubTypeMessageEvent,..#RPTSame)=""
	set:..DetailShowDifferentMessageEvent detail(..#RPTSubTypeMessageEvent,..#RPTDifferent)=""
	set:..DetailShowMissingMessageEvent detail(..#RPTSubTypeMessageEvent,..#RPTMissing)=""
	set:..DetailShowExtraMessageEvent detail(..#RPTSubTypeMessageEvent,..#RPTExtra)=""
	
	set:..DetailShowSameMessageType detail(..#RPTSubTypeMessageType,..#RPTSame)=""
	set:..DetailShowDifferentMessageType detail(..#RPTSubTypeMessageType,..#RPTDifferent)=""
	set:..DetailShowMissingMessageType detail(..#RPTSubTypeMessageType,..#RPTMissing)=""
	set:..DetailShowExtraMessageType detail(..#RPTSubTypeMessageType,..#RPTExtra)=""
	
	set:..DetailShowSameMessageStructure detail(..#RPTSubTypeMessageStructure,..#RPTSame)=""
	set:..DetailShowDifferentMessageStructure detail(..#RPTSubTypeMessageStructure,..#RPTDifferent)=""
	set:..DetailShowMissingMessageStructure detail(..#RPTSubTypeMessageStructure,..#RPTMissing)=""
	set:..DetailShowExtraMessageStructure detail(..#RPTSubTypeMessageStructure,..#RPTExtra)=""
	
	set:..DetailShowSameSegmentStructure detail(..#RPTSubTypeSegmentStructure,..#RPTSame)=""
	set:..DetailShowDifferentSegmentStructure detail(..#RPTSubTypeSegmentStructure,..#RPTDifferent)=""
	set:..DetailShowMissingSegmentStructure detail(..#RPTSubTypeSegmentStructure,..#RPTMissing)=""
	set:..DetailShowExtraSegmentStructure detail(..#RPTSubTypeSegmentStructure,..#RPTExtra)=""
	
	set:..DetailShowSameDataType detail(..#RPTSubTypeDataType,..#RPTSame)=""
	set:..DetailShowDifferentDataType detail(..#RPTSubTypeDataType,..#RPTDifferent)=""
	set:..DetailShowMissingDataType detail(..#RPTSubTypeDataType,..#RPTMissing)=""
	set:..DetailShowExtraDataType detail(..#RPTSubTypeDataType,..#RPTExtra)=""
	
	set:..DetailShowSameCodeTable detail(..#RPTSubTypeCodeTable,..#RPTSame)=""
	set:..DetailShowDifferentCodeTable detail(..#RPTSubTypeCodeTable,..#RPTDifferent)=""
	set:..DetailShowMissingCodeTable detail(..#RPTSubTypeCodeTable,..#RPTMissing)=""
	set:..DetailShowExtraCodeTable detail(..#RPTSubTypeCodeTable,..#RPTExtra)=""
	
	set key=""
	for {
		set pattern=..PatternHL7Exclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		set exclude(..#RPTTypeHL7,pattern)=""	
	}
	for {
		set pattern=..PatternHL7Include.GetNext(.key)
		quit:key=""
		continue:pattern=""
		set include(..#RPTTypeHL7,pattern)=""	
	}
}

Method IsEmptyReport() As %Boolean
{
	Quit:..SummaryShowSameHL7 0
	Quit:..SummaryShowDifferentHL7 0
	Quit:..SummaryShowMissingHL7 0
	Quit:..SummaryShowExtraHL7 0
	Quit 1
}

Method IsEmptyReportType(type As %String) As %Boolean
{
	Quit:type'=..#RPTTypeHL7 1
	Quit ..IsEmptyReport()
}

Method PopulateFromHttpRequest()
{
	set ..SummaryShowSameHL7=$G(%request.Data(..#DocumentType_"SummaryShowSameHL7",1),0)
	set ..DetailShowSameCategory=$G(%request.Data(..#DocumentType_"DetailShowSameCategory",1),0)
	set ..DetailShowSameMessageGroup=$G(%request.Data(..#DocumentType_"DetailShowSameMessageGroup",1),0)
	set ..DetailShowSameMessageEvent=$G(%request.Data(..#DocumentType_"DetailShowSameMessageEvent",1),0)
	set ..DetailShowSameMessageType=$G(%request.Data(..#DocumentType_"DetailShowSameMessageType",1),0)
	set ..DetailShowSameMessageStructure=$G(%request.Data(..#DocumentType_"DetailShowSameMessageStructure",1),0)
	set ..DetailShowSameSegmentStructure=$G(%request.Data(..#DocumentType_"DetailShowSameSegmentStructure",1),0)
	set ..DetailShowSameDataType=$G(%request.Data(..#DocumentType_"DetailShowSameDataType",1),0)
	set ..DetailShowSameCodeTable=$G(%request.Data(..#DocumentType_"DetailShowSameCodeTable",1),0)	
	set ..SummaryShowDifferentHL7=$G(%request.Data(..#DocumentType_"SummaryShowDifferentHL7",1),0)
	set ..DetailShowDifferentCategory=$G(%request.Data(..#DocumentType_"DetailShowDifferentCategory",1),0)
	set ..DetailShowDifferentMessageGroup=$G(%request.Data(..#DocumentType_"DetailShowDifferentMessageGroup",1),0)
	set ..DetailShowDifferentMessageEvent=$G(%request.Data(..#DocumentType_"DetailShowDifferentMessageEvent",1),0)
	set ..DetailShowDifferentMessageType=$G(%request.Data(..#DocumentType_"DetailShowDifferentMessageType",1),0)
	set ..DetailShowDifferentMessageStructure=$G(%request.Data(..#DocumentType_"DetailShowDifferentMessageStructure",1),0)
	set ..DetailShowDifferentSegmentStructure=$G(%request.Data(..#DocumentType_"DetailShowDifferentSegmentStructure",1),0)
	set ..DetailShowDifferentDataType=$G(%request.Data(..#DocumentType_"DetailShowDifferentDataType",1),0)
	set ..DetailShowDifferentCodeTable=$G(%request.Data(..#DocumentType_"DetailShowDifferentCodeTable",1),0)
	set ..SummaryShowMissingHL7=$G(%request.Data(..#DocumentType_"SummaryShowMissingHL7",1),0)
	set ..DetailShowMissingCategory=$G(%request.Data(..#DocumentType_"DetailShowMissingCategory",1),0)
	set ..DetailShowMissingMessageGroup=$G(%request.Data(..#DocumentType_"DetailShowMissingMessageGroup",1),0)
	set ..DetailShowMissingMessageEvent=$G(%request.Data(..#DocumentType_"DetailShowMissingMessageEvent",1),0)
	set ..DetailShowMissingMessageType=$G(%request.Data(..#DocumentType_"DetailShowMissingMessageType",1),0)
	set ..DetailShowMissingMessageStructure=$G(%request.Data(..#DocumentType_"DetailShowMissingMessageStructure",1),0)
	set ..DetailShowMissingSegmentStructure=$G(%request.Data(..#DocumentType_"DetailShowMissingSegmentStructure",1),0)
	set ..DetailShowMissingDataType=$G(%request.Data(..#DocumentType_"DetailShowMissingDataType",1),0)
	set ..DetailShowMissingCodeTable=$G(%request.Data(..#DocumentType_"DetailShowMissingCodeTable",1),0)
	set ..SummaryShowExtraHL7=$G(%request.Data(..#DocumentType_"SummaryShowExtraHL7",1),0)
	set ..DetailShowExtraCategory=$G(%request.Data(..#DocumentType_"DetailShowExtraCategory",1),0)
	set ..DetailShowExtraMessageGroup=$G(%request.Data(..#DocumentType_"DetailShowExtraMessageGroup",1),0)
	set ..DetailShowExtraMessageEvent=$G(%request.Data(..#DocumentType_"DetailShowExtraMessageEvent",1),0)
	set ..DetailShowExtraMessageType=$G(%request.Data(..#DocumentType_"DetailShowExtraMessageType",1),0)
	set ..DetailShowExtraMessageStructure=$G(%request.Data(..#DocumentType_"DetailShowExtraMessageStructure",1),0)
	set ..DetailShowExtraSegmentStructure=$G(%request.Data(..#DocumentType_"DetailShowExtraSegmentStructure",1),0)
	set ..DetailShowExtraDataType=$G(%request.Data(..#DocumentType_"DetailShowExtraDataType",1),0)
	set ..DetailShowExtraCodeTable=$G(%request.Data(..#DocumentType_"DetailShowExtraCodeTable",1),0)
	do ..PatternHL7Exclude.Clear()
	set data=$TR($G(%request.Data(..#DocumentType_"PatternHL7Exclude",1),""),$C(13))
	kill ary
	set pattern=""
	set len=$L(data,$C(10))
	for i=1:1:len {
		set pattern=$ZSTRIP($P(data,$C(10),i),"<>W")
		continue:pattern=""
		set ary(pattern)="" // Sort the user input
	}
	set pattern=""
	for {
		set pattern=$O(ary(pattern))
		quit:pattern=""
		do ..PatternHL7Exclude.Insert(pattern)	
	}
	do ..PatternHL7Include.Clear()
	set data=$TR($G(%request.Data(..#DocumentType_"PatternHL7Include",1),""),$C(13))
	kill ary
	set pattern=""
	set len=$L(data,$C(10))
	for i=1:1:len {
		set pattern=$ZSTRIP($P(data,$C(10),i),"<>W")
		continue:pattern=""
		set ary(pattern)="" // Sort the user input
	}
	set pattern=""
	for {
		set pattern=$O(ary(pattern))
		quit:pattern=""
		do ..PatternHL7Include.Insert(pattern)	
	}
}

Method DrawEditConfigForm()
{
	W !,"<fieldset><legend>HL7 Configuration</legend>"
	W !,"Show Same HL7 <input name=""",..#DocumentType,"SummaryShowSameHL7"" type=""checkbox"" value=""1""",$Select(..SummaryShowSameHL7:" checked",1:""),"/><br/>"
	W !,"Show Different HL7 <input name=""",..#DocumentType,"SummaryShowDifferentHL7"" type=""checkbox"" value=""1""",$Select(..SummaryShowDifferentHL7:" checked",1:""),"/><br/>"
	W !,"Show Missing HL7 <input name=""",..#DocumentType,"SummaryShowMissingHL7"" type=""checkbox"" value=""1""",$Select(..SummaryShowMissingHL7:" checked",1:""),"/><br/>"
	W !,"Show Extra HL7 <input name=""",..#DocumentType,"SummaryShowExtraHL7"" type=""checkbox"" value=""1""",$Select(..SummaryShowExtraHL7:" checked",1:""),"/><br/>"
	W !,"Include Mapped <input name=""",..#DocumentType,"SummaryIncludeMappedHL7"" type=""checkbox"" value=""1""",$Select(..SummaryIncludeMappedHL7:" checked",1:""),"/><br/>"
	W !,"Include Source Uncontrolled <input name=""",..#DocumentType,"SummaryIncludeUncontrolledHL7"" type=""checkbox"" value=""1""",$Select(..SummaryIncludeUncontrolledHL7:" checked",1:""),"/><br/>"
	
	W !,"Exclude&nbsp;pattern&nbsp;<textarea name=""",..#DocumentType,"PatternHL7Exclude"" rows=""4"" cols=""50"">"
	set key="",pattern=""
	for {
		set pattern=..PatternHL7Exclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		W $ZCONVERT(pattern,"O","HTML"),$C(10)	
	}
	W "</textarea><br/>"
	W !,"Include&nbsp;pattern&nbsp;<textarea name=""",..#DocumentType,"PatternHL7Include"" rows=""4"" cols=""50"">"
	set key="",pattern=""
	for {
		set pattern=..PatternHL7Include.GetNext(.key)
		quit:key=""
		continue:pattern=""
		W $ZCONVERT(pattern,"O","HTML"),$C(10)	
	}
	W "</textarea><br/>"
	
	W !,"<fieldset><legend>Category Configuration</legend>"
	W !,"Show Same Category <input name=""",..#DocumentType,"DetailShowSameCategory"" type=""checkbox"" value=""1""",$Select(..DetailShowSameCategory:" checked",1:""),"/><br/>"
	W !,"Show Different Category <input name=""",..#DocumentType,"DetailShowDifferentCategory"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentCategory:" checked",1:""),"/><br/>"
	W !,"Show Missing Category <input name=""",..#DocumentType,"DetailShowMissingCategory"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingCategory:" checked",1:""),"/><br/>"
	W !,"Show Extra Category <input name=""",..#DocumentType,"DetailShowExtraCategory"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraCategory:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>MessageGroup Configuration</legend>"
	W !,"Show Same MessageGroup <input name=""",..#DocumentType,"DetailShowSameMessageGroup"" type=""checkbox"" value=""1""",$Select(..DetailShowSameMessageGroup:" checked",1:""),"/><br/>"
	W !,"Show Different MessageGroup <input name=""",..#DocumentType,"DetailShowDifferentMessageGroup"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentMessageGroup:" checked",1:""),"/><br/>"
	W !,"Show Missing MessageGroup <input name=""",..#DocumentType,"DetailShowMissingMessageGroup"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingMessageGroup:" checked",1:""),"/><br/>"
	W !,"Show Extra MessageGroup <input name=""",..#DocumentType,"DetailShowExtraMessageGroup"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraMessageGroup:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>MessageEvent Configuration</legend>"
	W !,"Show Same MessageEvent <input name=""",..#DocumentType,"DetailShowSameMessageEvent"" type=""checkbox"" value=""1""",$Select(..DetailShowSameMessageEvent:" checked",1:""),"/><br/>"
	W !,"Show Different MessageEvent <input name=""",..#DocumentType,"DetailShowDifferentMessageEvent"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentMessageEvent:" checked",1:""),"/><br/>"
	W !,"Show Missing MessageEvent <input name=""",..#DocumentType,"DetailShowMissingMessageEvent"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingMessageEvent:" checked",1:""),"/><br/>"
	W !,"Show Extra MessageEvent <input name=""",..#DocumentType,"DetailShowExtraMessageEvent"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraMessageEvent:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>MessageType Configuration</legend>"
	W !,"Show Same MessageType <input name=""",..#DocumentType,"DetailShowSameMessageType"" type=""checkbox"" value=""1""",$Select(..DetailShowSameMessageType:" checked",1:""),"/><br/>"
	W !,"Show Different MessageType <input name=""",..#DocumentType,"DetailShowDifferentMessageType"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentMessageType:" checked",1:""),"/><br/>"
	W !,"Show Missing MessageType <input name=""",..#DocumentType,"DetailShowMissingMessageType"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingMessageType:" checked",1:""),"/><br/>"
	W !,"Show Extra MessageType <input name=""",..#DocumentType,"DetailShowExtraMessageType"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraMessageType:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>MessageStructure Configuration</legend>"
	W !,"Show Same MessageStructure <input name=""",..#DocumentType,"DetailShowSameMessageStructure"" type=""checkbox"" value=""1""",$Select(..DetailShowSameMessageStructure:" checked",1:""),"/><br/>"
	W !,"Show Different MessageStructure <input name=""",..#DocumentType,"DetailShowDifferentMessageStructure"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentMessageStructure:" checked",1:""),"/><br/>"
	W !,"Show Missing MessageStructure <input name=""",..#DocumentType,"DetailShowMissingMessageStructure"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingMessageStructure:" checked",1:""),"/><br/>"
	W !,"Show Extra MessageStructure <input name=""",..#DocumentType,"DetailShowExtraMessageStructure"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraMessageStructure:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>SegmentStructure Configuration</legend>"
	W !,"Show Same SegmentStructure <input name=""",..#DocumentType,"DetailShowSameSegmentStructure"" type=""checkbox"" value=""1""",$Select(..DetailShowSameSegmentStructure:" checked",1:""),"/><br/>"
	W !,"Show Different SegmentStructure <input name=""",..#DocumentType,"DetailShowDifferentSegmentStructure"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentSegmentStructure:" checked",1:""),"/><br/>"
	W !,"Show Missing SegmentStructure <input name=""",..#DocumentType,"DetailShowMissingSegmentStructure"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingSegmentStructure:" checked",1:""),"/><br/>"
	W !,"Show Extra SegmentStructure <input name=""",..#DocumentType,"DetailShowExtraSegmentStructure"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraSegmentStructure:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>DataType Configuration</legend>"
	W !,"Show Same DataType <input name=""",..#DocumentType,"DetailShowSameDataType"" type=""checkbox"" value=""1""",$Select(..DetailShowSameDataType:" checked",1:""),"/><br/>"
	W !,"Show Different DataType <input name=""",..#DocumentType,"DetailShowDifferentDataType"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentDataType:" checked",1:""),"/><br/>"
	W !,"Show Missing DataType <input name=""",..#DocumentType,"DetailShowMissingDataType"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingDataType:" checked",1:""),"/><br/>"
	W !,"Show Extra DataType <input name=""",..#DocumentType,"DetailShowExtraDataType"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraDataType:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>CodeTable Configuration</legend>"
	W !,"Show Same CodeTable <input name=""",..#DocumentType,"DetailShowSameCodeTable"" type=""checkbox"" value=""1""",$Select(..DetailShowSameCodeTable:" checked",1:""),"/><br/>"
	W !,"Show Different CodeTable <input name=""",..#DocumentType,"DetailShowDifferentCodeTable"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentCodeTable:" checked",1:""),"/><br/>"
	W !,"Show Missing CodeTable <input name=""",..#DocumentType,"DetailShowMissingCodeTable"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingCodeTable:" checked",1:""),"/><br/>"
	W !,"Show Extra CodeTable <input name=""",..#DocumentType,"DetailShowExtraCodeTable"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraCodeTable:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	
	W !,"</fieldset>"
}

Method DrawReport(definition As ompare.Report.Definition, isFirstDisplayed As %Boolean = 0)
{
	quit:..IsEmptyReport()
	set elapstart=$P($ZTS,",",2)
	W !,"<span class=""SectionTitle"">Section: HL7</span>"
	W !,"<a name=""show",..#PageAnchor,"""></a>"
	W:'isFirstDisplayed "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<a href=""#showTop"">Back to Top</a>]"
	W !,"<table border=1>"
	W !," <tr>"
	W !,"  <th>Item</th>"
	W !,"  <th>HL7 Name</th>"
	//  Put From Environment as the first column
	W !,"  <th>",definition.FromEnvironment,"</th>"
	set env=""
	for {
		set env=$Order(^||ReportData("Meta","To",env),+1,date)
		quit:env=""
		W !,"  <th>",$ZCONVERT(env,"O","HTML"),"<br/>",$ZD(date,3),"</th>"
	}
	W !," </tr>"
	set hl7name=""
	set sequence=0
	for {
		set hl7name=$O(^||ReportData(..#RPTTypeHL7,hl7name))
		quit:hl7name=""
		
		W !," <tr>"
		W !,"  <td>",$Increment(sequence),"</td>"
		W !,"  <td>",$ZCONVERT(hl7name,"O","HTML"),"</td>"
		
		set toNs=$O(^||ReportData(..#RPTTypeHL7,hl7name,"s",definition.FromEnvironment,""),+1,result)
		if toNs="" {
			W "<td> - </td>"
		} else {
			W "<td>",$Case(result,..#RPTSame:"Same",..#RPTDifferent:"Different",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - "),"</td>"
		}
		
		set env=""
		for {
			set env=$Order(^||ReportData("Meta","To",env),+1,date)
			quit:env=""
		
			set toNs=$O(^||ReportData(..#RPTTypeHL7,hl7name,"s",env,""),+1,result)
			if toNs="" {
				W "<td> - </td>"
			} else {
				set lnk("sfEnv")=definition.FromEnvironment
				set lnk("sfNS")=$Select($D(lnk("sfEnv")):$O(definition.EnvironmentsMD(lnk("sfEnv"),"")),1:"")
				set lnk("sfT")="HL7"
				set lnk("sfTN")=hl7name
				set lnk("sfST")="HL7CAT"  // eg: "M"
				set lnk("sfSTN")=""  // eg: OnProcessInput
				if definition.HistoricView {
					set lnk("stD")=date
					set lnk("stEnv")=$ZSTRIP($P(env,"("),">W")  // Remove History Discriptor
				} else {
					kill lnk("stD")
					set lnk("stEnv")=env
				}
				set lnk("stEnv")=$ZSTRIP($P(env,"("),">W")  // Remove History Discriptor
				set lnk("stNS")=$Select($D(lnk("stEnv")):$O(definition.EnvironmentsMD(lnk("stEnv"),"")),1:"")
				set lnk("stT")="HL7"
				set lnk("stTN")=hl7name
				set lnk("stST")="HL7CAT"  // eg: "M"
				set lnk("stSTN")=""  // eg: OnProcessInput
					
					
				W "<td style=""vertical-align:top"""
				if result=..#RPTDifferent {
					if definition.DisplayDifferenceDetail {
						W "><div>",..ReportDetailAltTextWithLink(..#RPTTypeHL7,hl7name,env,,.lnk,result),"</div>"
					} else {
						W " title=""",$ZCONVERT(..ReportDetailAltText(..#RPTTypeHL7,hl7name,env),"O","HTML"),""">Different"
					}
				} else {
					W ">",$Case(result,..#RPTSame:"Same",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - ")
				}
				W "</td>"			}
		}
	
		W !," </tr>"
	}
	W !,"</table>"
	set elapend=$P($ZTS,",",2)
	W !,"(Time taken:",$FN(elapend-elapstart,"",2)," seconds)"
	W !,"<hr/>"
	W !,"<br/>"
}

/// Override in ReportType
ClassMethod DrawDetailAltTextWithLink(ByRef out, return As %String, ByRef lnk, eol, displayComments)
{
	
	for lstSubType=$LB(..#RPTSubTypeCategory,"Category"),$LB(..#RPTSubTypeMessageGroup,"MessageGroup"),$LB(..#RPTSubTypeMessageEvent,"MessageEvent"),$LB(..#RPTSubTypeMessageType,"MessageType"),$LB(..#RPTSubTypeMessageStructure,"MessageStructure"),$LB(..#RPTSubTypeSegmentStructure,"SegmentStructure"),$LB(..#RPTSubTypeDataType,"DataType"),$LB(..#RPTSubTypeCodeTable,"CodeTable") {
	
		if +$G(out($LI(lstSubType,1)))>0 {
			W $S($L(return):eol,1:"")_$LI(lstSubType,2)_":"
			set:$L(return)=0 return=" "
			for i=1:1:out($LI(lstSubType,1)) {
				//W eol_" *"_out(..#RPTSubTypeLineLabel,i,"name")_" ("_..RTPEnumToText(out(..#RPTSubTypeLineLabel,i,"result"))_")<br/>"
				set lnk("sfST")=$LI(lstSubType,1)
				set lnk("sfSTN")=out($LI(lstSubType,1),i,"name")
				set lnk("stST")=$LI(lstSubType,1)
				set lnk("stSTN")=out($LI(lstSubType,1),i,"name")
					set result=$G(out($LI(lstSubType,1),i,"result"))
				W eol_" *"_out($LI(lstSubType,1),i,"name")_" ("
				Do ..AddSourceLink(..RTPEnumToText(result),.lnk,result)
				W ")"
				d:displayComments ..DisplayComment(.lnk)
			}	
		}
	}
}

/// Add new sections to generated Excel Report projection
/// Subclass in ompare.ReportType.[ViewName]
ClassMethod DrawExcelReportSection(definition As ompare.Report.Definition, numberofenvironments As %Integer, reportType As ompare.ReportType.Base)
{
	// TO DO
	set sequenceNumber=0
 	for i=1:1:2 {
 		W !,"<Row ss:AutoFitHeight=""0"" ss:StyleID=""s62"">"
 		
 		if i=1 {
	 		W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String""></Data></Cell>"  //seq
		 	W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String""></Data></Cell>"
			W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String"">",..XMLO(definition.FromEnvironment),"</Data></Cell>" 	
 		} else {
	 		W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String"">Item</Data></Cell>"  //seq
 			W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String"">HL7 name</Data></Cell>"
 			W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String"">",..XMLO(definition.GetDateTimeOfData(definition.FromEnvironment)),"</Data></Cell>"
  		}
  		set env="",key=""
  		for {
			//set env=$Order(definition.Environments(env))
			set env=definition.Environments.GetNext(.key)
			quit:key=""
			continue:env=""
			continue:definition.FromEnvironment=env.Name
			if i=1 {
				W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String"">",..XMLO(env.Name),"</Data></Cell>" 	
 			} else {
				W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String"">",..XMLO(definition.GetDateTimeOfData(env.Name)),"</Data></Cell>"
  			}
 		}
 		W !,"</Row>" 	
 	}
 
 
 	if $Data(^||ReportData(..#RPTTypeHL7))=0 {	 	
	 	Do ##class(ompare.Report.ExportExcelWorkbook).ReportIfEmptySection(reportType.SummaryShowSameHL7,reportType.SummaryShowDifferentHL7,reportType.SummaryShowMissingHL7,reportType.SummaryShowExtraHL7)
 	} else {
		 // Routine Header
 		set hl7name=""
		for {
			set hl7name=$O(^||ReportData(..#RPTTypeHL7,hl7name))
			quit:hl7name=""
			
			// Need to look through and count the number of sub-report lines
			set clines=0
			set subtype=""
			for {
				set subtype=$O(^||ReportData(..#RPTTypeHL7,hl7name,"d",subtype))
				quit:subtype=""
				set clines=clines+1  // Each subtype has an informational header
				
				set subname=""
				for {
					set subname=$O(^||ReportData(..#RPTTypeHL7,hl7name,"d",subtype,subname))
					quit:subname=""  // Each subtype item prints a line
					set clines=clines+1
				}
			}
			set:'clines clines=1
			
			W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",##class(ompare.Report.ExportExcelWorkbook).CapLineHeight((clines)*$PARAMETER("ompare.Report.ExportExcelWorkbook","LineHeight")),""">"
			//W !,"<Row>"  // TODO - Do we need to know the expanded row height?
			W !,"<Cell><Data ss:Type=""String"">",$Increment(sequenceNumber),"</Data></Cell>"  //seq
			W !,"<Cell><Data ss:Type=""String"">",..XMLO(hl7name),"</Data></Cell>"
			
			set toNs=$O(^||ReportData(..#RPTTypeHL7,hl7name,"s",definition.FromEnvironment,""),+1,result)
			if toNs="" {
				W !,"<Cell><Data ss:Type=""String""> - </Data></Cell>"
			} else {
				W !,"<Cell><Data ss:Type=""String"">",..XMLO($Case(result,..#RPTSame:"Same",..#RPTDifferent:"Different",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - ")),"</Data></Cell>"
			}
			
			set env="",key=""
			for {
				set env=definition.Environments.GetNext(.key)
				quit:key=""
				quit:'$IsObject(env)
				continue:definition.FromEnvironment=env.Name
			
				set toNs=$O(^||ReportData(..#RPTTypeHL7,hl7name,"s",env.Name,""),+1,result)
				if toNs="" {
					W !,"<Cell><Data ss:Type=""String""> - </Data></Cell>"
				} else {
					W !,"<Cell ss:StyleID=""s67""><Data ss:Type=""String"">"
					if result'=..#RPTDifferent {
						W ..XMLO($Case(result,..#RPTSame:"Same",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - ")_" HL7")
					} else {
						// Style to wrap text
						Do ..SpreadsheetReportDetailText(..#RPTTypeHL7, hl7name, env.Name)
					}
					W "</Data></Cell>"
				}
			}
			W !,"</Row>"
		}
	
 	//Routine Content
 	}
}

ClassMethod SpreadsheetReportDetailText(type = "", name = "", env = "")
{
	set return=""
	set out=""
	quit:type="" "type is empty"
	quit:name="" "name is empty"
	quit:env="" "env is empty"
	
	set sec=0
	set subname=""
	
	
	set subtype=""
	for {
		set subtype=$O(^||ReportData(type,name,"d",subtype))
		quit:subtype=""
		
		for {
			set subname=$Order(^||ReportData(type,name,"d",subtype,subname))
			quit:subname=""
		
			set ns=$Order(^||ReportData(type,name,"d",subtype,subname,env,""),+1,result)
			continue:ns=""
		
			set next=$I(out(subtype))
			set out(subtype,next,"name")=subname
			set out(subtype,next,"result")=result
		}
	}
	set first=1
	
	// Add customizations here
	for subTypeList=$LB(..#RPTSubTypeCategory,"Category"),$LB(..#RPTSubTypeMessageGroup,"MessageGroup"),$LB(..#RPTSubTypeMessageEvent,"MessageEvent"),$LB(..#RPTSubTypeMessageType,"MessageType"),$LB(..#RPTSubTypeMessageStructure,"MessageStructure"),$LB(..#RPTSubTypeSegmentStructure,"SegmentStructure"),$LB(..#RPTSubTypeDataType,"DataType"),$LB(..#RPTSubTypeCodeTable,"CodeTable") {
		if +$G(out($LI(subTypeList,1)))>0 {
			W:'first ..#eol
			S first=0
			W ..XMLO($LI(subTypeList,2)_": (Differences)")
			// TODO: List count differences??
			for i=1:1:out($LI(subTypeList,1)) {
				W ..#eol,..XMLO(" *"_out($LI(subTypeList,1),i,"name")_" ("_..RTPEnumToText(out($LI(subTypeList,1),i,"result"))_")")
			}
		}
	}
	Quit
}

Storage Default
{
<Data name="HL7DefaultData">
<Subscript>"HL7"</Subscript>
<Value name="1">
<Value>SummaryShowSameHL7</Value>
</Value>
<Value name="2">
<Value>SummaryShowDifferentHL7</Value>
</Value>
<Value name="3">
<Value>SummaryShowMissingHL7</Value>
</Value>
<Value name="4">
<Value>SummaryShowExtraHL7</Value>
</Value>
<Value name="5">
<Value>SummaryIncludeMappedHL7</Value>
</Value>
<Value name="6">
<Value>SummaryIncludeUncontrolledHL7</Value>
</Value>
<Value name="7">
<Value>DetailShowSameCategory</Value>
</Value>
<Value name="8">
<Value>DetailShowDifferentCategory</Value>
</Value>
<Value name="9">
<Value>DetailShowMissingCategory</Value>
</Value>
<Value name="10">
<Value>DetailShowExtraCategory</Value>
</Value>
<Value name="11">
<Value>DetailShowSameMessageGroup</Value>
</Value>
<Value name="12">
<Value>DetailShowDifferentMessageGroup</Value>
</Value>
<Value name="13">
<Value>DetailShowMissingMessageGroup</Value>
</Value>
<Value name="14">
<Value>DetailShowExtraMessageGroup</Value>
</Value>
<Value name="15">
<Value>DetailShowSameMessageEvent</Value>
</Value>
<Value name="16">
<Value>DetailShowDifferentMessageEvent</Value>
</Value>
<Value name="17">
<Value>DetailShowMissingMessageEvent</Value>
</Value>
<Value name="18">
<Value>DetailShowExtraMessageEvent</Value>
</Value>
<Value name="19">
<Value>DetailShowSameMessageType</Value>
</Value>
<Value name="20">
<Value>DetailShowDifferentMessageType</Value>
</Value>
<Value name="21">
<Value>DetailShowMissingMessageType</Value>
</Value>
<Value name="22">
<Value>DetailShowExtraMessageType</Value>
</Value>
<Value name="23">
<Value>DetailShowSameMessageStructure</Value>
</Value>
<Value name="24">
<Value>DetailShowDifferentMessageStructure</Value>
</Value>
<Value name="25">
<Value>DetailShowMissingMessageStructure</Value>
</Value>
<Value name="26">
<Value>DetailShowExtraMessageStructure</Value>
</Value>
<Value name="27">
<Value>DetailShowSameSegmentStructure</Value>
</Value>
<Value name="28">
<Value>DetailShowDifferentSegmentStructure</Value>
</Value>
<Value name="29">
<Value>DetailShowMissingSegmentStructure</Value>
</Value>
<Value name="30">
<Value>DetailShowExtraSegmentStructure</Value>
</Value>
<Value name="31">
<Value>DetailShowSameDataType</Value>
</Value>
<Value name="32">
<Value>DetailShowDifferentDataType</Value>
</Value>
<Value name="33">
<Value>DetailShowMissingDataType</Value>
</Value>
<Value name="34">
<Value>DetailShowExtraDataType</Value>
</Value>
<Value name="35">
<Value>DetailShowSameCodeTable</Value>
</Value>
<Value name="36">
<Value>DetailShowDifferentCodeTable</Value>
</Value>
<Value name="37">
<Value>DetailShowMissingCodeTable</Value>
</Value>
<Value name="38">
<Value>DetailShowExtraCodeTable</Value>
</Value>
<Value name="39">
<Value>PatternHL7Exclude</Value>
</Value>
<Value name="40">
<Value>PatternHL7Include</Value>
</Value>
</Data>
<DefaultData>HL7DefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

