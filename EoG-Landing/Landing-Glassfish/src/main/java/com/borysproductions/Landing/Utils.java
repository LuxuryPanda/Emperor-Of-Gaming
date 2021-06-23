package com.borysproductions.Landing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Utils {

    public static void CloseConnection(ResultSet resultSet, Statement connStatement, Connection connection) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
        if (connStatement != null) {
            try {
                connStatement.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
    }

    public static String StringFixerOld(String stringToFix){

        //#region ## FIX DELLE A ##

        if(stringToFix.contains("À")){
            stringToFix = stringToFix.replace("À", "&Agrave;");
        }

        if(stringToFix.contains("à")){
            stringToFix = stringToFix.replace("à", "&Agrave;");
        }

        if(stringToFix.contains("Á")){
            stringToFix = stringToFix.replace("Á", "&Aacute;");
        }

        if(stringToFix.contains("á")){
            stringToFix = stringToFix.replace("á", "&aacute;");
        }

        if(stringToFix.contains("Â")){
            stringToFix = stringToFix.replace("Â", "&Acirc;");
        }

        if(stringToFix.contains("â")){
            stringToFix = stringToFix.replace("â", "&acirc;");
        }

        if(stringToFix.contains("Ã")){
            stringToFix = stringToFix.replace("Ã", "&Atilde;");
        }

        if(stringToFix.contains("ã")){
            stringToFix = stringToFix.replace("ã", "&atilde;");
        }

        if(stringToFix.contains("Ä")){
            stringToFix = stringToFix.replace("Ä", "&Auml;");
        }

        if(stringToFix.contains("ä")){
            stringToFix = stringToFix.replace("ä", "&auml;");
        }

        //#endregion

        //#region ## FIX DELLE E ##

        if(stringToFix.contains("È")){
            stringToFix = stringToFix.replace("È", "&Egrave;");
        }

        if(stringToFix.contains("è")){
            stringToFix = stringToFix.replace("è", "&egrave;");
        }

        if(stringToFix.contains("É")){
            stringToFix = stringToFix.replace("É", "&Eacute;");
        }

        if(stringToFix.contains("é")){
            stringToFix = stringToFix.replace("é", "&eacute;");
        }

        if(stringToFix.contains("Ê")){
            stringToFix = stringToFix.replace("Ê", "&Ecirc;");
        }

        if(stringToFix.contains("ê")){
            stringToFix = stringToFix.replace("ê", "&ecirc;");
        }

        if(stringToFix.contains("Ë")){
            stringToFix = stringToFix.replace("Ë", "&Euml;");
        }

        if(stringToFix.contains("ë")){
            stringToFix = stringToFix.replace("ë", "&euml;");
        }

        //#endregion

        //#region ## FIX DELLE I ##

        if(stringToFix.contains("Ì")){
            stringToFix = stringToFix.replace("Ì", "&Igrave;");
        }

        if(stringToFix.contains("ì")){
            stringToFix = stringToFix.replace("ì", "&igrave;");
        }

        if(stringToFix.contains("Í")){
            stringToFix = stringToFix.replace("Í", "&Iacute;");
        }

        if(stringToFix.contains("í")){
            stringToFix = stringToFix.replace("í", "&iacute;");
        }

        if(stringToFix.contains("Î")){
            stringToFix = stringToFix.replace("Î", "&Icirc;");
        }

        if(stringToFix.contains("î")){
            stringToFix = stringToFix.replace("î", "&icirc;");
        }

        if(stringToFix.contains("Ï")){
            stringToFix = stringToFix.replace("Ï", "&Iuml;");
        }

        if(stringToFix.contains("ï")){
            stringToFix = stringToFix.replace("ï", "&iuml;");
        }



        //#endregion

        //#region ## FIX DELLE N ##

        if(stringToFix.contains("Ñ")){
            stringToFix = stringToFix.replace("Ñ", "&Ntilde;");
        }

        if(stringToFix.contains("ñ")){
            stringToFix = stringToFix.replace("ñ", "&ntilde;");
        }

        //#endregion

        //#region ## FIX DELLE O ##

        if(stringToFix.contains("Ò")){
            stringToFix = stringToFix.replace("Ò", "&Ograve;");
        }

        if(stringToFix.contains("ò")){
            stringToFix = stringToFix.replace("ò", "&ograve;");
        }

        if(stringToFix.contains("Ó")){
            stringToFix = stringToFix.replace("Ó", "&Oacute;");
        }

        if(stringToFix.contains("ó")){
            stringToFix = stringToFix.replace("ó", "&oacute;");
        }

        if(stringToFix.contains("Ô")){
            stringToFix = stringToFix.replace("Ô", "&Ocirc;");
        }

        if(stringToFix.contains("ô")){
            stringToFix = stringToFix.replace("ô", "&ocirc;");
        }

        if(stringToFix.contains("Õ")){
            stringToFix = stringToFix.replace("Õ", "&Otilde;");
        }

        if(stringToFix.contains("õ")){
            stringToFix = stringToFix.replace("õ", "&otilde;");
        }

        if(stringToFix.contains("Ö")){
            stringToFix = stringToFix.replace("Ö", "&Ouml;");
        }

        if(stringToFix.contains("ö")){
            stringToFix = stringToFix.replace("ö", "&ouml;");
        }

        //#endregion

        //#region ## FIX DELLE U ##

        if(stringToFix.contains("Ù")){
            stringToFix = stringToFix.replace("Ù", "&Ugrave;");
        }

        if(stringToFix.contains("ù")){
            stringToFix = stringToFix.replace("ù", "&ugrave;");
        }

        if(stringToFix.contains("Ú")){
            stringToFix = stringToFix.replace("Ú", "&Uacute;");
        }

        if(stringToFix.contains("ú")){
            stringToFix = stringToFix.replace("ú", "&uacute;");
        }

        if(stringToFix.contains("Û")){
            stringToFix = stringToFix.replace("Û", "&Ucirc;");
        }

        if(stringToFix.contains("û")){
            stringToFix = stringToFix.replace("û", "&ucirc;");
        }

        if(stringToFix.contains("Ü")){
            stringToFix = stringToFix.replace("Ü", "&Uuml;");
        }

        if(stringToFix.contains("ü")){
            stringToFix = stringToFix.replace("ü", "&uuml;");
        }

        //#endregion

        return stringToFix;
    }

    public static String StringFixer(String stringToFix){

        //#region ## FIX DELLE A ##

        if(stringToFix.contains("À")){
            stringToFix = stringToFix.replace("À", "A'");
        }

        if(stringToFix.contains("à")){
            stringToFix = stringToFix.replace("à", "a'");
        }

        if(stringToFix.contains("Á")){
            stringToFix = stringToFix.replace("Á", "A'");
        }

        if(stringToFix.contains("á")){
            stringToFix = stringToFix.replace("á", "a'");
        }

        if(stringToFix.contains("Â")){
            stringToFix = stringToFix.replace("Â", "A'");
        }

        if(stringToFix.contains("â")){
            stringToFix = stringToFix.replace("â", "a'");
        }

        if(stringToFix.contains("Ã")){
            stringToFix = stringToFix.replace("Ã", "A'");
        }

        if(stringToFix.contains("ã")){
            stringToFix = stringToFix.replace("ã", "a'");
        }

        if(stringToFix.contains("Ä")){
            stringToFix = stringToFix.replace("Ä", "A'");
        }

        if(stringToFix.contains("ä")){
            stringToFix = stringToFix.replace("ä", "a'");
        }

        //#endregion

        //#region ## FIX DELLE E ##

        if(stringToFix.contains("È")){
            stringToFix = stringToFix.replace("È", "E'");
        }

        if(stringToFix.contains("è")){
            stringToFix = stringToFix.replace("è", "e'");
        }

        if(stringToFix.contains("É")){
            stringToFix = stringToFix.replace("É", "E'");
        }

        if(stringToFix.contains("é")){
            stringToFix = stringToFix.replace("é", "e'");
        }

        if(stringToFix.contains("Ê")){
            stringToFix = stringToFix.replace("Ê", "E'");
        }

        if(stringToFix.contains("ê")){
            stringToFix = stringToFix.replace("ê", "e'");
        }

        if(stringToFix.contains("Ë")){
            stringToFix = stringToFix.replace("Ë", "E'");
        }

        if(stringToFix.contains("ë")){
            stringToFix = stringToFix.replace("ë", "e'");
        }

        //#endregion

        //#region ## FIX DELLE I ##

        if(stringToFix.contains("Ì")){
            stringToFix = stringToFix.replace("Ì", "I'");
        }

        if(stringToFix.contains("ì")){
            stringToFix = stringToFix.replace("ì", "i'");
        }

        if(stringToFix.contains("Í")){
            stringToFix = stringToFix.replace("Í", "I'");
        }

        if(stringToFix.contains("í")){
            stringToFix = stringToFix.replace("í", "i'");
        }

        if(stringToFix.contains("Î")){
            stringToFix = stringToFix.replace("Î", "I'");
        }

        if(stringToFix.contains("î")){
            stringToFix = stringToFix.replace("î", "i'");
        }

        if(stringToFix.contains("Ï")){
            stringToFix = stringToFix.replace("Ï", "I'");
        }

        if(stringToFix.contains("ï")){
            stringToFix = stringToFix.replace("ï", "i'");
        }



        //#endregion

        //#region ## FIX DELLE N ##

        if(stringToFix.contains("Ñ")){
            stringToFix = stringToFix.replace("Ñ", "N'");
        }

        if(stringToFix.contains("ñ")){
            stringToFix = stringToFix.replace("ñ", "n'");
        }

        //#endregion

        //#region ## FIX DELLE O ##

        if(stringToFix.contains("Ò")){
            stringToFix = stringToFix.replace("Ò", "O'");
        }

        if(stringToFix.contains("ò")){
            stringToFix = stringToFix.replace("ò", "o'");
        }

        if(stringToFix.contains("Ó")){
            stringToFix = stringToFix.replace("Ó", "O'");
        }

        if(stringToFix.contains("ó")){
            stringToFix = stringToFix.replace("ó", "o'");
        }

        if(stringToFix.contains("Ô")){
            stringToFix = stringToFix.replace("Ô", "O'");
        }

        if(stringToFix.contains("ô")){
            stringToFix = stringToFix.replace("ô", "o'");
        }

        if(stringToFix.contains("Õ")){
            stringToFix = stringToFix.replace("Õ", "O'");
        }

        if(stringToFix.contains("õ")){
            stringToFix = stringToFix.replace("õ", "o'");
        }

        if(stringToFix.contains("Ö")){
            stringToFix = stringToFix.replace("Ö", "O'");
        }

        if(stringToFix.contains("ö")){
            stringToFix = stringToFix.replace("ö", "o'");
        }

        //#endregion

        //#region ## FIX DELLE U ##

        if(stringToFix.contains("Ù")){
            stringToFix = stringToFix.replace("Ù", "U'");
        }

        if(stringToFix.contains("ù")){
            stringToFix = stringToFix.replace("ù", "u'");
        }

        if(stringToFix.contains("Ú")){
            stringToFix = stringToFix.replace("Ú", "U'");
        }

        if(stringToFix.contains("ú")){
            stringToFix = stringToFix.replace("ú", "u'");
        }

        if(stringToFix.contains("Û")){
            stringToFix = stringToFix.replace("Û", "U'");
        }

        if(stringToFix.contains("û")){
            stringToFix = stringToFix.replace("û", "u'");
        }

        if(stringToFix.contains("Ü")){
            stringToFix = stringToFix.replace("Ü", "U'");
        }

        if(stringToFix.contains("ü")){
            stringToFix = stringToFix.replace("ü", "u'");
        }

        //#endregion

        return stringToFix;
    }
}
