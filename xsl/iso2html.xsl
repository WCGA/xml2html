<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:gss="http://www.isotc211.org/2005/gss"
  xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gml="http://www.opengis.net/gml/3.2"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gmi="http://www.isotc211.org/2005/gmi"
  xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:gsr="http://www.isotc211.org/2005/gsr"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs xd gss gts gml xlink gco gmd gmi gmx gsr" version="1.0">
  <!-- aka: get data view -->
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Sep 30, 2010</xd:p>
      <xd:p><xd:b>Updated on: </xd:b>Sept. 6, 2012</xd:p>
      <xd:p><xd:b>Updated on: </xd:b>April 11, 2013 - improved instruction and constraints
        column</xd:p>
      <xd:p><xd:b>Updated on: </xd:b>April 17, 2013 - converted to XSL 1.0</xd:p>
      <xd:p><xd:b>Updated on: </xd:b>May 28, 2013 - added display of DOI under title</xd:p>

      <xd:p><xd:b>Author:</xd:b> anna.milan@noaa.gov</xd:p>
      <xd:p>Purpose is to present a brief HTML view of ISO 19115/19115-2 metadata with a focus on
        data access.</xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:output encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    omit-xml-declaration="yes" indent="no"/>

  <xsl:include href="displayElement.xsl"/>

  <xsl:include href="isoAltViews.xsl"/>

  <!-- HTML -->
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title><xsl:for-each
          select="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title[1]">
          <xsl:call-template name="displayElement"/>
        </xsl:for-each></title>
        <!--<title>Get Data View of ISO 19115 and 19115-2</title>-->
        <style type="text/css">
          table.mainTable{
              width:100%;
              border-style:none;
              vertical-align:top;
          }
          table.mainTable th{
              border-style:none;
              padding:5px 5px 5px 5px;
              font-weight:bold;
              vertical-align:top;
              text-align:left;
          }
          table.mainTable td{
              border-style:none;
              padding:5px 5px 5px 5px;
              vertical-align:top;
          }
          table.subTable{
              width:100%;
              border-style:none;
              vertical-align:top;
          }
          table.subTable th{
              border-style:none;
              padding:5px 5px 5px 5px;
              font-weight:bold;
              vertical-align:top;
              text-align:left;
          }
          table.subTable td{
              border-style:none;
              border-width:1px;
              padding:10px 10px 10px 10px;
              vertical-align:top;
              width:20%;
          }
          ul{
              list-style:circle inside;
              padding:0;
              margin:0;
          }
          dt{
              font-weight:bold;
          }</style>
      </head>
      <body>

        <!-- Links to Alternate ISO views -->
        <xsl:call-template name="isoAltViews"/>

        <table class="mainTable">
          <tr>
            <td>
              <table>
                <tr>
                  <th colspan="2" align="left">
                    <font size="+3">
                      <xsl:for-each
                        select="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title">
                        <xsl:call-template name="displayElement"/>
                      </xsl:for-each>
                    </font>
                  </th>
                </tr>
                <tr>
                  <td colspan="2">
                    <xsl:for-each
                      select="//gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code">
                      <xsl:call-template name="displayElement"/>
                    </xsl:for-each>
                  </td>
                </tr>
                <xsl:choose>
                  <xsl:when test="//gmd:MD_BrowseGraphic/gmd:fileName">
                    <tr>
                      <td valign="top" align="left">
                        <a href="{//gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString}">
                          <img alt="browse graphic" style="width: 300px; float: right; border: 0px"
                            src="{//gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString}"/>
                        </a>
                      </td>
                      <td valign="top" align="left">
                        <xsl:for-each select="//gmd:MD_DataIdentification/gmd:abstract">
                          <xsl:call-template name="displayElement"/>
                        </xsl:for-each>
                      </td>
                    </tr>
                  </xsl:when>
                  <xsl:otherwise>
                    <tr>
                      <td colspan="2">
                        <xsl:for-each select="//gmd:MD_DataIdentification/gmd:abstract">
                          <xsl:call-template name="displayElement"/>
                        </xsl:for-each>
                      </td>
                    </tr>
                  </xsl:otherwise>
                </xsl:choose>

              </table>
              <br/>
              <table class="subTable">
                <tr>
                  <th colspan="4" align="center">
                    <font size="+2">Get the Data</font>
                  </th>
                </tr>
                <xsl:choose>
                  <xsl:when test="//gmd:distributionInfo">
                    <xsl:for-each select="//gmd:distributionInfo">
                      <tr bgcolor="#F2F2F2">
                        <th>Access</th>
                        <th>Format(s)</th>
                        <th>Distributor(s) / Contact Info</th>
                        <th>Instructions / Constraints</th>
                      </tr>
                      <tr>
                        <td>
                          <xsl:for-each select=".//gmd:onLine">
                            <!--<xsl:if
                              test="gmd:CI_OnlineResource[not(.=preceding::gmd:CI_OnlineResource)]">-->
                              <xsl:for-each select=".//gmd:CI_OnlineResource">
                                <dl>
                                  <dt>
                                    <xsl:for-each select="./gmd:function">
                                      <i>
                                        <xsl:call-template name="displayElement"/>
                                      </i>
                                    </xsl:for-each>
                                  </dt>
                                  <xsl:call-template name="listElements_onlineResource"/>
                                </dl>
                              </xsl:for-each>
