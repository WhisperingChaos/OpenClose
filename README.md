# OpenClose
Implements mechanism to implement Open (for exextension) Closed (to modification) semantics for Bash scripts.

Leverages function override behavior where the last bash function definition with the same name as a prior one will replace the prior one's definition.  Encourages a module composition mechanism where a base script's functions can be replaced by a derived one's set.
 
Encourages other installations using base scripts to encode their own local customizations, in derived ones, without concern that these customizations will be overwritten by a new release of the base project code
