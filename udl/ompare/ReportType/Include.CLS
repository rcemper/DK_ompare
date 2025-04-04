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
Class ompare.ReportType.Include Extends ompare.ReportType.Base
{

/// Ensure this Code doesn't collide with other sub-class implementations of Base
/// Eg: "C" abbreviation for class
Parameter DocumentType As %String = "inc";

Parameter RPTTypeINC = "INC";

Parameter RPTSubTypeDefine = "INCDF";

Parameter RPTSubTypeDef1arg = "INCDA";

Parameter RPTSubTypeInclude = "INCIN";

Parameter RPTSubTypeFull = "INCFL";

Property SummaryShowSameINC As %Boolean [ InitialExpression = 0 ];

Property SummaryShowDifferentINC As %Boolean [ InitialExpression = 1 ];

Property SummaryShowMissingINC As %Boolean [ InitialExpression = 1 ];

Property SummaryShowExtraINC As %Boolean [ InitialExpression = 1 ];

Property SummaryIncludeMappedINC As %Boolean [ InitialExpression = 1 ];

Property SummaryIncludeUncontrolledINC As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameDefine As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentDefine As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingDefine As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraDefine As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameDeflarg As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentDeflarg As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingDeflarg As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraDeflarg As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameInclude As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentInclude As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingInclude As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraInclude As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameFull As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentFull As %Boolean [ InitialExpression = 1 ];

/// Subscript 3 = pattern
Property PatternINCExclude As list Of %String(MAXLEN = 10000);

/// Subscript 4 = pattern
Property PatternINCInclude As list Of %String(MAXLEN = 10000);

Parameter PageAnchor = "INC";

Parameter ReportOrder = 6;

/// Called from ompare.Report.Defintion on subclass on ompare.ReportType.Base
/// Override in subclass
ClassMethod CreateDynamicReport(name As %String) As ompare.ReportType.Base
{
	set obj=..%New()
	set obj.SummaryShowSameINC=1
	set obj.SummaryShowDifferentINC=1
	set obj.SummaryShowMissingINC=1
	set obj.SummaryShowExtraINC=1
	set obj.SummaryIncludeMappedINC=1
	set obj.SummaryIncludeUncontrolledINC=1
	set obj.DetailShowSameDefine=0
	set obj.DetailShowDifferentDefine=1
	set obj.DetailShowMissingDefine=1
	set obj.DetailShowExtraDefine=1
	set obj.DetailShowSameDeflarg=0
	set obj.DetailShowDifferentDeflarg=1
	set obj.DetailShowMissingDeflarg=1
	set obj.DetailShowExtraDeflarg=1
	set obj.DetailShowSameInclude=0
	set obj.DetailShowDifferentInclude=1
	set obj.DetailShowMissingInclude=1
	set obj.DetailShowExtraInclude=1
	set obj.DetailShowSameFull=0
	set obj.DetailShowDifferentFull=1

	do obj.PatternINCExclude.Insert("*")
	do obj.PatternINCInclude.Insert(name)
	quit obj
}

/// Called from ompare.Report.Defintion on subclass on ompare.ReportType.Base
/// Override in subclass
Method PopulateReportParams(ByRef config, ByRef summary, ByRef detail, ByRef exclude, ByRef include)
{
	set:..SummaryShowSameINC summary(..#RPTTypeINC,..#RPTSame)=""
	set:..SummaryShowDifferentINC summary(..#RPTTypeINC,..#RPTDifferent)=""
	set:..SummaryShowMissingINC summary(..#RPTTypeINC,..#RPTMissing)=""
	set:..SummaryShowExtraINC summary(..#RPTTypeINC,..#RPTExtra)=""
	set:..SummaryIncludeMappedINC config(..#RPTTypeINC,..#RPTMapped)=""
	set:..SummaryIncludeUncontrolledINC config(..#RPTTypeINC,..#RPTSourceControlled)=""
	
	set:..DetailShowSameDefine detail(..#RPTSubTypeDefine,..#RPTSame)=""
	set:..DetailShowDifferentDefine detail(..#RPTSubTypeDefine,..#RPTDifferent)=""
	set:..DetailShowMissingDefine detail(..#RPTSubTypeDefine,..#RPTMissing)=""
	set:..DetailShowExtraDefine detail(..#RPTSubTypeDefine,..#RPTExtra)=""
	
	set:..DetailShowSameDeflarg detail(..#RPTSubTypeDef1arg,..#RPTSame)=""
	set:..DetailShowDifferentDeflarg detail(..#RPTSubTypeDef1arg,..#RPTDifferent)=""
	set:..DetailShowMissingDeflarg detail(..#RPTSubTypeDef1arg,..#RPTMissing)=""
	set:..DetailShowExtraDeflarg detail(..#RPTSubTypeDef1arg,..#RPTExtra)=""
	
	set:..DetailShowSameInclude detail(..#RPTSubTypeInclude,..#RPTSame)=""
	set:..DetailShowDifferentInclude detail(..#RPTSubTypeInclude,..#RPTDifferent)=""
	set:..DetailShowMissingInclude detail(..#RPTSubTypeInclude,..#RPTMissing)=""
	set:..DetailShowExtraInclude detail(..#RPTSubTypeInclude,..#RPTExtra)=""
	
	set:..DetailShowSameFull detail(..#RPTSubTypeFull,..#RPTSame)=""
	set:..DetailShowDifferentFull detail(..#RPTSubTypeFull,..#RPTDifferent)=""
	
	set key=""
	for {
		set pattern=..PatternINCExclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		set exclude(..#RPTTypeINC,pattern)=""	
	}
	for {
		set pattern=..PatternINCInclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		set include(..#RPTTypeINC,pattern)=""	
	}
}

Method IsEmptyReport() As %Boolean
{
	Quit:..SummaryShowSameINC 0
	Quit:..SummaryShowDifferentINC 0
	Quit:..SummaryShowMissingINC 0
	Quit:..SummaryShowExtraINC 0
	Quit 1
}

Method IsEmptyReportType(type As %String) As %Boolean
{
	Quit:type'=..#RPTTypeINC 1
	Quit ..IsEmptyReport()
}

Method PopulateFromHttpRequest()
{
	set ..SummaryShowSameINC=$G(%request.Data(..#DocumentType_"SummaryShowSameINC",1),0)
	set ..DetailShowSameDefine=$G(%request.Data(..#DocumentType_"DetailShowSameDefine",1),0)
	set ..DetailShowSameDeflarg=$G(%request.Data(..#DocumentType_"DetailShowSameDeflarg",1),0)
	set ..DetailShowSameInclude=$G(%request.Data(..#DocumentType_"DetailShowSameInclude",1),0)
	set ..DetailShowSameFull=$G(%request.Data(..#DocumentType_"DetailShowSameFull",1),0)
	set ..SummaryShowDifferentINC=$G(%request.Data(..#DocumentType_"SummaryShowDifferentINC",1),0)
	set ..DetailShowDifferentDefine=$G(%request.Data(..#DocumentType_"DetailShowDifferentDefine",1),0)
	set ..DetailShowDifferentDeflarg=$G(%request.Data(..#DocumentType_"DetailShowDifferentDeflarg",1),0)
	set ..DetailShowDifferentInclude=$G(%request.Data(..#DocumentType_"DetailShowDifferentInclude",1),0)
	set ..DetailShowDifferentFull=$G(%request.Data(..#DocumentType_"DetailShowDifferentFull",1),0)
	set ..SummaryShowMissingINC=$G(%request.Data(..#DocumentType_"SummaryShowMissingINC",1),0)
	set ..DetailShowMissingDefine=$G(%request.Data(..#DocumentType_"DetailShowMissingDefine",1),0)
	set ..DetailShowMissingDeflarg=$G(%request.Data(..#DocumentType_"DetailShowMissingDeflarg",1),0)
	set ..DetailShowMissingInclude=$G(%request.Data(..#DocumentType_"DetailShowMissingInclude",1),0)
	set ..SummaryShowExtraINC=$G(%request.Data(..#DocumentType_"SummaryShowExtraINC",1),0)
	set ..DetailShowExtraDefine=$G(%request.Data(..#DocumentType_"DetailShowExtraDefine",1),0)
	set ..DetailShowExtraDeflarg=$G(%request.Data(..#DocumentType_"DetailShowExtraDeflarg",1),0)
	set ..DetailShowExtraInclude=$G(%request.Data(..#DocumentType_"DetailShowExtraInclude",1),0)
	do ..PatternINCExclude.Clear()
	set data=$TR($G(%request.Data(..#DocumentType_"PatternINCExclude",1),""),$C(13))
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
		do ..PatternINCExclude.Insert(pattern)	
	}
	do ..PatternINCInclude.Clear()
	set data=$TR($G(%request.Data(..#DocumentType_"PatternINCInclude",1),""),$C(13))
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
		do ..PatternINCInclude.Insert(pattern)	
	}
}

Method DrawEditConfigForm()
{
	W !,"<fieldset><legend>INC Configuration</legend>"
	W !,"Show Same INC <input name=""",..#DocumentType,"SummaryShowSameINC"" type=""checkbox"" value=""1""",$Select(..SummaryShowSameINC:" checked",1:""),"/><br/>"
	W !,"Show Different INC <input name=""",..#DocumentType,"SummaryShowDifferentINC"" type=""checkbox"" value=""1""",$Select(..SummaryShowDifferentINC:" checked",1:""),"/><br/>"
	W !,"Show Missing INC <input name=""",..#DocumentType,"SummaryShowMissingINC"" type=""checkbox"" value=""1""",$Select(..SummaryShowMissingINC:" checked",1:""),"/><br/>"
	W !,"Show Extra INC <input name=""",..#DocumentType,"SummaryShowExtraINC"" type=""checkbox"" value=""1""",$Select(..SummaryShowExtraINC:" checked",1:""),"/><br/>"
	W !,"Include Mapped <input name=""",..#DocumentType,"SummaryIncludeMappedINC"" type=""checkbox"" value=""1""",$Select(..SummaryIncludeMappedINC:" checked",1:""),"/><br/>"
	W !,"Include Source Uncontrolled <input name=""",..#DocumentType,"SummaryIncludeUncontrolledINC"" type=""checkbox"" value=""1""",$Select(..SummaryIncludeUncontrolledINC:" checked",1:""),"/><br/>"
	
	W !,"Exclude&nbsp;pattern&nbsp;<textarea name=""",..#DocumentType,"PatternINCExclude"" rows=""4"" cols=""50"">"
	set key="",pattern=""
	for {
		set pattern=..PatternINCExclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		W $ZCONVERT(pattern,"O","HTML"),$C(10)	
	}
	W "</textarea><br/>"
	W !,"Include&nbsp;pattern&nbsp;<textarea name=""",..#DocumentType,"PatternINCInclude"" rows=""4"" cols=""50"">"
	set key="",pattern=""
	for {
		set pattern=..PatternINCInclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		W $ZCONVERT(pattern,"O","HTML"),$C(10)	
	}
	W "</textarea><br/>"
	
	W !,"<fieldset><legend>Define Configuration</legend>"
	W !,"Show Same Define <input name=""",..#DocumentType,"DetailShowSameDefine"" type=""checkbox"" value=""1""",$Select(..DetailShowSameDefine:" checked",1:""),"/><br/>"
	W !,"Show Different Define <input name=""",..#DocumentType,"DetailShowDifferentDefine"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentDefine:" checked",1:""),"/><br/>"
	W !,"Show Missing Define <input name=""",..#DocumentType,"DetailShowMissingDefine"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingDefine:" checked",1:""),"/><br/>"
	W !,"Show Extra Define <input name=""",..#DocumentType,"DetailShowExtraDefine"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraDefine:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>Deflarg Configuration</legend>"
	W !,"Show Same Deflarg <input name=""",..#DocumentType,"DetailShowSameDeflarg"" type=""checkbox"" value=""1""",$Select(..DetailShowSameDeflarg:" checked",1:""),"/><br/>"
	W !,"Show Different Deflarg <input name=""",..#DocumentType,"DetailShowDifferentDeflarg"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentDeflarg:" checked",1:""),"/><br/>"
	W !,"Show Missing Deflarg <input name=""",..#DocumentType,"DetailShowMissingDeflarg"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingDeflarg:" checked",1:""),"/><br/>"
	W !,"Show Extra Deflarg <input name=""",..#DocumentType,"DetailShowExtraDeflarg"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraDeflarg:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>Include Configuration</legend>"
	W !,"Show Same Include <input name=""",..#DocumentType,"DetailShowSameInclude"" type=""checkbox"" value=""1""",$Select(..DetailShowSameInclude:" checked",1:""),"/><br/>"
	W !,"Show Different Include <input name=""",..#DocumentType,"DetailShowDifferentInclude"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentInclude:" checked",1:""),"/><br/>"
	W !,"Show Missing Include <input name=""",..#DocumentType,"DetailShowMissingInclude"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingInclude:" checked",1:""),"/><br/>"
	W !,"Show Extra Include <input name=""",..#DocumentType,"DetailShowExtraInclude"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraInclude:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
	W !,"<fieldset><legend>Show Full Configuration</legend>"
	W !,"Show Same Full <input name=""",..#DocumentType,"DetailShowSameFull"" type=""checkbox"" value=""1""",$Select(..DetailShowSameFull:" checked",1:""),"/><br/>"
	W !,"Show Different Full <input name=""",..#DocumentType,"DetailShowDifferentFull"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentFull:" checked",1:""),"/><br/>"
	W !,"</fieldset>"
		
	W !,"</fieldset>"
}

Method DrawReport(definition As ompare.Report.Definition, isFirstDisplayed As %Boolean = 0)
{
	quit:..IsEmptyReport()
	set elapstart=$P($ZTS,",",2)
	W !,"<span class=""SectionTitle"">Section: INC</span>"
	W !,"<a name=""show",..#PageAnchor,"""></a>"
	W:'isFirstDisplayed "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<a href=""#showTop"">Back to Top</a>]"
	W !,"<table border=1>"
	W !," <tr>"
	W !,"  <th>Item</th>"
	W !,"  <th>INC Name</th>"
	//  Put From Environment as the first column
	W !,"  <th>",definition.FromEnvironment,"</th>"
	set env=""
	for {
		set env=$Order(^||ReportData("Meta","To",env),+1,date)
		quit:env=""
		W !,"  <th>",$ZCONVERT(env,"O","HTML"),"<br/>",$ZD(date,3),"</th>"
	}
	W !," </tr>"
	set incName=""
	set sequence=0
	for {
		set incName=$O(^||ReportData(..#RPTTypeINC,incName))
		quit:incName=""
		
		W !," <tr>"
		W !,"  <td>",$Increment(sequence),"</td>"
		W !,"  <td>",$ZCONVERT(incName,"O","HTML"),"</td>"
		
		set toNs=$O(^||ReportData(..#RPTTypeINC,incName,"s",definition.FromEnvironment,""),+1,result)
		if toNs="" {
			W "<td> - </td>"
		} else {
			W "<td>",$Case(result,..#RPTSame:"Same",..#RPTDifferent:"Different",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - "),"</td>"
		}
		
		set env=""
		for {
			set env=$Order(^||ReportData("Meta","To",env),+1,date)
			quit:env=""
		
			set toNs=$O(^||ReportData(..#RPTTypeINC,incName,"s",env,""),+1,result)
			if toNs="" {
				W "<td> - </td>"
			} else {
				set lnk("sfEnv")=definition.FromEnvironment
				set lnk("sfNS")=$Select($D(lnk("sfEnv")):$O(definition.EnvironmentsMD(lnk("sfEnv"),"")),1:"")
				set lnk("sfT")="INC"
				set lnk("sfTN")=incName
				set lnk("sfST")="INCCAT"  // eg: "M"
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
				set lnk("stT")="INC"
				set lnk("stTN")=incName
				set lnk("stST")="INCCAT"  // eg: "M"
				set lnk("stSTN")=""  // eg: OnProcessInput
					
					
				W "<td style=""vertical-align:top"""
				if result=..#RPTDifferent {
					if definition.DisplayDifferenceDetail {
						W "><div>",..ReportDetailAltTextWithLink(..#RPTTypeINC,incName,env,,.lnk,result),"</div>"
					} else {
						W " title=""",$ZCONVERT(..ReportDetailAltText(..#RPTTypeINC,incName,env),"O","HTML"),""">Different"
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
	for lstSubType=$LB(..#RPTSubTypeDefine,"Define"),$LB(..#RPTSubTypeDef1arg,"Def1arg"),$LB(..#RPTSubTypeInclude,"Include"),$LB(..#RPTSubTypeFull,"Full") {
	
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
 			W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String"">INC name</Data></Cell>"
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
 
 
 	if $Data(^||ReportData(..#RPTTypeINC))=0 {	 	
	 	Do ##class(ompare.Report.ExportExcelWorkbook).ReportIfEmptySection(reportType.SummaryShowSameINC,reportType.SummaryShowDifferentINC,reportType.SummaryShowMissingINC,reportType.SummaryShowExtraINC)
 	} else {
		 // INC Header
 		set incName=""
		for {
			set incName=$O(^||ReportData(..#RPTTypeINC,incName))
			quit:incName=""
			
			// Need to look through and count the number of sub-report lines
			set clines=0
			set subtype=""
			for {
				set subtype=$O(^||ReportData(..#RPTTypeINC,incName,"d",subtype))
				quit:subtype=""
				set clines=clines+1  // Each subtype has an informational header
				
				set subname=""
				for {
					set subname=$O(^||ReportData(..#RPTTypeINC,incName,"d",subtype,subname))
					quit:subname=""  // Each subtype item prints a line
					set clines=clines+1
				}
			}
			set:'clines clines=1
			
			W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",##class(ompare.Report.ExportExcelWorkbook).CapLineHeight((clines)*$PARAMETER("ompare.Report.ExportExcelWorkbook","LineHeight")),""">"
			//W !,"<Row>"  // TODO - Do we need to know the expanded row height?
			W !,"<Cell><Data ss:Type=""String"">",$Increment(sequenceNumber),"</Data></Cell>"  //seq
			W !,"<Cell><Data ss:Type=""String"">",..XMLO(incName),"</Data></Cell>"
			
			set toNs=$O(^||ReportData(..#RPTTypeINC,incName,"s",definition.FromEnvironment,""),+1,result)
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
			
				set toNs=$O(^||ReportData(..#RPTTypeINC,incName,"s",env.Name,""),+1,result)
				if toNs="" {
					W !,"<Cell><Data ss:Type=""String""> - </Data></Cell>"
				} else {
					W !,"<Cell ss:StyleID=""s67""><Data ss:Type=""String"">"
					if result'=..#RPTDifferent {
						W ..XMLO($Case(result,..#RPTSame:"Same",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - ")_" INC")
					} else {
						// Style to wrap text
						Do ..SpreadsheetReportDetailText(..#RPTTypeINC, incName, env.Name)
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
	
	for subTypeList=$LB(..#RPTSubTypeDefine,"Define"),$LB(..#RPTSubTypeDef1arg,"Def1arg"),	$LB(..#RPTSubTypeInclude,"Include"),$LB(..#RPTSubTypeFull,"Full") {
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
<Data name="IncludeDefaultData">
<Subscript>"Include"</Subscript>
<Value name="1">
<Value>SummaryShowSameINC</Value>
</Value>
<Value name="2">
<Value>SummaryShowDifferentINC</Value>
</Value>
<Value name="3">
<Value>SummaryShowMissingINC</Value>
</Value>
<Value name="4">
<Value>SummaryShowExtraINC</Value>
</Value>
<Value name="5">
<Value>SummaryIncludeMappedINC</Value>
</Value>
<Value name="6">
<Value>SummaryIncludeUncontrolledINC</Value>
</Value>
<Value name="7">
<Value>DetailShowSameDefine</Value>
</Value>
<Value name="8">
<Value>DetailShowDifferentDefine</Value>
</Value>
<Value name="9">
<Value>DetailShowMissingDefine</Value>
</Value>
<Value name="10">
<Value>DetailShowExtraDefine</Value>
</Value>
<Value name="11">
<Value>DetailShowSameDeflarg</Value>
</Value>
<Value name="12">
<Value>DetailShowDifferentDeflarg</Value>
</Value>
<Value name="13">
<Value>DetailShowMissingDeflarg</Value>
</Value>
<Value name="14">
<Value>DetailShowExtraDeflarg</Value>
</Value>
<Value name="15">
<Value>DetailShowSameInclude</Value>
</Value>
<Value name="16">
<Value>DetailShowDifferentInclude</Value>
</Value>
<Value name="17">
<Value>DetailShowMissingInclude</Value>
</Value>
<Value name="18">
<Value>DetailShowExtraInclude</Value>
</Value>
<Value name="19">
<Value>DetailShowSameFull</Value>
</Value>
<Value name="20">
<Value>DetailShowDifferentFull</Value>
</Value>
<Value name="21">
<Value>PatternINCExclude</Value>
</Value>
<Value name="22">
<Value>PatternINCInclude</Value>
</Value>
</Data>
<DefaultData>IncludeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

