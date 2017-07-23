﻿###################################################################################################
##  REF: https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-automate-powershell
###################################################################################################

Import-Module "$ENV:ProgramFiles\Microsoft SDKs\Service Fabric\Tools\PSModule\ServiceFabricSDK\ServiceFabricSDK.psm1"

$path = 'C:\temp\pkg\Debug'  #Set this to the path for your solution output directory
$imageStorePath = 'Voting'
$appTypeName = 'VotingType'
$appVersion = '1.0.0'


# Connect to the Service Fabric cluster
Connect-ServiceFabricCluster localhost:19000

# Upload package to package store
Copy-ServiceFabricApplicationPackage -ApplicationPackagePath $path -ApplicationPackagePathInImageStore $imageStorePath -ImageStoreConnectionString (Get-ImageStoreConnectionStringFromClusterManifest(Get-ServiceFabricClusterManifest)) -TimeoutSec 1800

# Register the application package
Register-ServiceFabricApplicationType $imageStorePath

# Get all application types registered in the cluster
Get-ServiceFabricApplicationType

# Create the application 
New-ServiceFabricApplication "fabric:/$imageStorePath" $appTypeName $appVersion

# Get all application instances created in the cluster
Get-ServiceFabricApplication

# Get all service instances for each application
Get-ServiceFabricApplication | Get-ServiceFabricService
