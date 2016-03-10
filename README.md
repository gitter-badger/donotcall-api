
# Do Not Call API

Basic API endopoint that will allow actor to test for existence of 10-digit phone numbers against a list

## Design Roadmap:
* Audit log for every list query (DONE)
* Store metadata with list query:  user ip address, files searched, optional client/user/actor identifier, etc. 
* Protected Admin area to upload source text DNC files 
* Support a simple HTML interface to check a list of numbers (partially complete)
* Disclaimer/terms of use on HTML interface highlighting that only certain state files make up the DNC list 
* Support JSON Api endpoint to query a list of numbers and return JSON response 

