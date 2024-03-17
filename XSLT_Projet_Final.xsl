<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0"
        version="2.0">

<!--Format du document de sortie-->
    <xsl:output method="html" indent="yes" omit-xml-declaration="no"/>
    
<!--Définitions des variables-->
    <!--NOMS DE DOMAINE-->
    <!--HTML-->
    <xsl:variable name="html">
        <xsl:value-of select="'.html'"/>
    </xsl:variable>
    
    <!--Relax NG (documentation TEI)-->
    <xsl:variable name="rng">
        <xsl:value-of select="'.rng'"/>
    </xsl:variable>
    
    <!--CHEMIN DES FICHIERS DE SORTIE-->
    <!--Pages globales-->
    <xsl:variable name="home">
        <xsl:value-of select="concat('home', $html)"/>
    </xsl:variable>
    <xsl:variable name="metadata_corpus">
        <xsl:value-of select="concat('metadata', $html)"/>
    </xsl:variable>
    <xsl:variable name="documentation">
        <xsl:value-of select="concat('../ODD_TEI_Projet_Final', $html)"/>
    </xsl:variable>
    <xsl:variable name="index">
        <xsl:value-of select="concat('index', $html)"/>
    </xsl:variable>
    <!--Pages spécifiques-->
    <xsl:variable name="text_acis">
        <xsl:value-of select="concat('text_acis', $html)"/>
    </xsl:variable>
    <xsl:variable name="text_galatee">
        <xsl:value-of select="concat('text_galatee', $html)"/>
    </xsl:variable>
    <xsl:variable name="text_neree">
        <xsl:value-of select="concat('text_neree', $html)"/>
    </xsl:variable>
    <xsl:variable name="text_polypheme">
        <xsl:value-of select="concat('text_polypheme', $html)"/>
    </xsl:variable>
    
    <!--EN-TÊTE ET PIED DE PAGE DES DOCUMENTS HTML-->
    <!--En-tête-->
    <xsl:variable name="header">
        <head id="header">
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <title><xsl:value-of select="//titleStmt/title[@level='m']"/></title>
            <meta name="description">
                <xsl:attribute name="content">
                    <xsl:value-of select="//titleStmt/title[@level='m']"/><xsl:text> par </xsl:text><xsl:value-of select="//titleStmt/author"/>
                </xsl:attribute>
            </meta>
            <meta name="author">
                <xsl:attribute name="content">
                    <xsl:value-of select="//editionStmt/respStmt/persName"/>
                </xsl:attribute>
            </meta>
            <link rel="stylesheet" href="../projet_final_xslt.css"/>
        </head>
    </xsl:variable> 
    <!--Pied de page-->
    <xsl:variable name="footer">
        <footer id="footer">
            <p>
                <xsl:text>Devoir final de XSLT, par </xsl:text>
                <xsl:value-of select="//titleStmt/author"/>
            </p>
            <!--Raccourcis (hyperliens en bas de page)-->
            <p id="shortcuts">
                <xsl:copy-of select="$return_home"/> -
                <xsl:copy-of select="$return_metadata_corpus"/> -
                <xsl:copy-of select="$return_documentation"/> -
                <xsl:copy-of select="$return_index"/> -
                <xsl:copy-of select="$return_acis"/> -
                <xsl:copy-of select="$return_galatee"/> -
                <xsl:copy-of select="$return_neree"/> -
                <xsl:copy-of select="$return_polypheme"/>
            </p>
        </footer>
    </xsl:variable>

    <!--EN-TÊTE DES PAGES-->
    <xsl:variable name="body_header">
        <div id="body_header">
            <h1 id="main_title">Édition en ligne du <span><xsl:value-of select="//titleStmt/title[@level='m']"/></span></h1>
            <h2 id="sub_title">Réalisé par <xsl:value-of select="//titleStmt/author"/></h2>
        </div>
    </xsl:variable>

    <!--VARIABLES DES LIENS DE RETOUR-->
    <xsl:variable name="return_home">
        <a href="{concat('./', $home)}">Revenir à l'accueil</a>
    </xsl:variable>
    <xsl:variable name="return_metadata_corpus">
        <a href="{concat('./', $metadata_corpus)}">Consulter les métadonnées du corpus</a>
    </xsl:variable>
    <xsl:variable name="return_index">
        <a href="{concat('./', $index)}">Consulter les index</a>
    </xsl:variable>
    <xsl:variable name="return_documentation">
        <a href="{concat('./', $documentation)}">Consulter la documentation</a>
    </xsl:variable>
    <xsl:variable name="return_acis">
        <a href="{concat('./', $text_acis)}">ACIS</a>
    </xsl:variable>
    <xsl:variable name="return_galatee">
        <a href="{concat('./', $text_galatee)}">GALATÉE</a>
    </xsl:variable>
    <xsl:variable name="return_neree">
        <a href="{concat('./', $text_neree)}">NÉRÉE</a>
    </xsl:variable>
    <xsl:variable name="return_polypheme">
        <a href="{concat('./', $text_polypheme)}">POLYPHÈME</a>
    </xsl:variable>
    
