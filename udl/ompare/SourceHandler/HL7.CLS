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
/// <p>
/// Source indexer for HL7 Schemas<br/>
/// Extracts:
/// <ol><li>Implemention signatures for highlevel diffs</li>
/// <li><em>Optionally</em> functional source code lines for full-diff reporting</li>
/// <li>Creates an summary signature of HL7 independent of the order in which sub-elements and attributes are defined</li>
/// </ol>
/// Source line leading and trailing whitespace is ignored.<br/>
/// <h3>Configuration</h3>
/// To exclude source code from being captured for detailed reports use schedule configuration option IncludeSourceCode=0<br/>
/// To control which routines are included in each target namespace for analysis 
/// update the lookup global using Interoperability LookupTables in SMP or directly.
/// When first run in each namespace the following exclude defaults will be established:
/// <example>
/// ^ompare("Config","Exclude","2.1.hl7")=1
/// ^ompare("Config","Exclude","2.2.hl7")=1
/// ^ompare("Config","Exclude","2.3.hl7")=1
/// ^ompare("Config","Exclude","2.4.hl7")=1
/// ^ompare("Config","Exclude","2.5.hl7")=1
/// ^ompare("Config","Exclude","2.5.1.hl7")=1
/// ^ompare("Config","Exclude","2.6.hl7")=1
/// ^ompare("Config","Exclude","2.7.hl7")=1
/// ^ompare("Config","Exclude","2.7.1.hl7")=1
/// ^ompare("Config","Exclude","2.8.hl7")=1
/// ^ompare("Config","Exclude","2.8.1.hl7")=1
/// ^ompare("Config","Exclude","2.8.2.hl7")=1
/// ^ompare("Config","Exclude","HealthShare_2.5.hl7")=1
/// ^ompare("Config","Exclude","ITK.HL7.hl7")=1
/// </example>
/// Where value "1" means exclude and "0" means include.<br/>
/// Exclusions can layer for example to exclude all hl7 schemas with prefix "ompare"
/// except do include analysis of any hl7 schemas with prefix "ompareV2":
/// <example>
/// ^ompare("Config","Exclude","ompare*.hl7")=1
/// ^ompare("Config","Exclude","ompareV2*.hl7")=0
/// </example>
Class ompare.SourceHandler.HL7 Extends ompare.SourceHandler.Base
{

/// Ensure this Code doesn't collide with other sub-class implementations of Base
/// Eg: "CLS" abbreviation for class
Parameter DocumentType As %String = "hl7";

/// Main entry point for HL7 Source Handler
/// Do ##class(ompare.SourceHandler).IndexNamespace("OMPARE-TEST",,1)
ClassMethod IndexNamespace(namespace = "", logging = 0, includeSource = 0, schedule As ompare.Schedule = {$$$NULLOREF}) As %Status
{
	#define RPTType "HL7"
	#define RPTSubTypeCategory "HL7CAT"
	#define RPTSubTypeMessageGroup "HL7MG"
	#define RPTSubTypeMessageEvent "HL7ME"
	#define RPTSubTypeMessageType "HL7MT"
	#define RPTSubTypeMessageStructure "HL7MS"
	#define RPTSubTypeSegmentStructure "HL7SS"
	#define RPTSubTypeDataType "HL7DT"
	#define RPTSubTypeCodeTable "HL7CT"
	#define RPTSubTypeConfig "CFG"
	#define RPTItemConfigMapped "IsMapped"
	#define RPTItemConfigSourceControlled "IsSourceControlled"
	#define RPTItemConfigSourceVersion "SrcVer"
	
	if '$IsObject(schedule) {
		set schedule=##class(ompare.Schedule).%New()
	}
	// Testing
    // Do ##class(ompare.SourceHandler.HL7).IndexNamespace("Namespace",0,0)
	
	/*****************************
	 Start Template
	******************************/
	#dim tmpStream as %Stream.TmpCharacter
	Set tmpStream=##class(%Stream.TmpCharacter).%New()
	// It is necessary to switch namespace context within the method call as source code may not be 
	// deployed to target namespace
	set ret=$$$OK
	
	Quit:namespace="" $$$ERROR(5001,"Namespace not supplied to Routine Source Handler")
	
	New $NAMESPACE  // Ensures when method exits process will be returned to the original namespace
	
	try {	
		 // Generates <NAMESPACE> error if namespace doesn't exist
		 // Generate <PROTECT> error if user does not have access privilage
		set $NAMESPACE=namespace
	} catch errobj {
		// Name
		// Code
		// Location
		// Data
		if errobj.Name="<NAMESPACE>" {
			set ret=$$$ERROR(5001,"Cannot index namespace "_namespace_". Namespace does not exist.")
		} elseif errobj.Name="" {
			set ret=$$$ERROR(50001,"Cannot index namesapce "_namespace_". User "_$USERNAME_" does not have permission.")
		} else {
			set ret=$$$ERROR(5001,"Unknow error "_errobj.Name_". In code "_errobj.Code_" at location "_errobj.Location)
		}
	}
	Quit:$$$ISERR(ret) ret
    
	
	// Invoke sub-class extension code
	try {
		Do IndexerMain
	} catch ex {
		// Always report issue in output
		Do Log("Error","In SourceHandler.HL7Definition")
		Do Log("  Name:",ex.Name)
		Do Log("  Code:",ex.Code)
		Do Log("  Location:",ex.Location)
		Do Log("  Data:",ex.Data)
		Set ret=ex.AsStatus()
	}
	Quit ret
SetIsMapped(typeName="")
	quit:$$$RPTType=""
	quit:typeName=""
	quit:'##class(%Dictionary.CompiledMethod).%ExistsId("%Studio.SourceControl.ISC||IsMapped")
	// Assumes if the source control file is present on the filesystem then it is being source controlled
	// Requires both 3rd and 4th key to reuse generic export / import mechanism
	set ^||Data($$$RPTType,typeName,$$$RPTSubTypeConfig,$$$RPTItemConfigMapped)=##class(%Studio.SourceControl.ISC).IsMapped(typeName_".HL7")
	quit
SetIsSourceControlled(typeName="")
	quit:$$$RPTType=""
	quit:typeName=""
	quit:$Data(^Sources)<11
	quit:$$SourceControlClass^%occLibrary($Namespace)'="%Studio.SourceControl.ISC"
	// Assumes if the source control file is present on the filesystem then it is being source controlled
	// Requires both 3rd and 4th key to reuse generic export / import mechanism
	set ^||Data($$$RPTType,typeName,$$$RPTSubTypeConfig,$$$RPTItemConfigSourceControlled)=##class(%File).Exists(##class(%Studio.SourceControl.ISC).ExtName(typeName_".HL7"))
	quit
SetSourceVersion(typeName,data)
	quit:$$$RPTType=""
	quit:typeName=""
	set data=$ZSTRIP(data,"<>W")
	set:$E(data,1)=":" data=$ZSTRIP($E(data,2,*),"<>W")
	quit:data=""
	// Requires both 3rd and 4th key to reuse generic export / import mechanism
	set ^||Data($$$RPTType,typeName,$$$RPTSubTypeConfig,$$$RPTItemConfigSourceVersion)=data
	quit
SetSignature(typeName="", signature="",subTypeCode="", subTypeName="")
	Quit:$$$RPTType=""
	Quit:typeName=""
	Quit:signature=""
	if subTypeCode'="",subTypeName'="" {
		set ^||Data($$$RPTType,typeName,subTypeCode,subTypeName)=signature
	} else {
		set ^||Data($$$RPTType,typeName)=signature
	}
	quit
	// To itterate on the names and signatures of a particular subType
	// pass typeName by value required
	// pass signature by reference
	// pass subTypeCode by value required
	// pass subTypeName by reference required
NextSignature(typeName,signature,subTypeCode, subTypeName)
  set signature=""
  // subTypeName may be empty string at start of itteration
  Quit:typeName="" 0
  Quit:subTypeCode="" 0
  set subTypeName=$Order(^||Data($$$RPTType,typeName,subTypeCode,subTypeName),+1,signature)
  Quit:subTypeName="" 0 
  Quit 1
  // Write to stream AND conditionally to DataSrc
WriteLine(stream,data)
  // Intercept Source Control Tokens
  // eg: $I + d: //some/org/project/product/BASE/rtn/PRTDR9ORG.rtn#1 $
  // Converts to $I + d$
  set dataNoTokenVersion=""
  if schedule.SrcVersionTokenStart'="" {
	if schedule.SrcVersionTokenEnd'="" {
		set pattern=".E1"""_schedule.SrcVersionTokenStart_"""1.E1"""_schedule.SrcVersionTokenEnd_""""
  		for {
		  quit:data'?@pattern
		  set dataNoTokenVersion=dataNoTokenVersion_$P(data,schedule.SrcVersionTokenStart)_schedule.SrcVersionTokenStart_schedule.SrcVersionTokenEnd
		  set data=$P($P(data,schedule.SrcVersionTokenStart,2,999999),schedule.SrcVersionTokenEnd,2,999999)
	  	}
	} elseif data[schedule.SrcVersionTokenStart {
		// The source control token effectively matches to the end of the line
		set data=$P(data,schedule.SrcVersionTokenStart)	
	}
  }
  // Include remainder of line after token end if token version content removed
  set:$L(dataNoTokenVersion)>0 data=dataNoTokenVersion_data
  
  
  // strip any terminating whitespace from line
  set data=$ZSTRIP(data,">W")
  // reformatting lines section
  Do stream.WriteLine(data)
  Do:includeSource AddLine($I(line),data)
  Quit
AddLine(line,data)
  Quit:+line=0
  // remove previous data
  if line=1 {
	 kill ^||DataSrcTmp
	 set ^||DataSrcTmp=+$H
  }
  set ^||DataSrcTmp(line)=data
  Quit
SaveLines(sig="")
  quit:sig=""
  if $Data(^||DataSrc(sig)) {
	// if the source record already exists simply update the last referenced date to today
	set ^||DataSrc(sig)=+$H
  } else {
	merge ^||DataSrc(sig)=^||DataSrcTmp
	Kill ^||DataSrcTmp
  }
  Quit 1
Log(label, value="")
	W !,label,":",value
	Quit
IsExcluded(name,reason)
	Quit:name="" 1
	// Change the type extension to uppercase 
	set extension=$ZCVT($P(name,".",$L(name,".")),"L")
	set name=$e(name,1,*-($L(extension)+1))
	// Check Exact match for exlcusion
	if +$G(^ompare("Config","Exclude",name_"."_extension)) {
		set reason=name_"."_extension
		quit 1	
	} elseif $Data(^ompare("Config","Exclude",name_"."_extension)) {
		// Explicitly NOT excluded
		quit 0	
	}
	// now recursively look to exclude by wildcard match.
	set found=0
	set reason=""
	set prefix=$e(name,1,*-1)_"*"
	for {
		set found=+$G(^ompare("Config","Exclude",prefix_"."_extension))
		set:found reason=prefix_"."_extension
		quit:found
		if $Data(^ompare("Config","Exclude",prefix_"."_extension)) {
			// Explicitly NOT excluded
			quit	
		}
		set prefix=$E(prefix,1,*-2)_"*"
		q:prefix="*"
	}
	quit found
	
IndexerMain
	/*****************************
	 End Template
	 Add sub-class code and supporting HL7 schema components from this point forward.
	******************************/
	// Default exclusions in this namespace
	// Start set once in first run namespace
	set hasConfig=0
	set testExclude=""
	for {
		set testExclude=$O(^ompare("Config","Exclude",testExclude))
		quit:testExclude=""
		if $E(testExclude,*-3,*)=".hl7" {
			set hasConfig=1
			quit  // exit on first encountered
		}
	}
	if 'hasConfig {
		// ignore system routines
		set ^ompare("Config","Exclude","2.1.hl7")=1
		set ^ompare("Config","Exclude","2.2.hl7")=1
		set ^ompare("Config","Exclude","2.3.hl7")=1
		set ^ompare("Config","Exclude","2.3.1.hl7")=1
		set ^ompare("Config","Exclude","2.4.hl7")=1
		set ^ompare("Config","Exclude","2.5.hl7")=1
		set ^ompare("Config","Exclude","2.5.1.hl7")=1
		set ^ompare("Config","Exclude","2.6.hl7")=1
		set ^ompare("Config","Exclude","2.7.hl7")=1
		set ^ompare("Config","Exclude","2.7.1.hl7")=1
		set ^ompare("Config","Exclude","2.8.hl7")=1
		set ^ompare("Config","Exclude","2.8.1.hl7")=1
		set ^ompare("Config","Exclude","2.8.2.hl7")=1
		set ^ompare("Config","Exclude","HealthShare_2.5.hl7")=1
		set ^ompare("Config","Exclude","ITK.hl7")=1
	}
	// End set once in first run namespace

	set hl7name=""
	for {
		set hl7name=$Order(^EnsHL7.Schema(hl7name))
		quit:hl7name=""
		
		if $$IsExcluded(hl7name_".hl7",.reason) {
			Do:logging Log("Ignore """_hl7name_""" matches filter",reason)
			continue	
		}		
		// Simple - Reindex ALL HL7 on demand
		Do:logging Log("ProcessRoutine",hl7name_$C(13,10))
		
		Do Indexhl7(hl7name,tmpStream,includeSource)
	}
	Quit
Indexhl7(hl7name,tmpStream,includeSource)
	Quit:hl7name=""
	Quit:'$IsObject(tmpStream)
	
	Do tmpStream.Clear()
	
	// Replace existing data
	set line=0
	
	set hl7Stream=##class(%Stream.TmpCharacter).%New()
	do ##class(%SYSTEM.OBJ).ExportToStream(hl7name_".HL7",hl7Stream,"/diffexport=1")
	do hl7Stream.Rewind()
	for {
		quit:hl7Stream.AtEnd
		set fragment=$ZSTRIP(hl7Stream.ReadLine(),"<>W")
		continue:$L(fragment)=0
		set elementName=$E($P(fragment," "),2,*)
		
		
		// skip start lines
		// <?xml version="1.0" encoding="UTF-8"?>
		// <Export
		// <Document
		continue:elementName="?xml"
		continue:elementName="Export"
		continue:elementName="Document"
		
		
		// TODO - Review subtypes
		if elementName="Category" {
			set subtype=$$$RPTSubTypeCategory  //"HL7CAT"
		} elseif elementName="MessageGroup" {  //Y
			set subtype=$$$RPTSubTypeMessageGroup  //"HL7MG" 1
		} elseif elementName="MessageEvent" {  //Y
			set subtype=$$$RPTSubTypeMessageEvent  //"HL7ME"  1
		} elseif elementName="MessageType" {
			set subtype=$$$RPTSubTypeMessageType  //"HL7MT" // 0
		} elseif elementName="MessageStructure" {  //1
			set subtype=$$$RPTSubTypeMessageStructure // "HL7MS"
		} elseif elementName="SegmentStructure" {  //1
			// Multi
			set subtype=$$$RPTSubTypeSegmentStructure //"HL7SS"			
		} elseif elementName="DataType" {
			// Multi
			set subtype=$$$RPTSubTypeDataType //HL7DT  1
		} elseif elementName="CodeTable" {
			// multi
			set subtype=$$$RPTSubTypeCodeTable //HL7CT
		} else {
			set subtype="Unknown"
		}
		
		/*
			#define RPTSubTypeCategory "HL7CAT"
	#define RPTSubTypeMessageGroup "HL7MG"
	#define RPTSubTypeMessageEvent "HL7ME"
	#define RPTSubTypeMessageType "HL7MT"
	#define RPTSubTypeMessageStructure "HL7MS"
	#define RPTSubTypeDataType "HL7DT"
	#define RPTSubTypeCodeTable "HL7CT"
		*/
		do IndexContent(hl7name,subtype, tmpStream,hl7Stream,includeSource,fragment)
	
	}
	
	set hl7Summary=hl7name
	// After completing detail for line labels make a signature for the whole routine
	// Note that the order of the line labels is not functionally important
	for subtypeKey=$$$RPTSubTypeCategory,$$$RPTSubTypeMessageGroup,$$$RPTSubTypeMessageEvent,$$$RPTSubTypeMessageType,$$$RPTSubTypeMessageStructure,$$$RPTSubTypeSegmentStructure,$$$RPTSubTypeDataType,$$$RPTSubTypeCodeTable {
	
		set currentItem=""
		for {
			Quit:'$$NextSignature(hl7name,.sig,subtypeKey,.currentItem)
			set hl7Summary=hl7Summary_";"_currentItem_":"_sig
		}
	}
	
	Do SetSignature(hl7name, $SYSTEM.Encryption.Base64Encode($SYSTEM.Encryption.SHA1Hash(hl7Summary)))
	
	Do SetIsMapped(hl7name)
	Do SetIsSourceControlled(hl7name)
	
	Quit
	;From
	;	"<Category name=""Test"" desc=""Description"" />"
	; generates
	;   aryout("desc")="Description"
	;   aryout("name")="Test"
SplitAttributes(xmlline,aryout)
	kill aryout
	set xmlline=$ZSTRIP(xmlline,"<>W")
	if $E(xmlline,1)="<" set xmlline=$ZSTRIP($P(xmlline," ",2,999),"<W")
	for {
		quit:xmlline=""
		quit:xmlline="/>"
		quit:xmlline=">"
		set xmlatname=$ZSTRIP($P(xmlline,"="),">W")
		set xmlline=$ZSTRIP($P(xmlline,"=",2,9999),"<W")
		continue:xmlatname=""
		set xmlquot=$E(xmlline,1)
		continue:xmlquot'?1(1"""",1"'")
		set xmlatvalue=$P(xmlline,xmlquot,2)
		set xmlline=$ZSTRIP($P(xmlline,xmlquot,3,99999),"<W")
		set aryout(xmlatname)=xmlatvalue
	}
	Quit

	;
	; Indexer for:
	; * Category - Top level tag
	; * MessageStructure
	; * MessageGroup
	; * MessageEvent
	; * MessageType
	; * DataType
	; * CodeTable
