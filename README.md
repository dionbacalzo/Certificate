Create Self-signed certificates for local testing

### Pre-requisites

For Windows:
	Java must be installed and JAVA_HOME must be set in path
	Recommended to install Java 8+
	
For Unix:
	Openssl must be available(installed by default)
	tested on OpenSSL 1.1.1a 

### Create a PKCS12 certificate file

Run either SSL.bat or SSL.sh

the 1st argument is used to set the path to create the file

the 2nd argument is used to set the filename of the certificate

### Install self-signed certificates for local testing only

For Windows:
 - Run certmgr.msc
 - At 'Trusted Root Certification Authorities > Certificates' 
 - Right-click > All-tasks > import > select the .pfx/.p12 file you created
 - input the default password 'password' when prompted

### Tomcat server.xml configuration


```
<!--
%keydirectory% is the directory where the certificate is located
%keyfile% is the filename of the certificate
 -->
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
               maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeystoreFile="%keydirectory%\%keyfile%" 
        	certificateKeystorePassword="password" 
        	certificateKeystoreType="PKCS12" 
        	keyAlias="shopserver"/>
    </SSLHostConfig>
</Connector>
```

You can now visit your application at https://localhost:8443/

Comment out the HTTP/1.1 Connector if you don't need the unsecured access 

```
<!-- <Connector connectionTimeout="20000" port="8080" protocol="HTTP/1.1" redirectPort="8443"/> -->
```