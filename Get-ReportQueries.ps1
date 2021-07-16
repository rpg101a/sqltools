<#
Extract the queries from all reports in the local Reporting Services instance
#>

# Connect to the WSDL interface of the local Report Server
$url = 'http://odsprod.clsnet.intranet/ReportServer/ReportService2010.asmx?WSDL'
$ssrs = New-WebServiceProxy -uri $url -UseDefaultCredential -Namespace "ReportingWebService"

# Query the SQL Server ReportServer database for the path of every report
$q = @'
SELECT Path
FROM dbo.Catalog
WHERE Type = 2
'@
$rlist = Invoke-Sqlcmd2 -ServerInstance '.' -Database 'ReportServer' -Query $q

# Initialize the 'last path' and result set variables
$rlast = ''
$rqry = @()

# Iterate through the reports
foreach ($rrow in $rlist) {
	
	# Get the Path property from the returned DataRow
	$rpath = $rrow.Path
	
	# Use Split-Path to get the parent path for each report, and the leaf level with the report name
	# The -replace string is required because Split-Path turns '/' to '\', and it needs to be '/'
	$rprnt = (Split-Path -Path $rpath -Parent) -replace '\\','/'
	$rleaf = (Split-Path -Path $rpath -Leaf) -replace '\\','/'

	# If this is a new parent path, get the children of that parent path into $reports
	if ($rprnt -ne $rlast) {
		$reports = $ssrs.ListChildren($rprnt, $false)
		$rlast = $rprnt
		}

	# Extract the current report, and get the report definition
	$r = $reports | where-object {$_.Name -eq $rleaf}
	$def = $ssrs.GetItemDefinition($r.path)
	
	# The report definition is a byte array and it needs to be turned into a string
	$rdlstr = [System.Text.Encoding]::ASCII.GetString($def)
	
	# The resultant string sometimes has extra characters before the start of the XML, so strip those off
	$idx = $rdlstr.IndexOf('<')
	[xml]$rdl = $rdlstr.Substring($idx,($rdlstr.Length - $idx))

	# The queries are in the list of datasets in each report, so navigate there
	$dsl = $rdl.Report.DataSets.DataSet
	
	# Iterate through the DataSets and add the Path, Name, DataSet Name and Query Text to the result set
	foreach ( $ds in $dsl ) {
		$qry = new-object system.object
		$qry | Add-Member -type NoteProperty -name ReportPath -value $rpath
		$qry | Add-Member -type NoteProperty -name ReportName -value $rleaf
		$qry | Add-Member -type NoteProperty -name DatasetName -value $ds.Name
		$qry | Add-Member -type NoteProperty -name QueryText -value $ds.Query.CommandText
		$rqry += $qry
		}
	}
	
# Pipe the result set to the Export-Excel cmdlet to create the spreadsheet
$rqry | Export-Excel c:\Work\RSQueries.xlsx