IndexContent(hl7name,subtype, sigStream,hl7Stream,includeSource,fragment,source)
	
	Do sigStream.Clear()
	set line=0
	set fragment=$ZSTRIP(fragment,"<>W")
	set rootElementStart=$P($P($P($P(fragment,"<",2)," "),"/"),">")
	Kill aryout
	//W:subtype="HL7MT" !,"rootElementStart:",rootElementStart
	set isMultiLine=$S(subtype="HL7CAT":0,$E(fragment,*-1,*)="/>":0,1:1)
	// Both multi and single
	do SplitAttributes(fragment,.aryout)
	set (xmlatname,subtypeName)=$G(aryout("name"))
	quit:xmlatname=""  // If this hit a comment <!-- --> would be quite unlikely to pass this step.

	Do:logging Log("xmlatname",xmlatname_$C(13,10))
	Do:logging Log("subtype",subtype_$C(13,10))
	
	set xmlatname=""
	for {
		set xmlatname=$O(aryout(xmlatname),1,xmlatvalue)
		quit:xmlatname=""
		Do WriteLine(sigStream,xmlatname_": "_xmlatvalue)
	}
	if 'isMultiLine {
		if sigStream.Size>0 {
			Do sigStream.Rewind()
			set sig=$SYSTEM.Encryption.Base64Encode($SYSTEM.Encryption.SHA1HashStream(sigStream))
			Do SetSignature(hl7name, sig,subtype,subtypeName)
			Do:includeSource SaveLines(sig)
			Do sigStream.Clear()
		}
		quit  // end for single line element
	}
	set pad="                                                 "
	set level=1
	for {
		quit:hl7Stream.AtEnd
		set fragment=$ZSTRIP(hl7Stream.ReadLine(),"<>W")
		//W:$E(fragment,1,2)="</" fragment
		quit:fragment=("</"_rootElementStart_">")
		
		if $E(fragment,1,2)="</" {
			kill level(level)
			set level=level-1
			continue
		}
		if $E(fragment,1)="<" {
			set innerElement=$P($P($P($P(fragment,"<",2)," "),"/"),">")
			if innerElement'="" {
				set level($I(level))=innerElement
				Do WriteLine(sigStream,$E(pad,1,level*2)_innerElement_":")
				do SplitAttributes(fragment,.aryout)
				//set xmlatname=$G(aryout("name"))
				//quit:xmlatname=""
				set xmlatname=""
				for {
					set xmlatname=$O(aryout(xmlatname),1,xmlatvalue)
					quit:xmlatname=""
					Do WriteLine(sigStream,$E(pad,1,(level*2)+2)_xmlatname_": "_xmlatvalue)
				}
				
			}
			if $E(fragment,*-1,*)="/>" {
				kill level(level)
				set level=level-1
				continue	
			}
		} else {
			// attributes spanning multiple lines
			do SplitAttributes(fragment,.aryout)
			set xmlatname=""
			for {
				set xmlatname=$O(aryout(xmlatname),1,xmlatvalue)
				quit:xmlatname=""
				Do WriteLine(sigStream,$E(pad,1,(level*2)+2)_xmlatname_": "_xmlatvalue)
			}
		}
	}
	if sigStream.Size>0 {
		Do sigStream.Rewind()
		set sig=$SYSTEM.Encryption.Base64Encode($SYSTEM.Encryption.SHA1HashStream(sigStream))
		Do SetSignature(hl7name, sig,subtype,subtypeName)
		Do:includeSource SaveLines(sig)
		Do sigStream.Clear()
	}
	
	
	
	Quit

	/***********************
	  End Indexer Specific code
	************************/
	Quit
}

ClassMethod TSplitAttributes(xmlline, aryout)
{
	kill aryout
	set xmlline=$ZSTRIP(xmlline,"<>W")
	if $E(xmlline,1)="<" set xmlline=$ZSTRIP($P(xmlline," ",2,999),"<W")
	for {
		quit:xmlline=""
		quit:xmlline="/>"
		quit:xmlline=">"
		set xmlatname=$ZSTRIP($P(xmlline,"="),">W")
		set xmlline=$ZSTRIP($P(xmlline,"=",2,9999),"<W")
		continue:xmlatname=""
		set xmlquot=$E(xmlline,1)
		continue:xmlquot'?1(1"""",1"'")
		set xmlatvalue=$P(xmlline,xmlquot,2)
		set xmlline=$ZSTRIP($P(xmlline,xmlquot,3,99999),"<W")
		set aryout(xmlatname)=xmlatvalue
	}
	Quit
}

}

