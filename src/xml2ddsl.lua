#!/usr/bin/env lua
--[[
  (c) 2005-2015 Copyright, Real-Time Innovations, All rights reserved.     
                                                                           
 Permission to modify and use for internal purposes granted.               
 This software is provided "as is", without warranty, express or implied.
--]]
--[[
-------------------------------------------------------------------------------
Purpose: Utility to read an XML file as DDSL, and print the equivalent IDL
Created: Rajive Joshi, 2015 Jun 26
-------------------------------------------------------------------------------
--]]

package.path = '?.lua;?/init.lua;' .. package.path

local xtypes = require('ddsl.xtypes')
local xml = require('ddsl.xtypes.xml')
local xutils = require('ddsl.xtypes.utils')

local function main(arg)
  if #arg == 0 then
    print('Usage: ' .. arg[0] .. [[' [-d] <xml-file> [ <xml-files> ...]
    
    where:
      -d            turn debugging ON
      <xml-file>    is an XML file
    
    Imports all the XML files into a single X-Types global namespace. 
    Cross-references between files are resolved. However, duplicates 
    definitions are not permitted within a global namespace. 
    
    If there could be duplicates (ie multiple global namespaces), those files 
    should be processed in separate command line invocations of this utility.
    ]])
    return
  end

  -- turn on tracing?
  if '-d' == arg[1] then 
    table.remove(arg, 1) -- pop the argument
    xml.log.verbosity(xml.log.DEBUG)
  end

  -- import XML files
  local ns = xml.filelist2xtypes(arg)

  -- print as IDL on stdout
  print(table.concat(xutils.to_idl_string_table(ns), '\n'))
  
  -- TODO: print the DDSL representation  
end

main(arg)
