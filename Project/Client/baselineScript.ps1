 
#Baseline Sript 
#Variables 
$vUserName = "" 
$vPassword = "" 
$vTentant = "" 
$subscription = "" 
$randomName = -join ((48..57) + (97..122) | Get-Random -Count 10 | % {[char]$_}) #Random string to help us to create individual names in the cloud 
$webAppName = "exampleApp"+$randomName #The Name of the WebApp  
$webApiName = "exampleApi"+$randomName  #The Name of the WebApi 
$resourceGroupName = "exampleGroup" +$randomName  
$appServicePlanName = "exampleAppServicePlan" +$randomName  
$region = "eastus" 
$tier = "B1" 
#Connect to azure 
#SecurePassword converting the password to a secure string 
$passwd = ConvertTo-SecureString $vPassword -AsPlainText -Force 
az login -u $vUserName -p $vPassword --tenant $vTentant 
#Set Subscription where we’ll be work 
az account set --subscription $subscription 
 
#Create resources 
 
#Create Resource Group 
az group create --location $region --name $resourceGroupName  
#Create App Service Plan
az appservice plan create --name $appServicePlanName --resource-group $resourceGroupName --is-linux --sku $tier 
#Create Web App  
az webapp create --name $webAppName --plan $appServicePlanName --resource-group $resourceGroupName --runtime "DOTNETCORE|2.2" 
#Create Web Api 
az webapp create --name $webApiName --plan $appServicePlanName --resource-group $resourceGroupName --runtime "DOTNETCORE|2.2" 