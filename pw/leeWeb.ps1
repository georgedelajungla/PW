  

$quTodo = @"
PREFIX :<http://localhost:8080/oat#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd:<http://www.w3.org/2001/XMLSchema#>
PREFIX owl:<http://www.w3.org/2002/07/owl#>
PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX OAT:<http://example.org/file1#>
SELECT ?s ?p ?o
 WHERE {?s ?p ?o .}
"@

function Get-triples {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$symbol,
        [Switch]$Raw
        )
    Begin {
        $url = "http://www.webservicex.net/stockquote.asmx?wsdl"
        $proxy = New-WebServiceProxy $url
    }
    Process {
        $result = $ proxy.GetQuote($symbol)
        if($Raw) { return $result }
        [xml]$result
    }
}

    
    

function Get-WebData {
    param([string]$Url, [Switch]$Raw)
    $wc = New-Object Net.WebClient
    $feed = $wc.DownloadString($Url)
    if($Raw) { return $feed }
    [xml] $feed
    }




$url1="http://localhost:8080/openrdf-sesame/oat/"+"?query="+$quTodo

$url2 = "http://localhost:8080/openrdf-sesame/protocol HTTP/1.1"
Invoke-RestMethod $url2