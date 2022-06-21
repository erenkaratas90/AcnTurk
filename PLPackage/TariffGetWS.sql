create or replace and compile java source named TNSWIN.tariffgetws as
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.CharArrayReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.xml.soap.MessageFactory;
import javax.xml.soap.MimeHeaders;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPConnection;
import javax.xml.soap.SOAPConnectionFactory;
import javax.xml.soap.SOAPElement;
import javax.xml.soap.SOAPEnvelope;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;
import javax.xml.soap.SOAPPart;

public class TARIFFGETWS {

    private static SOAPMessage getSoapMessageFromString(String citizenshipNumber, String agencyCode, String cacheStyle, String identityType, String plateCityCode, String plateNo, String serviceTimeout,  String registrationSerialCode,  String registrationSerialNo, String chassisNo, String operationType, String registryDate, String firstRegistrationDate, String modelYear, String vehicleUsageCode, String refCorporationCode, String refAgencyCode, String refPolicyNo, String refRenewalNo, String sbmTeklifIslemId) throws SOAPException, IOException {

        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        SOAPPart soapPart = soapMessage.getSOAPPart();
//        soapMessage.setProperty (javax.xml.soap.SOAPMessage.CHARACTER_SET_ENCODING, "UTF-16");


        // SOAP Envelope
        SOAPEnvelope envelope = soapPart.getEnvelope();
        envelope.addNamespaceDeclaration("tem", "http://tempuri.org/");
        //envelope.addNamespaceDeclaration("lib", "http://schemas.datacontract.org/2004/07/Liberty.TariffWcfService");
        envelope.addNamespaceDeclaration("lib", "http://schemas.datacontract.org/2004/07/TariffService");

        SOAPBody soapBody = envelope.getBody();
        SOAPElement soapBodyElem = soapBody.addChildElement("GetIndividualResult", "tem");
        SOAPElement soapBodyElem1 = soapBodyElem.addChildElement("req", "tem");
        SOAPElement soapBodyElem9 = soapBodyElem1.addChildElement("serviceTimeout", "lib");
        soapBodyElem9.addTextNode(serviceTimeout);
        SOAPElement soapBodyElem10 = soapBodyElem1.addChildElement("operationList", "lib");

if("SBMTRF".equals(operationType)) {
                SOAPElement soapBodyElem20 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem20.addTextNode("OVMTrafficPolicyByChassisAndIdentity");
                SOAPElement soapBodyElem19 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem19.addTextNode("TrafficPolicyByTckn");
                SOAPElement soapBodyElem43 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem43.addTextNode("TrafficProposalData");
}
else {
        if("KSK".equals(operationType) || "TRF".equals(operationType)) {
            if ("Tax".equals(identityType)) {
                SOAPElement soapBodyElem12 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem12.addTextNode("Tax");
            } else {
                SOAPElement soapBodyElem11 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem11.addTextNode("Citizenship");
                SOAPElement soapBodyElem13 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem13.addTextNode("Family");
                SOAPElement soapBodyElem14 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem14.addTextNode("Address");
            }
            if("KSK".equals(operationType)) {
                SOAPElement soapBodyElem20 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem20.addTextNode("OVMCarInsurancePolicyByIdentityPlate");
                SOAPElement soapBodyElem15 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem15.addTextNode("OVMCarInsurancePolicyByTck");
                SOAPElement soapBodyElem16 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem16.addTextNode("VehicleRegistration");
                SOAPElement soapBodyElem17 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem17.addTextNode("OVMCarInsurancePolicyByChassis");
                SOAPElement soapBodyElem45 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem45.addTextNode("OVMTrafficPolicyByChassisAndIdentity");
            }
            else if("TRF".equals(operationType)) {
                SOAPElement soapBodyElem20 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem20.addTextNode("OVMTrafficPolicyByChassisAndIdentity");
                SOAPElement soapBodyElem16 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem16.addTextNode("VehicleRegistration");
                SOAPElement soapBodyElem19 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem19.addTextNode("TrafficPolicyByTckn");
                SOAPElement soapBodyElem17 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem17.addTextNode("OVMTrafficDamageFileDetail");
            }
        }
        else
        {
            if("KSKREF".equals(operationType)) {
                SOAPElement soapBodyElem11 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem11.addTextNode("OVMCarInsurancePolicyByIdentityPlate");
            }
            else if("KSKNCD".equals(operationType)) {
                SOAPElement soapBodyElem11 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem11.addTextNode("OVMCarInsurancePolicy");
                SOAPElement soapBodyElem12 = soapBodyElem10.addChildElement("OperationType", "lib");
                soapBodyElem12.addTextNode("OVMCarInsurancePolicyDamage");
            }
        }
}
        if(agencyCode != null){
            SOAPElement soapBodyElem2 = soapBodyElem1.addChildElement("agencyCode", "lib");
            soapBodyElem2.addTextNode(agencyCode);
        }
        if(cacheStyle != null){
            SOAPElement soapBodyElem3 = soapBodyElem1.addChildElement("cacheStyle", "lib");
            soapBodyElem3.addTextNode(cacheStyle);
        }
        if(identityType != null){
            SOAPElement soapBodyElem5 = soapBodyElem1.addChildElement("identityType", "lib");
            soapBodyElem5.addTextNode(identityType);
        }


        if(citizenshipNumber != null){
            if(citizenshipNumber.length() == 11) {
                SOAPElement soapBodyElem4 = soapBodyElem1.addChildElement("citizenshipNo", "lib");
                soapBodyElem4.addTextNode(citizenshipNumber);
            }
            else {
                SOAPElement soapBodyElem4 = soapBodyElem1.addChildElement("taxNo", "lib");
                soapBodyElem4.addTextNode(citizenshipNumber);
            }
        }


        if(plateCityCode != null){
            SOAPElement soapBodyElem7 = soapBodyElem1.addChildElement("plateCityCode", "lib");
            soapBodyElem7.addTextNode(plateCityCode);
        }
        if(plateNo != null){
            SOAPElement soapBodyElem8 = soapBodyElem1.addChildElement("plateNo", "lib");
            soapBodyElem8.addTextNode(plateNo);
        }
        if (registrationSerialCode != null){
            SOAPElement soapBodyElem25 = soapBodyElem1.addChildElement("registrationSerialCode", "lib");
            soapBodyElem25.addTextNode(registrationSerialCode);
        }
        if(registrationSerialNo != null){
            SOAPElement soapBodyElem26 = soapBodyElem1.addChildElement("registrationSerialNo", "lib");
            soapBodyElem26.addTextNode(registrationSerialNo);
        }
        if(chassisNo != null){
            SOAPElement soapBodyElem18 = soapBodyElem1.addChildElement("chassisNo", "lib");
            soapBodyElem18.addTextNode(chassisNo);
        }
        SOAPElement soapBodyElem30 = soapBodyElem1.addChildElement("clientAgencyCode", "lib");
        soapBodyElem30.addTextNode("10010");
        SOAPElement soapBodyElem31 = soapBodyElem1.addChildElement("clientUserCode", "lib");
        soapBodyElem31.addTextNode("051-10010");
        SOAPElement soapBodyElem32 = soapBodyElem1.addChildElement("clientCorporationCode", "lib");
        soapBodyElem32.addTextNode("051");
        if(registryDate != null){
            SOAPElement soapBodyElem33 = soapBodyElem1.addChildElement("registryDate", "lib");
            soapBodyElem33.addTextNode(registryDate);
        }
        if(firstRegistrationDate != null){
            SOAPElement soapBodyElem34 = soapBodyElem1.addChildElement("firstRegistrationDate", "lib");
            soapBodyElem34.addTextNode(firstRegistrationDate);
        }
        if(modelYear != null){
            SOAPElement soapBodyElem36 = soapBodyElem1.addChildElement("modelYear", "lib");
            soapBodyElem36.addTextNode(modelYear);
        }
        if(vehicleUsageCode != null){
            SOAPElement soapBodyElem37 = soapBodyElem1.addChildElement("vehicleUsageCode", "lib");
            soapBodyElem37.addTextNode(vehicleUsageCode);
        }

        if(refCorporationCode != null){
            SOAPElement soapBodyElem38 = soapBodyElem1.addChildElement("refCorporationCode", "lib");
            soapBodyElem38.addTextNode(refCorporationCode);
        }
        if(refAgencyCode != null){
            SOAPElement soapBodyElem39 = soapBodyElem1.addChildElement("refAgencyCode", "lib");
            soapBodyElem39.addTextNode(refAgencyCode);
        }
        if(refPolicyNo != null){
            SOAPElement soapBodyElem40 = soapBodyElem1.addChildElement("refPolicyNo", "lib");
            soapBodyElem40.addTextNode(refPolicyNo);
        }
        if(refRenewalNo != null){
            SOAPElement soapBodyElem41 = soapBodyElem1.addChildElement("refRenewalNo", "lib");
            soapBodyElem41.addTextNode(refRenewalNo);
        }

        if(sbmTeklifIslemId != null){
            SOAPElement soapBodyElem42 = soapBodyElem1.addChildElement("sbmTeklifIslemId", "lib");
            soapBodyElem42.addTextNode(sbmTeklifIslemId);
        }
        /**
         * <tem:GetIndividualResult>
         * <tem:req>
         * <wcf:agencyCode>11</wcf:agencyCode>
         * <wcf:cacheStyle>2</wcf:cacheStyle>
         * <wcf:citizenshipNo>23455947492</wcf:citizenshipNo>
         * <wcf:identityType>Citizenship</wcf:identityType>
         * <wcf:operationList>
         * <wcf:OperationType>Citizenship</wcf:OperationType>
         * <wcf:OperationType>Tax</wcf:OperationType>
         * <wcf:OperationType>Family</wcf:OperationType>
         * <wcf:OperationType>Address</wcf:OperationType>
         * <wcf:OperationType>CarInsurancePolicy</wcf:OperationType>
         * </wcf:operationList>
         * <wcf:operationTimeout>3000</wcf:operationTimeout>
         * <wcf:plateCityCode>034</wcf:plateCityCode>
         * <wcf:plateNo>FK3802</wcf:plateNo>
         * <wcf:serviceTimeout>5000</wcf:serviceTimeout>
         * </tem:req>
         * </tem:GetIndividualResult>
         *
         */

        MimeHeaders headers = soapMessage.getMimeHeaders();
        headers.addHeader("SOAPAction", "http://tempuri.org/" + "Tariff/GetIndividualResult");
        //headers.addHeader("Content-Type", "text/xml;charset=windows-1254");
        headers.addHeader("Content-Type", "text/xml;charset=utf-8");
        //windows-1254
        //headers.addHeader("SOAPAction", "http://tempuri.org/"  + "GetIndividualResultResult");
        //headers.addHeader("SOAPAction", "http://schemas.datacontract.org/2004/07/WcfService"  + "GetIndividualResult");
        //hh.addHeader("Content-Type", "text/xml; charset=ISO-8859-1");

        soapMessage.saveChanges();

        return soapMessage;

    }