<!--Définition des templates-->
    <!--ORDRE D'APPLICATION DES TEMPLATES DANS LE DOC DE SORTIE-->
    <xsl:template match="/">
        <xsl:call-template name="home"/>
        <xsl:call-template name="metadata_corpus"/>
        <xsl:call-template name="index"/>
        <xsl:call-template name="entries"/>
    </xsl:template>
    
    <!--TEMPLATE DE L'ACCUEIL-->
    <xsl:template name="home">
        <xsl:result-document href="./out/{$home}" method="html">
            <html lang="fr">
                <!--Pour chaque template, appel du <head> configuré plus haut sous forme de variable-->
                <xsl:copy-of select="$header"/>
                <!--Puis contenu de la page-->
                <body id="home_page">
                    <xsl:copy-of select="$body_header"/>
                    <div class="content general">
                        <div class="text_centre">
                            <h3 class="page_title">Bienvenue !</h3>
                            <p>Cette édition en ligne a été produite en XHMTL grâce à XSLT dans le cadre du cours de M. Jean-Damien GENERO à
                                l'<xsl:value-of select="//titleStmt/sponsor"/><xsl:value-of select="//titleStmt/author/date"/><xsl:text>.</xsl:text></p>
                        </div>
                        <div>  
                            <p><b>Résumé du projet : </b> <xsl:value-of select="//abstract/p"/></p>
                        </div>
                    </div>
                    <!--Et enfin, avant la fermeture du <body>, appel du pied de page configuré plus haut sous forme de variable-->
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!--TEMPLATE DES INDEX)-->
    <xsl:template name="index">
        <xsl:result-document href="./out/{$index}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body id="home_page">
                    <xsl:copy-of select="$body_header"/>
                    <div class="content general text_centre">
                        <h3 class="page_title">Index</h3>
                        <!--Index des personnages-->
                        <xsl:for-each select="//listPerson">
                            <!--Titre des listes-->
                            <div>
                                <h4 class="small_title">Liste des
                                <xsl:if test="./@type = 'réels_actuels'">
                                    <xsl:text>individus réels actuels</xsl:text>
                                </xsl:if>
                                <xsl:if test="./@type = 'réels_passés'">
                                    <xsl:text>auteurs réels passés</xsl:text>
                                </xsl:if>
                                <xsl:if test="./@type = 'mythologiques'">
                                    <xsl:text>personnages mythologiques</xsl:text>
                                </xsl:if>
                                </h4>
                                <!--Contenu des listes-->
                                <div>
                                    <xsl:for-each-group select="./person" group-by="@xml:id">
                                        <!--Individus réels actuels-->
                                        <xsl:if test="parent::listPerson/@type = 'réels_actuels'">
                                            <ul class="index_entry">
                                                <li><b>Nom : </b> <xsl:value-of select="./persName"/></li>
                                                <xsl:if test="occupation">
                                                  <li><b>Activité : </b> <xsl:value-of select="./occupation/roleName"/></li>
                                                  <li><b>À : </b> <xsl:value-of select="./occupation/orgName"/></li>
                                                  <xsl:for-each select="./occupation/email">
                                                      <li><b>Adresse électronique : </b> <xsl:value-of select="."/></li>
                                                  </xsl:for-each>
                                                </xsl:if>
                                            </ul>
                                        </xsl:if>
                                        <!--Auteurs passés-->
                                        <xsl:if test="parent::listPerson/@type = 'réels_passés'">
                                            <ul class="index_entry">
                                                <li><b>Nom : </b> <xsl:value-of select="./persName"/></li>
                                                <li><b>Activité(s) : </b> <xsl:value-of select="./occupation"/></li>
                                                <li><b>Nationalité : </b> <xsl:value-of select="./nationality"/></li>
                                                <li><b>Langue(s) écrite(s) : </b>
                                                    <xsl:if test="count(./langKnowledge/langKnown) = 0">
                                                        <xsl:text>Non mentionnée.</xsl:text>
                                                    </xsl:if>
                                                    <xsl:if test="count(./langKnowledge/langKnown) = 1">
                                                        <xsl:value-of select="./langKnowledge/langKnown"/>
                                                    </xsl:if>
                                                    <xsl:if test="count(./langKnowledge/langKnown) = 2">
                                                        <xsl:value-of select="./langKnowledge/langKnown[1]"/>
                                                        <xsl:text>, </xsl:text>
                                                        <xsl:value-of select="./langKnowledge/langKnown[2]"/>
                                                    </xsl:if>
                                                </li>
                                                <li><b>Dates de vie : </b> <xsl:value-of select="./birth"/> - <xsl:value-of select="./death"/></li>
                                                <li><b><xsl:value-of select="./note/ref"/> : </b> <xsl:value-of select="./note/ref/@target"/></li>
                                            </ul>
                                        </xsl:if>
                                        <!--Personnages mythologiques-->
                                        <xsl:if test="parent::listPerson/@type = 'mythologiques'">
                                            <ul class="index_entry">
                                                <li><b>Nom : </b> <xsl:value-of select="./persName"/></li>
                                                <li><b>Description : </b> <xsl:value-of select="./trait"/></li>
                                                <xsl:if test="death">
                                                    <li><b>Conditions du décès : </b><xsl:value-of select="./death"/></li>
                                                </xsl:if>
                                                <xsl:if test="note/ref">
                                                    <li><b><xsl:value-of select="./note/ref"/> : </b> <xsl:value-of select="./note/ref/@target"/></li>
                                                </xsl:if>
                                            </ul>
                                        </xsl:if>
                                    </xsl:for-each-group>
                                </div>
                            </div>
                        </xsl:for-each>
                        <xsl:for-each select="//listOrg">
                            <!--Titre de la liste-->
                            <h4 class="small_title">Liste des institutions</h4>
                            <xsl:for-each-group select="./org" group-by="@xml:id">
                                <!--Contenu de la liste-->
                                <ul class="index_entry">
                                    <li><b>Nom : </b> <xsl:value-of select="./orgName"/></li>
                                    <li><b>Type : </b> <xsl:value-of select="./desc/label"/></li>
                                    <li><b>Dates d'existence : </b> <xsl:value-of select="./desc/date[@from]"/>
                                        <xsl:if test="desc/date/@to">
                                            <xsl:text>- </xsl:text><xsl:value-of select="./desc/date[@to]"/>
                                        </xsl:if>
                                    </li>
                                    <li><b><xsl:value-of select="./desc/ref"/> : </b> <xsl:value-of select="./desc/ref/@target"/></li>
                                </ul>
                            </xsl:for-each-group>
                        </xsl:for-each>
                        <xsl:for-each select="//listPlace">
                            <!--Titre de la liste-->
                            <h4 class="small_title">Liste des lieux</h4>
                            <xsl:for-each-group select=".//place" group-by="@xml:id">
                                <!--Contenu de la liste-->
                                <ul class="index_entry">
                                    <xsl:for-each select="./settlement">
                                        <!--Configuration des villes-->
                                        <xsl:if test="not(name)">
                                            <li><b>Nom : </b> <xsl:value-of select="."/></li>
                                        </xsl:if>
                                        <xsl:if test="name">
                                            <xsl:choose>
                                                <xsl:when test="count(./name) = 1">
                                                    <li><b>Nom : </b> <xsl:value-of select="./name"/></li>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <li><b>Nom : </b> <xsl:value-of select="./name[1]"/></li>
                                                    <xsl:for-each select="./name">
                                                        <xsl:if test="position() != 1">
                                                            <li><b>Autre nom : </b> <xsl:value-of select="."/></li>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:if>
                                        <li><b>Type : </b> <xsl:text>Ville</xsl:text></li>
                                        <xsl:if test="following-sibling::location/country">
                                            <li><b>Pays : </b> <xsl:value-of select="following-sibling::location/country"/></li>
                                        </xsl:if>
                                    </xsl:for-each>
                                    <xsl:for-each select="./region">
                                        <!--Configuration des régions-->
                                        <li><b>Nom : </b> <xsl:value-of select="."/></li>
                                        <li><b>Type : </b> <xsl:text>Région</xsl:text></li>
                                        <xsl:for-each select="following-sibling::place">
                                            <li><b>Contient : </b> 
                                                <xsl:if test="geogName">
                                                    <xsl:value-of select="./geogName"/>
                                                </xsl:if>
                                                <xsl:if test="settlement">
                                                    <xsl:if test="not(./settlement/name)">
                                                        <xsl:value-of select="."/>
                                                    </xsl:if>
                                                    <xsl:if test="./settlement/name">
                                                        <xsl:if test="position() = 1">
                                                            <xsl:value-of select=".//name[1]"/>
                                                        </xsl:if>
                                                    </xsl:if>
                                                </xsl:if>
                                            </li>
                                        </xsl:for-each>
                                    </xsl:for-each>
                                    <xsl:for-each select="./geogName">
                                        <!--Configuration des autres toponymes-->
                                        <li><b>Nom : </b> <xsl:value-of select="."/></li>
                                        <li><b>Type : </b> <xsl:value-of select="following-sibling::location/geogFeat"/></li>
                                        <li><b>Coordonnées : </b> <xsl:value-of select="following-sibling::location/geo"/></li>
                                    </xsl:for-each>
                                </ul>
                            </xsl:for-each-group>
                        </xsl:for-each>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!--TEMPLATE DES METADONNEES DU CORPUS-->
    <xsl:template name="metadata_corpus">
        <xsl:result-document href="./out/{$metadata_corpus}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body id="home_page">
                    <xsl:copy-of select="$body_header"/>
                    <div class="content general text_centre">
                        <!--Introduction-->
                        <h3 class="page_title">Métadonnées du corpus</h3>
                        <p>La présente page contient les métadonnées du corpus de textes exploité dans le cadre de ce projet. En l'occurrence, il s'agît de trois tomes d'un même dictionnaire. Les métadonnées du dictionnaire sont valides pour chacun des tomes.</p>
                        <p>Les métadonnées du dictionnaire relèvent de la source originale, tandis que ceux des tomes ont en partie rapport avec la version numérique des documents consultée.</p>
                        <div>
                            <xsl:for-each select="//sourceDesc/bibl">
                                <!--Métadonnées de la source originale, propres à chaque tome du dictionnaire-->
                                <h4 class="small_title">Métadonnées du dictionnaire :</h4>
                                <div>
                                    <xsl:attribute name="class"><xsl:text>metadata_</xsl:text><xsl:value-of select="./title/@type"></xsl:value-of></xsl:attribute>
                                    <p><b>Titre complet : </b><xsl:value-of select="./title[@type='main']"/></p>
                                    <p><b>Auteur : </b><xsl:value-of select="./author"/></p>
                                    <p><b>Lieu de publication : </b><xsl:value-of select="./pubPlace"/></p>
                                    <p><b>Edition originale : </b><xsl:value-of select="./edition"/> <xsl:value-of select="./date"/> (<xsl:value-of select="./date/@when"/>)</p>
                                    <p><b>Commentaire : </b><xsl:value-of select="./note"/></p>
                                </div>
                                <!--Métadonnées distinctes de chaque tome dans leur version numérique disponible sur Gallica-->
                                <h4 class="small_title">Métadonnées des tomes :</h4>
                                <xsl:for-each select="following-sibling::listBibl//monogr">
                                    <div>
                                    <xsl:attribute name="class"><xsl:text>metadata_</xsl:text><xsl:value-of select="./title/@type"></xsl:value-of></xsl:attribute>
                                        <p><b>Titre du volume : </b><xsl:value-of select="./title"/>, de <xsl:value-of select="./imprint/biblScope/@from"/> à <xsl:value-of select="./imprint/biblScope/@to"/></p>
                                        <p><b>Publié en ligne par : </b><xsl:value-of select="./imprint/publisher"/>, <xsl:value-of select="./imprint/pubPlace"/></p>
                                        <p><b>Date de publication : </b><xsl:value-of select="./imprint/date/@when"/></p>
                                        <p><b>URI Gallica : </b><xsl:value-of select="./idno"/></p>
                                    </div>
                                </xsl:for-each>
                            </xsl:for-each>
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!--TEMPLATE DES ENTREES-->
    <xsl:template name="entries">
        <xsl:for-each select="//TEI/@n">
            <!--Variables internes au modèle : numéro et intitulé de l'entrée-->   
            <xsl:variable name="number" select="."/>
            <xsl:variable name="entry_name">
                <xsl:value-of select="//TEI[@n=$number]//orth/persName/translate(@ref, '#', '')"/>
            </xsl:variable>
            <!--Production du document HTML-->   
            <xsl:result-document href="./out/text_{$entry_name}.html" method="html">
                <html lang="fr">
                    <xsl:copy-of select="$header"/>
                    <body>
                        <xsl:copy-of select="$body_header"/>
                        <div class="entry">
                            <!--Titre de l'entrée-->
                            <p class="page_title"><xsl:value-of select="upper-case($entry_name)"/></p>
                            <!--Contenu de l'entrée-->
                            <div class="content">
                                <p><b>Entrée numéro : </b><xsl:value-of select="$number"/>.</p>
                                <p><b>Forme(s) : </b>
                                    <xsl:for-each select="//TEI[@n=$number]//orth/persName">
                                        <!--Distinctions de toutes les formes du nom du personnage de cette entrée mentionnées dans l'ensemble de ladite entrée-->
                                        <xsl:choose>
                                            <xsl:when test="ancestor::form/following-sibling::etym/term">
                                                <xsl:if test="name">
                                                    <xsl:for-each select="./name">
                                                        <xsl:value-of select="."/>
                                                        <xsl:text>, </xsl:text>
                                                    </xsl:for-each>
                                                </xsl:if>
                                                <xsl:if test="text()">
                                                    <xsl:value-of select="."/>
                                                        <xsl:text>, </xsl:text>
                                                </xsl:if>
                                                <xsl:if test="ancestor::form/following-sibling::etym/term">
                                                    <xsl:for-each select="ancestor::form/following-sibling::etym/term">
                                                        <xsl:value-of select="."/>
                                                        <xsl:if test="position() != last()">
                                                            <xsl:text>, </xsl:text>
                                                        </xsl:if>
                                                        <xsl:if test="position() = last()">
                                                            <xsl:text>.</xsl:text>
                                                        </xsl:if>
                                                    </xsl:for-each>
                                                </xsl:if>      
                                            </xsl:when>
                                            <xsl:when test="not(ancestor::form/following-sibling::etym/term)">
                                                    <xsl:choose>
                                                        <xsl:when test="name">
                                                            <xsl:for-each select="./name">
                                                                <xsl:value-of select="."/>
                                                                <xsl:if test="position() != last()">
                                                                    <xsl:text>, </xsl:text>
                                                                </xsl:if>
                                                                <xsl:if test="position() = last()">
                                                                    <xsl:text>.</xsl:text>
                                                                </xsl:if>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="."/>
                                                            <xsl:text>. </xsl:text>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:when>
                                            </xsl:choose>
                                    </xsl:for-each>
                                </p>
                                <!--Autres informations sur l'entrée prélevées grâce à son numéro-->
                                <p><b>Origine étymologique : </b> <xsl:value-of select="//TEI[@n=$number]//etym/lang"/>.</p>
                                <p><b>Groupe grammatical : </b> <xsl:value-of select="//TEI[@n=$number]//reg"/>.</p>
                                <div>
                                    <b>Définition(s) : </b> 
                                    <xsl:for-each select="//TEI[@n=$number]//sense/def">
                                        <p><xsl:apply-templates/></p>
                                    </xsl:for-each>
                                </div>
                                <xsl:if test="//TEI[@n=$number]//xr">
                                    <div>
                                        <b>Références : </b>
                                        <xsl:value-of select="//TEI[@n=$number]//xr"/>
                                    </div>
                                </xsl:if>
                                <a href="{//TEI[@n=$number]//form/ref/@target}">Accéder à la numérisation en ligne</a>
                            </div>
                        </div>
                        <xsl:copy-of select="$footer"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    
</xsl:stylesheet>