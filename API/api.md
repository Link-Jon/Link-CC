# /API

### Description

* A list of functions, returned as a table.
* Should not add new functions to global table (_G)
* These should be something not allready in CC


### File List

* craftAPI.lua;     incomplete
* loadLibs.lua;     incomplete
* logic.lua;        funcitonal
* musicAPI.lua;     functional
* periPreset.lua;   unknown
* recipeHandler;    incomplete?
  * seems incorrect, returns the table but doesnt define functions locally
* uiAPI.lua / uiAPIv2; broken. AND incomplete.
* wireless.lua;     functional


### Exeptions

* loadLibs.lua  
    is (supposed to be) a list of require() to
    require the entire library

* Logic.lua     
    A decent bit of the error checking in logic.lua can now be done with    
    CC:T's module "cc.expect", but... im allready organizing,   
    and i dont *think* cc.expect can do **all** that my errchecks can.  
    Also, adds a few thing to globals for easier usage.

### Notes


* Logic does a few things it probably shouldnt, but allways will:
  * Adds ccprint, ccwrite, print, montest, table.append to _G.term for ease of access    
  * Replaces _G.print, _G.write, and _G.term.write for ease of access

    (How do i get rid of the weird spacing that gets added when i add ANY extra empty lines...)

  * ccprint and ccwrite are backups of print and write, incase something breaks   
    when it uses the mtext version (to print on terminal and a monitor)
  * table.append is table.insert, i just keep trying to use table.append.  
    Constantly.


like... look at this
* Logic does a few things it probably shouldnt, but allways will:
  * Adds ccprint, ccwrite, print, montest, table.append to _G.term for ease of access    
  * Replaces _G.print, _G.write, and _G.term.write for ease of access
  * ccprint and ccwrite are backups of print and write, incase something breaks   
    when it uses the mtext version (to print on terminal and a monitor)
  * table.append is table.insert, i just keep trying to use table.append.  
    Constantly.