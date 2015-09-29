<xsl:stylesheet version="1.0" xmlns:gss="http://www.isotc211.org/2005/gss"
	xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gml="http://www.opengis.net/gml/3.2"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gco="http://www.isotc211.org/2005/gco"
	xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gmi="http://www.isotc211.org/2005/gmi"
	xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:gsr="http://www.isotc211.org/2005/gsr"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Created: Sept 15, 2009, AMilan -
	Used to display content of tags and test for @nilReason, @indeterminatePosition, replace single quotes and endash
	-->
	<xsl:strip-space elements="*"/>
	<xsl:param name="singleQuote">&#39;</xsl:param>
	<xsl:param name="rightQuote">&#8217;</xsl:param>
	<xsl:param name="enDash">–</xsl:param>
	<xsl:param name="normalDash">-</xsl:param>
	<xsl:template name="displayElement">
		<xsl:variable name="value">
			<xsl:choose>
				<xsl:when test="contains(normalize-space(.),$singleQuote)">
					<xsl:variable name="value1">
						<xsl:value-of
							select="translate(normalize-space(.), $singleQuote, $rightQuote)"/>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="contains($value1,$enDash)">
							<xsl:value-of select="translate($value1, $enDash, $normalDash)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$value1"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="contains(normalize-space(.),$enDash)">
					<xsl:value-of select="translate(normalize-space(.), $enDash, $normalDash)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="./@gco:nilReason"> (<xsl:value-of select="local-name(.)"
					/><xsl:text> is </xsl:text><xsl:value-of select="./@gco:nilReason"/>) </xsl:when>
			<xsl:when test="./@indeterminatePosition">
				<xsl:value-of select="./@indeterminatePosition"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$value"/>
			</xsl:when>
			<xsl:when test="./@xlink:href"> &lt;a href=&quot;<xsl:value-of
					select="normalize-space(./@xlink:href)"/>&quot;&gt;<xsl:value-of
					select="normalize-space(./@xlink:href)"/>&lt;/a&gt; </xsl:when>
			<xsl:when test="./gco:Boolean">
				<xsl:if test="./gco:Boolean='false'">No</xsl:if>
				<xsl:if test="./gco:Boolean='true'">Yes</xsl:if>
			</xsl:when>
			<xsl:when test="./gmx:Anchor">
				<xsl:choose>
					<xsl:when test="./gmx:Anchor/@xlink:href">
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="normalize-space(./gmx:Anchor/@xlink:href)"/>
							</xsl:attribute>
							<xsl:choose>
								<xsl:when test="./gmx:Anchor/node()">
									<xsl:value-of select="$value"/>
								</xsl:when>
								<xsl:otherwise><xsl:value-of select="./gmx:Anchor/@xlink:href"/></xsl:otherwise>
							</xsl:choose>
						</a>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
