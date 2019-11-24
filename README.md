# Cat DSL

DSL that prints out the contents of a file (like cat).
Example programs located in `examples` directory.  
The source code demonstrates how to convert from an embedded DSL to an external DSL.  

### Modules
#### Embedded DSL
* **Quote.hs** contains the original quasiquoter module that expects a `Q Exp` for the embedded DSL
* **CodeGen.hs** generates a `Q Exp`
* **QuoteDec.hs** has a quasiquoter for the embedded DSL that expects a `Q Dec`
* **CodeGenDec.hs** generates a `Q Dec`

#### External DSL
* **QuoteExternal.hs** is the version of Quote.hs for the external DSL. It expects a `Q Exp` and generates a declaration
* QuoteExternalDec is the version of QuoteDec.hs for the external DSL. It expects a `Q Dec` and generates a declaration

#### Main
* Main.hs contains 4 versions of the quasiquoted program, one for each of the quasiquoters. Uncomment a version to test that version


### Instructions to run
#### Embedded DSL
For the normal embedded DSL, uncomment either of the first 2 versions in Main.hs.  
Compile with `stack build && stack exec cat-dsl`, or `stack repl` and call `main` in the interpreter, as usual.

#### External DSL
Uncomment either of the third and fourth versions in Main.hs.  
From the root directory, compile with `./cat.sh <filename>`  
Run with `./run.sh` or `stack exec cat-dsl`  

For example:
```
./cat.sh examples/test.txt
./run.sh
```
