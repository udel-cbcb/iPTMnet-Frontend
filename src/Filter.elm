module Filter exposing (proteoforms,ptmDependentPPI)
import Model exposing (..)
import String
import List

proteoforms: String -> (Proteoform Enzyme Source) -> Bool
proteoforms searchTerm proteoform = 
    if String.contains (String.toLower searchTerm) (String.toLower proteoform.pro_id) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform.label) then
        True
    else if List.length (List.filter (matchString searchTerm) proteoform.sites) > 0 then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform.ptm_enzyme.pro_id) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform.ptm_enzyme.label) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform.source.name) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform.source.label) then
        True
    else if List.length (List.filter (matchString searchTerm) proteoform.sites) > 0 then
        True
    else if String.contains (String.toLower searchTerm) (String.join "," proteoform.pmids) then
        True
    else
        False

ptmDependentPPI: String -> (PTMDependentPPI Entity Source) -> Bool
ptmDependentPPI searchTerm ptm_dependent_ppi = 
    if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.ptm_type) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.substrate.uniprot_id) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.substrate.name) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.site) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.interactant.uniprot_id) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.interactant.name) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.association_type) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.source.name) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.source.label) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower ptm_dependent_ppi.pmid) then
        True
    else
        False


matchString: String -> String -> Bool
matchString searchTerm refString =
    if String.contains (String.toLower searchTerm) (String.toLower refString) then
        True
    else 
        False


