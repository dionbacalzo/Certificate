@echo off
setlocal EnableDelayedExpansion

rem sample argument config
rem SSL.bat "C:\Users\81015414\eclipse-workspace\Shop\SSL Setup" "certificate.pfx"
rem SSL.bat "C:\Program Files\Apache Software Foundation\Tomcat 9.0\conf"

set keyfile=%~2

if "%~2" == "" (  
  rem PKCS12
  set keyfile=localhost.pfx
  
  rem CSR
  rem set keyfile=localhost
  
  echo 2nd argument not found default filename will be !keyfile!
)

if not exist "%~1" (
	echo 1st argument not found or directory does not exist will default to current directory  
) else (
	set keydirectory=%~1
)

if not exist "%JAVA_HOME%" (
  echo JAVA_HOME is not set in path
  pause
  exit /B 0
) else (
	
	set completePath="!keydirectory!\!keyfile!"	
	if not exist "%keydirectory%" (
		set completePath=!!keyfile!!		
	) else (
		echo will create files at directory %keydirectory%
	)
	
	if exist "%completePath%" (
		echo %keyfile% file already exists at %keydirectory%, deleting this file
		del /f %completePath%		
	)
	
	
rem PKCS12
"%JAVA_HOME%\bin\keytool" -genkey -noprompt -alias shopserver ^
 -dname "CN=localhost,OU=Marketing, O=Shop\, ltd., L=Los Banos, ST=Laguna, C=PH" ^
 -ext SAN=dns:localhost,ip:127.0.0.1 ^
 -keystore !completePath! ^
 -storepass password -keypass password -storetype PKCS12 -keyalg RSA 

rem CSR
rem "%JAVA_HOME%\bin\keytool" -genkey -alias server -keyalg RSA -keysize 2048 -keystore "%keydirectory%\%keyfile%.jks" -dname "CN=localhost,OU=Marketing, O=Shop\, ltd., L=Los Banos, ST=Laguna, C=PH" -storepass password -keypass password
rem "%JAVA_HOME%\bin\keytool" -certreq -alias server -file "%keydirectory%\%keyfile%.csr" -keystore localhost.jks -storepass password
	 
	echo created SSL cert at !completePath!
	
	rem delete existing keystore
	rem "%JAVA_HOME%\bin\keytool" -delete -alias shopserver -keystore localhost -storepass password && (
	rem echo existing key deleted
	rem ) || (
	rem echo If the key is not found then don't worry this is intended
	rem )
	
	rem Import a SSL certificate into a Java Keystore via a PKCS12 file, will overwrite existing key with same server
	rem "%JAVA_HOME%\bin\keytool" -v -importkeystore -srckeystore "%keydirectory%\%keyfile%" -noprompt ^
	rem -srcstoretype PKCS12 -srcstorepass password ^
	rem -destkeystore localhost -deststorepass password -deststoretype JKS 
		
	pause
)
 
 
 


