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
Class ompare.ReportType.Routine Extends ompare.ReportType.Base
{

/// Ensure this Code doesn't collide with other sub-class implementations of Base
/// Eg: "C" abbreviation for class
Parameter DocumentType As %String = "rou";

Parameter RPTTypeRoutines = "R";

Parameter RPTSubTypeLineLabel = "L";

Property SummaryShowSameRoutines As %Boolean [ InitialExpression = 0 ];

Property SummaryShowDifferentRoutines As %Boolean [ InitialExpression = 1 ];

Property SummaryShowMissingRoutines As %Boolean [ InitialExpression = 1 ];

Property SummaryShowExtraRoutines As %Boolean [ InitialExpression = 1 ];

Property SummaryIncludeMappedRoutines As %Boolean [ InitialExpression = 1 ];

Property SummaryIncludeUncontrolledRoutines As %Boolean [ InitialExpression = 1 ];

Property DetailShowSameLabels As %Boolean [ InitialExpression = 0 ];

Property DetailShowDifferentLabels As %Boolean [ InitialExpression = 1 ];

Property DetailShowMissingLabels As %Boolean [ InitialExpression = 1 ];

Property DetailShowExtraLabels As %Boolean [ InitialExpression = 1 ];

/// Subscript 3 = pattern
Property PatternRoutinesExclude As list Of %String(MAXLEN = 10000);

/// Subscript 4 = pattern
Property PatternRoutinesInclude As list Of %String(MAXLEN = 10000);

/// Subscript 9 = pattern
Property PatternLabelsExclude As list Of %String(MAXLEN = 10000);

/// Subscript 10 = pattern
Property PatternLabelsInclude As list Of %String(MAXLEN = 10000);

Parameter PageAnchor = "Routines";

Parameter ReportOrder = 1;

/// Called from ompare.Report.Defintion on subclass on ompare.ReportType.Base
/// Override in subclass
ClassMethod CreateDynamicReport(name As %String) As ompare.ReportType.Base
{
	set obj=..%New()
	set obj.SummaryShowSameRoutines=1
	set obj.SummaryShowDifferentRoutines=1
	set obj.SummaryShowMissingRoutines=1
	set obj.SummaryShowExtraRoutines=1
	set obj.SummaryIncludeMappedRoutines=1
	set obj.SummaryIncludeUncontrolledRoutines=1
	set obj.DetailShowSameLabels=0
	set obj.DetailShowDifferentLabels=1
	set obj.DetailShowMissingLabels=1
	set obj.DetailShowExtraLabels=1
	do obj.PatternRoutinesExclude.Insert("*")
	do obj.PatternRoutinesInclude.Insert(name)
	quit obj
}

/// Called from ompare.Report.Defintion on subclass on ompare.ReportType.Base
/// Override in subclass
Method PopulateReportParams(ByRef config, ByRef summary, ByRef detail, ByRef exclude, ByRef include)
{
	set:..SummaryShowSameRoutines summary(..#RPTTypeRoutines,..#RPTSame)=""
	set:..SummaryShowDifferentRoutines summary(..#RPTTypeRoutines,..#RPTDifferent)=""
	set:..SummaryShowMissingRoutines summary(..#RPTTypeRoutines,..#RPTMissing)=""
	set:..SummaryShowExtraRoutines summary(..#RPTTypeRoutines,..#RPTExtra)=""
	set:..SummaryIncludeMappedRoutines config(..#RPTTypeRoutines,..#RPTMapped)=""
	set:..SummaryIncludeUncontrolledRoutines config(..#RPTTypeRoutines,..#RPTSourceControlled)=""
	
	set:..DetailShowSameLabels detail(..#RPTSubTypeLineLabel,..#RPTSame)=""
	set:..DetailShowDifferentLabels detail(..#RPTSubTypeLineLabel,..#RPTDifferent)=""
	set:..DetailShowMissingLabels detail(..#RPTSubTypeLineLabel,..#RPTMissing)=""
	set:..DetailShowExtraLabels detail(..#RPTSubTypeLineLabel,..#RPTExtra)=""
	
	
	set key=""
	for {
		set pattern=..PatternRoutinesExclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		set exclude(..#RPTTypeRoutines,pattern)=""	
	}
	for {
		set pattern=..PatternRoutinesInclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		set include(..#RPTTypeRoutines,pattern)=""	
	}
	for {
		set pattern=..PatternLabelsExclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		set exclude(..#RPTSubTypeLineLabel,pattern)=""	
	}
	for {
		set pattern=..PatternLabelsInclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		set include(..#RPTSubTypeLineLabel,pattern)=""	
	}
}

Method IsEmptyReport() As %Boolean
{
	Quit:..SummaryShowSameRoutines 0
	Quit:..SummaryShowDifferentRoutines 0
	Quit:..SummaryShowMissingRoutines 0
	Quit:..SummaryShowExtraRoutines 0
	Quit 1
}

Method IsEmptyReportType(type As %String) As %Boolean
{
	Quit:type'=..#RPTTypeRoutines 1
	Quit ..IsEmptyReport()
}

Method PopulateFromHttpRequest()
{
	set ..SummaryShowSameRoutines=$G(%request.Data(..#DocumentType_"SummaryShowSameRoutines",1),0)
	set ..DetailShowSameLabels=$G(%request.Data(..#DocumentType_"DetailShowSameLabels",1),0)
	set ..SummaryShowDifferentRoutines=$G(%request.Data(..#DocumentType_"SummaryShowDifferentRoutines",1),0)
	set ..DetailShowDifferentLabels=$G(%request.Data(..#DocumentType_"DetailShowDifferentLabels",1),0)
	set ..SummaryShowMissingRoutines=$G(%request.Data(..#DocumentType_"SummaryShowMissingRoutines",1),0)
	set ..DetailShowMissingLabels=$G(%request.Data(..#DocumentType_"DetailShowMissingLabels",1),0)
	set ..SummaryShowExtraRoutines=$G(%request.Data(..#DocumentType_"SummaryShowExtraRoutines",1),0)
	set ..DetailShowExtraLabels=$G(%request.Data(..#DocumentType_"DetailShowExtraLabels",1),0)
	do ..PatternRoutinesExclude.Clear()
	set data=$TR($G(%request.Data(..#DocumentType_"PatternRoutinesExclude",1),""),$C(13))
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
		do ..PatternRoutinesExclude.Insert(pattern)	
	}
	do ..PatternRoutinesInclude.Clear()
	set data=$TR($G(%request.Data(..#DocumentType_"PatternRoutinesInclude",1),""),$C(13))
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
		do ..PatternRoutinesInclude.Insert(pattern)	
	}
	
	do ..PatternLabelsExclude.Clear()
	set data=$TR($G(%request.Data(..#DocumentType_"PatternLabelsExclude",1),""),$C(13))
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
		do ..PatternLabelsExclude.Insert(pattern)	
	}
	do ..PatternLabelsInclude.Clear()
	set data=$TR($G(%request.Data(..#DocumentType_"PatternLabelsInclude",1),""),$C(13))
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
		do ..PatternLabelsInclude.Insert(pattern)	
	}
}

Method DrawEditConfigForm()
{
	W !,"<fieldset><legend>Routine Configuration</legend>"
	W !,"Show Same Routines <input name=""",..#DocumentType,"SummaryShowSameRoutines"" type=""checkbox"" value=""1""",$Select(..SummaryShowSameRoutines:" checked",1:""),"/><br/>"
	W !,"Show Different Routines <input name=""",..#DocumentType,"SummaryShowDifferentRoutines"" type=""checkbox"" value=""1""",$Select(..SummaryShowDifferentRoutines:" checked",1:""),"/><br/>"
	W !,"Show Missing Routines <input name=""",..#DocumentType,"SummaryShowMissingRoutines"" type=""checkbox"" value=""1""",$Select(..SummaryShowMissingRoutines:" checked",1:""),"/><br/>"
	W !,"Show Extra Routines <input name=""",..#DocumentType,"SummaryShowExtraRoutines"" type=""checkbox"" value=""1""",$Select(..SummaryShowExtraRoutines:" checked",1:""),"/><br/>"
	W !,"Include Mapped <input name=""",..#DocumentType,"SummaryIncludeMappedRoutines"" type=""checkbox"" value=""1""",$Select(..SummaryIncludeMappedRoutines:" checked",1:""),"/><br/>"
	W !,"Include Source Uncontrolled <input name=""",..#DocumentType,"SummaryIncludeUncontrolledRoutines"" type=""checkbox"" value=""1""",$Select(..SummaryIncludeUncontrolledRoutines:" checked",1:""),"/><br/>"
	
	W !,"Exclude&nbsp;pattern&nbsp;<textarea name=""",..#DocumentType,"PatternRoutinesExclude"" rows=""4"" cols=""50"">"
	set key="",pattern=""
	for {
		set pattern=..PatternRoutinesExclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		W $ZCONVERT(pattern,"O","HTML"),$C(10)	
	}
	W "</textarea><br/>"
	W !,"Include&nbsp;pattern&nbsp;<textarea name=""",..#DocumentType,"PatternRoutinesInclude"" rows=""4"" cols=""50"">"
	set key="",pattern=""
	for {
		set pattern=..PatternRoutinesInclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		W $ZCONVERT(pattern,"O","HTML"),$C(10)	
	}
	W "</textarea><br/>"
	
	W !,"<fieldset><legend>Label Configuration</legend>"
	W !,"Show Same Labels <input name=""",..#DocumentType,"DetailShowSameLabels"" type=""checkbox"" value=""1""",$Select(..DetailShowSameLabels:" checked",1:""),"/><br/>"
	W !,"Show Different Labels <input name=""",..#DocumentType,"DetailShowDifferentLabels"" type=""checkbox"" value=""1""",$Select(..DetailShowDifferentLabels:" checked",1:""),"/><br/>"
	W !,"Show Missing Labels <input name=""",..#DocumentType,"DetailShowMissingLabels"" type=""checkbox"" value=""1""",$Select(..DetailShowMissingLabels:" checked",1:""),"/><br/>"
	W !,"Show Extra Labels <input name=""",..#DocumentType,"DetailShowExtraLabels"" type=""checkbox"" value=""1""",$Select(..DetailShowExtraLabels:" checked",1:""),"/><br/>"
	W !,"Exclude&nbsp;pattern&nbsp;<textarea name=""",..#DocumentType,"PatternLabelsExclude"" rows=""4"" cols=""50"">"
	set key="",pattern=""
	for {
		set pattern=..PatternLabelsExclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		W $ZCONVERT(pattern,"O","HTML"),$C(10)	
	}
	W "</textarea><br/>"
	W !,"Include&nbsp;pattern&nbsp;<textarea name=""",..#DocumentType,"PatternLabelsInclude"" rows=""4"" cols=""50"">"
	set key="",pattern=""
	for {
		set pattern=..PatternLabelsInclude.GetNext(.key)
		quit:key=""
		continue:pattern=""
		W $ZCONVERT(pattern,"O","HTML"),$C(10)	
	}
	W "</textarea><br/>"
	W !,"</fieldset>"
	
	W !,"</fieldset>"
}

Method DrawReport(definition As ompare.Report.Definition, isFirstDisplayed As %Boolean = 0)
{
	quit:..IsEmptyReport()
	set elapstart=$P($ZTS,",",2)
	W !,"<span class=""SectionTitle"">Section: Routines</span>"
	W !,"<a name=""show",..#PageAnchor,"""></a>"
	W:'isFirstDisplayed "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<a href=""#showTop"">Back to Top</a>]"
	W !,"<table border=1>"
	W !," <tr>"
	W !,"  <th>Item</th>"
	W !,"  <th>Routine Name</th>"
	//  Put From Environment as the first column
	W !,"  <th>",definition.FromEnvironment,"</th>"
	set env=""
	for {
		set env=$Order(^||ReportData("Meta","To",env),+1,date)
		quit:env=""
		W !,"  <th>",$ZCONVERT(env,"O","HTML"),"<br/>",$ZD(date,3),"</th>"
	}
	W !," <tr>"
	set routinename=""
	set sequence=0
	for {
		set routinename=$O(^||ReportData(..#RPTTypeRoutines,routinename))
		quit:routinename=""
		
		W !," <tr>"
		W !,"  <td>",$Increment(sequence),"</td>"
		W !,"  <td>",$ZCONVERT(routinename,"O","HTML"),"</td>"
		
		set toNs=$O(^||ReportData(..#RPTTypeRoutines,routinename,"s",definition.FromEnvironment,""),+1,result)
		if toNs="" {
			W "<td> - </td>"
		} else {
			W "<td>",$Case(result,..#RPTSame:"Same",..#RPTDifferent:"Different",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - "),"</td>"
		}
		
		set env=""
		for {
			set env=$Order(^||ReportData("Meta","To",env),+1,date)
			quit:env=""
		
			set toNs=$O(^||ReportData(..#RPTTypeRoutines,routinename,"s",env,""),+1,result)
			if toNs="" {
				W "<td> - </td>"
			} else {
				set lnk("sfEnv")=definition.FromEnvironment
				set lnk("sfNS")=$Select($D(lnk("sfEnv")):$O(definition.EnvironmentsMD(lnk("sfEnv"),"")),1:"")
				set lnk("sfT")="R"
				set lnk("sfTN")=routinename
				set lnk("sfST")="L"  // eg: "M"
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
				set lnk("stT")="R"
				set lnk("stTN")=routinename
				set lnk("stST")="L"  // eg: "M"
				set lnk("stSTN")=""  // eg: OnProcessInput
					
					
				W "<td style=""vertical-align:top"""
				if result=..#RPTDifferent {
					if definition.DisplayDifferenceDetail {
						W "><div>",..ReportDetailAltTextWithLink(..#RPTTypeRoutines,routinename,env,,.lnk,result),"</div>"
					} else {
						W " title=""",$ZCONVERT(..ReportDetailAltText(..#RPTTypeRoutines,routinename,env),"O","HTML"),""">Different"
					}
				} else {
					W ">",$Case(result,..#RPTSame:"Same",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - ")
				}
				W "</td>"
			}
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
	if +$G(out(..#RPTSubTypeLineLabel))>0 {
		W $S($L(return):eol,1:"")_"Line Label:"
		set:$L(return)=0 return=" "
		for i=1:1:out(..#RPTSubTypeLineLabel) {
			//W eol_" *"_out(..#RPTSubTypeLineLabel,i,"name")_" ("_..RTPEnumToText(out(..#RPTSubTypeLineLabel,i,"result"))_")<br/>"
			set lnk("sfST")=..#RPTSubTypeLineLabel
			set lnk("sfSTN")=out(..#RPTSubTypeLineLabel,i,"name")
			set lnk("stST")=..#RPTSubTypeLineLabel
			set lnk("stSTN")=out(..#RPTSubTypeLineLabel,i,"name")
			set result=$G(out(..#RPTSubTypeLineLabel,i,"result"))
			W eol_" *"_out(..#RPTSubTypeLineLabel,i,"name")_" ("
			Do ..AddSourceLink(..RTPEnumToText(result),.lnk,result)
			W ")"
			d:displayComments ..DisplayComment(.lnk)
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
 			W !,"<Cell ss:StyleID=""s64""><Data ss:Type=""String"">RoutineName</Data></Cell>"
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
 
 
 	if $Data(^||ReportData(..#RPTTypeRoutines))=0 {	 	
	 	Do ##class(ompare.Report.ExportExcelWorkbook).ReportIfEmptySection(reportType.SummaryShowSameRoutines,reportType.SummaryShowDifferentRoutines,reportType.SummaryShowMissingRoutines,reportType.SummaryShowExtraRoutines)
 	} else {
		 // Routine Header
 		set routinename=""
		for {
			set routinename=$O(^||ReportData(..#RPTTypeRoutines,routinename))
			quit:routinename=""
			
			// Need to look through and count the number of sub-report lines
			set clines=0
			set subtype=""
			for {
				set subtype=$O(^||ReportData(..#RPTTypeRoutines,routinename,"d",subtype))
				quit:subtype=""
				set clines=clines+1  // Each subtype has an informational header
				
				set subname=""
				for {
					set subname=$O(^||ReportData(..#RPTTypeRoutines,routinename,"d",subtype,subname))
					quit:subname=""  // Each subtype item prints a line
					set clines=clines+1
				}
			}
			set:'clines clines=1
			
			W !,"<Row ss:AutoFitHeight=""0"" ss:Height=""",##class(ompare.Report.ExportExcelWorkbook).CapLineHeight((clines)*$PARAMETER("ompare.Report.ExportExcelWorkbook","LineHeight")),""">"
			//W !,"<Row>"  // TODO - Do we need to know the expanded row height?
			W !,"<Cell><Data ss:Type=""String"">",$Increment(sequenceNumber),"</Data></Cell>"  //seq
			W !,"<Cell><Data ss:Type=""String"">",..XMLO(routinename),"</Data></Cell>"
			
			set toNs=$O(^||ReportData(..#RPTTypeRoutines,routinename,"s",definition.FromEnvironment,""),+1,result)
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
			
				set toNs=$O(^||ReportData(..#RPTTypeRoutines,routinename,"s",env.Name,""),+1,result)
				if toNs="" {
					W !,"<Cell><Data ss:Type=""String""> - </Data></Cell>"
				} else {
					W !,"<Cell ss:StyleID=""s67""><Data ss:Type=""String"">"
					if result'=..#RPTDifferent {
						W ..XMLO($Case(result,..#RPTSame:"Same",..#RPTMissing:"Missing",..#RPTExtra:"Extra",:" - ")_" Routine")
					} else {
						// Style to wrap text
						Do ..SpreadsheetReportDetailText(..#RPTTypeRoutines, routinename, env.Name)
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
	
	// Start customization
	if +$G(out(..#RPTSubTypeLineLabel))>0 {
		W:'first ..#eol
		S first=0
		W ..XMLO("Line Label:")
		for i=1:1:out(..#RPTSubTypeLineLabel) {
			W ..#eol,..XMLO(" *"_$G(out(..#RPTSubTypeLineLabel,i,"name"))_" ("_..RTPEnumToText($G(out(..#RPTSubTypeLineLabel,i,"result")))_")")
		}	
	}
	
	Quit
}

Storage Default
{
<Data name="RoutineDefaultData">
<Subscript>"Routine"</Subscript>
<Value name="1">
<Value>SummaryShowSameRoutines</Value>
</Value>
<Value name="2">
<Value>SummaryShowDifferentRoutines</Value>
</Value>
<Value name="3">
<Value>SummaryShowMissingRoutines</Value>
</Value>
<Value name="4">
<Value>SummaryShowExtraRoutines</Value>
</Value>
<Value name="5">
<Value>SummaryIncludeMappedRoutines</Value>
</Value>
<Value name="6">
<Value>SummaryIncludeUncontrolledRoutines</Value>
</Value>
<Value name="7">
<Value>DetailShowSameLabels</Value>
</Value>
<Value name="8">
<Value>DetailShowDifferentLabels</Value>
</Value>
<Value name="9">
<Value>DetailShowMissingLabels</Value>
</Value>
<Value name="10">
<Value>DetailShowExtraLabels</Value>
</Value>
<Value name="11">
<Value>PatternRoutinesExclude</Value>
</Value>
<Value name="12">
<Value>PatternRoutinesInclude</Value>
</Value>
<Value name="13">
<Value>PatternLabelsExclude</Value>
</Value>
<Value name="14">
<Value>PatternLabelsInclude</Value>
</Value>
</Data>
<DefaultData>RoutineDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

