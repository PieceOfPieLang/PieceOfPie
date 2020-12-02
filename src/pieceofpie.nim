#[
  Copyright 2020 EagleOnGitHub, ProtoUncreative

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]#

import os
import strutils

let args = commandLineParams()
let fileToCompile = args[0]
let fileSplit = splitFile(fileToCompile)
let outputBinaryFile = fileSplit.name
var outputC = open(outputBinaryFile & ".c", fmWrite)
echo "Transpiling to C...."
outputC.writeLine(r"#include <stdio.h>")
outputC.writeLine(r"")
outputC.writeLine(r"int main() {")
for line in fileToCompile.lines:
    var a = cast[string](line).split(' ')
    var reala = a
    a.delete(0)
    var atostring = a.join(" ")
    if cmpIgnoreCase(atostring[0..4], "!num ") == 0:
      atostring.delete(0, 4)
    for i, c in reala:
        if cmpIgnoreCase(c, "print") == 0:
            outputC.write("\tprintf(")
            for i, c in a:
                if cmpIgnoreCase(c, "!num") == 0:
                  outputC.write("\"%d\", ")
            outputC.write(atostring)
            outputC.writeLine(");")
outputC.write("}")
outputC.close()
echo "Done!\n"
#[
  echo "Compiling..."
  let compileCmd = "gcc " & outputCName & " -o " & outputBinaryFile & ".exe"
  echo "Compile command: "
  echo compileCmd
  echo ""
  discard execShellCmd(compileCmd)
  echo "Done! You must manually remove the .c file."
  ^
  |
  |
  Compiling is not done yet, so this is commented
]#