<!--                            </xsl:if>-->
                          </xsl:for-each>
                        </td>
                        <td valign="top">
                          <xsl:for-each select="//gmd:distributorFormat|//gmd:distributionFormat">
                            <xsl:if test="gmd:MD_Format[not(.=preceding::gmd:MD_Format)]">
                              <xsl:for-each select="gmd:MD_Format">
                                <dl>
                                  <dt>
                                    <xsl:for-each select="gmd:name">
                                      <xsl:call-template name="displayElement"/>
                                    </xsl:for-each>
                                  </dt>
                                  <dd>
                                    <xsl:for-each select="gmd:version"> Format version:
                                        <xsl:call-template name="displayElement"/>
                                    </xsl:for-each>
                                  </dd>
                                  <dd>
                                    <xsl:for-each select="gmd:specification"> Format specification:
                                        <xsl:call-template name="displayElement"/>
                                    </xsl:for-each>
                                  </dd>
                                  <dd>
                                    <xsl:for-each select="gmd:fileDecompressionTechnique">
                                      Compression: <xsl:call-template name="displayElement"/>
                                    </xsl:for-each>
                                  </dd>
                                </dl>
                              </xsl:for-each>
                            </xsl:if>
                          </xsl:for-each>
                        </td>
                        <td>
                          <dl>
                            <xsl:for-each select=".//gmd:distributorContact">
                              <xsl:if
                                test="gmd:CI_ResponsibleParty[not(.=preceding::gmd:CI_ResponsibleParty)]">
                                <xsl:call-template name="listElements_CI_ResponsibleParty"/>
                              </xsl:if>
                            </xsl:for-each>
                          </dl>
                        </td>
                        <td>
                          <dl>
                            <xsl:if test="./gmd:MD_Distribution//gmd:fees">
                              <dt>Fees</dt>
                            </xsl:if>
                            <xsl:for-each select=".//gmd:fees">
                              <dd>
                                <xsl:if
                                  test="gco:CharacterString[not(.=preceding::gco:CharacterString)]">
                                  <xsl:call-template name="displayElement"/>
                                </xsl:if>
                              </dd>
                              <br/>
                            </xsl:for-each>
                            <xsl:if test="./gmd:MD_Distribution//gmd:orderingInstructions">
                              <dt>Ordering Instructions</dt>
                            </xsl:if>
                            <xsl:for-each select=".//gmd:orderingInstructions">
                              <dd>
                                <xsl:if
                                  test="gco:CharacterString[not(.=preceding::gco:CharacterString)]">
                                  <xsl:call-template name="displayElement"/>
                                </xsl:if>
                              </dd>
                              <br/>
                            </xsl:for-each>
                            <!-- gmd:MD_Constraints/gmd:useLimitation-->
                            <xsl:if
                              test="//gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_Constraints/gmd:useLimitation">
                              <dt>Use Limitation</dt>
                              <xsl:for-each
                                select="//gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_Constraints/gmd:useLimitation">
                                <dd>
                                  <xsl:call-template name="displayElement"/>                                  
                                </dd>
                                <br/>
                              </xsl:for-each>
                            </xsl:if>

                            <!-- MD_LegalConstraints -->
                            <xsl:if
                              test="//gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints">
                              <dt>
                                <font>Legal Constraints</font>
                                <br/>
                              </dt>
                              <xsl:for-each
                                select="//gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints">
                                <xsl:if test=".//gmd:accessConstraints">
                                  <dt> Access </dt>
                                  <xsl:for-each select=".//gmd:accessConstraints">
                                    <dd>
                                      <xsl:call-template name="displayElement"/>                                      
                                    </dd>
                                    <br/>
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:if test=".//gmd:useConstraints">
                                  <dt> Use Limitation</dt>
                                  <xsl:for-each select=".//gmd:useConstraints">
                                    <dd>
                                      <xsl:call-template name="displayElement"/>                                     
                                    </dd>
                                    <br/>
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:if test=".//gmd:otherConstraints">
                                  <dt>Other</dt>
                                  <xsl:for-each select=".//gmd:otherConstraints">
                                    <xsl:if
                                      test="gco:CharacterString[not(.=preceding::gco:CharacterString)]">
                                      <dd>
                                        <xsl:if test="contains(., 'doi')">
                                          <b>Citation Recommendation: </b>
                                        </xsl:if>
                                        <xsl:call-template name="displayElement"/>                                        
                                      </dd>
                                      <br/>
                                    </xsl:if>
                                  </xsl:for-each>
                                </xsl:if>
                              </xsl:for-each>
                            </xsl:if>
                            <!-- Security Constraints -->
                            <xsl:if
                              test="//gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_SecurityConstraints">
                              <dt>
                                <font>Security Constraints</font>
                                <br/>
                              </dt>
                              <xsl:for-each
                                select="//gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_SecurityConstraints">
                                <xsl:if test=".//gmd:useLimitation">
                                  <dt>Use Limitation</dt>
                                  <xsl:for-each select=".//gmd:useLimitation">
                                    <xsl:if
                                      test="gco:CharacterString[not(.=preceding::gco:CharacterString)]">
                                      <dd>
                                        <xsl:call-template name="displayElement"/>                                       
                                      </dd>
                                      <br/>
                                    </xsl:if>
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:if test=".//gmd:classification">
                                  <dt> Classification </dt>
                                  <xsl:for-each select=".//gmd:classification">
                                    <dd>
                                      <xsl:call-template name="displayElement"/>                                      
                                    </dd>
                                    <br/>
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:if test=".//gmd:userNote">
                                  <dt>User Note</dt>
                                  <xsl:for-each select=".//gmd:userNote">
                                    <xsl:if
                                      test="gco:CharacterString[not(.=preceding::gco:CharacterString)]">
                                      <dd>
                                        <xsl:call-template name="displayElement"/>                                       
                                      </dd>
                                      <br/>
                                    </xsl:if>
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:if test=".//gmd:classificationSystem">
                                  <dt>Classification System</dt>
                                  <xsl:for-each select=".//gmd:classificationSystem">
                                    <xsl:if
                                      test="gco:CharacterString[not(.=preceding::gco:CharacterString)]">
                                      <dd>
                                        <xsl:call-template name="displayElement"/>                                       
                                      </dd>
                                      <br/>
                                    </xsl:if>
                                  </xsl:for-each>
                                </xsl:if>
                                <xsl:if test=".+//gmd:handlingDescription">
                                  <dt>Handling Description</dt>
                                  <xsl:for-each select=".//gmd:handlingDescription">
                                    <xsl:if
                                      test="gco:CharacterString[not(.=preceding::gco:CharacterString)]">
                                      <dd>
                                        <xsl:call-template name="displayElement"/>                                        
                                      </dd>
                                      <br/>
                                    </xsl:if>
                                  </xsl:for-each>
                                </xsl:if>
                              </xsl:for-each>
                            </xsl:if>
                          </dl>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>Distribution information is not documented.</xsl:otherwise>
                </xsl:choose>
              </table>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
  <xsl:template name="listElements_onlineResource">
    <dd>
      <a>
        <xsl:attribute name="href">
          <xsl:for-each select="gmd:linkage/gmd:URL">
            <xsl:call-template name="displayElement"/>
          </xsl:for-each>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="gmd:name">
            <xsl:for-each select="gmd:name">
              <xsl:call-template name="displayElement"/>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="gmd:linkage/gmd:URL">
              <xsl:call-template name="displayElement"/>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </a>
    </dd>
    <dd>
      <xsl:for-each select="gmd:description/gco:CharacterString">
        <xsl:call-template name="displayElement"/>
      </xsl:for-each>
    </dd>
  </xsl:template>
  <xsl:template name="listElements_CI_ResponsibleParty">
    <xsl:choose>
      <xsl:when test=".//gmd:electronicMailAddress">
        <xsl:variable name="email">
          <xsl:value-of
            select=".//gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress"
          />
        </xsl:variable>
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="concat('mailto:',$email)"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test=".//gmd:individualName">
              <xsl:for-each select=".//gmd:individualName">
                <xsl:call-template name="displayElement"/>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test=".//gmd:organisationName">
              <xsl:for-each select=".//gmd:organisationName">
                <xsl:call-template name="displayElement"/>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test=".//gmd:positionName">
              <xsl:for-each select=".//gmd:positionName">
                <xsl:call-template name="displayElement"/>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$email"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="gmd:individualName">
            <xsl:for-each select="gmd:individualName">
              <br/>
              <xsl:call-template name="displayElement"/>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="gmd:organisationName">
            <xsl:for-each select="gmd:organisationName">
              <br/>
              <xsl:call-template name="displayElement"/>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="gmd:positionName">
            <xsl:for-each select="gmd:positionName">
              <br/>
              <xsl:call-template name="displayElement"/>
            </xsl:for-each>
          </xsl:when>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:for-each select=".//gmd:organisationName">
      <br/>
      <xsl:call-template name="displayElement"/>
    </xsl:for-each>
    <xsl:for-each select=".//gmd:contactInstructions">
      <br/>
      <xsl:call-template name="displayElement"/>
    </xsl:for-each>
    <xsl:for-each select=".//gmd:voice">
      <br/>
      <xsl:call-template name="displayElement"/>
    </xsl:for-each>
    <xsl:for-each select=".//gmd:hoursOfService">
      <br/>
      <xsl:call-template name="displayElement"/>
    </xsl:for-each>

  </xsl:template>
</xsl:stylesheet>
