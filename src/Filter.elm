module Filter exposing (proteoforms,ptmDependentPPI,proteoformPPI,substrate)

import Model.Proteoform exposing (..)
import Model.PTMDependentPPI exposing (..)
import Model.ProteoformPPI exposing (..)
import Model.Substrate exposing (..)
import Model.SubstrateEnzyme exposing (..)
import Model.Source exposing (..)

import String
import List

proteoforms: String -> Proteoform -> Bool
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

ptmDependentPPI: String -> PTMDependentPPI -> Bool
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

proteoformPPI: String -> ProteoformPPI -> Bool
proteoformPPI searchTerm proteoform_ppi = 
    if String.contains (String.toLower searchTerm) (String.toLower proteoform_ppi.protein_1.pro_id) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform_ppi.protein_1.label) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform_ppi.protein_2.pro_id) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform_ppi.protein_2.label) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform_ppi.relation) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform_ppi.source.name) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower proteoform_ppi.source.label) then
        True
    else if String.contains (String.toLower searchTerm) (String.join "," proteoform_ppi.pmids) then
        True
    else
        False

substrate: String -> Substrate -> Bool
substrate searchTerm substrate_item = 
    if String.contains (String.toLower searchTerm) (String.toLower substrate_item.residue) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower substrate_item.site) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower substrate_item.ptm_type) then
        True
    else if List.length (List.filter (enzyme searchTerm) substrate_item.enzymes) > 0 then
        True
    else if List.length (List.filter (source searchTerm) substrate_item.sources) > 0 then
        True
    else if String.contains (String.toLower searchTerm) (String.join "," substrate_item.pmids) then
        True  
    else 
        False

enzyme: String -> SubstrateEnzyme -> Bool
enzyme searchTerm enzyme =
    if String.contains (String.toLower searchTerm) (String.toLower enzyme.enz_type) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower enzyme.name) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower enzyme.id) then
        True   
    else
        False

source: String -> Source -> Bool
source searchTerm source = 
    if String.contains (String.toLower searchTerm) (String.toLower source.name) then
        True
    else if String.contains (String.toLower searchTerm) (String.toLower source.label) then
        True
    else
        False


matchString: String -> String -> Bool
matchString searchTerm refString =
    if String.contains (String.toLower searchTerm) (String.toLower refString) then
        True
    else 
        False


