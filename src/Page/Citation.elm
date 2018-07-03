module Page.Citation exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Views.Footer
import Colors
import Views.Navbar
import Model exposing (..)

view: Model -> Html Msg
view model =
            div [id "page",css [
            Css.property "min-height" "100%",
            displayFlex,
            flexDirection column,
            alignItems center,
            flex (num 1),
            backgroundColor Colors.pageBackground
            ]
        ] [

        div [id "header", css [
            displayFlex,
            flexDirection column,
            alignSelf stretch
            ]] [
                Views.Navbar.view model.navbar
            ],
        
        div [id "body", css [
            displayFlex,
            flexDirection column,
            alignItems center,
            flexGrow (num 1),
            paddingTop (px 20),
            overflow auto            
            ]] [   
                div [
                    css [
                        marginLeft (px 30),
                        marginRight (px 30)
                    ]
                ][
                    div [
                        css [
                            fontSize (Css.em 1.5)
                        ]
                    ][
                        text "How to cite iPTMnet and its sources"
                    ],

                    div [
                        css [
                            marginTop (px 20),
                            fontSize (Css.em 0.88)
                        ]
                    ][
                        text "If you use iPTMnet please include this citation:"
                    ],

                    div [
                        css [
                            marginTop (px 10),
                            fontSize (Css.em 0.88)
                        ]
                    ][
                        text "Ross KE, Huang H, Ren J, Arighi CN, Li G, Tudor CO, Lv M, Lee JY, Chen SC, Vijay-Shanker K, Wu CH iPTMnet: Integrative Bioinformatics for Studying PTM Networks. Methods Mol Biol. 2017;1558:333-353. doi: 10.1007/978-1-4939-6783-4_16. 28150246"
                    ],

                    Html.Styled.table [
                        css [
                            marginTop (px 20),
                            borderWidth (px 1),
                            borderStyle solid,
                            borderColor (rgb 225 225 232),
                            borderCollapse collapse,
                            alignSelf stretch
                        ]
                    ][
                        -- header
                        tr[css tableItemStyle][
                            th[css tableItemStyle][
                                text "#"
                            ],
                            th[css tableItemStyle][
                                text "Name"
                            ],
                            th[css tableItemStyle][
                                text "Publication"
                            ],
                            th[css tableItemStyle][
                                text "Pubmed"
                            ]
                        ],

                        -- HPRD
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "1"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "HPRD"]
                            ],
                            td[css tableItemStyle][
                                text "Prasad, T. S. K. et al. (2009) Human Protein Reference Database - 2009 Update. Nucleic Acids Research. 37, D767-72. "
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=18988627"][text "18988627"]
                            ]
                        ],

                        -- phospho.ELM
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "2"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "phospho.ELM"]
                            ],
                            td[css tableItemStyle][
                                text "Dinkel H, Chica C, Via A, Gould CM, Jensen LJ, Gibson TJ, Diella F. Nucleic Acids Res. 2011 Jan;39(Database issue) 261-7. doi: 10.1093/nar/gkq1104."
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=21062810"][text "21062810"]
                            ]
                        ],

                        -- p3db
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "3"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "p3DB"]
                            ],
                            td[css tableItemStyle][
                                text "Yao Q, Ge H, Wu S, Zhang N, Chen W, Xu C, Gao J, Thelen JJ, Xu D. (2013) P3DB 3.0: From plant phosphorylation sites to protein networks. Nucleic Acids Res 2013. 42(Database issue):D1206-D1213"
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=24243849"][text "24243849"]
                            ]
                        ],

                        -- phosphogrid
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "4"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "PhosphoGrid"]
                            ],
                            td[css tableItemStyle][
                                text "Stark C, Breitkreutz BJ, Reguly T, Boucher L, Breitkreutz A, Tyers M. Biogrid: A General Repository for Interaction Datasets. Nucleic Acids Res. 2006; 34:D535-9. "
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=16381927"][text "16381927"]
                            ]
                        ],

                        -- PomBase
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "5"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "PomBase"]
                            ],
                            td[css tableItemStyle][
                                text "Wood V, Harris MA, McDowall MD, Rutherford K, Vaughan BW, Staines DM, Aslett M, Lock A, Bähler J, Kersey PJ, Oliver SG. PomBase: a comprehensive online resource for fission yeast. Nucleic Acids Res. 2012;40(Database issue):D695-9. Epub 2011"
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=22039153"][text "22039153"]
                            ]
                        ],

                        -- neXtProt
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "6"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "neXtProt"]
                            ],
                            td[css tableItemStyle][
                                text "Gaudet P, Michel PA, Zahn-Zabal M, Britan A, Cusin I, Domagalski M, Duek PD, Gateau A, Gleizes A, Hinard V, Rech de Laval V, Lin JJ, Nikitin F, Schaeffer M, Teixeira D, Lane L, Bairoch A. The neXtProt knowledgebase on human proteins: 2017 update. Nucleic Acids Res. 2017; 45(D1):D177-D182 doi:10.1093/nar/gkw1062"
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=27899619"][text "27899619"]
                            ]
                        ],

                        -- Signor
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "7"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "neXtProt"]
                            ],
                            td[css tableItemStyle][
                                text " Perfetto L, Briganti L, Calderone A, Cerquone Perpetuini A, Iannuccelli M, Langone F, Licata L, Marinkovic M, Mattioni A, Pavlidou T, Peluso D, Petrilli LL, Pirrò S, Posca D, Santonico E, Silvestri A, Spada F, Castagnoli L, Cesareni G. SIGNOR: a database of causal relationships between biological entities. Nucleic Acids Res. 2016;44(D1):D548-54. doi: 10.1093/nar/gkv1048 "
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=26467481"][text "26467481"]
                            ]
                        ],

                        -- dbSNO
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "8"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "dbSNO"]
                            ],
                            td[css tableItemStyle][
                                text "Chen YJ, Lu CT, Su MG, Huang KY, Ching WC, Yang HH, Liao YC, Chen YJ, Lee TY. dbSNO 2.0: a resource for exploring structural environment, functional and disease association and regulatory network of protein S-nitrosylation. Nucleic Acids Res. 2015;43(Database issue):D503-11. doi: 10.1093/nar/gku1176. "
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=25399423"][text "25399423"]
                            ]
                        ],

                        -- PhosphoSitePlus
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "9"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "PhosphoSitePlus"]
                            ],
                            td[css tableItemStyle][
                                text "Hornbeck PV, Zhang B, Murray B, Kornhauser JM, Latham V, Skrzypek E. PhosphoSitePlus, 2014: mutations, PTMs and recalibrations. Nucleic Acids Res. 2015;43(Database issue):D512-20. doi: 10.1093/nar/gku1267."
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=25514926"][text "25514926"]
                            ]
                        ],

                        -- PhosPhAt
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "10"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "PhosPhAt"]
                            ],
                            td[css tableItemStyle][
                                text "Durek P, Schmidt R, Heazlewood JL, Jones A, Maclean D, Nagel A, Kersten B, Schulze WX. PhosPhAt: the Arabidopsis thaliana phosphorylation site database. An update. Nucleic Acids Res. 38: D828-D834 (2010)"
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=17984086"][text "17984086"]
                            ]
                        ],

                        --  UniProt
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "11"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "UniProt"]
                            ],
                            td[css tableItemStyle][
                                text "The UniProt Consortium. UniProt: the universal protein knowledgebase Nucleic Acids Res. 45: D158-D169 (2017)"
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=27899622"][text "27899622"]
                            ]
                        ],

                        --  PRO
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "12"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "PRO"]
                            ],
                            td[css tableItemStyle][
                                text " Natale DA, Arighi CN, Blake JA, Bona J, Chen C, Chen SC, Christie KR, Cowart J, D'Eustachio P, Diehl AD, Drabkin HJ, Duncan WD, Huang H, Ren J, Ross K,Ruttenberg A, Shamovsky V, Smith B, Wang Q, Zhang J, El-Sayed A, Wu CH. Protein Ontology (PRO): enhancing and scaling up the representation of protein entities. Nucleic Acids Res.2017;45(D1):D339-D346. doi: 10.1093/nar/gkw1075."
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=27899649"][text "27899649"]
                            ]
                        ],

                        -- RLIMS-P
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "13"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "RLIMS-P"]
                            ],
                            td[css tableItemStyle][
                                text "Torii M, Li G, Li Z, Oughtred R, Diella F, Celen I, Arighi CN, Huang H, Vijay-Shanker K, Wu CH. RLIMS-P: an online text-mining tool for literature-based extraction of protein phosphorylation information. Database (Oxford).2014. pii: bau081. doi: 10.1093/database/bau081."
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=27899649"][text "27899649"]
                            ]
                        ],                        

                        -- eFIP
                        tr[css tableItemStyle][
                            td[css (tableItemStyle ++ [textAlign center])][
                                text "14"
                            ],
                            td[css tableItemStyle][
                                a [href "_"][text "eFIP"]
                            ],
                            td[css tableItemStyle][
                                text "Wang Q, Ross KE, Huang H, Ren J, Li G, Vijay-Shanker K, Wu CH, Arighi CN. Analysis of Protein Phosphorylation and Its Functional Impact on Protein-Protein Interactions via Text Mining of the Scientific Literature. Methods Mol Biol. 2017;1558:213-232. doi: 10.1007/978-1-4939-6783-4_10. "
                            ],
                            td[css tableItemStyle][
                                a [href "https://www.ncbi.nlm.nih.gov/pubmed/?term=18988627"][text "18988627"]
                            ]
                        ]
                        
                         

                    ]

                ]
            ],

            div[
                id "filler",css [alignSelf stretch ]]
            [],

            Views.Footer.view 

    ]


tableItemStyle : (List Style) 
tableItemStyle = 
    [
        padding (px 8),
        fontSize (Css.em 0.90),
        textAlign left,
        borderWidth (px 1),
        borderStyle solid,
        borderColor (rgb 225 225 232)   
    ]