    private static String getIdentityType(String value){
        if(value.length() == 11 && value.substring(0, 1) == "9")
            return "CitizenshipForeign";
        else if (value.length() == 11)
            return "Citizenship";
        else if (value.length() == 10)
            return "Tax";
        else
            return "Passport";
    }
    /**
     * Sends a SOAP-Request and receives a SOAP-Response
     *
     * @param outputParameterText
     * @param url - Url of the wsdl
     * @param clobXML
     * @return
     * @throws Exception
     */
    public static Clob getResponse(String citizenshipNumber, String plateCityCode, String plateNo, String registrationSerialCode,  String registrationSerialNo, String chassisNo, Clob clobXML, String operationType, String registryDate, String firstRegistrationDate, String modelYear, String vehicleUsageCode, String refCorporationCode, String refAgencyCode, String refPolicyNo, String refRenewalNo, String sbmTeklifIslemId) throws Exception {
        String xmlResponse = null;
        String url = "http://192.168.2.85/TariffService/TariffService.svc";

        String agencyCode = "10010";
        String outputParameterText = "123";
        String cacheStyle = "2";
        String serviceTimeout = "10000";
        Clob rtn = null;
        String result = "";
        String[] outputParameter = null;
        int outputLength = 0;
        String identityType = getIdentityType(citizenshipNumber);
        SOAPMessage xml = getSoapMessageFromString(citizenshipNumber, agencyCode, cacheStyle, identityType, plateCityCode, plateNo, serviceTimeout, registrationSerialCode, registrationSerialNo, chassisNo, operationType, registryDate, firstRegistrationDate, modelYear, vehicleUsageCode, refCorporationCode, refAgencyCode, refPolicyNo, refRenewalNo, sbmTeklifIslemId);

        if (outputParameterText != "") {
            outputParameter = stringToArray(outputParameterText);
            outputLength = outputParameter.length;
        }

        try {
            // Create SOAP Connection
            SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
            SOAPConnection soapConnection = soapConnectionFactory.createConnection();

            //Send SOAP Message to SOAP Server
            SOAPMessage soapResponse = soapConnection.call(xml, url);

            if (outputLength != 0) {
                //Convert SOAPMessage back to String
                ByteArrayOutputStream baos = null;

                try {
                    baos = new ByteArrayOutputStream();
                    soapResponse.writeTo(baos);
                    xmlResponse = baos.toString("utf-8");
                    xmlResponse = xmlResponse.replace("&lt;", "<");
                    xmlResponse = xmlResponse.replace("&gt;&#xD;", ">");
                    xmlResponse = xmlResponse.replace("&gt;", ">");
/*                    xmlResponse = xmlResponse.replace("????", "??");
                    xmlResponse = xmlResponse.replace("??", "??");
                    xmlResponse = xmlResponse.replace("??", "??");
                    xmlResponse = xmlResponse.replace("????", "??");
                    xmlResponse = xmlResponse.replace("??", "??");
                    xmlResponse = xmlResponse.replace("???", "??");
                    xmlResponse = xmlResponse.replace("?????", "??");
                    */
                } catch (Exception e) {
                    xmlResponse = "Exception during SOAP to String: " + e.toString();
                }

                // Check if an error exists
                if (xmlResponse.contains("faultcode")) {
                    String[] beforeFaultcode = xmlResponse.split("<faultcode>");
                    String[] afterFaultcode = beforeFaultcode[1].split("</faultcode>");
                    result = result + "faultcode: " + afterFaultcode[0] + "; \n";
                }
                if (xmlResponse.contains("faultstring")) {
                    String[] beforeFaultstring = xmlResponse.split("<faultstring>");
                    String[] afterFaultstring = beforeFaultstring[1].split("</faultstring>");
                    result = result + "faultstring: " + afterFaultstring[0] + "; \n";
                }

                // If an error exists
                if (result != "") {
                    soapConnection.close();
                } // If no error exists
                else {
                    // Extract chosen output variables
                    try {
                        for (int i = 0; i <= outputLength - 1; i++) {
                            String[] vorErgebnis = xmlResponse.split("<" + outputParameter[i] + ">");
                            String[] nachErgebnis = vorErgebnis[1].split("</" + outputParameter[i] + ">");
                            result = result + outputParameter[i] + ": " + nachErgebnis[0] + "; \n";
                        }
                    } catch (Exception e) {
                    }
                    soapConnection.close();
                }
            } else {
                soapConnection.close();
            }
        } catch (Exception e) {
            xmlResponse = "Exception during the SOAP-Connection: " + e.toString();
        }
        clobXML.truncate(0);
        clobXML.setString(1, xmlResponse);

        rtn = clobXML;
        return rtn;

    }

    /**
     * Transforms a String to an Array. The separation of an element with ";;"
     *
     * @param transform
     * @return
     */
    public static String[] stringToArray(String transform) {
        String[] toArray = transform.split(";;");;
        return toArray;
    }

    /**
     * Converts a CLOB to a String
     *
     * @param data
     * @return
     */
    public static String clobToString(Clob data) {
        final StringBuilder sb = new StringBuilder();
        String result = "";
        try {
            final Reader reader = data.getCharacterStream();
            final BufferedReader br = new BufferedReader(reader);

            int b;
            while (-1 != (b = br.read())) {
                sb.append((char) b);
            }
            br.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }
}
