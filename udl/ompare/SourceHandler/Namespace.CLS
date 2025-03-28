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
/// Capture product deployment metadata context about the Namespace being analysed.
/// These minimum contexts will make it simpler to report configuration for comparing accross environments.
/// The following diagram shows the relationship of deployment concepts:
/// <ol><li>Organisation - (eg: ACME and MEEP)</li>
/// <li>System - (eg: PlanA and PlanB)</li>
/// <li>Environment - (eg: BASE, TEST, UAT, PROD)</li></ol>
/// In the example code is developed for two customers on a single shared inhouse development instance.
/// Each customer provides 3 seperate instances to support TEST, UAT and PROD stages.
/// The cylinders represent namespaces. In the example each logical product deployment consists of two participating namespaces.
/// Components for PlanA (System) occupy one namespace and components PlanB (System) occupy the other.
/// <img src="data:image/png;base64, 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"/><br/>
/// Metadata is added to each target namespace for next and subsequent analysis.
/// Update the lookup global using Interoperability LookupTables or Global Explorer in SMP or directly.
/// When first run in each namespace the following blank defaults will be added if no previous setting is detected.
/// <example>
/// ^Ens.LookupTable("ompare.Namespace","Organisation")=""
/// ^Ens.LookupTable("ompare.Namespace","System")=""
/// ^Ens.LookupTable("ompare.Namespace","Environment")=""
/// </example>
/// A complete configuration would be:
/// <example>
/// ^Ens.LookupTable("ompare.Namespace","Organisation")="MEEP"
/// ^Ens.LookupTable("ompare.Namespace","System")="PlanA"
/// ^Ens.LookupTable("ompare.Namespace","Environment")="TEST"
/// </example>
Class ompare.SourceHandler.Namespace Extends ompare.SourceHandler.Base
{

/// Ensure this Code doesn't collide with other sub-class implementations of Base
/// Eg: "CLS" abbreviation for class
Parameter TypeCode As %String;

/// Do not invoke supporting methods on this class definition
ClassMethod IndexNamespace(namespace = "", logging = 0, includeSource = 0, schedule As ompare.Schedule = {$$$NULLOREF}) As %Status
{
	#define RPTType "?"
	
	/*****************************
	 Start Template
	******************************/
	#dim tmpStream as %Stream.TmpCharacter
	Set tmpStream=##class(%Stream.TmpCharacter).%New()
	// It is necessary to switch namespace context within the method call as source code may not be 
	// deployed to target namespace
	set ret=$$$OK
	
	Quit:namespace="" $$$ERROR(5001,"Namespace not supplied to Namespace Source Handler")
	
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
	//Do IndexerMain
	try {
		// Invoke sub-class extension code
		Do IndexerMain  //(logging, includeSource)
	} catch ex {
		// Always report issue in output
		Do Log("Error","In SourceHandler.ClassDefinition")
		Do Log("  Name:",ex.Name)
		Do Log("  Code:",ex.Code)
		Do Log("  Location:",ex.Location)
		Do Log("  Data:",ex.Data)
		Set ret=ex.AsStatus()
	}
	
	Quit ret
Log(label, value)
	W !,label,":",value
	Quit
IndexerMain
	// Defaults
	if '$Data(^Ens.LookupTable("ompare.Namespace","Organisation")) {
		set ^Ens.LookupTable("ompare.Namespace","Organisation")=""
	}
	if '$Data(^Ens.LookupTable("ompare.Namespace","System")) {
		set ^Ens.LookupTable("ompare.Namespace","System")=""	
	}
	if '$Data(^Ens.LookupTable("ompare.Namespace","Environment")) {
		set ^Ens.LookupTable("ompare.Namespace","Environment")=""	
	}

	// Only record data on top node of ^||Data
	
	// Current Date
	set $P(^||Data,"^")=+$H
	
	// Current Time
	set $P(^||Data,"^",2)=$P($H,",",2)
	
	// Active Source Control Class
	set sourceControlClass=$G(^SYS("SourceControlClass"))
	if sourceControlClass'="" {
		set $P(^||Data,"^",3)=sourceControlClass
	} else {
		do:logging Log(label, value)
	}
	
	// Check for whether this is %Studio.SourceControl.ISC or empty
	if sourceControlClass'="" {
		if ##class(%Dictionary.CompiledMethod).%ExistsId(sourceControlClass_"||Locked") {
			// Is SourceControl Locked
			set $P(^||Data,"^",4)=$$Escape($CLASSMETHOD(sourceControlClass,"Locked"))
		}
		if ##class(%Dictionary.CompiledMethod).%ExistsId(sourceControlClass_"||Disconnected") {
			// Is SourceControl Connected
			set $P(^||Data,"^",5)=$$Escape($CLASSMETHOD(sourceControlClass,"Disconnected"))
		}
	} else {
		do:logging Log("Namespace Handler","Source Control Class not found")
	}
	
	if ##class(%Dictionary.CompiledClass).%ExistsId("Ens.Director") {
		// Current Production Name
		Do ##class(Ens.Director).GetProductionStatus(.pProduction,.pStatus)
		set $P(^||Data,"^",6)=$$Escape(pProduction)
		do:logging Log("Namespace","Current Production: "_pProduction)
	}
	
	// Organisation
	set $P(^||Data,"^",7)=$$Escape(^Ens.LookupTable("ompare.Namespace","Organisation"))
	// System
	set $P(^||Data,"^",8)=$$Escape(^Ens.LookupTable("ompare.Namespace","System"))
	// Environment
	set $P(^||Data,"^",9)=$$Escape(^Ens.LookupTable("ompare.Namespace","Environment"))
	
	// Role
	set $P(^||Data,"^",10)=$$Escape($G(^SYS("SourceControl","Misc","SU_Role")))
	// Tags
	set $P(^||Data,"^",11)=$$Escape($G(^SYS("SourceControl","Misc","SU_Tags")))
	// Depreciate Comment
	set $P(^||Data,"^",12)=$$Escape($G(^SYS("SourceControl","Misc","SU_Depreciate")))
	
	/***********************
	  End Indexer Specific code
	************************/
	Quit
Escape(data)
  Quit $TR(data,"\/^|")
}

}

