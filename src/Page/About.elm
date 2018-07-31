module Page.About exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Views.Footer
import Colors
import Views.Navbar
import Model.AppModel exposing (..)

view : Model -> Html Msg
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
                        displayFlex,
                        flexDirection column,
                        paddingLeft (px 100),
                        paddingRight (px 100)
                    ]
                ] [
                    div [
                        id "div_info",
                        css [
                            fontSize (Css.em 0.95)
                        ]
                    ][
                        div [
                            css [
                                fontWeight bold,
                                fontSize (Css.em 2)
                            ]
                        ][
                            text "About"
                        ],
                        div [
                            css [
                                marginTop (px 10)
                            ]
                        ][
                            span [
                                css [
                                    fontWeight bold,
                                    display inline
                                ]
                            ][
                                text "iPTMnet"
                            ],
                            p[
                                css[
                                    display inline
                                ]
                            ][
                                text """ aims to provide answers for questions such as: (i) What PTMs of a protein of interest are known? (ii) What 
                                specific enzymes (kinases, methylases, etc.) are known to modify a given protein? (iii) What substrates are known for a given PTM enzyme? (iv)
                                What interacting partners are known for each PTM form of a given protein? (v) What protein modifications and enzymes are known in a given signaling pathway? In addition, iPTMnet can be used to generate training sets for PTM site prediction methods."""
                            ]
                        ],

                        p[][
                            text " The specific aims of iPTMnet project are to:"
                        ],

                        ol [][
                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                text "Develop an integrative bioinformatics framework for PTM discovery, connecting enzyme-substrate relationships, major PTMs that may work in concert, PTM forms to biological contexts and across taxons; "
                            ],
                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                text "Develop a bioinformatics resource, iPTMnet, for studying PTM networks in plants with scientific case studies;"
                            ],
                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                text "Provide broad dissemination with interoperable resource sharing, training, outreach and integrated education."
                            ]
                        ],

                        p [][
                            text """
                            The iPTMnet will provide data and tools essential for the understanding of plant PTM networks.
                            A PTM enzyme-substrate database will be developed, combining text mining and data mining results with evidence attribution to capture relevant PTM information and their functional impact, such as interacting proteins, function, pathway, subcellular location, gene expression,
                             protein expression and growth/developmental phenotype. The web portal will allow biologists to search, browse, review results interactively, visualize PTM in protein networks and pathway maps, conduct use cases (such as finding target substrates of given enzymes and vice versa), and capture expert knowledge via community annotation. Scientific case studies will be developed to demonstrate the integrative bioinformatics approach for hypothesis generation, with lab validation of the in silico analysis.
                            """
                        ]
                    ],

                    div [
                        id "div_publications",
                        css [
                            marginTop (px 20)
                        ]
                    ][
                        div [
                            css [
                                fontWeight bold,
                                fontSize (Css.em 2)
                            ]
                        ][
                            text "Publications"
                        ],
                        div [
                            css [
                                marginTop (px 10)
                            ]
                        ][
                            ol[
                                css [
                                    fontSize (Css.em 0.85)
                                ]
                            ][
                                li [][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://bioinformatics.oxfordjournals.org/content/21/suppl_1/i319.abstract",
                                            css[
                                                display inline
                                            ]
                                        ][
                                            text "Beyond the clause: extraction of phosphorylation information from medline abstracts,"
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Narayanaswamy, M., Ravikumar, K. E., Vijay-Shanker, K. (2005) Bioinformatics 21 (suppl_1) : i319-i327"
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://bioinformatics.oxfordjournals.org/content/22/13/1668.abstract",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "An online literature mining tool for protein phosphorylation,"
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Yuan, X., Hu, Z. Z., Wu, H. T., Torii, M., Narayanaswamy, M., Ravikumar, K. E., Vijay-Shanker, K., Wu, C. H. (2006) Bioinformatics 22 (13) : 1668-1669"
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://www.ncbi.nlm.nih.gov/pubmed/21082428",
                                            css[
                                                display inline
                                            ]
                                        ][
                                            text "eFIP: a tool for mining functional impact of phosphorylation from literature,"
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Arighi, C. N., Siu, A. Y., Tudor, C. O., Nchoutmboube, J. A., Wu, C. H., Shanker, V. K. (2011) Methods in Molecular Biology, 694, 63-75"
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            css [
                                                display inline
                                            ],
                                            href "http://database.oxfordjournals.org/content/2012/bas044.long"
                                        ][
                                            text "The eFIP system for text mining of protein interaction networks of phosphorylated proteins."
                                        ],
                                        div[
                                            css [
                                                display inline,
                                                marginLeft (px 5)
                                            ]
                                        ][
                                            text "Tudor CO, Arighi CN, Wang Q, Wu CH, Vijay-Shanker K. (2012) Database (Oxford) 2012:bas044"
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://journal.frontiersin.org/Journal/10.3389/fgene.2013.00062/full",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "Use of the protein ontology for multi-faceted analysis of biological processes: a case study of the spindle checkpoint."
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Ross KE, Arighi CN, Ren J, Natale DA, Huang H, Wu CH. Front Genet. 2013 Apr 26;4:62."
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://dl.acm.org/citation.cfm?id=2506619",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "Text Mining of Protein Phosphorylation Information Using a Generalizable Rule-Based Approach."
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Torii M, Arighi CN, Wang Q, Wu CH, Vijay-Shanker K. Presented at the ACMBCB’13 (International Conference on Bioinformatics, Computational Biology and Biomedical Informatics), September 22-25, 2013."
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://www.biocreative.org/media/store/files/2013/bc4_v1_2.pdf",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "Enhancing the Interoperability of iSimp by using the BioC Format."
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Peng Y, Tudor CO, Torii M, Wu CH, Vijay-Shanker K. Presented at the BioCreative IV Workshop, Bethesda, MD, October 7-9, 2013."
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://www.biocreative.org/media/store/files/2013/bc4_v1_34.pdf",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "RLIMS-P: Literature-based curation of protein phosphorylation information."
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Torii M, Li G, Li Z, Çelen I, Diella F, Oughtred R, Arighi C, Huang H, Vijay-Shanker K, Wu CH. Presented at the BioCreative IV Workshop, Bethesda, MD, October 7-9, 2013."
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        div[
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "Mining the Impact of Phosphorylation on PPI in Full Length Scientific Articles. Tudor CO, Arighi CN, Wu CH, Vijay-Shanker K. Presented as a poster at the BioCreative IV Workshop, Bethesda, MD, October 7-9, 2013."
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://www.ncbi.nlm.nih.gov/pubmed/25122463",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "RLIMS-P: an online text-mining tool for literature-base extraction of protein phosphorylation information. "
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Torii M, Li G, Li Z, Oughtred R, Diella F, Celen I, Arighi CN, Huang H, Vijay-Shanker K, Wu CH. Database (Oxford). 2014: bau081."
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://www.ncbi.nlm.nih.gov/pubmed/23749465",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "Construction of protein phosphorylation networks by data mining, text mining and ontology integration: analysis of the spindle checkpoint."
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Ross KE, Arighi CN, Ren J, Huang H, Wu CH. Database (Oxford). 2013:bat038."
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://www.ncbi.nlm.nih.gov/pubmed/25833953",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "Construction of phosphorylation interaction networks by text mining of full-length articles using the eFIP system."
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Tudor CO, Ross KE, Li G, Vijay-Shanker K, Wu CH, Arighi CN. Database (Oxford). 2015: bav020."
                                        ]
                                    ]
                                ],

                                li [
                                    css[
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        a[
                                            href "http://www.ncbi.nlm.nih.gov/pubmed/26357075",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "RLIMS-P 2.0: A Generalizable Rule-Based Information Extraction System for Literature Mining of Protein Phosphorylation Information."
                                        ],
                                        div[
                                            css [
                                                marginLeft (px 5),
                                                display inline
                                            ]
                                        ][
                                            text "Torii M, Arighi CN, Gang Li, Qinghua Wang, Wu CH, Vijay-Shanker K. IEEE/ACM Trans Comput Biol Bioinform. 2015 12(1):17-29."
                                        ]
                                    ]
                                ]

                            ]
                        ]
                    ],

                    div [
                        id "div_resources",
                        css [
                            fontSize (Css.em 0.95)
                        ]
                    ][
                        div [
                            css [
                                fontWeight bold,
                                fontSize (Css.em 2)
                            ]
                        ][
                            text "Resources"
                        ],

                        ol [][
                            li [][
                                div [
                                    css [
                                        marginTop (px 10),
                                        fontSize (Css.em 1.2)
                                    ]
                                ][
                                    text "Text Mining Tools"
                                ],
                                div [
                                    css [
                                        marginLeft (px 10)
                                    ]
                                ][
                                    img [
                                        src "images/tm.png",
                                        css [
                                            margin (px 5)
                                        ]
                                    ][],
                                    ul [
                                        css [
                                            margin (px 5)
                                        ]
                                    ][
                                        li [][
                                            div [
                                                css [
                                                    display inline
                                                ]
                                            ][
                                                a[
                                                    href "http://biotm.cis.udel.edu/eGIFT",
                                                    css [
                                                        display inline
                                                    ]
                                                ][
                                                    text "eGIFT"
                                                ],
                                                div[
                                                    css [
                                                        marginLeft (px 5),
                                                        display inline
                                                    ]
                                                ][
                                                    text "- Identifies terms and documents that are relevant to a gene and its products "
                                                ]
                                            ]
                                        ],

                                        li [
                                            css[
                                                marginTop (px 5)
                                            ]
                                        ][
                                            div [
                                                css [
                                                    display inline
                                                ]
                                            ][
                                                a[
                                                    href "http://pir.georgetown.edu/pirwww/iprolink/rlimsp.shtml",
                                                    css [
                                                        display inline
                                                    ]
                                                ][
                                                    text "RLIMS-P"
                                                ],
                                                div[
                                                    css [
                                                        marginLeft (px 5),
                                                        display inline
                                                    ]
                                                ][
                                                    text "- A rule-based text-mining program specifically designed to extract protein phosphorylation."
                                                ]
                                            ]
                                        ],

                                        li [
                                            css[
                                                marginTop (px 5)
                                            ]
                                        ][
                                            div [
                                                css [
                                                    display inline
                                                ]
                                            ][
                                                a[
                                                    href "http://pir.georgetown.edu/pirwww/iprolink/eFIP.shtml",
                                                    css [
                                                        display inline
                                                    ]
                                                ][
                                                    text "eFIP"
                                                ],
                                                div[
                                                    css [
                                                        marginLeft (px 5),
                                                        display inline
                                                    ]
                                                ][
                                                    text "- presents ranked abstracts mentioning impact of protein phosphorylation"
                                                ]
                                            ]
                                        ]
                                    ]
                                ]
                            ],
                            li [
                                css [
                                    marginTop (px 15)
                                ]
                            ][
                                div [
                                    css [
                                        fontSize (Css.em 1.2)
                                    ]
                                ][
                                    text "Protein Ontology (PRO)"
                                ],

                                div [
                                    css [
                                        marginTop (px 5)
                                    ]
                                ][
                                    text """
                                    PRO provides an ontological representation of protein-related entities by explicitly defining them and showing the relationships between them.
                                    Each PRO term represents a distinct class of entities (including specific modified forms, orthologous isoforms, and protein complexes).
                                    """
                                ],

                                div [
                                    css[
                                        displayFlex,
                                        flexDirection row,
                                        marginTop (px 10),
                                        alignItems center
                                    ]
                                ][
                                    a [
                                        href "http://pir.georgetown.edu/cgi-bin/pro/entry_pro?id=PR:000028483",
                                        Html.Styled.Attributes.target "_"
                                    ][
                                        img [
                                            src "images/entry.png"
                                        ][]
                                    ],

                                    a [
                                        href "http://pir.georgetown.edu/~np6/PRO_Cytoscape/12_16_2011/help_page/help.html",
                                        Html.Styled.Attributes.target "_",
                                        css [
                                            marginLeft (px 15)
                                        ]
                                    ][
                                        img [
                                            src "images/network.png"
                                        ][]
                                    ],

                                    a [
                                        href "http://pir.georgetown.edu/cgi-bin/pro/browser_pro?ids=P000027962,P000027963,P000027965,P000027967,P000027969,P000027971,P000027973,P000027975,P000027977,P000028335,P000028337,P000028340,P000028342,P000028345,P000028347,P000028349,P000028352,P000028355,P000028357,P000028359,P000028361,P000028456,P000028458,P000028460,P000028461,P000028463,P000028465,P000028467,P000028469,P000028471,P000028473,P000028476,P000028478,P000028481,P000028483,P000028486,P000028488,P000028489,P000028491,P000028493,P000028494,P000028495,P000028496,P000028497,P000028498,P000028499,P000028500,P000028503,P000028505,P000028508",
                                        Html.Styled.Attributes.target "_",
                                        css [
                                            marginLeft (px 15)
                                        ]
                                    ][
                                        img [
                                            src "images/hierach.png"
                                        ][]
                                    ]
                        
                                ]

                            ],
                            li [
                                css [
                                    marginTop (px 15)
                                ]
                            ][
                                div [
                                    css [
                                        fontSize (Css.em 1.2)
                                    ]
                                ][
                                    text "Relevant PTM Resources"
                                ],

                                ul [][
                            li [][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    a [
                                        href "http://www.phosphosite.org/",
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "PhosphoSitePlus"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - A comprehensive PTM resource covering phosphorylation, acetylation, methylation, ubiquitination and O-glycosylation data manually curated from literature and 
                                        integrated from other data sources, primarily on human and mouse 
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    a [
                                        href "http://www.phosida.de/",
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "PHOSIDA"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - Providing phosphorylation sites information for model organisms such as human, yeast, and E. coli (but no plant species), and some acelylation sites and N-glycosylation sites
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    a [
                                        href "http://phospho.elm.eu.org/",
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "Phospho.ELM"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - A manually-curated database of experimentally verified phosphorylation sites in animal proteins
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "PhosphoPep"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - Including phosphorylation site datafrom human, yeast, C. elegans and D. melanogaster 
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "Phosphorylation site database"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        -  For prokaryotic organisms
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    a [
                                        href "http://phosphat.uni-hohenheim.de/",
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "PhosPhAt"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - An Arabidopsis thaliana phosphorylation site database identified by mass spectrometry in large scale experiments
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    a [
                                        href "http://www.p3db.org/",
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "P3DB"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - With the largest collection of plant phosphorylation data 
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    a [
                                        href "http://www.cbs.dtu.dk/databases/OGLYCBASE/",
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "O-GlycBase"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - Of O- and C-glycosylated proteins 
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    a [
                                        href "http://ubiprot.org.ru/",
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "UbiProt"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - Of ubiquitylated proteins, mainly in human and yeast 
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    a [
                                        href "http://scud.kaist.ac.kr/",
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "SCUD"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - For the ubiquitination system in yeast with enzymes and substrates 
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        PlantsUPS of plants Ubiquitin Proteasome System 
                                        """
                                    ]
                                ]       
                            ],

                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ] 
                                ][
                                    a [
                                        href "http://www.arabidopsis.org/servlets/Search?type=general&search_action=detail&method=1&show_obsolete=F&name=myristoylation&sub_type=gene&SEARCH_EXACT=4&SEARCH_CONTAINS=1",
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text "Arabidopsis myristoylation data sets"
                                    ],
                                    div [
                                        css [
                                            display inline
                                        ]
                                    ][
                                        text  """
                                        - stored at TAIR 
                                        """
                                    ]
                                ]       
                            ],

                            div [
                                css [
                                    fontSize (Css.em 1.2),
                                    marginTop (px 10)
                                ]
                            ][
                                text "Enzyme databases:"
                            ],

                            ul [
                                css [
                                    
                                ]
                            ][
                                li [
                                    css [
                                        marginTop (px 5)
                                    ]
                                ][
                                    text "Protein Kinase Resource: with comprehensive kinase data in animals and plants"
                                ],
                                li [
                                    css [
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ] 
                                    ][
                                        a [
                                            href "http://www.functionalglycomics.org/static/gt/gtdb.shtml",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "The Glycosyltransferase Database"
                                        ],
                                        div [
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text  """
                                            - For humans and mouse
                                            """
                                        ]
                                    ]       
                                ],
                                li [
                                    css [
                                        marginTop (px 5)
                                    ]
                                ][
                                    div [
                                        css [
                                            display inline
                                        ] 
                                    ][
                                        a [
                                            href "http://wwwappli.nantes.inra.fr:8180/GTIDB/",
                                            css [
                                                display inline
                                            ]
                                        ][
                                            text "A wheat-Arabidopsis-rice glycosyltransferase database"
                                        ]
                                    ]       
                                ]

                                
                            ]




                        ]

                    

                        ]
                    ]
                ],

                div [
                    id "div_contributiions",
                    css [
                        fontSize (Css.em 0.95)
                    ]
                ][
                    div [
                        css [
                            fontWeight bold,
                            fontSize (Css.em 2)
                        ]
                    ][
                        text "Contributions"
                    ],
                    div [
                        css [
                            marginLeft (px 20)
                        ]
                    ][
                        div [
                            css [
                                marginTop (px 10)
                            ]
                        ][
                            text "You can contribute to iPTMnet in several ways to enrich the knowledge map for proteins of your interest:"
                        ],

                        ol [][
                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                text """
                                Validating text mining results: in the text mining result page, use check boxes to indicate correct or wrong annotations as appropriate.
                                In this way we can present the validated result to the public after editorial checking. 
                                """
                            ],
                            li [
                                css[
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ]
                                ][
                                    text "Input your own annotations: Use the "
                                ],

                                a [
                                    href "http://pir.georgetown.edu/cgi-bin/pro/race_pro/",
                                    css [
                                        display inline
                                    ]
                                ][
                                    text "RACE-PRO"
                                ],

                                div [
                                    css [
                                        display inline
                                    ]
                                ][
                                    text """
                                        interface to add information about a protein and its modification(s) based on literature evidence.
                                        Your contribution will be reflected on the Protein Ontology with appropriate source attribution, and linked from iPTMnet.
                                    """
                                ]
                            ],
                            li [
                                css [
                                    marginTop (px 5)
                                ]
                            ][
                                div [
                                    css [
                                        display inline
                                    ]
                                ][
                                    text "Via "
                                ],
                                a [
                                    href "",
                                    css [
                                        display inline
                                    ]
                                ][
                                    text "email"
                                ],
                                div [
                                    css[
                                        display inline
                                    ]
                                ][
                                    text " if you have any particular suggestion, comment or question. Please include your name and institution in the email. "
                                ]
                            ]

                        ]
                    ]
                    
                ]                     

            ]
            ],

            div[
                id "filler",css [
                    alignSelf stretch,
                    marginBottom (px 20)
                ]]
            [],

            Views.Footer.view 

    ]