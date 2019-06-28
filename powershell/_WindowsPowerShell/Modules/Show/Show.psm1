#
#	PowerShell - Show
#		|--> Writes a input variable(s) to output
#
Function Show() {
	Param(
	
		# [Parameter(Mandatory=$False)]
		# [ValidateLength(2,255)]
		# [String]$AndAndName,
	
		[Switch]$Enumerate
		
	)

	$VarsToShow = @{};

	# $VarsToShow["MyInvocation.MyCommand"] = ($MyInvocation.MyCommand);
	# $VarsToShow["PSScriptRoot"] = ($PSScriptRoot);
	# $VarsToShow["PsBoundParameters.Values"] = ($PsBoundParameters.Values);
	# $VarsToShow["args"] = ($args);

	$VarsToShow = $PsBoundParameters.Values;

	ForEach ($EachVarName in $VarsToShow.Keys) {
		$EachVarValue = $VarsToShow[$EachVarName];
		Write-Output "============================================================";
		Write-Output "`n`nVariable Name";
		Write-Output "`$$(${EachVarName})";
		Write-Output "`n`nVariable Value";
		$EachVarValue | Format-List;
		Write-Output "`n`nVariable Info";
		If ($PSBoundParameters.ContainsKey('Enumerate') -Eq $False) {
			Write-Output -NoEnumerate $EachVarValue | Get-Member;
		} Else {
			Write-Output $EachVarValue | Get-Member;
		}
		Write-Output "`n------------------------------------------------------------";
	}
	
	Return;
}
Export-ModuleMember -Function "Show";
# Install-Module -Name "Show"



#
#	Citation(s)
#
#		"Powershell: Everything you wanted to know about arrays"
#			|--> https://powershellexplained.com/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know/#write-output--noenumerate
#			|--> by Kevin Marquette
#
#