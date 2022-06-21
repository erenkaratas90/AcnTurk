CREATE OR REPLACE PACKAGE TNSWIN.gettariff AS
/*
    TYPE sRecord IS RECORD(
       m1 decimal(11,5),
       m2 decimal(11,5),
       m3 decimal(11,5),
       m4 decimal(11,5),
       m5 decimal(11,5),
       m6 decimal(11,5),
       prim decimal(11,5));
*/ 
    TYPE sRecordx IS RECORD(
        priceId VARCHAR2(15),
       m1 decimal(15,5),
       m2 decimal(15,5),
       m3 decimal(15,5),
       m4 decimal(15,5),
       m5 decimal(15,5),
       m6 decimal(15,5),
       prim decimal(15,5));

    type refCursorxx is ref cursor;

    TYPE sTablex IS TABLE OF sRecordx;
--    TYPE sTable IS TABLE OF sRecord;
    TYPE sonuc_tb IS TABLE OF tariff_result;

    FUNCTION getKaskoGelirKaybiPrim(p_tarifeTarihi date, p_kullanimSekli char)
        RETURN NUMBER;

    FUNCTION getKaskoHukuksalKorumaPrim(p_tarifeTarihi date)
        RETURN NUMBER;

    FUNCTION getKaskoMiniOnarimPrim(p_tarifeTarihi date, p_product_no varchar2, p_kullanimSekli varchar2, p_aracSegment varchar2)
        RETURN NUMBER;

    FUNCTION getKaskoYanlisAkaryakitPrim(p_tarifeTarihi date, p_kullanimSekli varchar2)
        RETURN NUMBER;

    FUNCTION getKaskoYolYardimPrim(p_tarifeTarihi date, p_kullanimSekli varchar2, p_kullanimTipi varchar2, p_yardimAlternatifTeminat varchar2)
        RETURN NUMBER;

    FUNCTION getKaskoTasinanEmteaFiyati(p_tarifeTarihi date, p_tasinanEmtiaCinsi varchar2)
        RETURN NUMBER;

    FUNCTION getKaskoSesGoruntuCihaziFiyati(p_tarifeTarihi date)
        RETURN NUMBER;

    FUNCTION getKaskoSigortaliFKPrim(p_tarifeTarihi date, p_fkSigortaliTeminatLimiti number)
        RETURN NUMBER;

    FUNCTION getKaskoFKPrim(p_tarifeTarihi date, p_kullanimSekli varchar2, p_koltukSayisi varchar2, p_fksigortaliTeminatLimiti varchar2, p_fkKoltukTeminatLimiti varchar2)
        RETURN NUMBER;

    FUNCTION getKaskoIMMPrim(p_tarifeTarihi date, p_kullanimSekli char, p_immSorumlulukLimiti varchar2, p_maneviTazminat varchar2)
        RETURN NUMBER;

    PROCEDURE addTestLog (s_sql CLOB);

    /*********************************************************************************************************************************************************************/
    /*********************************************************************************************************************************************************************/

    FUNCTION getKaskoReferansPolice(p_pricingId number, p_kimlikNo varchar2, p_plakaIlKodu varchar2, p_plakaNo varchar2)
        RETURN VARCHAR2;

    FUNCTION getKaskoHasarsizlik(p_pricingId NUMBER, p_kimlikNo varchar2, p_referansSirket varchar2, p_referansAcente varchar2, p_referansPoliceNo varchar2, p_referansYenilemeNo varchar2)
        RETURN VARCHAR2;

    PROCEDURE addMotorNcdLog(p_pricingId NUMBER, p_reference_id VARCHAR2, p_kimlikNo VARCHAR2, system_date varchar2, system_time varchar2, S_FONK_BEG_TIME varchar2, S_FONK_END_TIME varchar2, s_hasarsizlik NUMBER, clob_sbmValues CLOB, v_error_msg VARCHAR2, s_case1 NUMBER, s_case2 NUMBER, s_case3 NUMBER, s_case4 NUMBER, s_case5 NUMBER, s_zeylTuru VARCHAR2, s_policebaslamatarihi VARCHAR2, s_policebitistarihi VARCHAR2, s_policeekibaslamatarihi VARCHAR2, s_aractarifegrupkodu VARCHAR2, s_uygulananKademeSBM VARCHAR2, s_uygulananKademeLBR NUMBER, s_hasarSayisi NUMBER, s_camHasarSayisi NUMBER, s_ruculuHasarSayisi NUMBER, s_nihaiHasarSayisi NUMBER, s_redIptalHasarsayisi NUMBER, s_miniOnarimHasarsayisi NUMBER);

    PROCEDURE addMotorRefPolicyLog (p_pricing_id NUMBER, p_kimlikNo VARCHAR2, p_plakaIlKodu VARCHAR2, p_plakaNo VARCHAR2, system_date VARCHAR2, system_time VARCHAR2, s_fonk_beg_time VARCHAR2, s_fonk_end_time VARCHAR2, clob_sbmvalues CLOB, v_error_msg VARCHAR2, s_sirketKodu VARCHAR2, s_acenteNo VARCHAR2, s_policeNo VARCHAR2, s_yenilemeno VARCHAR2, s_aracTarifeGrupKodu VARCHAR2, s_policeBitisTarihi VARCHAR2, s_aracMarkaKodu VARCHAR2,s_aracTipKodu VARCHAR2);

    FUNCTION getKSKGenelBilgi (p_kimlikNo varchar2, p_xml_value in CLOB)
        RETURN VARCHAR2;

    FUNCTION getKSKHasarSayisi (p_kimlikNo varchar2, p_plakaIlKodu varchar2, p_plakaNo varchar2, p_xml_value in CLOB)
        RETURN VARCHAR2;

    FUNCTION getKSKDonemselHasarSayisi (p_kimlikNo varchar2, p_plakaIlKodu varchar2, p_plakaNo varchar2, p_xml_value in CLOB, p_geriyegunbasla NUMBER, p_geriyegunbitis NUMBER)
    RETURN VARCHAR2;

    FUNCTION getTariffCheck(priceId varchar2)
        RETURN sTablex
        PIPELINED;

    /*********************************************************************************************************************************************************************/
    /*********************************************************************************************************************************************************************/

    FUNCTION getTariff(productNo varchar2, tariffDate varchar2, kullanimsekli varchar2, kullanimtarzi varchar2, aracyasi varchar2, plakailkodu varchar2, tramerilce varchar2, yenilemeyeniiskod varchar2, sigortaliyas varchar2, aracbedeli varchar2, yakittipi varchar2, medenidurum varchar2, cocukdegiskeni varchar2, kismiHasarSayisi varchar2, sigortaliliksuresi varchar2, cinsiyet varchar2, hasarsizlikkademesi varchar2, markariskgrubu varchar2, camhasarsayisi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, filosegment varchar2, guncelbedel varchar2, sigortaliskor number, aracskor varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, markakodu varchar2)
        RETURN sTablex
        PIPELINED;
    FUNCTION getTariffSbm(productNo varchar2, tariffDate varchar2, kimlikNo varchar2, sasiNo varchar2, tescilSeriKod varchar2, tescilSeriNo varchar2, plakailkodu varchar2, plakaNo varchar2, aracbedeli varchar2, hasarsizlikkademesi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, guncelbedel varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, asbisNo varchar2, tescilTarihi VARCHAR2, trafigeCikisTarihi VARCHAR2)
        RETURN sTablex
        PIPELINED;
    FUNCTION getTariffMain(productNo varchar2,TariffDate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,tescilTarihi varchar2,trafigeCikisTarihi varchar2,referansPoliceBilgileri varchar2,kullanimSekli varchar2,model varchar2,markaTipKodu varchar2,hasarsizlikKademesi varchar2,yakitTipi varchar2,aracBedeli varchar2,kasaBedeli varchar2,tasinanEmtiaBedeli varchar2,tasinanEmtiaCinsi varchar2,sesGoruntuCihaziBedeli varchar2,digerAksesuarBedeli varchar2,yurtDisiTeminatiSuresi varchar2,trafikKademesi varchar2,paketTipi varchar2,kullanimTipi varchar2,OzelIndirim number,surprim number,meslek varchar2, kullanimTarzi varchar2, kiymetKazanma varchar2, sigortaliliksuresi number, kismihasarsayisi varchar2, camhasarsayisi varchar2, minimumFiyatKorunsunMu varchar2, minimumPrimKorunsunMu varchar2, acente varchar2, kullaniciAdi varchar2, referancePriceId varchar2, camMuafiyetIstisnasi varchar2, yenilemePrimKontroluCalissinMi varchar2, immSorumlulukTeminatLimiti varchar2, fkSigortaliTeminatLimiti varchar2, fkKoltukTeminatLimiti varchar2, maneviTazminatLimiti varchar2, koltukSayisi varchar2, YolYardimAlternatifTeminat varchar2)
        RETURN sTablex
        PIPELINED;

    FUNCTION getMaxYetkiliIndirimi(productNo varchar2,TariffDate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,tescilTarihi varchar2,trafigeCikisTarihi varchar2,referansPoliceBilgileri varchar2,kullanimSekli varchar2,model varchar2,markaTipKodu varchar2,hasarsizlikKademesi varchar2,yakitTipi varchar2,aracBedeli varchar2,kasaBedeli varchar2,tasinanEmtiaBedeli varchar2,tasinanEmtiaCinsi varchar2,sesGoruntuCihaziBedeli varchar2,digerAksesuarBedeli varchar2,yurtDisiTeminatiSuresi varchar2,trafikKademesi varchar2,paketTipi varchar2,kullanimTipi varchar2,OzelIndirim number,surprim number,meslek varchar2, kullanimTarzi varchar2, kiymetKazanma varchar2, sigortaliliksuresi number, kismihasarsayisi varchar2, camhasarsayisi varchar2, minimumFiyatKorunsunMu varchar2, minimumPrimKorunsunMu varchar2, acente varchar2, kullaniciAdi varchar2, referancePriceId varchar2, camMuafiyetIstisnasi varchar2, yenilemePrimKontroluCalissinMi varchar2, immSorumlulukTeminatLimiti varchar2, fkSigortaliTeminatLimiti varchar2, fkKoltukTeminatLimiti varchar2, maneviTazminatLimiti varchar2, koltukSayisi varchar2, YolYardimAlternatifTeminat varchar2)
        RETURN number;

    FUNCTION getTariffKsk(productNo varchar2,TariffDate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,tescilTarihi varchar2,trafigeCikisTarihi varchar2,referansPoliceBilgileri varchar2,kullanimSekli varchar2,model varchar2,markaTipKodu varchar2,hasarsizlikKademesi varchar2,yakitTipi varchar2,aracBedeli varchar2,kasaBedeli varchar2,tasinanEmtiaBedeli varchar2,tasinanEmtiaCinsi varchar2,sesGoruntuCihaziBedeli varchar2,digerAksesuarBedeli varchar2,yurtDisiTeminatiSuresi varchar2,trafikKademesi varchar2,paketTipi varchar2,kullanimTipi varchar2,OzelIndirim number,surprim number,meslek varchar2, kullanimTarzi varchar2, kiymetKazanma varchar2, sigortaliliksuresi number, kismihasarsayisi varchar2, camhasarsayisi varchar2, minimumFiyatKorunsunMu varchar2, minimumPrimKorunsunMu varchar2, acente varchar2, kullaniciAdi varchar2, referancePriceId varchar2, camMuafiyetIstisnasi varchar2, yenilemePrimKontroluCalissinMi varchar2, immSorumlulukTeminatLimiti varchar2, fkSigortaliTeminatLimiti varchar2, fkKoltukTeminatLimiti varchar2, maneviTazminatLimiti varchar2, koltukSayisi varchar2, YolYardimAlternatifTeminat varchar2, garaj varchar2, resmidaire varchar2, servis varchar2, muafiyet varchar2, anlasmaliServis varchar2, parcaTuru varchar2, servisTuru varchar2, surucu1 varchar2, surucu2 varchar2, channel varchar2, araccoklugu varchar2)
        RETURN stablex
        PIPELINED;
    FUNCTION getTariffTRF(productNo varchar2,TariffDate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,tescilTarihi varchar2,trafigeCikisTarihi varchar2,    kullanimSekli varchar2,model varchar2,markaTipKodu varchar2,kaskoHasarsizlikKademesi varchar2,yakitTipi varchar2,trafikKademesi varchar2, sigortaliliksuresi number, kismihasarsayisi varchar2,oncekiTrafikKademesi varchar2,hatliMi varchar2, gecikmeSurprimi varchar2, yenilemeYili varchar2,  acente varchar2, kullaniciAdi varchar2, referancePriceId varchar2)
        RETURN sTablex
        PIPELINED;
    FUNCTION getTariffMainSeyahat(tariffDate varchar2,yas varchar2,teminatTipi varchar2,cografiAlan varchar2,ekTeminat varchar2,seyahatSuresi varchar2,acenteKodu varchar2)
        RETURN NUMBER;
    FUNCTION getTariffMainDogalgaz(tariffDate varchar2, gazDagitimSirketKodu varchar2, sigortaBedeli number)
        RETURN NUMBER;
    FUNCTION kasko_debug(kullanimsekli varchar2, kullanimtarzi varchar2, aracyasi varchar2, plakailkodu varchar2, tramerilce varchar2, yenilemeyeniiskod varchar2, sigortaliyas varchar2, aracbedeli varchar2, yakittipi varchar2, medenidurum varchar2, cocukdegiskeni varchar2, kismiHasarSayisi varchar2, sigortaliliksuresi varchar2, cinsiyet varchar2, hasarsizlikkademesi varchar2, markariskgrubu varchar2, camhasarsayisi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, filosegment varchar2, guncelbedel varchar2, sigortaliskor number, aracskor varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, markakodu varchar2)
        RETURN sonuc_tb
        PIPELINED;

    FUNCTION getactivefactorsql1(priceid number, productNoo varchar2, TariffDate date,kullanimsekli varchar2, kullanimtarzi varchar2, aracyasi varchar2, plakailkodu varchar2, tramerIl varchar2, tramerilce varchar2, yenilemeyeniiskod varchar2, sigortaliyas varchar2, aracbedeli varchar2, yakittipi varchar2, medenidurum varchar2, cocukdegiskeni varchar2, kismiHasarSayisi varchar2, sigortaliliksuresi varchar2, cinsiyet varchar2, hasarsizlikkademesi varchar2, markariskgrubu varchar2, camhasarsayisi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, filosegment varchar2, guncelbedel varchar2, sigortaliskor number, aracskor varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, markakodu varchar2, yeniaracbedel number, meslek varchar2 , markatipkodu varchar2, trafikkademesi varchar2, commercialScore varchar2, kiymetKazanma varchar2, ilkAracYasi varchar2, plaka100502 varchar2, ozelTuzel varchar2, ticariFaktor varchar2, P_WHP VARCHAR2, p_aracSegment varchar2, p_kasaTipi varchar2, camMuafiyetIstisnasi varchar2,p_cocukSayisi varchar2,p_hasarSayisi varchar2, oncekitrafikkademesi varchar2,hatliMi varchar2, gecikmeSurprimi varchar2, yenilemeYili varchar2, trfFrekans varchar2, p_trafikKayitliAracSayisi NUMBER, p_aracSayisiKimlik NUMBER,p_yasayanOtoUrun varchar2,p_teenCocuk varchar2,p_ErkekTeenCocuk varchar2,p_pertarac varchar2,p_aracyerliyabanci varchar2, p_garaj varchar2, p_resmidaire varchar2, p_Servis varchar2, p_muafiyet varchar2, p_anlasmaliServis varchar2, p_parcaTuru varchar2, p_servisTuru varchar2, p_surucuInd varchar2, channel varchar2, araccoklugu varchar2, acenteCarpan varchar2, aracyasgrubu varchar2, kontrol1 varchar2, kontrol2 varchar2, kontrol3 varchar2, kontrol4 varchar2, s8000 varchar2, s8060 varchar2, kontrol5 varchar2, eurocar_segment varchar2, eurocar_kasatipi varchar2, eurocar_sanziman varchar2, NBRENEWAL2 varchar2, markaTipGrup varchar2, ililcegrup varchar2, birYilOncekiHasar varchar2, ikiYilOncekiHasar varchar2, ucYilOncekiHasar varchar2, p_aracBedelGrubu varchar2, p_ortalamaHasarTutar1 varchar2,p_ortalamaHasarTutar2 varchar2,p_ortalamaHasarTutar3 varchar2, p_sonUcYilHasarSayisi varchar2, p_bifurcationSegment varchar2, p_bifurcationSubSegment varchar2)
        RETURN CLOB;
    FUNCTION getVariableDetail(varIable varchar2,kullanImseklI varchar2,kullanImtarzI varchar2,aracyasI varchar2,plakaIlkodu varchar2,tramerIl varchar2,tramerIlce varchar2,yenIlemeyenIIskod varchar2,sIgortalIyas varchar2,aracbedelI varchar2,yakIttIpI varchar2,medenIdurum varchar2,cocukdegIskenI varchar2,kIsmIHasarSayIsI varchar2,sIgortalılıksuresI varchar2,cInsIyet varchar2,kaskoHasarsIzlIkkademesI varchar2,markarIskgrubu varchar2,camhasarsayIsI varchar2,pakettIpI varchar2,yenIlemecamIndIrImI varchar2,fIlosegment varchar2,guncelbedel varchar2,sIgortalIskor varchar2,aracskor varchar2,surprIm varchar2,ozelIndIrIm varchar2,kullanImtIpI varchar2,yurtdIsIay varchar2,markakodu varchar2,yeniaracbedel varchar2, meslek varchar2, markatipkodu varchar2, trafikkademesi varchar2, commercialScore varchar2, kiymetKazanma varchar2, ilkAracYasi varchar2, plaka100502 varchar2, ozelTuzel varchar2, ticariFaktor varchar2, P_WHP VARCHAR2, p_aracSegment varchar2, p_kasaTipi varchar2, camMuafiyetIstisnasi varchar2, p_cocukSayisi varchar2,p_hasarSayisi varchar2, oncekitrafikkademesi varchar2,hatliMi varchar2, gecikmeSurprimi varchar2, yenilemeYili varchar2, trfFrekans varchar2, p_trafikKayitliAracSayisi NUMBER, p_aracSayisiKimlik NUMBER,p_yasayanOtoUrun varchar2,p_teenCocuk varchar2,p_ErkekTeenCocuk varchar2,p_pertarac varchar2,productNoo varchar2, p_aracyerliyabanci varchar2, p_garaj varchar2, p_resmidaire varchar2, p_servis varchar2, p_muafiyet varchar2, p_anlasmaliServis varchar2, p_parcaTuru varchar2, p_servisTuru varchar2, p_surucuInd varchar2, channel varchar2, araccoklugu varchar2, acenteCarpan varchar2, aracYasGrubu varchar2, kontrol1 varchar2, kontrol2 varchar2, kontrol3 varchar2, kontrol4 varchar2, s8000 varchar2, s8060 varchar2, kontrol5 varchar2, eurocar_segment varchar2, eurocar_kasatipi varchar2, eurocar_sanziman varchar2, NBRENEWAL2 varchar2, markaTipGrup varchar2, ililcegrup varchar2, birYilOncekiHasar varchar2, ikiYilOncekiHasar varchar2, ucYilOncekiHasar varchar2, p_aracBedelGrubu varchar2,p_ortalamaHasarTutar1 varchar2,p_ortalamaHasarTutar2 varchar2,p_ortalamaHasarTutar3 varchar2, p_sonUcYilHasarSayisi varchar2, p_bifurcationSegment varchar2, p_bifurcationSubSegment varchar2)
        RETURN VARCHAR2;
    FUNCTION getCocukDegiskeni (value in CLOB, teklifBaslangicTarihi in DATE)
        RETURN VARCHAR2;
    FUNCTION getCocukSayisi (value in CLOB, teklifBaslangicTarihi in DATE)
        RETURN VARCHAR2;
    FUNCTION getHasarSayisi (value in CLOB)
        RETURN NUMBER;
    FUNCTION getSbmDetails (value in CLOB, returnType in VARCHAR2)
        RETURN CLOB;
    FUNCTION removeElement (value in VARCHAR2, elementName in VARCHAR2)
        RETURN VARCHAR2;
    FUNCTION getaracskor (value CLOB,p_egmKaydiVarMi in varchar2,yenilemeMi in varchar2,p_HasarslkIndrm VARCHAR2,p_PolBasTarh in DATE ,p_TesclTarh in DATE,p_TrafkCksTarh in DATE,p_ModelYl in varchar2,p_Plaka in varchar2 ,s_PricingId NUMBER)
         RETURN VARCHAR2;
    FUNCTION getTariffSqlDetail (s_fsql in CLOB,s_variable in VARCHAR2,s_dataType in VARCHAR2,s_operator in VARCHAR2,s_var in VARCHAR2,s_condition in VARCHAR2,s_targetValue in VARCHAR2,s_parameterName in VARCHAR2,s_parameterColumnName1 in VARCHAR2,s_parameterOperator1 in VARCHAR2,s_var1 in VARCHAR2,s_parameterColumnName2 in VARCHAR2,s_parameterOperator2 in VARCHAR2,s_var2 in VARCHAR2)
        RETURN CLOB;
    FUNCTION getSigortaliSkor (s_PricingId in NUMBER, p_xml_value in CLOB, kimlikNo in varchar2, p_tariffDate in Date, p_aracTarifeGrupKodu in varchar2, p_hasarsizlikKademesi in number)
        RETURN NUMBER;
    PROCEDURE addTariffLog(s_productNo VARCHAR2, s_tariffdate VARCHAR2, s_kimlikNo VARCHAR2, s_sasiNo VARCHAR2, s_tescilSeriKod VARCHAR2, s_tescilSeriNo VARCHAR2, s_plakailkodu VARCHAR2, s_plakaNo VARCHAR2, s_asbisNo varchar2, s_tescilTarihi VARCHAR2, s_trafigeCikisTarihi VARCHAR2, s_PricingId NUMBER, s_PriceType VARCHAR2, s_errorDesc VARCHAR2, s_ssql CLOB, p_cocukdegiskeni VARCHAR2, p_sigortaliyas VARCHAR2, p_aracyasi VARCHAR2, p_kullanimtarzi VARCHAR2, p_kullanimsekli VARCHAR2, p_aracskor VARCHAR2, p_cinsiyeti VARCHAR2, p_medenihali VARCHAR2, p_tramerilce VARCHAR2, p_sigortaliskor VARCHAR2, s_systemdate varchar2, s_systemtime varchar2, p_yakittipi VARCHAR2, p_markakodu VARCHAR2, p_aracbedeli VARCHAR2,p_filosegment VARCHAR2,p_markariskgrubu VARCHAR2,p_yenilemeyeniiskod VARCHAR2,  p_kismihasarsayisi VARCHAR2,  p_sigortaliliksuresi VARCHAR2,  p_camhasarsayisi VARCHAR2, s_PricingType VARCHAR2, s_m1 NUMBER, s_m2 NUMBER, s_m3 NUMBER, s_m4 NUMBER, s_m5 NUMBER, s_m6 NUMBER, p_sql CLOB,       p_markatipkodu VARCHAR2,      p_minimumfiyat VARCHAR2,      p_minimumprim VARCHAR2,      p_meslek VARCHAR2,      p_ilkAracBedeli VARCHAR2,p_kasaBedeli VARCHAR2,      p_digerAksesuarBedeli VARCHAR2,      p_sesGoruntuCihazBedeli VARCHAR2, p_commercialScore VARCHAR2,p_kiymetKazanma varchar2, p_ilkAracYasi varchar2,p_commercialScoreId varchar2,p_gecmisHasarSayisi varchar2,      p_gecmisHasarsizlikIndirimi varchar2,      p_gecmisPoliceFiyat varchar2,      p_yenilemeCapMin varchar2,      p_yenilemeCapMax varchar2, p_sbm clob,p_capMin varchar2,p_capMax varchar2,P_WHP VARCHAR2,acente varchar2,kullaniciAdi varchar2,HasarsizlikKademesi varchar2, OzelIndirim varchar2, surprim varchar2, p_capPolice varchar2, p_refpriceid varchar2, trafikHasarsizlikKademesi varchar2,p_karaListeKontrol VARCHAR2, p_bedeniWinsureKontrol VARCHAR2, p_bedeniAS400Kontrol VARCHAR2, p_ofacKontrol VARCHAR2, auth varchar2, cache_key varchar2, status varchar2, s_m7 NUMBER, s_m8 NUMBER, s_m9 NUMBER, s_m10 NUMBER, s_m11 NUMBER, s_m12 NUMBER, s_m13 NUMBER, s_m14 NUMBER, s_m15 NUMBER, s_m16 NUMBER,s_m17 NUMBER,s_m18 NUMBER,      s_toplamprim number,      s_toplamprimcap number, s_otorNihaiHasarAdet number, s_gecmisServisTuru varchar2, p_birYilOncekiHasarTutariArac varchar2,p_ozelTuzel varchar2, p_oncekiTrafikKademesi varchar2, p_gecikmeSurprimi varchar2, p_trfFrekans varchar2, p_trafikKayitliAracSayisi varchar2, p_markaTipGrup varchar2, p_ilIlcegrup varchar2, birYilOncekiHasar varchar2, ikiYilOncekiHasar varchar2, ucYilOncekiHasar varchar2, sonUcYilHasarSayisi varchar2, p_m19 number);

    PROCEDURE addYetkiliIndLog(s_price_id NUMBER, s_biryiloncekihasar varchar2, s_ikiyiloncekihasar varchar2, s_ucyiloncekihasar varchar2, s_maxindirim number, s_yenilemeyeniiskod varchar2, s_kullaniciadi varchar2, s_cacheKey varchar2);

    FUNCTION getYenilemeYeniIsKod (tariffDate varchar2, clob_tcknPlakaSorgu in CLOB, sasi varchar2, plakaNo varchar2, kimlikno varchar2)
        RETURN VARCHAR2;
    FUNCTION getTRFYenilemeYil (p_xml_value in CLOB)
        RETURN NUMBER;
    FUNCTION getTRFSigortalilikSuresi (p_xml_value in CLOB)
        RETURN NUMBER;
    FUNCTION getSonTRFPoliceKademe (p_xml_value in CLOB)
        RETURN NUMBER;
    FUNCTION getTRFGecikmeSurprimi (p_system_date in date, p_registry_date in date, p_type varchar2)
        RETURN NUMBER;
    FUNCTION  getTariffDetay(productNoo varchar2, TariffDate IN date,kullanimsekli varchar2, kullanimtarzi varchar2, aracyasi varchar2, plakailkodu varchar2, tramerIl  varchar2, tramerilce varchar2, yenilemeyeniiskod varchar2, sigortaliyas varchar2, aracbedeli varchar2, yakittipi varchar2, medenidurum varchar2, cocukdegiskeni varchar2, kismiHasarSayisi varchar2, sigortaliliksuresi varchar2, cinsiyet varchar2, hasarsizlikkademesi varchar2, markariskgrubu varchar2, camhasarsayisi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, filosegment varchar2, guncelbedel varchar2, sigortaliskor number, aracskor varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, markakodu varchar2, yeniaracbedel number , meslek varchar2, markatipkodu varchar2, trafikkademesi varchar2, commercialScore varchar2, kiymetKazanma varchar2, ilkAracYasi varchar2, plaka100502 varchar2, ozelTuzel varchar2, ticariFaktor varchar2, P_WHP VARCHAR2,p_aracsegment varchar2, p_kasaTipi varchar2, camMuafiyetIstisnasi varchar2, p_cocukSayisi varchar2,p_hasarSayisi varchar2, oncekitrafikkademesi varchar2,hatliMi varchar2, gecikmeSurprimi varchar2, yenilemeYili varchar2, trfFrekans varchar2,p_trafikKayitliAracSayisi NUMBER, p_aracSayisiKimlik NUMBER,p_yasayanOtoUrun varchar2,p_teenCocuk varchar2,p_ErkekTeenCocuk varchar2,p_pertarac varchar2, p_aracyerliyabanci varchar2, p_garaj varchar2, p_resmidaire varchar2, p_servis varchar2, p_muafiyet varchar2, p_anlasmaliServis varchar2, p_parcaTuru varchar2, p_servisTuru varchar2, p_surucuInd varchar2, channel varchar2, araccoklugu varchar2, acentecarpan varchar2, aracYasGrubu varchar2, kontrol1 varchar2, kontrol2 varchar2, kontrol3 varchar2, kontrol4 varchar2, s8000 varchar2, s8060 varchar2, kontrol5 varchar2, eurocar_segment varchar2, eurocar_kasatipi varchar2, eurocar_sanziman varchar2, NBRENEWAL2 varchar2, markaTipGrup varchar2, ililcegrup varchar2, birYilOncekiHasar varchar2, ikiYilOncekiHasar varchar2, ucYilOncekiHasar varchar2, p_aracBedelGrubu varchar2, p_ortalamaHasarTutar1 varchar2,p_ortalamaHasarTutar2 varchar2,p_ortalamaHasarTutar3 varchar2, p_sonUcYilHasarSayisi varchar2, p_bifurcationSegment varchar2, p_bifurcationSubSegment varchar2)
        RETURN CLOB;
    FUNCTION getPlaka100502 (productNo in varchar2,tariffdate varchar2,kullanimSekli in varchar2,plakaIlKodu in varchar2,plakaNo in varchar2)
        RETURN VARCHAR2;
    FUNCTION getTrfYenilemeYeniIsKod (tariffDate varchar2,clob_KimlikSasiSorgu in CLOB,sasi VARCHAR2,plakaNo VARCHAR2,kimlikNo VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION fncgeciciplaka (plk IN VARCHAR2)
        RETURN number;

    FUNCTION getTRFDonemselHasarSayisi (p_kimlikNo varchar2, p_plakaIlKodu varchar2, p_plakaNo varchar2, p_xml_value in CLOB, p_geriyegunbasla NUMBER, p_geriyegunbitis NUMBER)
        RETURN VARCHAR2;

    FUNCTION fncTrafikKayitliAracSayisi (kimlikNo IN VARCHAR2)
        RETURN number;
    FUNCTION fncOfacKontrol (sbmSorgu IN CLOB, kimlikNo VARCHAR2, operationType varchar2)
        RETURN number;

    FUNCTION getTrafikSigortaliSkor (p_PricingId in NUMBER, p_xml_value in CLOB, p_kimlikNo in VARCHAR2, p_tariffDate in DATE, p_aracTarifeGrupKodu in VARCHAR2, p_hasarsizlikKademesi in NUMBER)
        RETURN NUMBER;

    FUNCTION getYasayanOtoUrun (kimlikNo IN VARCHAR2, sasiNo in varchar2, tariffDate date)
        RETURN varchar2;

    FUNCTION getPertHasar (sbmSorgu IN CLOB)
        RETURN varchar2;

    FUNCTION getTeenCocuk (value in CLOB,teklifBaslangicTarihi in DATE)
    RETURN VARCHAR2;

    FUNCTION getErkekTeenCocuk (value in CLOB,teklifBaslangicTarihi in DATE)
    RETURN VARCHAR2;

    PROCEDURE addTrafficInsuredScoreLog (p_PricingId NUMBER, p_kimlikNo VARCHAR2, systemDate VARCHAR2, systemTime VARCHAR2, p_xml_value CLOB, p_tariffDate DATE, p_aracTarifeGrupKodu VARCHAR2, p_hasarsizlikKademesi NUMBER, s_SigortaliSkor NUMBER, s_Kademe_FX_Faktoru NUMBER, s_MHS_Faktoru NUMBER, s_AKPS NUMBER, s_Frekans NUMBER, s_AynıDonemMaxHasarSayisi NUMBER, s_PoliceYilSayisi NUMBER, s_ToplamHasarSayisi NUMBER , s_HasarYilSayisi NUMBER, s_KPS NUMBER, s_AHS NUMBER, s_Fx_Ust_Limit NUMBER, s_policeSuresiBasinaHasSay NUMBER, s_year_list VARCHAR2, s_AkpsKontrolOrani NUMBER, s_AracTipKontrol NUMBER, v_error_msg VARCHAR2,s_cache NUMBER, s_sql CLOB, s_Fonk_Beg_Time VARCHAR2, s_Fonk_End_Time VARCHAR2, s_KPS_Admitted NUMBER, s_Mhs_Kademe_Admitted NUMBER, s_PoliceYilSayisi_Admitted NUMBER);

    PROCEDURE addTrafficInsuredScoreLogCache (ss_PriceId NUMBER, ss_xml_value CLOB, ss_sql CLOB);

    PROCEDURE addInsuredScoreLog (s_PricingId NUMBER, kimlikno VARCHAR2, systemDate VARCHAR2, systemTime VARCHAR2, p_xml_value CLOB, p_tariffDate DATE, p_aracTarifeGrupKodu VARCHAR2, p_hasarsizlikKademesi NUMBER, s_sigortaliskor NUMBER, s_fx NUMBER, s_mhs NUMBER, s_akps NUMBER, s_fonk1 NUMBER, s_fonk2 NUMBER, s_kazanilmispolice NUMBER, s_skoratabihasarlar NUMBER, s_rucusuzhasarlar NUMBER, s_yururpoliceler NUMBER, s_camhasarsayisi NUMBER, s_mintutarhasarsayisi NUMBER, s_hasarsayisi NUMBER, s_year1 NUMBER, s_year2 NUMBER, s_year3 NUMBER, s_year4 NUMBER, s_year5 NUMBER, s_sigarackontrol  NUMBER, s_minimumhasartutari  NUMBER, s_AkpsKontrolOrani NUMBER, v_errm VARCHAR2, p_sql CLOB);

    PROCEDURE addInsuredScoreLogCache (s_PriceId NUMBER, s_xml_value CLOB, s_sql CLOB);

    PROCEDURE addAracSkorLog (p_HasarslkIndrm VARCHAR2,p_PolBasTarh VARCHAR2, p_TesclTarh VARCHAR2,p_TrafkCksTarh VARCHAR2, p_ModelYl VARCHAR2, p_Plaka VARCHAR2,v_PolBasFarkPreBts VARCHAR2,v_aracSifirKmMi VARCHAR2,v_geciciPlakaMi VARCHAR2, yenilemeMi VARCHAR2,v_asbisRuhsatVarMi VARCHAR2,v_yeniSatinAlinmisMi VARCHAR2,v_surekliSigortaliMi VARCHAR2, v_sigortasizliksuresi VARCHAR2,p_PrePolBtsTarh  VARCHAR2,AP VARCHAR2,APP VARCHAR2,v_sigortaKaydiVarMi VARCHAR2,s_PricingId NUMBER,s_key varchar2,p_sql CLOB,v_errm VARCHAR2) ;

    PROCEDURE addAracSkorLogCache (s_PricingId NUMBER, s_sql CLOB);

    PROCEDURE addLog (s_priceid VARCHAR2, s_error VARCHAR2, p_error varchar2);
    
    --PROCEDURE addLog_IA (s_priceid VARCHAR2, s_error VARCHAR2, p_error varchar2, p_clob clob);

    PROCEDURE addDebugLog (s_priceid VARCHAR2,p_val varchar2);

    FUNCTION getTariff1(islemTipi number, tariffdate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,tescilTarihi varchar2,trafigeCikisTarihi varchar2,hasarsizlikKademesi varchar2,kullanimTarzi varchar2,modelyili varchar2,yenilememi varchar2,referansPoliceBilgileri varchar2)
        RETURN number;
  /* procedure gettariffcursor ;*/
    islemTipi number;

    PROCEDURE getTrfTariffSBM (ssql varchar2, RESULT out refCursorxx);

    PROCEDURE getTrfTariffSBMCache (ssql varchar2, cacheKey varchar2, RESULT out refCursorxx);

    FUNCTION getTRFReferans (p_xml_value in CLOB)
    RETURN VARCHAR2;

    FUNCTION getTRFSigortalilikSuresiNew (p_xml_value in CLOB)
    RETURN VARCHAR2;
    
    PROCEDURE insertXMLtoTable(p_xml_value in clob);

/*
    - Debug fonksiyonu için getActiveFactorSql yeniden yazılmalı. Debug fonksiyonundan faktor detaylı çarpanlar dönmeli.
    -
*/
END;
/
CREATE OR REPLACE PACKAGE BODY TNSWIN.gettariff AS

    FUNCTION getKaskoHukuksalKorumaPrim(p_tarifeTarihi date)
    RETURN NUMBER AS
        s_result NUMBER;
        v_errm CLOB;
    BEGIN
        s_result := 0;

        return s_result;
    EXCEPTION WHEN OTHERS THEN
        s_result := 0;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_result;
    END getKaskoHukuksalKorumaPrim;

    FUNCTION getKaskoMiniOnarimPrim(p_tarifeTarihi date, p_product_no varchar2, p_kullanimSekli varchar2, p_aracSegment varchar2)
    RETURN NUMBER AS
        s_result NUMBER;
        v_errm CLOB;
        s_count NUMBER;
        pr_kullanimTarzi varchar2(5);
    BEGIN
        pr_kullanimTarzi := cast(cast(p_kullanimSekli as number) as varchar2);
        select count(0) into s_result from pricing_tables a where a.table_code='MINIONARIM' and a.key1=p_product_no and a.key2=pr_kullanimTarzi and a.key3=p_aracSegment and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code='MINIONARIM' and b.key1=p_product_no and b.key2=pr_kullanimTarzi and b.key3=p_aracSegment and b.valid_date<=p_tarifeTarihi);
        if s_result > 0 then
            select mult1 into s_result from pricing_tables a where a.table_code='MINIONARIM' and a.key1=p_product_no and a.key2=pr_kullanimTarzi and a.key3=p_aracSegment and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code='MINIONARIM' and b.key1=p_product_no and b.key2=pr_kullanimTarzi and b.key3=p_aracSegment and b.valid_date<=p_tarifeTarihi);
        end if;

        return s_result;
    EXCEPTION WHEN OTHERS THEN
        s_result := 0;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_result;
    END getKaskoMiniOnarimPrim;

    FUNCTION getKaskoYanlisAkaryakitPrim(p_tarifeTarihi date, p_kullanimSekli varchar2)
    RETURN NUMBER AS
        s_result NUMBER;
        v_errm CLOB;
    BEGIN
        s_result:=0;

        return s_result;
    EXCEPTION WHEN OTHERS THEN
        s_result := 0;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_result;
    END getKaskoYanlisAkaryakitPrim;

    FUNCTION getKaskoYolYardimPrim(p_tarifeTarihi date, p_kullanimSekli varchar2, p_kullanimTipi varchar2, p_yardimAlternatifTeminat varchar2)
    RETURN NUMBER AS
        s_result NUMBER;
        v_errm CLOB;
        s_count NUMBER;
    BEGIN
        s_result:=0;

        return s_result;
    EXCEPTION WHEN OTHERS THEN
        s_result := 0;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_result;
    END getKaskoYolYardimPrim;

    FUNCTION getKaskoTasinanEmteaFiyati(p_tarifeTarihi date, p_tasinanEmtiaCinsi varchar2)
    RETURN NUMBER AS
        s_result NUMBER;
        v_errm CLOB;
    BEGIN
        s_result := 0;

        return s_result;
    EXCEPTION WHEN OTHERS THEN
        s_result := 1;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_result;
    END getKaskoTasinanEmteaFiyati;

    FUNCTION getKaskoSesGoruntuCihaziFiyati(p_tarifeTarihi date)
    RETURN NUMBER AS
        s_result NUMBER;
        v_errm CLOB;
    BEGIN
        s_result := 0;

        return s_result;
    EXCEPTION WHEN OTHERS THEN
        s_result := 1;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_result;
    END getKaskoSesGoruntuCihaziFiyati;

    FUNCTION getKaskoSigortaliFKPrim(p_tarifeTarihi date, p_fkSigortaliTeminatLimiti number)
    RETURN NUMBER AS
        s_prim NUMBER;
        v_errm CLOB;
        s_kisaVadeGunHesabiCarpani NUMBER;
    BEGIN
        -- İleride dahil edilebilir.
        s_kisaVadeGunHesabiCarpani := 1;
        s_prim := 0;

        return s_prim;
    EXCEPTION WHEN OTHERS THEN
        s_prim := 0;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_prim;
    END getKaskoSigortaliFKPrim;

    FUNCTION getKaskoFKPrim(p_tarifeTarihi date, p_kullanimSekli varchar2, p_koltukSayisi varchar2, p_fksigortaliTeminatLimiti varchar2, p_fkKoltukTeminatLimiti varchar2)
    RETURN NUMBER AS
        s_prim NUMBER;
        v_errm CLOB;
        s_kisaVadeGunHesabiCarpani NUMBER;
        s_toplamFormul NUMBER;
        s_formul1 NUMBER;
        s_formul2 NUMBER;
        s_formul3 NUMBER;
        s_FIYAT_OLUM NUMBER(11,2);
        s_FIYAT_SUREKLI_SAKATLIK NUMBER(11,2);
        s_FIYAT_TEDAVI_MASRAFLARI NUMBER(11,2);
        s_TEMINAT_LIM_OLUM NUMBER;
        s_TEMINAT_LIM_SUREKLI_SAKAT NUMBER;
        s_TEMINAT_LIM_TEDAVI_MAS NUMBER;
        s_koltukSayisi NUMBER;
    BEGIN
        s_prim := 0;
        s_koltukSayisi := nvl(p_koltukSayisi,0);
        select count(0) into s_FIYAT_OLUM from pricing_tables a where a.table_code='KSK-FK' and a.key1=p_kullanimSekli and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code='KSK-FK' and b.key1=p_kullanimSekli and b.valid_date<=p_tarifeTarihi);
        if s_FIYAT_OLUM > 0 then
            select a.mult1, a.mult2 into s_FIYAT_OLUM, s_FIYAT_TEDAVI_MASRAFLARI from pricing_tables a where a.table_code='KSK-FK' and a.key1=p_kullanimSekli and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code='KSK-FK' and b.key1=p_kullanimSekli and b.valid_date<=p_tarifeTarihi);
--            (T1042*OLUM FIYATI + T1044*TEDAVI FIYATI) * TOPLAM KISI
            if s_koltukSayisi = 0 then
                if p_kullanimSekli = '1' then s_koltukSayisi := '5'; end if;
                if p_kullanimSekli = '6' then s_koltukSayisi := '4'; end if;
            end if;
            s_prim := ((p_fksigortaliTeminatLimiti*s_FIYAT_OLUM/1000)+(p_fkKoltukTeminatLimiti*s_FIYAT_TEDAVI_MASRAFLARI/1000))*s_koltukSayisi;
        end if;
        return s_prim;
    EXCEPTION WHEN OTHERS THEN
        s_prim := 0;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_prim;
    END getKaskoFKPrim;

    FUNCTION getKaskoIMMPrim(p_tarifeTarihi date, p_kullanimSekli char, p_immSorumlulukLimiti varchar2, p_maneviTazminat varchar2)
    RETURN NUMBER AS
        s_prim NUMBER;
        v_errm CLOB;
        s_kisaVadeGunHesabiCarpani NUMBER;
        s_formul0 NUMBER;
        s_formul1 NUMBER;
        s_formul2 NUMBER;
        s_formul1_1 NUMBER;
        s_formul1_2 NUMBER;
        s_formul1_3 NUMBER;
        s_formul1_4 NUMBER;


    BEGIN
        s_prim := 0;
        select count(0) into s_prim from pricing_tables a where a.table_code='KSK-IMM' and a.key1=p_kullanimSekli and a.key2=p_immSorumlulukLimiti and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code='KSK-IMM' and b.key1=p_kullanimSekli and b.key2=p_immSorumlulukLimiti  and b.valid_date<=p_tarifeTarihi);
        if s_prim > 0 then
            select mult1 into s_prim from pricing_tables a where a.table_code='KSK-IMM' and a.key1=p_kullanimSekli and a.key2=p_immSorumlulukLimiti and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code='KSK-IMM' and b.key1=p_kullanimSekli and b.key2=p_immSorumlulukLimiti  and b.valid_date<=p_tarifeTarihi);
            if cast(p_kullanimSekli as number) in ('1','6') then
                s_prim := s_prim*0.6;
            end if;
            if p_maneviTazminat = 'E' then
                s_prim := s_prim*1.2;
            end if;
        end if;

        return s_prim;
    EXCEPTION WHEN OTHERS THEN
        s_prim := 0;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_prim;
    END getKaskoIMMPrim;

    FUNCTION getKaskoGelirKaybiPrim(p_tarifeTarihi date, p_kullanimSekli char)
    RETURN NUMBER AS
        s_prim NUMBER;
        v_errm CLOB;
        pr_kullanimSekli varchar2(5);
    BEGIN
        s_prim := 0;
        pr_kullanimSekli := cast(cast(p_kullanimSekli as NUMBER) as varchar2);

        select count(0) into s_prim from pricing_tables a where a.table_code='GELIRKAYBI' and a.key1=pr_kullanimSekli and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code='GELIRKAYBI' and b.key1=p_kullanimSekli and b.valid_date<=p_tarifeTarihi);
        if s_prim > 0 then
            select mult1 into s_prim from pricing_tables a where a.table_code='GELIRKAYBI' and a.key1=pr_kullanimSekli and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code='GELIRKAYBI' and b.key1=p_kullanimSekli and b.valid_date<=p_tarifeTarihi);
        end if;
        return s_prim;

    EXCEPTION WHEN OTHERS THEN
        s_prim := 0;
        v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        return s_prim;
    END getKaskoGelirKaybiPrim;

    PROCEDURE addTestLog (
        s_sql CLOB) is PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        --update test set txt = s_sql where idx = 17;
        --insert into test(idx,txt) values(17, s_sql);
        commit;
    END;

    /*************************************************************************************************************************************************************************/

    FUNCTION getKaskoReferansPolice(p_pricingId number, p_kimlikNo varchar2, p_plakaIlKodu varchar2, p_plakaNo varchar2)
    RETURN VARCHAR2 AS
      s_referansPolice VARCHAR2(100);
      s_cache number;
      v_error_msg CLOB;
      s_Fonk_Beg_Time VARCHAR2(30);
      s_Fonk_End_Time VARCHAR2(30);
      clob_sbmValues CLOB;
      clob_kimlikPlakaSorgu CLOB;
      s_sirketKodu VARCHAR2(10);
      s_acenteNo VARCHAR2(20);
      s_policeNo VARCHAR2(30);
      s_yenilemeno VARCHAR2(3);
      s_aracTarifeGrupKodu VARCHAR2(4);
      s_policeBitisTarihi VARCHAR2(30);
      s_count number;
      s_aracMarkaKodu VARCHAR2(4);
      s_aracTipKodu VARCHAR2(4);
    BEGIN
        s_Fonk_Beg_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');

        select count(*) into s_cache from pricing_motor_ref_policy_log a where a.kimlikNo = p_kimlikNo and a.plakaIlKodu = p_plakaIlKodu and a.plakaNo = p_plakaNo and system_date=to_char(sysdate,'DD/MM/YYYY');
        if s_cache = 0 then
            select GETTARIFFTOSBM(p_kimlikNo, p_plakaIlKodu , p_plakaNo, NULL, NULL, NULL, '123', 'KSKREF', NULL, NULL, NULL , NULL, NULL, NULL, NULL, NULL, NULL) into clob_sbmValues from dual;
            clob_kimlikPlakaSorgu := getSbmDetails(clob_sbmValues, 'ovmKaskoPoliceByKimlikPlakaSorgu');

            if removeElement(getSbmDetails(clob_kimlikPlakaSorgu, 'isSuccessfull'),'isSuccessfull') = 'true' then

               select count(0) into s_count from
                (
                    select sirketKodu, acenteNo, policeNo, yenilemeno, aracTarifeGrupKodu, bitisTarihi, case1+case2+case3+case4 as caseSum from
                    (
                        select y.sirketKodu, y.acenteNo, y.policeNo, y.yenilemeno, y.aracTarifeGrupKodu, y.bitisTarihi, y.policeBaslamaTarihi,
                              (case when y.aracTarifeGrupKodu not in (1,3,6) then 0 else 0 end) as case1,
                              (case when y.zeylTuru = 8 and round(nvl(sysdate
                                    - to_date(substr(y.policeekibaslamatarihi,1,10),'YYYY-MM-DD'),0),2) > 180 then 1 else 0 end) as case2,
                              (case when (iptalmi = 1 or mebiptalmi = 1) and y.zeylTuru <> 8 and round(nvl(sysdate
                                    - to_date(substr(y.policeBitisTarihi,1,10),'YYYY-MM-DD'),0),2) > 45 then 1 else 0 end) as case3,
                              (case when (iptalmi = 0 or mebiptalmi = 0) and round(nvl( to_date(substr(y.policeBitisTarihi,1,10),'YYYY-MM-DD')
                                    - to_date(substr(y.policeBaslamaTarihi,1,10),'YYYY-MM-DD'),0),2) < 365 then 1 else 0 end) as case4,
                              (case when (iptalmi = 0 or mebiptalmi = 0) and round(nvl( sysdate
                                    - to_date(substr(y.policeBaslamaTarihi,1,10),'YYYY-MM-DD'),0),2) < 30 then 1 else 0 end) as case5
                        from
                        (
                           select distinct x.sirketKodu, x.acenteNo, x.policeNo, x.yenilemeno,
                                 x.zeylTuru , x.aracTarifeGrupKodu , x.plakaIlKodu , x.plakaNo ,
                                 case when x.zeylTuru in (8,9,13,38,43,44) then 1 else 0 end iptalmi,
                                 case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi,
                                 case when x.zeylTuru in (3,8,9,13,38,43,44) then x.policeEkiBaslamaTarihi else x.policeBitisTarihi end bitisTarihi,
                                 x.policeBaslamaTarihi , x.policeBitisTarihi , x.policeEkiBaslamaTarihi
                                 from
                                 (select xmltype(clob_kimlikPlakaSorgu) data from dual) t,
                                 --(select xmltype(getsbmdetails(clob_sbmvalues,'ovmKaskoPoliceByKimlikPlakaSorgu')) data from PRICING_MOTOR_REF_POLICY_LOG where pricing_id=14100260) t,
                                 XMLTABLE ('/ovmKaskoPoliceByKimlikPlakaSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'      PASSING t.data
                                             COLUMNS
                                               sirketKodu VARCHAR2(10) PATH 'sirketKodu',
                                               acenteNo VARCHAR2(20) PATH 'acenteNo',
                                               policeNo VARCHAR2(30) PATH 'policeNo',
                                               yenilemeno VARCHAR2(3) PATH 'yenilemeNo',
                                               policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                               zeylTuru VARCHAR2(3) PATH 'zeylTuru',
                                               policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                                               policeBitisTarihi varchar2(30) PATH 'policeBitisTarihi',
                                               policeEkiBaslamaTarihi varchar2(30) PATH 'policeEkiBaslamaTarihi',
                                               aracTarifeGrupKodu varchar2(4) PATH 'arac/aracTarifeGrupKodu',
                                               plakaIlKodu varchar2(4) PATH 'arac/plakaIlKodu',
                                               plakaNo varchar2(4) PATH 'arac/plakaNo'
                                           ) x
                        ) y
                        where mebiptalmi <> 1 and sysdate > to_date(substr(y.policeBaslamaTarihi,1,10),'YYYY-MM-DD') and sysdate+45 > to_date(substr(y.bitisTarihi,1,10),'YYYY-MM-DD')
                    )
                    where case1+case2+case3+case4+case5 = 0  order by bitisTarihi desc
                ) z;


                    if s_count > 0 then
                        select sirketKodu, acenteNo, policeNo, yenilemeno, aracTarifeGrupKodu , bitisTarihi, aracMarkaKodu, aracTipKodu into s_sirketKodu, s_acenteNo, s_policeNo, s_yenilemeno, s_aracTarifeGrupKodu , s_policeBitisTarihi, s_aracMarkaKodu, s_aracTipKodu from
                        (
                            select sirketKodu, acenteNo, policeNo, yenilemeno, aracTarifeGrupKodu, bitisTarihi, aracMarkaKodu, aracTipKodu, case1+case2+case3+case4 as caseSum from
                            (
                                select y.sirketKodu, y.acenteNo, y.policeNo, y.yenilemeno, y.aracTarifeGrupKodu, y.bitisTarihi, y.policeBaslamaTarihi, y.aracMarkaKodu, y.aracTipKodu,
                                      (case when y.aracTarifeGrupKodu not in (1,3,6) then 0 else 0 end) as case1,
                                      (case when y.zeylTuru = 8 and round(nvl(sysdate
                                            - to_date(substr(y.policeekibaslamatarihi,1,10),'YYYY-MM-DD'),0),2) > 180 then 1 else 0 end) as case2,
                                      (case when (iptalmi = 1 or mebiptalmi = 1) and y.zeylTuru <> 8 and round(nvl(sysdate
                                            - to_date(substr(y.policeBitisTarihi,1,10),'YYYY-MM-DD'),0),2) > 45 then 1 else 0 end) as case3,
                                      (case when (iptalmi = 0 or mebiptalmi = 0) and round(nvl( to_date(substr(y.policeBitisTarihi,1,10),'YYYY-MM-DD')
                                            - to_date(substr(y.policeBaslamaTarihi,1,10),'YYYY-MM-DD'),0),2) < 365 then 1 else 0 end) as case4,
                                      (case when (iptalmi = 0 or mebiptalmi = 0) and round(nvl( sysdate
                                            - to_date(substr(y.policeBaslamaTarihi,1,10),'YYYY-MM-DD'),0),2) < 30 then 1 else 0 end) as case5
                                from
                                (
                                   select distinct x.sirketKodu, x.acenteNo, x.policeNo, x.yenilemeno,
                                         x.zeylTuru , x.aracTarifeGrupKodu , x.plakaIlKodu , x.plakaNo ,
                                         case when x.zeylTuru in (8,9,13,38,43,44) then 1 else 0 end iptalmi,
                                         case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi,
                                         case when x.zeylTuru in (3,8,9,13,38,43,44) then x.policeEkiBaslamaTarihi else x.policeBitisTarihi end bitisTarihi,
                                         x.policeBaslamaTarihi , x.policeBitisTarihi , x.policeEkiBaslamaTarihi, x.aracMarkaKodu, x.aracTipKodu
                                         from
                                         (select xmltype(clob_kimlikPlakaSorgu) data from dual) t,
                                         --(select xmltype(txt) data from test where idx =12) t,
                                         XMLTABLE ('/ovmKaskoPoliceByKimlikPlakaSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'      PASSING t.data
                                                     COLUMNS
                                                       sirketKodu VARCHAR2(10) PATH 'sirketKodu',
                                                       acenteNo VARCHAR2(20) PATH 'acenteNo',
                                                       policeNo VARCHAR2(30) PATH 'policeNo',
                                                       yenilemeno VARCHAR2(3) PATH 'yenilemeNo',
                                                       policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                                       zeylTuru VARCHAR2(3) PATH 'zeylTuru',
                                                       policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                                                       policeBitisTarihi varchar2(30) PATH 'policeBitisTarihi',
                                                       policeEkiBaslamaTarihi varchar2(30) PATH 'policeEkiBaslamaTarihi',
                                                       aracTarifeGrupKodu varchar2(4) PATH 'arac/aracTarifeGrupKodu',
                                                       plakaIlKodu varchar2(4) PATH 'arac/plakaIlKodu',
                                                       plakaNo varchar2(4) PATH 'arac/plakaNo',
                                                       aracMarkaKodu varchar2(4) PATH 'arac/aracMarkaKodu',
                                                       aracTipKodu varchar2(4) PATH 'arac/aracTipKodu'
                                                   ) x
                                ) y
                                where mebiptalmi <> 1 and sysdate > to_date(substr(y.policeBaslamaTarihi,1,10),'YYYY-MM-DD') and sysdate+45 > to_date(substr(y.bitisTarihi,1,10),'YYYY-MM-DD')
                            )
                            where case1+case2+case3+case4+case5 = 0  order by bitisTarihi desc
                        ) z where rownum = 1;
                        else
                            s_referansPolice := '';
                        end if;
            else
                s_referansPolice := '';
            end if;

            if length(s_policeBitisTarihi)>10 then
                s_policeBitisTarihi := to_char(to_date(substr(s_policeBitisTarihi,1,10),'YYYY-MM-DD'),'DD/MM/YYYY');
            end if;
            s_referansPolice := s_sirketKodu || '-' || s_acenteNo || '-' || s_policeNo || '-' || s_yenilemeno || '-' || s_aracTarifeGrupKodu || '-' || s_policeBitisTarihi;

            s_Fonk_End_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');

        addMotorRefPolicyLog(p_pricingId, p_kimlikNo, p_plakaIlKodu , p_plakaNo, to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), s_Fonk_Beg_Time, s_Fonk_End_Time, clob_sbmValues, '', s_sirketKodu, s_acenteNo, s_policeNo, s_yenilemeno, s_aracTarifeGrupKodu, s_policeBitisTarihi, s_aracMarkaKodu, s_aracTipKodu);
        else
            select a.sirketKodu || '-' || a.acenteNo || '-' || a.policeNo || '-' || a.yenilemeno || '-' || a.aracTarifeGrupKodu || '-' || a.policeBitisTarihi, a.sirketkodu, a.acenteno, a.policeno, a.yenilemeno, a.aractarifegrupkodu, a.policebitistarihi, aracMarkaKodu, aracTipKodu
                    into s_referansPolice, s_sirketKodu, s_acenteNo, s_policeNo, s_yenilemeno, s_aracTarifeGrupKodu, s_policeBitisTarihi, s_aracMarkaKodu, s_aracTipKodu
                from pricing_motor_ref_policy_log a where a.kimlikNo = p_kimlikNo and a.plakaIlKodu = p_plakaIlKodu and a.plakaNo = p_plakaNo and system_date=to_char(sysdate,'DD/MM/YYYY') and rownum=1;

            s_Fonk_End_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');

        addMotorRefPolicyLog(p_pricingId, p_kimlikNo, p_plakaIlKodu , p_plakaNo, to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), s_Fonk_Beg_Time, s_Fonk_End_Time, clob_sbmValues, '', s_sirketKodu, s_acenteNo, s_policeNo, s_yenilemeno, s_aracTarifeGrupKodu, s_policeBitisTarihi , s_aracMarkaKodu, s_aracTipKodu);
        end if;

        return s_referansPolice;
    EXCEPTION WHEN OTHERS THEN
        s_Fonk_End_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');
        v_error_msg :=   substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
            if length(s_policeBitisTarihi)>10 then
                s_policeBitisTarihi := to_char(to_date(substr(s_policeBitisTarihi,1,10),'YYYY-MM-DD'),'DD/MM/YYYY');
            end if;
        addMotorRefPolicyLog(p_pricingId, p_kimlikNo, p_plakaIlKodu , p_plakaNo, to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), s_Fonk_Beg_Time, s_Fonk_End_Time, clob_sbmValues, v_error_msg, s_sirketKodu, s_acenteNo, s_policeNo, s_yenilemeno, s_aracTarifeGrupKodu, s_policeBitisTarihi , s_aracMarkaKodu, s_aracTipKodu);
        return '';
    END getKaskoReferansPolice;

    FUNCTION getKaskoHasarsizlik(p_pricingId number, p_kimlikNo varchar2, p_referansSirket varchar2, p_referansAcente varchar2, p_referansPoliceNo varchar2, p_referansYenilemeNo varchar2)
    RETURN VARCHAR2 AS
      s_result VARCHAR2(10);
      s_cache number;
      s_hasarsizlik NUMBER;
      c_hasarsizlik NUMBER;
      c_aractarifegrupkodu VARCHAR2(2);
      s_reference_id VARCHAR2(100);
      s_Fonk_Beg_Time VARCHAR2(30);
      s_Fonk_End_Time VARCHAR2(30);
      v_errm CLOB;
      s_kimlikNo VARCHAR2(30);
      s_case1 NUMBER;
      s_case2 NUMBER;
      s_case3 NUMBER;
      s_case4 NUMBER;
      s_case5 NUMBER;
      s_case6 NUMBER;
      s_case7 NUMBER;
      s_zeylTuru VARCHAR2(3);
      --s_bitisTarihi VARCHAR2(50);
      clob_sbmValues CLOB;
      clob_policeSorgu CLOB;
      clob_policeHasarSorgu CLOB;
      s_policebaslamatarihi VARCHAR2(50);
      s_policebitistarihi VARCHAR2(50);
      s_policeekibaslamatarihi VARCHAR2(50);
      s_aractarifegrupkodu VARCHAR2(2);
      s_uygulananKademeSBM VARCHAR2(3);
      s_uygulananKademeLBR NUMBER;
      s_hasarSayisi NUMBER;
      s_camHasarSayisi NUMBER;
      s_ruculuHasarSayisi NUMBER;
      s_nihaiHasarSayisi NUMBER;
      s_redIptalHasarsayisi NUMBER;
      s_miniOnarimHasarsayisi NUMBER;
      s_radyoTeypHasarSayisi NUMBER;
      s_sirketKodu VARCHAR2(10);
      s_policeNo VARCHAR2(20);
      s_yenilemeno VARCHAR2(3);
      s_gecmisPoliceNetPrim NUMBER;
      s_rucudusulmustutar NUMBER;
    BEGIN
        s_Fonk_Beg_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');
        s_reference_id := p_referansSirket || '-' || p_referansAcente || '-' || p_referansPoliceNo || '-' || p_referansYenilemeNo;
        s_hasarsizlik:= 0;

        select count(*) into s_cache from pricing_motor_ncd_log a where a.reference_id = s_reference_id and a.identity_no = p_kimlikNo and system_date=to_char(sysdate,'DD/MM/YYYY');
        if s_cache = 0 then
            select GETTARIFFTOSBM('123', NULL, NULL, NULL, NULL, NULL, '123', 'KSKNCD', NULL, NULL, NULL, NULL, p_referansSirket, p_referansAcente, p_referansPoliceNo, p_referansYenilemeNo, NULL) into clob_sbmValues from dual;
            clob_policeSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceSorgu');
            clob_policeHasarSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceHasarSorgu');

            if removeElement(getSbmDetails(clob_policeSorgu, 'isSuccessfull'),'isSuccessfull') = 'true' then

                select distinct x.kimlikNo,
                   case when x.zeylTuru in (8,9,13,38,43,44) and trim(x.policeEkiBaslamaTarihi) = '' then 1 else 0 end case1,
                   case when x.zeylTuru not in (8) then 1 else 0 end case2,
                   --case when (select count(*) from T001C002U69 where to_number(decode(trim(k1),'',0)) = to_number(x.plakaIlKodu) and k2 = x.plakaNo) > 0 then 1 else 0 end case3,
                   0 case3,
                   case when x.zeylTuru <> 0 then case when round(nvl(to_date(substr((case when x.zeylTuru in (3,8,9,13,38,43,44) then x.policeEkiBaslamaTarihi else x.policeBitisTarihi end),1,10),'YYYY-MM-DD') - sysdate,0),2) >= 45 then 1 else 0 end else 0 end case4,
                   case when x.zeylTuru <> 0 then case when to_date(substr((case when x.zeylTuru in (3,8,9,13,38,43,44) then x.policeEkiBaslamaTarihi else x.policeBitisTarihi end),1,10),'YYYY-MM-DD') < sysdate then 0 else 1 end else 0 end case5,
                   case when round(nvl(sysdate - to_date(substr((case when x.zeylTuru in (3,8,9,13,38,43,44) then x.policeEkiBaslamaTarihi else x.policeBitisTarihi end),1,10),'YYYY-MM-DD'),0),2) >= 90 then 1 else 0 end case6,
                   case when x.zeylTuru in (13,43) then 1 else 0 end case7, --Pert
                   aracTarifeGrupKodu, sirketKodu, policeNo, yenilemeno
                   into s_kimlikNo, s_case1, s_case2, s_case3, s_case4, s_case5, s_case6, s_case7, s_aractarifegrupkodu, s_sirketKodu, s_policeNo, s_yenilemeno
                from
                (select xmltype(clob_policeSorgu) data from dual) t,
                --(select xmltype(txt) data from test where idx =13) t,
                XMLTABLE ('/ovmkaskoPoliceSorgu/kaskoPoliceSonucType'  PASSING t.data
                       COLUMNS
                         sirketKodu VARCHAR2(10) PATH 'sirketKodu',
                         acenteNo VARCHAR2(20) PATH 'acenteNo',
                         policeNo VARCHAR2(30) PATH 'policeNo',
                         yenilemeno VARCHAR2(3) PATH 'yenilemeNo',
                         policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                         zeylTuru VARCHAR2(3) PATH 'zeylTuru',
                         policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                         policeBitisTarihi varchar2(30) PATH 'policeBitisTarihi',
                         policeEkiBaslamaTarihi varchar2(30) PATH 'policeEkiBaslamaTarihi',
                         aracTarifeGrupKodu varchar2(4) PATH 'arac/aracTarifeGrupKodu',
                         plakaIlKodu varchar2(3) PATH 'arac/plakaIlKodu',
                         plakaNo varchar2(50) PATH 'arac/plakaNo',
                         uygulananKademe varchar2(3) PATH 'uygulananKademe',
                         kimlikNo varchar2(30) PATH 'sigortali/kimlikNo'
                ) x;

                if s_sirketKodu = '051' or s_sirketKodu = '51' then
                    select count(0) into s_gecmisPoliceNetPrim from tnswin.t001polmas m where m.firm_code=2 and m.company_code=2 and m.policy_no=s_policeNo and m.renewal_no=s_yenilemeno and m.policy_status='O';
                    if s_gecmisPoliceNetPrim > 0 then
                        select sum(decode(m.prod_cancel,'I',-1,1)*m.lc_net_premium) into s_gecmisPoliceNetPrim from tnswin.t001polmas m where m.firm_code=2 and m.company_code=2 and m.policy_no=s_policeNo and m.renewal_no=s_yenilemeno and m.policy_status='O';
                    end if;
                end if;

                --if trim(p_kimlikNo) = trim(s_kimlikNo) then
                if (case when REGEXP_SUBSTR(s_kimlikNo,'\d+') = substr(p_kimlikNo, -length(REGEXP_SUBSTR(s_kimlikNo,'\d+')), length(p_kimlikNo)) then 1 else 0 end) = 1 or s_kimlikNo = substr(p_kimlikNo,1,1)||'***'||substr(p_kimlikNo,length(p_kimlikNo),1) then
                    --if (s_case1 = 1 and s_case2 = 1 and s_case3 = 1) or s_case7 = 1 then
                    if s_case6 = 1 then
                        s_hasarsizlik := 0;
                    else
                        if s_case4 = 1 then
                            s_hasarsizlik := 0;
                        else
                             /* HESAP */
                             select zeylturu, policebaslamatarihi, policebitistarihi, policeekibaslamatarihi, aractarifegrupkodu, uygulananKademe,
                                 SUM(hasarsayisi) hasarsayisi, SUM(camhasarsayisi) camhasarsayisi, SUM(ruculuhasarsayisi) ruculuhasarsayisi,
                                 SUM(redIptalHasarsayisi) redIptalHasarsayisi, SUM(miniOnarimHasarsayisi) miniOnarimHasarsayisi,
                                 (SUM(hasarsayisi) - ((case when SUM(camhasarsayisi) > 0 then 1 else 0 end) + SUM(ruculuhasarsayisi))) as nihaiHasarSayisi,
                                 sum(radyoTeypHasarSayisi) radyoTeypHasarSayisi, sum(rucudusulmustutarhesap) rucudusulmustutar
                                 into
                                 s_zeylturu, s_policebaslamatarihi, s_policebitistarihi, s_policeekibaslamatarihi, s_aractarifegrupkodu, s_uygulananKademeSBM,
                                 s_hasarSayisi, s_camHasarSayisi, s_ruculuhasarsayisi, s_redIptalHasarsayisi, s_miniOnarimHasarsayisi, s_nihaiHasarSayisi, s_radyoTeypHasarSayisi,s_rucudusulmustutar
                             from
                             (
                                select
                                    v.*,
                                    SUM(case when dosyadurumkodu not in ('3','4') and hasarNedenTipi<>'35' then 1 else 0 end) hasarsayisi,
                                    sum(case when hasarNedenTipi='20' and dosyaDurumKodu not in ('3','4') and rucuOrani != '100' then 1 else 0 end) camHasarSayisi,
                                    sum(case when hasarNedenTipi='23' and dosyaDurumKodu not in ('3','4') and rucuOrani != '100' then 1 else 0 end) radyoTeypHasarSayisi,
                                    sum(case when rucuOrani='100' and dosyaDurumKodu not in ('3','4') and hasarNedenTipi<>'35' then 1 else 0 end) ruculuhasarsayisi,
                                    SUM(case when dosyadurumkodu in ('3','4') then 1 else 0 end) redIptalHasarsayisi,
                                    SUM(case when hasarNedenTipi<>'35' then 1 else 0 end) miniOnarimHasarsayisi,
                                    sum(case when hasarNedenTipi not in('20','23') then rucudusulmustutar else 0 end) rucudusulmustutarhesap
                                from
                                (
                                   select distinct t.system_date, x.policeEkino ,x.zeylTuru ,
                                        case when x.zeylTuru in(8,9,13,38,43,44) then 1 else 0 end iptalmi,
                                        case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi,
                                        x.policeBaslamaTarihi ,x.policeBitisTarihi ,x.policeEkiBaslamaTarihi,
                                        x.aracTarifeGrupKodu ,x.uygulananKademe,
                                        x2.hasarDosyaNo, x2.dosyaDurumKodu, x2.kaskoHasarTipi, x2.hasarNedenTipi, x2.rucuOrani,
                                        x3.hasarTutari, (x3.hasartutari*(100-x2.rucuorani)/100) as rucudusulmustutar
                                        from
                                        (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(clob_policeHasarSorgu) data from dual) t,
                                        --(select to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(txt) data from test where idx =14) t,
                                            XMLTABLE ('/ovmkaskoPoliceHasarSorgu/kaskoPoliceHasarSonucType'      PASSING t.data
                                                       COLUMNS
                                                         policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                                         zeylTuru VARCHAR2(3) PATH 'zeylTuru',
                                                         policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                                                         policeBitisTarihi varchar2(30) PATH 'policeBitisTarihi',
                                                         policeEkiBaslamaTarihi varchar2(30) PATH 'policeEkiBaslamaTarihi',
                                                         aracTarifeGrupKodu varchar2(4) PATH 'aracTarifeGrupKodu',
                                                         uygulananKademe varchar2(2) PATH 'uygulananKademe',
                                                         hasarList xmltype PATH 'hasarList'
                                                     ) x
                                            LEFT OUTER JOIN XMLTABLE('hasarList' PASSING x.hasarList
                                                COLUMNS
                                                        hasarDosyaNo varchar2(50) PATH 'hasarDosyaNo',
                                                        dosyaDurumKodu varchar2(5) PATH 'dosyaDurumKodu',
                                                        kaskoHasarTipi varchar2(5) PATH 'kaskoHasarTipi',
                                                        hasarNedenTipi varchar2(5) PATH 'hasarNedenTipi',
                                                        rucuOrani varchar2(5) PATH 'rucuOrani',
                                                        odemeList xmltype PATH 'odemeList'
                                            ) x2 ON 1=1
                                            LEFT OUTER JOIN XMLTABLE('odemeList' PASSING x2.odemeList
                                                COLUMNS
                                                        hasarTutari varchar2(10) PATH 'tutar'
                                            ) x3 ON 1=1
                                  )  v
                                  group by v.system_date, v.policeEkino ,v.zeylTuru ,v.iptalmi, v.mebiptalmi, v.policeBaslamaTarihi,
                                           v.policeBitisTarihi, v.policeEkiBaslamaTarihi ,v.aracTarifeGrupKodu ,v.uygulananKademe,v.rucudusulmustutar,
                                           v.hasarDosyaNo, v.dosyaDurumKodu,v.kaskoHasarTipi, v.hasarNedenTipi, v.rucuOrani,v.hasarTutari
                             ) y group by policeekino, zeylturu, iptalmi, mebiptalmi, policebaslamatarihi, policebitistarihi, policeekibaslamatarihi, aractarifegrupkodu, uygulananKademe
                             having mebiptalmi<>1;

                             /*if s_nihaiHasarSayisi > 3 then s_nihaiHasarSayisi := 3; end if;*/

  --                           if to_number(s_uygulananKademeSBM) > 0 then
                                --s_uygulananKademeLBR := to_number(s_uygulananKademeSBM) + 1;
/*                             else
                                s_uygulananKademeLBR:= to_number(s_uygulananKademeSBM);
                             end if;*/

                    --         if s_zeylturu = 8 and s_nihaiHasarSayisi = 0 and length(p_kimlikNo)=11 then
                                 --s_hasarsizlik := s_uygulananKademeLBR;
--                             else
                                 if (case when sysdate > to_date(substr((case when s_zeylTuru in (13,38,43,44) then s_policeekibaslamatarihi else s_policebitistarihi end),1,10),'YYYY-MM-DD') then
                                        case when round(nvl(sysdate - to_date(substr((case when s_zeylTuru in (3,13,38,43,44) then s_policeekibaslamatarihi else s_policebitistarihi end),1,10),'YYYY-MM-DD'),0),2) <= 90 then 1 else 0 end
                                     else
                                        case when round(nvl(to_date(substr((case when s_zeylTuru in (13,38,43,44) then s_policeekibaslamatarihi else s_policebitistarihi end),1,10),'YYYY-MM-DD') - sysdate,0),2) <= 45 then 1 else 0 end
                                    end) = 1
                                 then
                                 /*
                                    if s_nihaiHasarSayisi =0 then
                                        if s_uygulananKademeLBR <= 4  then
                                            if s_uygulananKademeLBR = 0  then
                                                s_hasarsizlik := 2;
                                            else
                                                s_hasarsizlik := s_uygulananKademeLBR + 1;
                                            end if;
                                        elsif s_uygulananKademeLBR > 4 then
                                            s_hasarsizlik := 5;
                                        end if;
                                    elsif s_nihaiHasarSayisi =1 then
                                        if s_uygulananKademeLBR <= 4  then
                                            s_hasarsizlik := s_uygulananKademeLBR - 1;
                                        elsif s_uygulananKademeLBR > 4 then
                                            s_hasarsizlik := 4;
                                        end if;
                                    elsif s_nihaiHasarSayisi >=2 then
                                        s_hasarsizlik := 0;
                                    end if;*/
                                    if s_hasarSayisi - s_ruculuHasarSayisi = 4 then
                                        if s_camHasarSayisi + s_radyoTeypHasarSayisi in(3,4) then
                                            s_hasarsizlik := to_number(s_uygulananKademeSBM) - 2;
                                        else
                                            s_hasarsizlik := 0;
                                        end if;
                                    elsif s_hasarSayisi - s_ruculuHasarSayisi = 3 then
                                        if s_camHasarSayisi + s_radyoTeypHasarSayisi = 3 then
                                            s_hasarsizlik := to_number(s_uygulananKademeSBM) - 1;
                                        elsif s_camHasarSayisi + s_radyoTeypHasarSayisi in (1,2) then
                                            s_hasarsizlik := to_number(s_uygulananKademeSBM) - 2;
                                        else
                                            s_hasarsizlik := 0;
                                        end if;
                                    elsif s_hasarSayisi - s_ruculuHasarSayisi = 2 then
                                       if s_camHasarSayisi + s_radyoTeypHasarSayisi = 2 then
                                            s_hasarsizlik := to_number(s_uygulananKademeSBM) - 1;
                                       elsif s_camHasarSayisi + s_radyoTeypHasarSayisi = 1 then
                                            s_hasarsizlik := to_number(s_uygulananKademeSBM) - 1;
                                       else
                                           if (s_sirketKodu = '051' or s_sirketKodu = '51') and to_number(s_uygulananKademeSBM)>1 and s_rucudusulmustutar<s_gecmisPoliceNetPrim then -- 2 HAsar gerçekleşmiş yenilememiz kademesi 1'den büyükse ve hasar tutarı poliçe net primden küçükse
                                               s_hasarsizlik := to_number(s_uygulananKademeSBM) - 1;
                                           else
                                               s_hasarsizlik := to_number(s_uygulananKademeSBM) - 2;
                                           end if;
                                       end if;
                                    elsif s_hasarSayisi - s_ruculuHasarSayisi =1 then
                                       if s_camHasarSayisi + s_radyoTeypHasarSayisi = 1 then
                                            s_hasarsizlik := to_number(s_uygulananKademeSBM) + 1;
                                       elsif s_camHasarSayisi + s_radyoTeypHasarSayisi = 0 then
                                            if (s_sirketKodu = '051' or s_sirketKodu = '51') then -- 1 Hasar Gerçekleşmiş Yenilememiz
                                                if to_number(s_uygulananKademeSBM) = 1 then -- 1 Hasar gerçekleşmiş yenilememiz kademe 1 ise %15 indirim kademesi seçilmeli
                                                    s_hasarsizlik := 99; -- %15 indirim kademesi fonksiyon çıkışında 1. kademe olarak ayarlanıyor.
                                                elsif to_number(s_uygulananKademeSBM)>1 and s_rucudusulmustutar<(s_gecmisPoliceNetPrim/2) then -- 1 HAsar gerçekleşmiş yenilememiz kademesi 1'den büyükse ve hasar tutarı poliçe net priminin yarısından küçükse
                                                    s_hasarsizlik := to_number(s_uygulananKademeSBM);
                                                else
                                                    s_hasarsizlik := to_number(s_uygulananKademeSBM) - 1;
                                                end if;
                                            else
                                                s_hasarsizlik := to_number(s_uygulananKademeSBM) - 1;
                                            end  if;
                                       end if;
                                    elsif s_hasarSayisi - s_ruculuHasarSayisi = 0 then
                                        s_hasarsizlik := to_number(s_uygulananKademeSBM) + 1;
                                    else
                                        s_hasarsizlik := 0;
                                    end if;
                                 elsif s_zeylTuru in('8','9','3') and sysdate-to_date(substr(s_policeekibaslamatarihi,1,10),'YYYY-MM-DD')<90 and s_hasarSayisi - s_ruculuHasarSayisi = 0 then
                                    s_hasarsizlik := to_number(s_uygulananKademeSBM);
                                 else
                                     s_hasarsizlik := 0;
                                 end if;
                   --          end if;
                             /* HESAP */
                        end if;
                    end if;
                else
                    s_hasarsizlik := 0;
                end if;
            else
                s_hasarsizlik := 0;
            end if ;

            if s_hasarsizlik < 0 then s_hasarsizlik := 0; end if;

            if s_hasarsizlik = 0 then
                s_hasarsizlik := 0;
--            elsif s_hasarsizlik > 0 and s_hasarsizlik != 99 then
--                s_hasarsizlik := s_hasarsizlik + 1;
--            elsif s_hasarsizlik = 99 then
--                s_hasarsizlik := 1;
            end if;

            if s_hasarsizlik > 10 and s_hasarsizlik!=99 then s_hasarsizlik := 10; end if;

            s_Fonk_End_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');

            addMotorNcdLog(p_pricingId , s_reference_id , p_kimlikNo , to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), S_FONK_BEG_TIME , S_FONK_END_TIME , s_hasarsizlik , clob_sbmValues , '' , s_case1 , s_case2 , s_case3 , s_case4 , s_case5 , s_zeylTuru , s_policebaslamatarihi , s_policebitistarihi , s_policeekibaslamatarihi , s_aractarifegrupkodu , s_uygulananKademeSBM , s_uygulananKademeLBR , s_hasarSayisi , s_camHasarSayisi , s_ruculuHasarSayisi , s_nihaiHasarSayisi, s_redIptalHasarsayisi, s_miniOnarimHasarsayisi);

            s_result := to_char(s_hasarsizlik) || '-' || s_aractarifegrupkodu;
        else
            select a.hasarsizlik, a.aractarifegrupkodu, policebaslamatarihi,policebitistarihi,uygulanankademesbm,uygulanankademelbr,hasarsayisi,camhasarsayisi,ruculuhasarsayisi,nihaihasarsayisi,rediptalhasarsayisi,minionarimhasarsayisi into c_hasarsizlik, c_aractarifegrupkodu, s_policebaslamatarihi,s_policebitistarihi,s_uygulanankademesbm,s_uygulanankademelbr,s_hasarsayisi,s_camhasarsayisi,s_ruculuhasarsayisi,s_nihaihasarsayisi,s_rediptalhasarsayisi,s_minionarimhasarsayisi from pricing_motor_ncd_log a where a.reference_id = s_reference_id and a.identity_no = p_kimlikNo and system_date=to_char(sysdate,'DD/MM/YYYY') and rownum=1;
            if c_hasarsizlik > 10 and c_hasarsizlik!=99 then c_hasarsizlik := 10; end if;
            addMotorNcdLog(p_pricingId , s_reference_id , p_kimlikNo , to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), S_FONK_BEG_TIME , S_FONK_END_TIME , c_hasarsizlik , clob_sbmValues , '' , s_case1 , s_case2 , s_case3 , s_case4 , s_case5 , s_zeylTuru , s_policebaslamatarihi , s_policebitistarihi , s_policeekibaslamatarihi , c_aractarifegrupkodu , s_uygulananKademeSBM , s_uygulananKademeLBR , s_hasarSayisi , s_camHasarSayisi , s_ruculuHasarSayisi , s_nihaiHasarSayisi, s_redIptalHasarsayisi, s_miniOnarimHasarsayisi);
            s_result := c_hasarsizlik || '-' || c_aractarifegrupkodu;
        end if;

        return s_result;
    EXCEPTION WHEN OTHERS THEN
        v_errm :=   substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        s_Fonk_End_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');
        s_hasarsizlik := 0;
        s_result := to_char(s_hasarsizlik) || '-' || s_aractarifegrupkodu;
        addMotorNcdLog(p_pricingId , s_reference_id , p_kimlikNo , to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), S_FONK_BEG_TIME , S_FONK_END_TIME , s_hasarsizlik , clob_sbmValues , v_errm , s_case1 , s_case2 , s_case3 , s_case4 , s_case5 , s_zeylTuru , s_policebaslamatarihi , s_policebitistarihi , s_policeekibaslamatarihi , s_aractarifegrupkodu , s_uygulananKademeSBM , s_uygulananKademeLBR , s_hasarSayisi , s_camHasarSayisi , s_ruculuHasarSayisi , s_nihaiHasarSayisi, s_redIptalHasarsayisi, s_miniOnarimHasarsayisi);
        return s_result;
    END getKaskoHasarsizlik;



    PROCEDURE addMotorNcdLog (
        p_pricingId NUMBER,
        p_reference_id VARCHAR2,
        p_kimlikNo VARCHAR2,
        system_date varchar2,
        system_time varchar2,
        S_FONK_BEG_TIME varchar2,
        S_FONK_END_TIME varchar2,
        s_hasarsizlik NUMBER,
        clob_sbmValues CLOB,
        v_error_msg VARCHAR2,
        s_case1 NUMBER,
        s_case2 NUMBER,
        s_case3 NUMBER,
        s_case4 NUMBER,
        s_case5 NUMBER,
        s_zeylTuru VARCHAR2,
        s_policebaslamatarihi VARCHAR2,
        s_policebitistarihi VARCHAR2,
        s_policeekibaslamatarihi VARCHAR2,
        s_aractarifegrupkodu VARCHAR2,
        s_uygulananKademeSBM VARCHAR2,
        s_uygulananKademeLBR NUMBER,
        s_hasarSayisi NUMBER,
        s_camHasarSayisi NUMBER,
        s_ruculuHasarSayisi NUMBER,
        s_nihaiHasarSayisi NUMBER,
        s_redIptalHasarsayisi NUMBER,
        s_miniOnarimHasarsayisi NUMBER
        ) is PRAGMA AUTONOMOUS_TRANSACTION;
    begin
        insert into pricing_motor_ncd_log
        values(p_pricingId , p_reference_id , p_kimlikNo , system_date , system_time , S_FONK_BEG_TIME , S_FONK_END_TIME , s_hasarsizlik , clob_sbmValues , v_error_msg , s_case1 , s_case2 ,
                s_case3 , s_case4 , s_case5 , s_zeylTuru , s_policebaslamatarihi , s_policebitistarihi , s_policeekibaslamatarihi , s_aractarifegrupkodu ,
                s_uygulananKademeSBM , s_uygulananKademeLBR , s_hasarSayisi , s_camHasarSayisi , s_ruculuHasarSayisi, s_nihaiHasarSayisi, s_redIptalHasarsayisi, s_miniOnarimHasarsayisi);
        commit;
    end;

    PROCEDURE addMotorRefPolicyLog (
        p_pricing_id                   NUMBER,
        p_kimlikNo                     VARCHAR2,
        p_plakaIlKodu                  VARCHAR2,
        p_plakaNo                      VARCHAR2,
        system_date                    VARCHAR2,
        system_time                    VARCHAR2,
        s_fonk_beg_time                VARCHAR2,
        s_fonk_end_time                VARCHAR2,
        clob_sbmvalues                 CLOB,
        v_error_msg                    VARCHAR2,
        s_sirketKodu                   VARCHAR2,
        s_acenteNo                     VARCHAR2,
        s_policeNo                     VARCHAR2,
        s_yenilemeno                   VARCHAR2,
        s_aracTarifeGrupKodu           VARCHAR2,
        s_policeBitisTarihi            VARCHAR2,
        s_aracMarkaKodu                VARCHAR2,
        s_aracTipKodu                  VARCHAR2
        ) is PRAGMA AUTONOMOUS_TRANSACTION;
    begin
        insert into pricing_motor_ref_policy_log values(p_pricing_id , p_kimlikNo , p_plakaIlKodu , p_plakaNo , system_date, system_time, s_fonk_beg_time , s_fonk_end_time , clob_sbmvalues , v_error_msg , s_sirketKodu, s_acenteNo, s_policeNo, s_yenilemeno, s_aracTarifeGrupKodu, s_policeBitisTarihi, s_aracMarkaKodu, s_aracTipKodu);
        commit;
    end;

    FUNCTION getKSKGenelBilgi (p_kimlikNo varchar2, p_xml_value in CLOB)
    RETURN VARCHAR2 AS
    s_Result VARCHAR2(100);
    s_sigortalilikSuresi NUMBER(11,2);
    s_camHasarSayisi NUMBER(11);
    s_kismiHasarSayisi NUMBER(11);
    v_errm VARCHAR2(4000);
    BEGIN

    if LENGTH(p_kimlikNo) = 11 then
        select NVL(sum(z.sigortalilikSuresi),0), NVL(sum(z.kismiHasarsayisi),0), NVL(sum(z.camHasarSayisi),0) into s_sigortalilikSuresi, s_kismiHasarSayisi, s_camHasarSayisi
        from
        (
            select SUM(kismihasarsayisi) as kismiHasarsayisi, SUM(camhasarsayisi) as camHasarSayisi,
                   round(nvl(case when iptalmi=1 then to_date(substr(policeekibaslamatarihi,1,10),'YYYY-MM-DD') - to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD')
                                    else case when to_date(substr(policebitistarihi,1,10),'YYYY-MM-DD')>system_date then system_date-to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD')
                                    else to_date(substr(policebitistarihi,1,10),'YYYY-MM-DD')-to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD') end
                                    end,0)/365,2) as sigortalilikSuresi
            from
            (
                select
                    v.*,
                    SUM(case when dosyadurumkodu is not null then 1 else 0 end) hasarsayisi,
                    sum(case when kaskoHasarTipi='2' and dosyaDurumKodu not in ('3','4') and rucuOrani != '100' then 1 else 0 end) kismiHasarSayisi,
                    sum(case when hasarNedenTipi='20' and dosyaDurumKodu not in ('3','4') and rucuOrani != '100' then 1 else 0 end) camHasarSayisi,
                    sum(case when rucuOrani!='100' and dosyaDurumKodu not in ('3','4') then 1 else 0 end) rucusuzHasarSayisi,
                    (case when sum(rucudusulmustutar)<500 and dosyaDurumKodu not in ('3','4') and rucuOrani != '100' then 1 else 0 end) minTutarHasarSayisi
                    from
                        ( select distinct t.system_date, x.policeNo ,x.yenilemeno ,x.policeEkino ,x.zeylTuru ,
                                case when x.zeylTuru in(8,9,13,38,43,44) then 1 else 0 end iptalmi,
                                case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi,
                                x.policeBaslamaTarihi ,x.policeBitisTarihi ,x.policeEkiBaslamaTarihi
                                ,x.aracMarkaKodu ,x.aracTarifeGrupKodu ,x.aracTipKodu ,x.kullanimSekli ,x.modelYili ,x.plakaIlKodu ,x.plakaNo ,x.uygulananKademe,
                                x2.dosyaDurumKodu, x2.kaskoHasarTipi, x2.hasarNedenTipi, x2.rucuOrani,x3.hasarTutari, (x3.hasartutari*(100-x2.rucuorani)/100) as rucudusulmustutar
                                from
                                (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(p_xml_value) data from dual) t,
                                    XMLTABLE ('/ovmkaskoPoliceByTckSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'      PASSING t.data
                                               COLUMNS
                                                 policeNo VARCHAR2(30) PATH 'policeNo',
                                                 yenilemeno VARCHAR2(3) PATH 'yenilemeNo',
                                                 policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                                 zeylTuru VARCHAR2(3) PATH 'zeylTuru',
                                                 policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                                                 policeBitisTarihi varchar2(30) PATH 'policeBitisTarihi',
                                                 policeEkiBaslamaTarihi varchar2(30) PATH 'policeEkiBaslamaTarihi',
                                                 aracMarkaKodu varchar2(4) PATH 'arac/aracMarkaKodu',
                                                 aracTarifeGrupKodu varchar2(4) PATH 'arac/aracTarifeGrupKodu',
                                                 aracTipKodu varchar2(4) PATH 'arac/aracTipKodu',
                                                 kullanimSekli varchar2(4) PATH 'arac/kullanimSekli',
                                                 modelYili varchar2(4) PATH 'arac/modelYili',
                                                 plakaIlKodu varchar2(4) PATH 'arac/plakaIlKodu',
                                                 plakaNo varchar2(4) PATH 'arac/plakaNo',
                                                 uygulananKademe varchar2(2) PATH 'uygulananKademe',
                                                 hasarList xmltype PATH 'hasarList'
                                             ) x
                                    LEFT OUTER JOIN XMLTABLE('hasarList' PASSING x.hasarList
                                        COLUMNS
                                                dosyaDurumKodu varchar2(5) PATH 'dosyaDurumKodu',
                                                kaskoHasarTipi varchar2(5) PATH 'kaskoHasarTipi',
                                                hasarNedenTipi varchar2(5) PATH 'hasarNedenTipi',
                                                rucuOrani varchar2(5) PATH 'rucuOrani',
                                                odemeList xmltype PATH 'odemeList'
                                    ) x2 ON 1=1
                                    LEFT OUTER JOIN XMLTABLE('odemeList' PASSING x2.odemeList
                                        COLUMNS
                                                hasarTutari varchar2(10) PATH 'tutar'
                                    ) x3 ON 1=1
                        )  v
                         group by v.system_date, v.policeNo,v.yenilemeno ,v.policeEkino ,v.zeylTuru ,v.iptalmi, v.mebiptalmi, v.policeBaslamaTarihi
                         ,v.policeBitisTarihi, v.policeEkiBaslamaTarihi ,v.aracMarkaKodu ,v.aracTarifeGrupKodu ,v.aracTipKodu
                         ,v.kullanimSekli, v.modelYili ,v.plakaIlKodu ,v.plakaNo ,v.uygulananKademe,v.rucudusulmustutar, v.dosyaDurumKodu,
                          v.kaskoHasarTipi, v.hasarNedenTipi, v.rucuOrani,v.hasarTutari
            ) y group by system_date, policeno, yenilemeno, policeekino, zeylturu, iptalmi, mebiptalmi, policebaslamatarihi, policebitistarihi, policeekibaslamatarihi,
            aracmarkakodu, aractarifegrupkodu, aractipkodu, kullanimsekli, modelyili, plakailkodu, plakano, uygulananKademe
            having mebiptalmi<>1
        ) z;
    else
        s_sigortalilikSuresi := 0;
        s_camHasarSayisi := 0;
        s_kismiHasarSayisi := 0;
    end if;

    s_Result:= to_char(s_sigortalilikSuresi) || '-' || to_char(s_kismiHasarSayisi) || '-' || to_char(s_camHasarSayisi) ;

    RETURN s_Result;

    EXCEPTION WHEN OTHERS THEN
       v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       s_sigortalilikSuresi := 0;
       s_camHasarSayisi := 0;
       s_kismiHasarSayisi := 0;
       s_Result:= to_char(s_sigortalilikSuresi) || '-' || to_char(s_kismiHasarSayisi) || '-' || to_char(s_camHasarSayisi) ;
       return s_Result;
    end getKSKGenelBilgi;

    FUNCTION getKSKHasarSayisi (p_kimlikNo varchar2, p_plakaIlKodu varchar2, p_plakaNo varchar2, p_xml_value in CLOB)
    RETURN VARCHAR2 AS
    s_Result VARCHAR2(100);
    s_camHasarSayisi NUMBER(11);
    s_kismiHasarSayisi NUMBER(11);
    v_errm VARCHAR2(4000);
    BEGIN

    if LENGTH(p_kimlikNo) = 11 then
        select NVL(sum(z.kismiHasarsayisi),0), NVL(sum(z.camHasarSayisi),0) into s_kismiHasarSayisi, s_camHasarSayisi
        from
        (
            select SUM(kismihasarsayisi) as kismiHasarsayisi, SUM(camhasarsayisi) as camHasarSayisi,
                   round(nvl(case when iptalmi=1 then to_date(substr(policeekibaslamatarihi,1,10),'YYYY-MM-DD') - to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD')
                                    else case when to_date(substr(policebitistarihi,1,10),'YYYY-MM-DD')>system_date then system_date-to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD')
                                    else to_date(substr(policebitistarihi,1,10),'YYYY-MM-DD')-to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD') end
                                    end,0)/365,2) as sigortalilikSuresi
            from
            (
                select
                    v.*,
                    SUM(case when dosyadurumkodu is not null then 1 else 0 end) hasarsayisi,
                    sum(case when kaskoHasarTipi='2' and dosyaDurumKodu not in ('3','4') and (rucuOrani != '100' or rucuOrani is null) then 1 else 0 end) kismiHasarSayisi,
                    sum(case when hasarNedenTipi='20' and dosyaDurumKodu not in ('3','4') and (rucuOrani != '100' or rucuOrani is null) then 1 else 0 end) camHasarSayisi,
                    sum(case when (rucuOrani!='100' or rucuOrani is null) and dosyaDurumKodu not in ('3','4') then 1 else 0 end) rucusuzHasarSayisi,
                    (case when sum(rucudusulmustutar)<500 and dosyaDurumKodu not in ('3','4') and (rucuOrani != '100' or rucuOrani is null) then 1 else 0 end) minTutarHasarSayisi
                    from
                        ( select distinct t.system_date, x.policeNo ,x.yenilemeno ,x.policeEkino ,x.zeylTuru ,
                                case when x.zeylTuru in(8,9,13,38,43,44) then 1 else 0 end iptalmi,
                                case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi,
                                x.policeBaslamaTarihi ,x.policeBitisTarihi ,x.policeEkiBaslamaTarihi
                                ,x.aracMarkaKodu ,x.aracTarifeGrupKodu ,x.aracTipKodu ,x.kullanimSekli ,x.modelYili ,x.plakaIlKodu ,x.plakaNo ,x.uygulananKademe,x2.hasarDosyaNo,
                                x2.dosyaDurumKodu, x2.kaskoHasarTipi, x2.hasarNedenTipi, x2.rucuOrani,x3.hasarTutari, (case when x2.rucuorani is null then (case when x3.hasartutari is null then 0 else cast(x3.hasartutari as number) end) else (x3.hasartutari*(100-(x2.rucuorani))/100) end) as rucudusulmustutar
                                from
                                (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(p_xml_value) data from dual) t,
                                    XMLTABLE ('/ovmkaskoPoliceByTckSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'      PASSING t.data
                                               COLUMNS
                                                 policeNo VARCHAR2(30) PATH 'policeNo',
                                                 yenilemeno VARCHAR2(3) PATH 'yenilemeNo',
                                                 policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                                 zeylTuru VARCHAR2(3) PATH 'zeylTuru',
                                                 policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                                                 policeBitisTarihi varchar2(30) PATH 'policeBitisTarihi',
                                                 policeEkiBaslamaTarihi varchar2(30) PATH 'policeEkiBaslamaTarihi',
                                                 aracMarkaKodu varchar2(4) PATH 'arac/aracMarkaKodu',
                                                 aracTarifeGrupKodu varchar2(4) PATH 'arac/aracTarifeGrupKodu',
                                                 aracTipKodu varchar2(4) PATH 'arac/aracTipKodu',
                                                 kullanimSekli varchar2(4) PATH 'arac/kullanimSekli',
                                                 modelYili varchar2(4) PATH 'arac/modelYili',
                                                 plakaIlKodu varchar2(4) PATH 'arac/plakaIlKodu',
                                                 plakaNo varchar2(10) PATH 'arac/plakaNo',
                                                 uygulananKademe varchar2(2) PATH 'uygulananKademe',
                                                 hasarList xmltype PATH 'hasarList'
                                             ) x
                                    LEFT OUTER JOIN XMLTABLE('hasarList' PASSING x.hasarList
                                        COLUMNS
                                                dosyaDurumKodu varchar2(5) PATH 'dosyaDurumKodu',
                                                hasarDosyaNo varchar2(35) PATH 'hasarDosyaNo',
                                                kaskoHasarTipi varchar2(5) PATH 'kaskoHasarTipi',
                                                hasarNedenTipi varchar2(5) PATH 'hasarNedenTipi',
                                                rucuOrani varchar2(5) PATH 'rucuOrani',
                                                odemeList xmltype PATH 'odemeList'
                                    ) x2 ON 1=1
                                    LEFT OUTER JOIN XMLTABLE('odemeList' PASSING x2.odemeList
                                        COLUMNS
                                                hasarTutari varchar2(10) PATH 'tutar'
                                    ) x3 ON 1=1
                        )  v where trim(v.plakailkodu) = substr('00'||trim(p_plakaIlKodu),-3) and trim(v.plakaNo) = trim(p_plakaNo)
                                and to_date(substr(v.policeBitisTarihi,1,10),'YYYY-MM-DD') between to_char(sysdate-30,'DD/MM/YYYY') and to_char(sysdate+45,'DD/MM/YYYY')
                         group by v.system_date, v.policeNo,v.yenilemeno ,v.policeEkino ,v.zeylTuru ,v.iptalmi, v.mebiptalmi, v.policeBaslamaTarihi
                         ,v.policeBitisTarihi, v.policeEkiBaslamaTarihi ,v.aracMarkaKodu ,v.aracTarifeGrupKodu ,v.aracTipKodu
                         ,v.kullanimSekli, v.modelYili ,v.plakaIlKodu ,v.plakaNo ,v.uygulananKademe,v.rucudusulmustutar, v.dosyaDurumKodu, v.hasarDosyaNo,
                          v.kaskoHasarTipi, v.hasarNedenTipi, v.rucuOrani,v.hasarTutari
            ) y group by system_date, policeno, yenilemeno, policeekino, zeylturu, iptalmi, mebiptalmi, policebaslamatarihi, policebitistarihi, policeekibaslamatarihi,
            aracmarkakodu, aractarifegrupkodu, aractipkodu, kullanimsekli, modelyili, plakailkodu, plakano, uygulananKademe
            having mebiptalmi<>1
        ) z;
    else
        s_camHasarSayisi := 0;
        s_kismiHasarSayisi := 0;
    end if;

    s_Result:= to_char(s_kismiHasarSayisi) || '-' || to_char(s_camHasarSayisi) ;

    RETURN s_Result;

    EXCEPTION WHEN OTHERS THEN
       v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       s_camHasarSayisi := 0;
       s_kismiHasarSayisi := 0;
       s_Result:= to_char(s_kismiHasarSayisi) || '-' || to_char(s_camHasarSayisi) ;
       return s_Result;
    end getKSKHasarSayisi;


    FUNCTION getKSKDonemselHasarSayisi (p_kimlikNo varchar2, p_plakaIlKodu varchar2, p_plakaNo varchar2, p_xml_value in CLOB, p_geriyegunbasla NUMBER, p_geriyegunbitis NUMBER)
    RETURN VARCHAR2 AS
    s_Result VARCHAR2(100);
    s_camHasarSayisi NUMBER(11);
    s_kismiHasarSayisi NUMBER(11);
    s_minTutarHasarSayisi NUMBER(11);
    s_agirHasarTipi NUMBER(1);
    v_errm VARCHAR2(4000);
    s_ortalamaHasarTutar NUMBER(11,2);
    BEGIN

    if LENGTH(p_kimlikNo) = 11 then
        select sum(NVL((z.kismiHasarsayisi),0)), sum(NVL((z.camHasarSayisi),0)), sum(NVL((z.minTutarHasarSayisi),0)), max((case when agirHasarTipi in('17','18','19') then '1' else '0' end)), sum(hasarOrtalama)
        into s_kismiHasarSayisi, s_camHasarSayisi, s_minTutarHasarSayisi, s_agirHasarTipi, s_ortalamaHasarTutar
        from
        (
            select SUM(kismihasarsayisi) as kismiHasarsayisi, SUM(camhasarsayisi) as camHasarSayisi, sum(minTutarHasarSayisi) as minTutarHasarSayisi,
                   round(nvl(case when iptalmi=1 then to_date(substr(policeekibaslamatarihi,1,10),'YYYY-MM-DD') - to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD')
                                    else case when to_date(substr(policebitistarihi,1,10),'YYYY-MM-DD')>system_date then system_date-to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD')
                                    else to_date(substr(policebitistarihi,1,10),'YYYY-MM-DD')-to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD') end
                                    end,0)/365,2) as sigortalilikSuresi, max(agirHasarTipi) agirHasarTipi, avg(rucudusulmustutar) hasarOrtalama
            from
            (
                select
                    v.*,
                    SUM(case when dosyadurumkodu is not null then 1 else 0 end) hasarsayisi,
                    sum(case when (kaskoHasarTipi in('2', '3')  or kaskoHasarTipi is null) and dosyaDurumKodu not in ('3','4') and (rucuOrani != '100' or rucuorani is null) then 1 else 0 end) kismiHasarSayisi,
                    sum(case when hasarNedenTipi='20' and dosyaDurumKodu not in ('3','4') and (rucuOrani != '100' or rucuorani is null) then 1 else 0 end) camHasarSayisi,
                    sum(case when (rucuOrani != '100' or rucuorani is null) and dosyaDurumKodu not in ('3','4')  then 1 else 0 end) rucusuzHasarSayisi,
                    (case when sum(rucudusulmustutar)<200 and (kaskoHasarTipi in('2', '3')  or kaskoHasarTipi is null) and nvl(hasarTutari,0)!=0 and (dosyaDurumKodu not in ('3','4') or dosyaDurumKodu is null) and (rucuOrani != '100' or rucuorani is null) then 1 else 0 end) minTutarHasarSayisi
                    from
                        ( select distinct x2.hasarDosyaNo, t.system_date, x.policeNo ,x.yenilemeno ,x.policeEkino ,x.zeylTuru ,
                                case when x.zeylTuru in(8,9,13,38,43,44) then 1 else 0 end iptalmi,
                                case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi,
                                x.policeBaslamaTarihi ,x.policeBitisTarihi ,x.policeEkiBaslamaTarihi
                                ,x.aracMarkaKodu ,x.aracTarifeGrupKodu ,x.aracTipKodu ,x.kullanimSekli ,x.modelYili ,x.plakaIlKodu ,x.plakaNo ,x.uygulananKademe,
                                x2.dosyaDurumKodu, x2.kaskoHasarTipi, x2.hasarNedenTipi, nvl(x2.rucuOrani,0) rucuorani,(nvl(x2.hasarTutari,0) + nvl(x2.muallakhasarTutari,0)) hasartutari, (case when x2.hasarDosyaNo is not null then (case when length(trim(x2.hasartutari+x2.muallakhasarTutari))>0 and length(trim(nvl(x2.rucuorani,0))) >0 then ((nvl(x2.hasartutari,0)+nvl(x2.muallakhasarTutari,0))*(100-nvl(x2.rucuorani,0))/100) else (7500*(100-nvl(x2.rucuorani,0))/100) end) else 0 end) as rucudusulmustutar, x2.agirHasarTipi
                                from
                                (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(p_xml_value) data from dual) t,
                                    XMLTABLE ('/ovmkaskoPoliceByTckSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'      PASSING t.data
                                               COLUMNS
                                                 policeNo VARCHAR2(30) PATH 'policeNo',
                                                 yenilemeno VARCHAR2(3) PATH 'yenilemeNo',
                                                 policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                                 zeylTuru VARCHAR2(3) PATH 'zeylTuru',
                                                 policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                                                 policeBitisTarihi varchar2(30) PATH 'policeBitisTarihi',
                                                 policeEkiBaslamaTarihi varchar2(30) PATH 'policeEkiBaslamaTarihi',
                                                 aracMarkaKodu varchar2(4) PATH 'arac/aracMarkaKodu',
                                                 aracTarifeGrupKodu varchar2(4) PATH 'arac/aracTarifeGrupKodu',
                                                 aracTipKodu varchar2(4) PATH 'arac/aracTipKodu',
                                                 kullanimSekli varchar2(4) PATH 'arac/kullanimSekli',
                                                 modelYili varchar2(4) PATH 'arac/modelYili',
                                                 plakaIlKodu varchar2(4) PATH 'arac/plakaIlKodu',
                                                 plakaNo varchar2(10) PATH 'arac/plakaNo',
                                                 uygulananKademe varchar2(2) PATH 'uygulananKademe',
                                                 hasarList xmltype PATH 'hasarList'
                                             ) x
                                    LEFT OUTER JOIN XMLTABLE('hasarList' PASSING x.hasarList
                                        COLUMNS
                                                hasarDosyaNo varchar2(100) PATH 'hasarDosyaNo',
                                                dosyaDurumKodu varchar2(5) PATH 'dosyaDurumKodu',
                                                kaskoHasarTipi varchar2(5) PATH 'kaskoHasarTipi',
                                                hasarNedenTipi varchar2(5) PATH 'hasarNedenTipi',
                                                rucuOrani varchar2(5) PATH 'rucuOrani',
                                                odemeList xmltype PATH 'odemeList',
                                                agirHasarTipi varchar2(2) PATH 'agirHasarTipi',
                                                hasarTutari varchar2(10) PATH 'toplamHasarMeblagi',
                                                muallakhasarTutari varchar2(10) PATH 'toplamMuallakTutari'
                                    ) x2 ON 1=1/*
                                    LEFT OUTER JOIN XMLTABLE('odemeList' PASSING x2.odemeList
                                        COLUMNS
                                                hasarTutari varchar2(10) PATH 'tutar'
                                    ) x3 ON 1=1*/
                        )  v --where trim(v.plakailkodu) = substr('00'||p_plakaIlKodu,-3) and trim(v.plakaNo) = p_plakaNo
                                where to_date(substr(v.policeBaslamaTarihi,1,10),'YYYY-MM-DD') >= (sysdate-p_geriyegunbasla) and to_date(substr(v.policeBaslamaTarihi,1,10),'YYYY-MM-DD') <= (sysdate-p_geriyegunbitis)
                         group by v.hasarDosyaNo, v.system_date, v.policeNo,v.yenilemeno ,v.policeEkino ,v.zeylTuru ,v.iptalmi, v.mebiptalmi, v.policeBaslamaTarihi
                         ,v.policeBitisTarihi, v.policeEkiBaslamaTarihi ,v.aracMarkaKodu ,v.aracTarifeGrupKodu ,v.aracTipKodu
                         ,v.kullanimSekli, v.modelYili ,v.plakaIlKodu ,v.plakaNo ,v.uygulananKademe,v.rucudusulmustutar, v.dosyaDurumKodu,
                          v.kaskoHasarTipi, v.hasarNedenTipi, v.rucuOrani,v.hasarTutari, v.agirHasarTipi
            ) y group by system_date, policeno, yenilemeno, policeekino, zeylturu, iptalmi, mebiptalmi, policebaslamatarihi, policebitistarihi, policeekibaslamatarihi,
            aracmarkakodu, aractarifegrupkodu, aractipkodu, kullanimsekli, modelyili, plakailkodu, plakano, uygulananKademe, agirHasarTipi
            having mebiptalmi<>1
        ) z;
        if s_minTutarHasarSayisi > 0 then
            s_kismiHasarSayisi := s_kismiHasarSayisi-1;
        end if;
    else
        s_camHasarSayisi := 0;
        s_kismiHasarSayisi := 0;
    end if;

    s_Result:= to_char(s_kismiHasarSayisi) || '-' || to_char(s_agirHasarTipi) || '-' || to_char(s_ortalamaHasarTutar);

    RETURN s_Result;

    EXCEPTION WHEN OTHERS THEN
       v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       s_camHasarSayisi := 0;
       s_kismiHasarSayisi := 0;
       s_Result:= to_char(s_kismiHasarSayisi) || '-' || to_char(s_camHasarSayisi) ;
       return s_Result;
    end getKSKDonemselHasarSayisi;

    FUNCTION getTRFDonemselHasarSayisi (p_kimlikNo varchar2, p_plakaIlKodu varchar2, p_plakaNo varchar2, p_xml_value in CLOB, p_geriyegunbasla NUMBER, p_geriyegunbitis NUMBER)
    RETURN VARCHAR2 AS
    s_Result VARCHAR2(100);
    s_camHasarSayisi NUMBER(11);
    s_kismiHasarSayisi NUMBER(11);
    s_minTutarHasarSayisi NUMBER(11);
    s_agirHasarTipi NUMBER(1);
    v_errm VARCHAR2(4000);
    BEGIN

    if LENGTH(p_kimlikNo) = 11 then
       select count(distinct hasarDosyaNo) into s_kismiHasarSayisi from
            (select x.*,  x2.*, x3.*
                                            from
                                            (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(p_xml_value) data from dual) t,
                                                XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'      PASSING t.data
                                                           COLUMNS
                                                             tarihBil xmltype PATH 'tarihBilgileri',
                                                             policeAnahtari xmltype PATH 'policeAnahtari'
                                                         ) x
                                                LEFT OUTER JOIN XMLTABLE('tarihBilgileri' PASSING x.tarihBil
                                                    COLUMNS
                                                            baslangicTarihi varchar2(10) PATH 'baslangicTarihi'
                                                ) x2 ON 1=1
                                                LEFT OUTER JOIN XMLTABLE('policeAnahtari' PASSING x.policeAnahtari
                                                    COLUMNS
                                                            acenteKod varchar2(30) PATH 'acenteKod',
                                                            policeNo varchar2(30) PATH 'policeNo',
                                                            sirketKodu varchar2(5) PATH 'sirketKodu',
                                                            yenilemeNo varchar2(5) PATH 'yenilemeNo'
                                                ) x3 ON 1=1
                    union all
                    select x.*,  x2.*, x3.*
                                            from
                                            (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(p_xml_value) data from dual) t,
                                                XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler' PASSING t.data
                                                           COLUMNS
                                                             tarihBil xmltype PATH 'tarihBilgileri',
                                                             policeAnahtari xmltype PATH 'policeAnahtari'
                                                         ) x
                                                LEFT OUTER JOIN XMLTABLE('tarihBilgileri' PASSING x.tarihBil
                                                    COLUMNS
                                                            baslangicTarihi varchar2(10) PATH 'baslangicTarihi'
                                                ) x2 ON 1=1
                                                LEFT OUTER JOIN XMLTABLE('policeAnahtari' PASSING x.policeAnahtari
                                                    COLUMNS
                                                            acenteKod varchar2(30) PATH 'acenteKod',
                                                            policeNo varchar2(30) PATH 'policeNo',
                                                            sirketKodu varchar2(5) PATH 'sirketKodu',
                                                            yenilemeNo varchar2(5) PATH 'yenilemeNo'
                                                ) x3 ON 1=1
                                                ) t
                                                LEFT OUTER JOIN (select h.* from
            (select *
                                            from
                                            (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(p_xml_value) data from dual) t,
                                                XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/policeninHasarlari'      PASSING t.data
                                                           COLUMNS
                                                             policeAnahtari xmltype PATH 'policeAnahtari',
                                                             hasarDosyaDurumKod VARCHAR2(30) PATH 'hasarDosyaDurumKod',
                                                             hasarDosyaNo VARCHAR2(30) PATH 'hasarDosyaNo'
                                                         ) x
                                            LEFT OUTER JOIN XMLTABLE('policeAnahtari' PASSING x.policeAnahtari
                                                    COLUMNS
                                                            acenteKod varchar2(30) PATH 'acenteKod',
                                                            policeNo varchar2(30) PATH 'policeNo',
                                                            sirketKodu varchar2(5) PATH 'sirketKodu',
                                                            yenilemeNo varchar2(5) PATH 'yenilemeNo'
                                                ) x2 ON 1=1) h) k ON k.acentekod=t.acentekod and k.policeno=t.policeno and k.sirketkodu=t.sirketkodu and k.yenilemeno=t.yenilemeno
            where to_date(substr(BaslangicTarihi,1,10),'YYYY-MM-DD') >= (sysdate-p_geriyegunbasla) and to_date(substr(BaslangicTarihi,1,10),'YYYY-MM-DD') <= (sysdate-p_geriyegunbitis) and hasarDosyaDurumKod in('1','2','5');
    else
        s_kismiHasarSayisi := 0;
    end if;

    s_Result:= to_char(s_kismiHasarSayisi);

    RETURN s_Result;

    EXCEPTION WHEN OTHERS THEN
       v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       s_kismiHasarSayisi := 0;
       s_Result:= to_char(s_kismiHasarSayisi);
       return s_Result;
    end getTRFDonemselHasarSayisi;


    FUNCTION getTariffCheck(priceId varchar2)
        RETURN stablex
        PIPELINED IS
        rec srecordx;
        p_sql CLOB;
    BEGIN
        select t.psql into p_sql from pricing_tariff_log t where price_id = TO_NUMBER(priceId);
        execute immediate p_sql into rec;

        PIPE ROW (rec);
        RETURN;
    END getTariffCheck;

    /*************************************************************************************************************************************************************************/

    FUNCTION getTariff(productNo varchar2, tariffdate varchar2, kullanimsekli varchar2, kullanimtarzi varchar2, aracyasi varchar2, plakailkodu varchar2, tramerilce varchar2, yenilemeyeniiskod varchar2, sigortaliyas varchar2, aracbedeli varchar2, yakittipi varchar2, medenidurum varchar2, cocukdegiskeni varchar2, kismiHasarSayisi varchar2, sigortaliliksuresi varchar2, cinsiyet varchar2, hasarsizlikkademesi varchar2, markariskgrubu varchar2, camhasarsayisi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, filosegment varchar2, guncelbedel varchar2, sigortaliskor number, aracskor varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, markakodu varchar2)
        RETURN stablex

        PIPELINED IS

        rec            srecordx;
        v_sql CLOB;
        t_sql CLOB;
        d1_sql CLOB;
        d2_sql CLOB;
        s_PricingId NUMBER;
        p_systemdate VARCHAR2(10);
        p_systemtime VARCHAR2(25);
    BEGIN
        select seq_pricing_id.nextval into s_PricingId from dual;
        p_systemdate := to_char(SYSDATE,'DD/MM/YYYY');
        p_systemtime := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF');
        v_sql := 'select getTariff.getactivefactorsql1('||s_PricingId||','''||productNo||''', to_date('''||tariffdate||''',''DD/MM/YYYY''),'''||kullanimsekli||''','''|| kullanimtarzi||''','''|| aracyasi||''','''|| plakailkodu||''','''|| tramerilce||''','''|| yenilemeyeniiskod||''','''|| sigortaliyas||''','''|| aracbedeli||''','''|| yakittipi||''','''|| medenidurum||''','''|| cocukdegiskeni||''','''|| kismiHasarSayisi ||''','''|| sigortaliliksuresi||''','''|| cinsiyet||''','''|| hasarsizlikkademesi||''','''|| markariskgrubu||''','''|| camhasarsayisi||''','''|| pakettipi||''','''|| yenilemecamindirimi||''','''|| filosegment||''','''|| guncelbedel||''','''|| sigortaliskor||''','''|| aracskor||''','''|| surprim||''','''|| ozelindirim||''','''|| kullanimtipi||''','''|| yurtdisiay||''','''|| markakodu||''') from dual';
        d1_sql := 'select getTariff.getTariffDetay('''||productNo||''', to_date('''||tariffdate||''',''DD/MM/YYYY''),'''||kullanimsekli||''','''|| kullanimtarzi||''','''|| aracyasi||''','''|| plakailkodu||''','''|| tramerilce||''','''|| yenilemeyeniiskod||''','''|| sigortaliyas||''','''|| aracbedeli||''','''|| yakittipi||''','''|| medenidurum||''','''|| cocukdegiskeni||''','''|| kismiHasarSayisi ||''','''|| sigortaliliksuresi||''','''|| cinsiyet||''','''|| hasarsizlikkademesi||''','''|| markariskgrubu||''','''|| camhasarsayisi||''','''|| pakettipi||''','''|| yenilemecamindirimi||''','''|| filosegment ||''','''|| guncelbedel||''','''|| sigortaliskor||''','''|| aracskor||''','''|| surprim||''','''|| ozelindirim||''','''|| kullanimtipi||''','''|| yurtdisiay||''','''|| markakodu||''') from dual';
      execute immediate d1_sql into d2_sql;

      execute immediate v_sql into t_sql;
      execute immediate t_sql into rec;
                    addTariffLog(productNo,tariffdate,'','','','',plakailkodu,'','', '','',s_PricingId,'TARIFF','',d2_sql,cocukdegiskeni,sigortaliyas,aracyasi,kullanimtarzi,kullanimsekli,aracskor,cinsiyet,medenidurum,tramerilce,sigortaliskor,p_systemdate,p_systemtime,yakittipi,markakodu,aracbedeli,filosegment,markariskgrubu,yenilemeyeniiskod,  kismihasarsayisi,  sigortaliliksuresi, camhasarsayisi, 'MANUEL', rec.m1, rec.m2, rec.m3, rec.m4, rec.m5, rec.m6, null, NULL ,NULL,null,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, null, null, null, null, null, null,null, null, null, null, null, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
        PIPE ROW (rec);
        RETURN;
    END getTariff;

    FUNCTION getTariffSbm(productNo varchar2, tariffdate varchar2, kimlikNo varchar2, sasiNo varchar2, tescilSeriKod varchar2, tescilSeriNo varchar2, plakailkodu varchar2, plakaNo varchar2, aracbedeli varchar2, hasarsizlikkademesi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, guncelbedel varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, asbisNo varchar2, tescilTarihi VARCHAR2,trafigeCikisTarihi VARCHAR2)
        RETURN stablex
        PIPELINED IS
        rec            srecordx;
        v_sql CLOB;
        t_sql CLOB;
        clob_sbmValues CLOB;
        clob_aileSorgu CLOB;
        clob_sasiSorgu CLOB;
        clob_tcknSorgu CLOB;
        clob_adresSorgu CLOB;
        clob_tcknAracSorgu CLOB;
        clob_tcknPlakaSorgu CLOB;
        p_cocukdegiskeni VARCHAR2(4);
        p_aracyasi VARCHAR2(10);
        p_sigortaliyas VARCHAR2(10);
        p_aracskor VARCHAR2(10);
        p_kullanimsekli VARCHAR2(20);
        p_kullanimtarzi VARCHAR2(2);
        p_cinsiyeti VARCHAR(5);
        p_medenihali VARCHAR2(25);
        p_tramerilce VARCHAR2(7);
        p_sigortaliskor NUMBER;
        p_systemdate VARCHAR2(10);
        p_systemtime VARCHAR2(25);
        s_PricingId NUMBER;
        p_yakittipi VARCHAR2(15);
        v_errm CLOB;
        p_markakodu VARCHAR2(10);
        z_sql CLOB;
        d1_sql CLOB;
        d2_sql CLOB;
        p_aracbedeli NUMBER(15);
        p_filosegment VARCHAR2(2);
        p_markariskgrubu VARCHAR2(3);
        p_yenilemeyeniiskod VARCHAR2(3);
        p_kismihasarsayisi NUMBER;
        p_sigortaliliksuresi NUMBER;
        p_camhasarsayisi NUMBER;
        p_modelyili NUMBER;
    BEGIN
    select seq_pricing_id.nextval into s_PricingId from dual;
    p_systemdate := to_char(SYSDATE,'DD/MM/YYYY');
    p_systemtime := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF');
        -- SBM 'den veriler çekiliyor.
        select GETTARIFFTOSBM(kimlikNo, plakaIlKodu, plakaNo, tescilSeriKod, tescilSeriNo, sasiNo, '123', 'KSK', tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
        clob_aileSorgu := getSbmDetails(clob_sbmValues, 'aileSorgu');
        clob_sasiSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceBySasiSorgu');
        clob_tcknSorgu := getSbmDetails(clob_sbmValues, 'tcknSorgu');
        clob_adresSorgu := getSbmDetails(clob_sbmValues, 'adresSorgu');
        clob_tcknAracSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceByTckSorgu');
        clob_tcknPlakaSorgu := getSbmDetails(clob_sbmValues, 'ovmKaskoPoliceByKimlikPlakaSorgu');
        -- Tarife değişkenleri dolduruluyor.
        -- Null kontrolü yapılmalı.
        p_cocukdegiskeni := getCocukDegiskeni(clob_aileSorgu, to_date(tariffdate,'DD/MM/YYYY'));
        p_sigortaliyas := cast(to_char(sysdate,'YYYY') as number) - cast(substr(removeElement(getSbmDetails(clob_tcknSorgu, 'dogumTarihi'), 'dogumTarihi'),1,4) as number);
        p_modelyili := cast(substr(removeElement(getSbmDetails(clob_sasiSorgu, 'modelYili'), 'modelYili'),1,4) as number);
        p_aracyasi := cast(to_char(sysdate,'YYYY') as number) - p_modelyili;

        p_kullanimtarzi := cast(cast(removeElement(getSbmDetails(clob_sasiSorgu, 'aracTarifeGrupKodu'), 'aracTarifeGrupKodu') as number) as varchar2);
        select decode(p_kullanimtarzi,'1','Otomobil','2','','3','','4','','5','','6','','7','','8','','9','','10','','11','','12','','') into p_kullanimsekli from dual;

        p_aracskor := GETARACSKOR(clob_sasiSorgu,asbisNo,tescilSeriKod||tescilSeriNo,hasarsizlikkademesi,to_date(tariffdate,'DD/MM/YYYY'),tescilTarihi,trafigeCikisTarihi,p_modelyili,plakailkodu||plakaNo,s_PricingId);
        p_cinsiyeti := removeElement(getSbmDetails(clob_tcknSorgu, 'cinsiyeti'), 'cinsiyeti'); -- E - K
        p_medenihali := removeElement(getSbmDetails(clob_tcknSorgu, 'medeniHali'), 'medeniHali'); -- Evli - Bekar
        p_tramerilce := removeElement(getSbmDetails(clob_adresSorgu, 'ilceKod'), 'ilceKod');
        p_sigortaliskor := getSigortaliSkor (0, clob_tcknAracSorgu, kimlikNo, tariffdate, p_kullanimtarzi, hasarsizlikkademesi);
        p_markakodu := removeElement(getSbmDetails(clob_sasiSorgu, 'aracMarkaKodu'), 'aracMarkaKodu')||removeElement(getSbmDetails(clob_sasiSorgu, 'aracTipKodu'), 'aracTipKodu');
        p_yenilemeyeniiskod := getYenilemeYeniIsKod(tariffdate,clob_tcknPlakaSorgu,sasiNo,plakaNo,kimlikNo);
        p_kismihasarsayisi := 0;
        p_sigortaliliksuresi := 0;
        p_camhasarsayisi := 0;
        IF p_yenilemeyeniiskod = '051' OR p_yenilemeyeniiskod = '51' THEN p_yenilemeyeniiskod := '51'; ELSE p_yenilemeyeniiskod := '99'; END IF;

        z_sql := 'select count(0) from t001c002u100501 a where a.k1='''||p_markakodu
                                                                        ||''' and a.k2='''||removeElement(getSbmDetails(clob_sasiSorgu, 'modelYili'), 'modelYili')||'''
                                                                        and a.k3='''||p_kullanimtarzi||'''
                                                                        and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100501 b where b.k1=a.k1
                                                                                                        and b.k2=a.k2
                                                                                                        and b.k3=a.k3
                                                                                                        and b.gecer_tarih<=to_date('''||tariffdate||''',''DD/MM/YYYY'')) and rownum=1';
        execute immediate z_sql into p_yakittipi;
        IF p_yakittipi='0' THEN p_yakittipi := 'Diğer'; ELSE
            z_sql := 'select trim(a.D11), trim(a.d3) from t001c002u100501 a where a.k1='''||p_markakodu
                                                                                    ||''' and a.k2='''||removeElement(getSbmDetails(clob_sasiSorgu, 'modelYili'), 'modelYili')||'''
                                                                                    and a.k3='''||p_kullanimtarzi||'''
                                                                                    and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100501 b where b.k1=a.k1
                                                                                                                    and b.k2=a.k2
                                                                                                                    and b.k3=a.k3
                                                                                                                    and b.gecer_tarih<=to_date('''||tariffdate||''',''DD/MM/YYYY'')) and rownum=1';
            execute immediate z_sql into p_yakittipi, p_markariskgrubu;
        END IF;

        IF aracbedeli is null or aracbedeli='0' THEN
            z_sql := 'select trim(a.D1) from t001c002u100500 a where a.k1='''||p_markakodu ||''' and a.k2='''||removeElement(getSbmDetails(clob_sasiSorgu, 'modelYili'), 'modelYili')||'''
                                                                                    and a.k3='''||p_kullanimtarzi||'''
                                                                                    and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100500 b where b.k1=a.k1
                                                                                                                    and b.k2=a.k2
                                                                                                                    and b.k3=a.k3
                                                                                                                    and b.gecer_tarih<=to_date('''||tariffdate||''',''DD/MM/YYYY''))';
            execute immediate z_sql into p_aracbedeli;
        ELSE
            p_aracbedeli := aracbedeli;
        END IF;
        -- * XML'den alınacak.   T Tablodan çekilecek.   P Parametre olarak gelecek.
        -- *P p_hasarsizlikkademesi
        --select count(0) into p_filosegment from t001c002u100081 a where (a.k1=kimlikno or a.k2=kimlikno) and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100081 b where a.k1=kimlikno or a.k2=kimlikno) and rownum=1;
        --IF p_filosegment <> '0' THEN
        --    select a.D7 into p_filosegment from t001c002u100081 a where (a.k1=kimlikno or a.k2=kimlikno) and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100081 b where a.k1=kimlikno or a.k2=kimlikno) and rownum=1;
        --END IF;
        v_sql := 'select getTariff.getactivefactorsql1('||s_PricingId||','''||productNo||''', to_date('''||tariffdate||''',''DD/MM/YYYY''),'''||p_kullanimsekli||''','''|| p_kullanimtarzi||''','''|| p_aracyasi||''','''|| plakailkodu||''','''|| p_tramerilce||''','''|| p_yenilemeyeniiskod||''','''|| p_sigortaliyas||''','''|| p_aracbedeli||''','''|| p_yakittipi||''','''|| p_medenihali||''','''|| p_cocukdegiskeni||''','''|| p_kismiHasarSayisi ||''','''|| p_sigortaliliksuresi||''','''|| p_cinsiyeti||''','''|| hasarsizlikkademesi||''','''|| p_markariskgrubu||''','''|| p_camhasarsayisi||''','''|| pakettipi||''','''|| yenilemecamindirimi||''','''|| p_filosegment ||''','''|| guncelbedel||''','''|| p_sigortaliskor||''','''|| p_aracskor||''','''|| surprim||''','''|| ozelindirim||''','''|| kullanimtipi||''','''|| yurtdisiay||''','''|| p_markakodu||''') from dual';
        d1_sql := 'select getTariff.getTariffDetay('''||productNo||''', to_date('''||tariffdate||''',''DD/MM/YYYY''),'''||p_kullanimsekli||''','''|| p_kullanimtarzi||''','''|| p_aracyasi||''','''|| plakailkodu||''','''|| p_tramerilce||''','''|| p_yenilemeyeniiskod||''','''|| p_sigortaliyas||''','''|| p_aracbedeli||''','''|| p_yakittipi||''','''|| p_medenihali||''','''|| p_cocukdegiskeni||''','''|| p_kismiHasarSayisi ||''','''|| p_sigortaliliksuresi||''','''|| p_cinsiyeti||''','''|| hasarsizlikkademesi||''','''|| p_markariskgrubu||''','''|| p_camhasarsayisi||''','''|| pakettipi||''','''|| yenilemecamindirimi||''','''|| p_filosegment ||''','''|| guncelbedel||''','''|| p_sigortaliskor||''','''|| p_aracskor||''','''|| surprim||''','''|| ozelindirim||''','''|| kullanimtipi||''','''|| yurtdisiay||''','''|| p_markakodu||''') from dual';
        execute immediate d1_sql into d2_sql;
        execute immediate v_sql into t_sql;
        execute immediate t_sql into rec;
                    addTariffLog(productNo,tariffdate,kimlikNo,sasiNo,tescilSeriKod,tescilSeriNo,plakailkodu,plakaNo,asbisNo, tescilTarihi,trafigeCikisTarihi,s_PricingId,'TARIFF','',d2_sql,p_cocukdegiskeni,p_sigortaliyas,p_aracyasi,p_kullanimtarzi,p_kullanimsekli,p_aracskor,p_cinsiyeti,p_medenihali,p_tramerilce,p_sigortaliskor,p_systemdate,p_systemtime,p_yakittipi,p_markakodu,p_aracbedeli,p_filosegment,p_markariskgrubu,p_yenilemeyeniiskod,  p_kismihasarsayisi,  p_sigortaliliksuresi, p_camhasarsayisi, 'SBM', rec.m1, rec.m2, rec.m3, rec.m4, rec.m5, rec.m6, null, NULL ,NULL,null,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, null, '1', null, null, null, null,null, null, null, null, null, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
        PIPE ROW (rec);
        RETURN;
        EXCEPTION WHEN OTHERS THEN
            v_errm := SUBSTR(SQLERRM, 1, 4000);
            addTariffLog(productNo,tariffdate,kimlikNo,sasiNo,tescilSeriKod,tescilSeriNo,plakailkodu,plakaNo,asbisNo, tescilTarihi,trafigeCikisTarihi,s_PricingId,'TARIFF',v_errm,v_sql,p_cocukdegiskeni,p_sigortaliyas,p_aracyasi,p_kullanimtarzi,p_kullanimsekli,p_aracskor,p_cinsiyeti,p_medenihali,p_tramerilce,p_sigortaliskor,p_systemdate,p_systemtime,p_yakittipi, p_markakodu,p_aracbedeli,p_filosegment,p_markariskgrubu,p_yenilemeyeniiskod,  p_kismihasarsayisi,  p_sigortaliliksuresi,  p_camhasarsayisi, 'SBM', 99,99,99,99,99,99, null, NULL ,NULL,null,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, null, '0', null, null, null, null,null, null, null, null, null, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
        RETURN;
    END getTariffSbm;

    FUNCTION getTariffMain(productNo varchar2,TariffDate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,tescilTarihi varchar2,trafigeCikisTarihi varchar2,referansPoliceBilgileri varchar2,kullanimSekli varchar2,model varchar2,markaTipKodu varchar2,hasarsizlikKademesi varchar2,yakitTipi varchar2,aracBedeli varchar2,kasaBedeli varchar2,tasinanEmtiaBedeli varchar2,tasinanEmtiaCinsi varchar2,sesGoruntuCihaziBedeli varchar2,digerAksesuarBedeli varchar2,yurtDisiTeminatiSuresi varchar2,trafikKademesi varchar2,paketTipi varchar2,kullanimTipi varchar2,OzelIndirim number,surprim number,meslek varchar2, kullanimTarzi varchar2, kiymetKazanma varchar2, sigortaliliksuresi number, kismihasarsayisi varchar2, camhasarsayisi varchar2, minimumFiyatKorunsunMu varchar2, minimumPrimKorunsunMu varchar2, acente varchar2, kullaniciAdi varchar2, referancePriceId varchar2, camMuafiyetIstisnasi varchar2, yenilemePrimKontroluCalissinMi varchar2, immSorumlulukTeminatLimiti varchar2, fkSigortaliTeminatLimiti varchar2, fkKoltukTeminatLimiti varchar2, maneviTazminatLimiti varchar2, koltukSayisi varchar2, YolYardimAlternatifTeminat varchar2)
        RETURN stablex
        PIPELINED IS
        rec            srecordx;
        v_sql CLOB;
        t_sql CLOB;
        auth VARCHAR2(4000);
        clob_sbmValues CLOB;
        clob_aileSorgu CLOB;
        clob_sasiSorgu CLOB;
        clob_tcknSorgu CLOB;
        clob_adresSorgu CLOB;
        clob_tcknAracSorgu CLOB;
        clob_tcknPlakaSorgu CLOB;
        clob_egmSorgu CLOB;
        p_cocukdegiskeni VARCHAR2(5);
        p_aracyasi VARCHAR2(10);
        p_aracyasgrubu VARCHAR2(10);
        p_sigortaliyas VARCHAR2(10);
        p_aracskor VARCHAR2(10);
        p_kullanimsekli VARCHAR2(20);
        p_kullanimtarzi100501 VARCHAR2(2);
        p_kullanimtarzi VARCHAR2(2);
        p_kullanimTipiCap VARCHAR2(1);
        p_cinsiyeti VARCHAR(5);
        p_medenihali VARCHAR2(25);
        p_tramerIl VARCHAR2(3);
        p_tramerilce VARCHAR2(7);
        p_sigortaliskor NUMBER;
        p_otor_sigortaliskor NUMBER;
        p_systemdate VARCHAR2(10);
        p_systemtime VARCHAR2(25);
        s_PricingId NUMBER;
        p_yakittipi VARCHAR2(15);
        v_errm CLOB;
        p_markatipkodu VARCHAR2(10);
        p_markakodu VARCHAR2(10);
        z_sql CLOB;
        d1_sql CLOB;
        d2_sql CLOB;
        p_meslek varchar2(20);
        p_yeniaracbedel NUMBER(15);
        p_aracbedeli NUMBER(15);
        p_filosegment VARCHAR2(3);
        p_markariskgrubu VARCHAR2(3);
        p_yenilemeyeniiskod VARCHAR2(3);
        p_kismihasarsayisi NUMBER;
        p_sigortaliliksuresi NUMBER;
        p_camhasarsayisi NUMBER;
        p_sql CLOB;
        p_model NUMBER(4);
        p_minimumprim NUMBER(11,2);
        p_minimumfiyat NUMBER(11,5);
        p_egmkaydivarmi VARCHAR2(1);
        p_yenilemeMi VARCHAR2(1);
        p_kasabedeli NUMBER(11,2);
        p_digerAksesuarBedeli NUMBER(11,2);
        p_yenilemeCapIndirimi NUMBER;
        p_guncelbedel VARCHAR2(1);
        p_ilkAracBedeli NUMBER(15);
        p_commercialScore VARCHAR2(10);
        p_commercialScoreId NUMBER(20);
        p_hasarsizlikOran VARCHAR2(10);
        p_ilkAracYas VARCHAR2(10);
        p_ozelIndirim NUMBER(11,5);
        p_surprim NUMBER(11,5);
        p_plakaIlKodu VARCHAR2(3);
        p_ilkPlakaIlKodu VARCHAR2(3);
        p_plakaNo VARCHAR2(25);
        p_gecmisHasarSayisi VARCHAR2(5);
        p_gecmisHasarsizlikIndirimi VARCHAR2(5);
        p_gecmisPoliceFiyat NUMBER(11,5);
        p_yenilemeCapMin VARCHAR2(15);
        p_yenilemeCapMax VARCHAR2(15);
        p_yenilemeCap VARCHAR(15);
        p_yenilemeFloor VARCHAR(15);
        p_plaka100502 NUMBER;
        p_filoSegmentD VARCHAR2(10);
        p_filoSegmentSql CLOB;
        p_ozelTuzel VARCHAR2(1);
        p_ticariFaktor NUMBER;
        p_minimumFiyatKorunsunMu VARCHAR2(1);
        p_agirlik VARCHAR2(5);
        p_beygirGucu VARCHAR2(5);
        p_whp varchar2(5);
        p_aracSegment varchar2(7);
        p_kasaTipi varchar(30);
        p_cache number;
        p_capPolice varchar2(30);
        p_tcknSorguKontrol varchar2(1);
        s_key varchar2(4000);
        p_tariffDate Date;
        p_var varchar2(4000);
        refproductNo varchar2(50);
refTariffdate varchar2(50);
refkimlikNo varchar2(50);
refsasiNo varchar2(50);
reftescilSeriKod varchar2(50);
reftescilSeriNo varchar2(50);
refplakailkodu varchar2(50);
refplakaNo varchar2(50);
refasbisNo varchar2(50);
reftescilTarihi varchar2(50);
reftrafigeCikisTarihi varchar2(50);
refreferansPoliceBilgileri varchar2(50);
refkullanimSekli varchar2(50);
refmodel varchar2(50);
refmarkaTipKodu varchar2(50);
refhasarsizlikKademesi varchar2(50);
refyakitTipi varchar2(50);
refaracBedeli varchar2(50);
refkasaBedeli varchar2(50);
reftasinanEmtiaBedeli varchar2(50);
reftasinanEmtiaCinsi varchar2(50);
refsesGoruntuCihaziBedeli varchar2(50);
refdigerAksesuarBedeli varchar2(50);
refyurtDisiTeminatiSuresi varchar2(50);
reftrafikKademesi varchar2(50);
refpaketTipi varchar2(50);
refkullanimTipi varchar2(50);
refOzelIndirim varchar2(50);
refsurprim varchar2(50);
refmeslek varchar2(50);
refkullanimTarzi varchar2(50);
refkiymetKazanma varchar2(50);
refsigortaliliksuresi varchar2(50);
refkismihasarsayisi varchar2(50);
refcamhasarsayisi varchar2(50);
refminimumFiyatKorunsunMu varchar2(50);
refminimumPrimKorunsunMu varchar2(50);
refacente varchar2(50);
refkullaniciAdi varchar2(50);
refreferancePriceId varchar2(50);
checkRef varchar2(1);
refp_cocukdegiskeni varchar2(50);
refp_sigortaliyas varchar2(50);
refp_aracyasi varchar2(50);
refp_aracskor varchar2(50);
refp_sigortaliskor varchar2(50);
refp_yakittipi varchar2(50);
refp_commercialScore varchar2(50);
refp_medenihali varchar2(50);
refp_yenilemeyeniiskod varchar2(50);
checkReferansId number;
p_kiymetKazanma varchar2(5);
p_kskGenelBilgi varchar2(100);
p_ksk_sigortalilikSuresi NUMBER(11,2);
p_ksk_camHasarSayisi NUMBER;
p_ksk_kismiHasarSayisi NUMBER;
p_hasarsizlikKademesi varchar2(5);
p_eskiPolSirketKodu varchar2(3);
p_eskiPolAcenteNo varchar2(10);
p_eskiPolPoliceNo varchar2(30);
p_eskiPolYenilemeNo varchar2(2);
p_kaskoReferansSorgu varchar2(200);
p_kaskoReferansKullanimTarzi varchar2(2);
p_kaskoRefPlakaIlKodu varchar2(3);
p_yasayanOtoUrun varchar2(2);
p_pertarac varchar2(2);
p_teenCocuk varchar2(2);
p_ErkekTeenCocuk varchar2(2);
p_cache_key varchar2(2000);
p_m19 number(11,5);
/*
p_immPrim NUMBER;
p_fkSigortaliPrim NUMBER;
p_fkPrim NUMBER;
p_sesGoruntuCihaziFiyat NUMBER;
p_tasinanEmteaFiyat NUMBER;
p_koltukSayisi varchar2(3);
p_hukuksalKorumaPrim NUMBER;
p_miniOnarimPrim NUMBER;
p_yanlisAkaryakitPrim NUMBER;
p_yolYardimPrim NUMBER;

ACİL TIBBİ YARDIM   GÖZ MUAYENESİ   KİLİT MEKANİZMA DEG.    KİŞİSEL EŞYA    YURTİÇİ TAŞIYICI SORUM.
*/
prm_acilTibbiYardim NUMBER;
prm_gozMuayenesi NUMBER;
prm_kilitMekanizmaDeg NUMBER;
prm_kisiselEsya NUMBER;
prm_yurticiTasiyiciSrm NUMBER;
prm_miniOnarim NUMBER;
prm_imm NUMBER;
prm_fk NUMBER;
prm_hukuksalKoruma NUMBER;
prm_gelirKaybi NUMBER;
prm_tasinanEmtea NUMBER;
prm_asistans NUMBER;
prm_diger NUMBER;

p_aracBedelGrubu varchar2(2);

p_kskHasarSayisi varchar2(100);
p_Otor_camHasarSayisi NUMBER;
p_Otor_kismiHasarSayisi NUMBER;
p_ililcekontrol NUMBER;
p_aracyerliyabanci varchar2(5);
p_garaj varchar2(5);
p_resmidaire varchar2(5);
p_servis varchar2(5);
p_muafiyet varchar2(5);
p_anlasmaliServis varchar2(5);
p_parcaTuru varchar2(5);
p_servisTuru varchar2(5);
p_surucu1 varchar2(5);
p_surucu2 varchar2(5);
p_surucuInd varchar2(5);
p_debugmode varchar2(1);
p_acenteCarpan NUMBER;
p_kontrol1 number;
p_kontrol2 number;
p_kontrol3 number;
p_kontrol4 number;
p_ilKontrol number;
s8000 varchar2(5);
s8060 varchar2(5);
p_kontrol5 number;
        eurocar_segment varchar2(30);
        eurocar_kasatipi varchar2(30);
        eurocar_sanziman varchar2(30);
        cnt99 NUMBER;
        NBRENEWAL2 VARCHAR2(30);
        p_MARKATIPGRUP VARCHAR2(50);
        p_ililcegrup varchar2(50);
        p_ilceAd varchar2(20);
        p_ilAd varchar2(20);
        p_kismiHasarSayisi1 varchar2(10);
        p_camHasarSayisi1 varchar2(10);
        p_kismiHasarSayisi2 varchar2(10);
        p_camHasarSayisi2 varchar2(10);
        p_kismiHasarSayisi3 varchar2(10);
        p_camHasarSayisi3 varchar2(10);
        p_kskDonemselHasarSayisi varchar2(100);
        birYilOncekiHasar varchar2(2);
        ikiYilOncekiHasar varchar2(2);
        ucYilOncekiHasar varchar2(2);
        aracCoklugu varchar2(1);
        p_filokontrol number;
        p_yenilemeYeniIsKodNew varchar2(3);
        p_agirHasar1 varchar2(1);
        p_agirHasar2 varchar2(1);
        p_agirHasar3 varchar2(1);
        p_oncekiHasarsizlikKademe varchar2(2);
        p_toplamprim number;
        p_toplamprimcap number;
        p_tmpPrim number;
        p_Otor_nihaiHasarSayisi number;
        p_cachedays number;
        p_gecmisUrunKod number;
        p_gecmisPoliceNo number;
        p_gecmisYenilemeNo number;
        p_gecmisServisTuru varchar2(2);
        p_pakettipi varchar2(1);
        p_kimlikNo varchar2(11);
        sonucyilhasar varchar2(2);
        p_ortalamaHasarTutar1 number(11,2);
        p_ortalamaHasarTutar2 number(11,2);
        p_ortalamaHasarTutar3 number(11,2);
        p_birYilOncekiHasarTutariArac number(11,2);
        maxDiscount number(11,2);
        clob_TRFKimlikSasi clob;
        p_trfKademe varchar2(2);
        p_filokontrolminprm varchar2(1);
        p_filokontrolassist varchar2(1);
--p_tasinanEmteaPrim NUMBER;

    BEGIN
    p_debugmode:='0';
/* yenileme cap indirim yapısı tasarlanmalı. Cap ve floor aynı tabloda (Winsure) */
    p_sql := 'select * from table(getTariff.getTariffMain('''||productNo||''','''||Tariffdate ||''','''||kimlikNo ||''','''||sasiNo ||''','''||tescilSeriKod ||''','''||
    tescilSeriNo ||''','''||plakailkodu ||''','''||plakaNo ||''','''||asbisNo ||''','''||tescilTarihi ||''','''||trafigeCikisTarihi ||''','''||
    referansPoliceBilgileri ||''','''||kullanimSekli ||''','''||model ||''','''||markaTipKodu ||''','''||hasarsizlikKademesi ||''','''||yakitTipi ||''','''||
    aracBedeli ||''','''||kasaBedeli ||''','''||tasinanEmtiaBedeli ||''','''||tasinanEmtiaCinsi ||''','''||sesGoruntuCihaziBedeli ||''','''||
    digerAksesuarBedeli ||''','''||yurtDisiTeminatiSuresi ||''','''||trafikKademesi ||''','''||paketTipi ||''','''||kullanimTipi ||''','''||
    OzelIndirim ||''','''||surprim ||''','''||meslek||''','''||kullanimTarzi||''','''||kiymetKazanma||''','''||sigortaliliksuresi||''','''||
    kismihasarsayisi||''','''||camhasarsayisi||''','''||minimumFiyatKorunsunMu||''','''||minimumPrimKorunsunMu ||''','''||acente||''','''||kullaniciAdi||''','''||
    referancePriceId||''','''||camMuafiyetIstisnasi||''','''||yenilemePrimKontroluCalissinMi    ||''','''||immSorumlulukTeminatLimiti ||''','''||
    fkSigortaliTeminatLimiti||''','''||fkKoltukTeminatLimiti||''','''||maneviTazminatLimiti||''','''||koltukSayisi||''','''||YolYardimAlternatifTeminat||'''))';

        if p_debugmode='1' then addlog ('','1', ''); end if;

    if pakettipi is not null and pakettipi!='0' then
        p_pakettipi := pakettipi;
    else
        p_pakettipi := '1';
    end if;

    p_surucuInd := '0';
    if trim(p_surucu1) is not null then
        if trim(p_surucu2) is not null then
            p_surucuInd := '2';
        else
            p_surucuInd := '1';
        end if;
    end if;


    select count(0) into maxDiscount from tnswin.pricing_tables bb where bb.key1=acente and bb.table_code = 'KSK-MAX YETKILI INDIRIM' and bb.valid_date=(select max(bbb.valid_date) from tnswin.pricing_tables bbb where bbb.table_code=bb.table_code and bbb.key1=bb.key1 and bbb.valid_Date<=tariffDate);
    if maxDiscount > 0 then
        select bb.mult1 into maxDiscount from tnswin.pricing_tables bb where bb.key1=acente and bb.table_code = 'KSK-MAX YETKILI INDIRIM' and bb.valid_date=(select max(bbb.valid_date) from tnswin.pricing_tables bbb where bbb.table_code=bb.table_code and bbb.key1=bb.key1 and bbb.valid_Date<=tariffDate);
    end if;


    if maxDiscount < 20 then maxDiscount := 20; end if;
if trunc(sysdate) < '02/02/2021' then
    if acente != 30458 then
        if OzelIndirim > maxDiscount then
            p_ozelIndirim := (100-maxDiscount)/100;
        else
            p_ozelIndirim := (100 - OzelIndirim)/100;
        end if;
    else
        if OzelIndirim > maxDiscount then
            p_ozelIndirim := (100-maxDiscount)/100;
        else
            p_ozelIndirim := (100 - OzelIndirim)/100;
        end if;
    end if;
elsif trunc(sysdate) > '02/03/2021' then
    if OzelIndirim >= 50 then
        p_ozelIndirim := 50/100;
    else
        p_ozelIndirim := (100 - OzelIndirim)/100;
    end if;
elsif trunc(sysdate) > '25/03/2021' then
    if OzelIndirim >= 20 then
        p_ozelIndirim := 80/100;
    else
        p_ozelIndirim := (100 - OzelIndirim)/100;
    end if;
else
    if OzelIndirim >= 35 then
        p_ozelIndirim := 65/100;
    else
        p_ozelIndirim := (100 - OzelIndirim)/100;
    end if;
end if;
/*
    if OzelIndirim > 15 then
        if acente != 30458 then
            p_ozelIndirim := 95/100;
        else
            p_ozelIndirim := 88/100;
        end if;
    else
        p_ozelIndirim := (100 - OzelIndirim)/100;
    end if;
*/

    p_surprim := (100+surprim)/100;

    p_tariffDate := TariffDate;
    p_cache_key := 'KSK'||','||kimlikNo||','||sasiNo;

    select count(0) into p_cachedays from tnswin.pricing_tables a where a.table_code='KSK-CACHE DAYS' and a.valid_date=(select max(b.valid_date) from tnswin.pricing_tables b where a.table_code=b.table_code and to_date(b.valid_date,'DD/MM/YYYY')<=to_char(sysdate,'DD/MM/YYYY'));
    if p_cachedays>0 then
        select a.mult1 into p_cachedays from tnswin.pricing_tables a where a.table_code='KSK-CACHE DAYS' and a.valid_date=(select max(b.valid_date) from tnswin.pricing_tables b where a.table_code=b.table_code and to_date(b.valid_date,'DD/MM/YYYY')<=to_char(sysdate,'DD/MM/YYYY'));
    end if;

--    select count(0) into p_cache from pricing_tariff_log where system_date=to_char(sysdate-p_cachedays,'DD/MM/YYYY') and cast(psql as varchar2(1000))=to_char(p_sql) and m1<>'99' and status='1';
    select count(0) into p_cache from pricing_tariff_log a where cast(a.psql as varchar2(1000))=to_char(p_sql) and a.m1<>'99' and a.status='1' and to_date(a.system_date||' '||substr(a.system_time,1,8),'DD/MM/YYYY HH24:MI:SS')=(select max(to_date(b.system_date||' '||substr(b.system_time,1,8),'DD/MM/YYYY HH24:MI:SS')) from tnswin.pricing_tariff_log b where cast(a.psql as varchar2(4000))=cast(b.psql as varchar2(4000)) and a.m1=b.m1 and a.status=b.status and to_date(b.system_date,'DD/MM/YYYY')>=to_char(sysdate-p_cachedays,'DD/MM/YYYY'));
    if p_cache=0 then
--    p_sigortalilikSuresi := cast(to_number('0'||sigortaliliksuresi) as varchar2);
    select seq_pricing_id.nextval into s_PricingId from dual;
    p_systemdate := to_char(SYSDATE,'DD/MM/YYYY');
    p_systemtime := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF');
        if p_debugmode='1' then addlog ('','2', ''); end if;
-- referans price id ile kontrol
if referancePriceId is not null and referancePriceId<>'0' then
    select count(0) into checkReferansId from pricing_tariff_log where price_id=referancePriceId;
    if checkReferansId>0 then
        select trim(p1),trim(p2),trim(p3),trim(p4),trim(p5),trim(p6),trim(p7),trim(p8),trim(p9),trim(p10),trim(p11),trim(p12),trim(p13),trim(p14),trim(p15),trim(p16),trim(p17),trim(p18),trim(p19),trim(p20),trim(p21),trim(p22),trim(p23),trim(p24),trim(p25),trim(p26),trim(p27),trim(p28),trim(p29),trim(p30),trim(p31),trim(p32),trim(p33),trim(p34),trim(p35),trim(p36),trim(p37),trim(p38),trim(p39),x.*
        into refproductNo,refTariffdate,refkimlikNo,refsasiNo,reftescilSeriKod,reftescilSeriNo,refplakailkodu,refplakaNo,refasbisNo,reftescilTarihi,reftrafigeCikisTarihi,refreferansPoliceBilgileri,refkullanimSekli,refmodel,refmarkaTipKodu,refhasarsizlikKademesi,refyakitTipi,refaracBedeli,refkasaBedeli,reftasinanEmtiaBedeli,reftasinanEmtiaCinsi,refsesGoruntuCihaziBedeli,refdigerAksesuarBedeli,refyurtDisiTeminatiSuresi,reftrafikKademesi,refpaketTipi,refkullanimTipi,refOzelIndirim,refsurprim,refmeslek,refkullanimTarzi,refkiymetKazanma,refsigortaliliksuresi,refkismihasarsayisi,refcamhasarsayisi,refminimumFiyatKorunsunMu,refminimumPrimKorunsunMu,refacente,refkullaniciAdi,refp_cocukdegiskeni,refp_sigortaliyas,refp_aracyasi,refp_aracskor,refp_sigortaliskor,refp_yakittipi,refp_commercialScore,refp_medenihali,refp_yenilemeyeniiskod
        from
        (select replace(cast(substr(psql,instr(psql,'(',1,2)+1,instr(psql,',',1,1)-instr(psql,'(',1,2)-1) as varchar2(100)),'''','') p1,
        replace(cast(substr(psql,instr(psql,',',1,1)+1,instr(psql,',',1,2)-instr(psql,',',1,1)-1)as varchar2(100)),'''','') p2,
        replace(cast(substr(psql,instr(psql,',',1,2)+1,instr(psql,',',1,3)-instr(psql,',',1,2)-1)as varchar2(100)),'''','') p3,
        replace(cast(substr(psql,instr(psql,',',1,3)+1,instr(psql,',',1,4)-instr(psql,',',1,3)-1)as varchar2(100)),'''','') p4,
        replace(cast(substr(psql,instr(psql,',',1,4)+1,instr(psql,',',1,5)-instr(psql,',',1,4)-1)as varchar2(100)),'''','') p5,
        replace(cast(substr(psql,instr(psql,',',1,5)+1,instr(psql,',',1,6)-instr(psql,',',1,5)-1)as varchar2(100)),'''','') p6,
        replace(cast(substr(psql,instr(psql,',',1,6)+1,instr(psql,',',1,7)-instr(psql,',',1,6)-1)as varchar2(100)),'''','') p7,
        replace(cast(substr(psql,instr(psql,',',1,7)+1,instr(psql,',',1,8)-instr(psql,',',1,7)-1)as varchar2(100)),'''','') p8,
        replace(cast(substr(psql,instr(psql,',',1,8)+1,instr(psql,',',1,9)-instr(psql,',',1,8)-1)as varchar2(100)),'''','') p9,
        replace(cast(substr(psql,instr(psql,',',1,9)+1,instr(psql,',',1,10)-instr(psql,',',1,9)-1)as varchar2(100)),'''','') p10,
        replace(cast(substr(psql,instr(psql,',',1,10)+1,instr(psql,',',1,11)-instr(psql,',',1,10)-1)as varchar2(100)),'''','') p11,
        replace(cast(substr(psql,instr(psql,',',1,11)+1,instr(psql,',',1,12)-instr(psql,',',1,11)-1)as varchar2(100)),'''','') p12,
        replace(cast(substr(psql,instr(psql,',',1,12)+1,instr(psql,',',1,13)-instr(psql,',',1,12)-1)as varchar2(100)),'''','') p13,
        replace(cast(substr(psql,instr(psql,',',1,13)+1,instr(psql,',',1,14)-instr(psql,',',1,13)-1)as varchar2(100)),'''','') p14,
        replace(cast(substr(psql,instr(psql,',',1,14)+1,instr(psql,',',1,15)-instr(psql,',',1,14)-1)as varchar2(100)),'''','') p15,
        replace(cast(substr(psql,instr(psql,',',1,15)+1,instr(psql,',',1,16)-instr(psql,',',1,15)-1)as varchar2(100)),'''','') p16,
        replace(cast(substr(psql,instr(psql,',',1,16)+1,instr(psql,',',1,17)-instr(psql,',',1,16)-1)as varchar2(100)),'''','') p17,
        replace(cast(substr(psql,instr(psql,',',1,17)+1,instr(psql,',',1,18)-instr(psql,',',1,17)-1)as varchar2(100)),'''','') p18,
        replace(cast(substr(psql,instr(psql,',',1,18)+1,instr(psql,',',1,19)-instr(psql,',',1,18)-1)as varchar2(100)),'''','') p19,
        replace(cast(substr(psql,instr(psql,',',1,19)+1,instr(psql,',',1,20)-instr(psql,',',1,19)-1)as varchar2(100)),'''','') p20,
        replace(cast(substr(psql,instr(psql,',',1,20)+1,instr(psql,',',1,21)-instr(psql,',',1,20)-1)as varchar2(100)),'''','') p21,
        replace(cast(substr(psql,instr(psql,',',1,21)+1,instr(psql,',',1,22)-instr(psql,',',1,21)-1)as varchar2(100)),'''','') p22,
        replace(cast(substr(psql,instr(psql,',',1,22)+1,instr(psql,',',1,23)-instr(psql,',',1,22)-1)as varchar2(100)),'''','') p23,
        replace(cast(substr(psql,instr(psql,',',1,23)+1,instr(psql,',',1,24)-instr(psql,',',1,23)-1)as varchar2(100)),'''','') p24,
        replace(cast(substr(psql,instr(psql,',',1,24)+1,instr(psql,',',1,25)-instr(psql,',',1,24)-1)as varchar2(100)),'''','') p25,
        replace(cast(substr(psql,instr(psql,',',1,25)+1,instr(psql,',',1,26)-instr(psql,',',1,25)-1)as varchar2(100)),'''','') p26,
        replace(cast(substr(psql,instr(psql,',',1,26)+1,instr(psql,',',1,27)-instr(psql,',',1,26)-1)as varchar2(100)),'''','') p27,
        replace(cast(substr(psql,instr(psql,',',1,27)+1,instr(psql,',',1,28)-instr(psql,',',1,27)-1)as varchar2(100)),'''','') p28,
        replace(cast(substr(psql,instr(psql,',',1,28)+1,instr(psql,',',1,29)-instr(psql,',',1,28)-1)as varchar2(100)),'''','') p29,
        replace(cast(substr(psql,instr(psql,',',1,29)+1,instr(psql,',',1,30)-instr(psql,',',1,29)-1)as varchar2(100)),'''','') p30,
        replace(cast(substr(psql,instr(psql,',',1,30)+1,instr(psql,',',1,31)-instr(psql,',',1,30)-1)as varchar2(100)),'''','') p31,
        replace(cast(substr(psql,instr(psql,',',1,31)+1,instr(psql,',',1,32)-instr(psql,',',1,31)-1)as varchar2(100)),'''','') p32,
        replace(cast(substr(psql,instr(psql,',',1,32)+1,instr(psql,',',1,33)-instr(psql,',',1,32)-1)as varchar2(100)),'''','') p33,
        replace(cast(substr(psql,instr(psql,',',1,33)+1,instr(psql,',',1,34)-instr(psql,',',1,33)-1)as varchar2(100)),'''','') p34,
        replace(cast(substr(psql,instr(psql,',',1,34)+1,instr(psql,',',1,35)-instr(psql,',',1,34)-1)as varchar2(100)),'''','') p35,
        replace(cast(substr(psql,instr(psql,',',1,35)+1,instr(psql,',',1,36)-instr(psql,',',1,35)-1)as varchar2(100)),'''','') p36,
        replace(cast(substr(psql,instr(psql,',',1,36)+1,instr(psql,',',1,37)-instr(psql,',',1,36)-1)as varchar2(100)),'''','') p37,
        replace(cast(substr(psql,instr(psql,',',1,37)+1,instr(psql,',',1,38)-instr(psql,',',1,37)-1)as varchar2(100)),'''','') p38,
        replace(cast(substr(psql,instr(psql,',',1,38)+1,instr(psql,')',1,1)-instr(psql,',',1,38)-1)as varchar2(100)),'''','') p39,
--        replace(cast(substr(psql,instr(psql,',',1,39)+1,instr(psql,')',1,1)-instr(psql,',',1,39)-1)as varchar2(100)),'''','') p40,
        xmltype(output) data
        from pricing_tariff_log where price_id=referancePriceId) t,
        XMLTABLE ('/Tariff/Calculated'      PASSING t.data
                        COLUMNS CocukDegiskeni VARCHAR2(30) PATH 'CocukDegiskeni',
                        SigortaliYas VARCHAR2(30) PATH 'SigortaliYas',
                        AracYasi VARCHAR2(30) PATH 'AracYasi',
                        AracSkor VARCHAR2(30) PATH 'AracSkor',
                    SigortaliSkor VARCHAR2(30) PATH 'SigortaliSkor',
                    YakitTipi VARCHAR2(30) PATH 'YakitTipi',
                    TuzelSkor VARCHAR2(30) PATH 'TuzelSkor',
                    MedeniHali VARCHAR2(30) PATH 'MedeniHali',
                    YenilemeYeniIsKod VARCHAR2(30) PATH 'YenilemeYeniIsKod') x;
        if kimlikNo=refkimlikNo and plakailkodu=refplakailkodu and /*plakaNo=refplakaNo and tescilSeriKod=reftescilSeriKod and tescilSeriNo=reftescilSeriNo and*/ sasino=refsasiNo then
            checkRef := '0';
        end if;

        if /*model != refmodel and */markaTipKodu!=refmarkaTipKodu and sasiNo!=refsasiNo then
            p_tariffDate:=TariffDate;
            checkRef := '1';
        else
            p_tariffDate:=refTariffdate;
            checkRef := '0';
        end if;
       end if;
end if;
        if p_debugmode='1' then addlog ('','3', ''); end if;
    p_plakaIlKodu := substr('00' || trim(replace(plakailkodu,' ','')), -3);
    p_ilkPlakaIlKodu := substr('00' || trim(replace(plakailkodu,' ','')), -3);
    p_plakaNo := plakaNo;

        -- SBM 'den veriler çekiliyor.
        if checkRef = '0' then
            select ssbm into clob_sbmValues from pricing_tariff_log where price_id=referancePriceId;
        else
            if tescilSeriNo is null then
                select GETTARIFFTOSBM(kimlikNo, p_plakaIlKodu, p_plakaNo, NULL, asbisNo, sasiNo, '123', 'KSK', tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
            else
                select GETTARIFFTOSBM(kimlikNo, p_plakaIlKodu, p_plakaNo, tescilSeriKod, tescilSeriNo, sasiNo, '123', 'KSK', tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
            end if;
        end if;
        clob_aileSorgu := getSbmDetails(clob_sbmValues, 'aileSorgu');
        clob_sasiSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceBySasiSorgu');
                if length(kimlikNo) = 11 and substr(kimlikNo,1,1)='9' THEN
            clob_tcknSorgu := getSbmDetails(clob_sbmValues, 'yabanciKimlikSorgu');
            clob_adresSorgu := getSbmDetails(clob_sbmValues, 'yabanciAdresSorgu');
        else
            clob_tcknSorgu := getSbmDetails(clob_sbmValues, 'tcknSorgu');
            clob_adresSorgu := getSbmDetails(clob_sbmValues, 'adresSorgu');
        end if;

        p_ilceAd := UPPER(removeElement(getSbmDetails(clob_adresSorgu, 'ilceAd'), 'ilceAd'));
        p_ilAd := UPPER(removeElement(getSbmDetails(clob_adresSorgu, 'ilAd'), 'ilAd'));

        p_ilceAd := trim(replace(replace(replace(replace(replace(replace(p_ilceAd,'Ğ','G'),'Ü','U'),'Ş','S'),'İ','I'),'Ö','O'),'Ç','C'));
        p_ilAd := trim(replace(replace(replace(replace(replace(replace(p_ilAd,'Ğ','G'),'Ü','U'),'Ş','S'),'İ','I'),'Ö','O'),'Ç','C'));

        -- Bazı durumlarda SBM'den AFYONKARAHİSAR şeklinde veri gelmesi sebebiyle eklendi. 26/08/2019
        if p_ilAd like 'AFYONKARA%' then p_ilAd := 'AFYON KARAHISAR'; end if;

        clob_tcknAracSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceByTckSorgu');
        clob_tcknPlakaSorgu := getSbmDetails(clob_sbmValues, 'ovmKaskoPoliceByKimlikPlakaSorgu');
        clob_egmSorgu := getSbmDetails(clob_sbmValues, 'tescilBilgiSorgu');
        clob_TRFKimlikSasi := getSbmDetails(clob_sbmValues, 'ovmtrafikPoliceSorguSasiKimlikSorgu');
        p_trfKademe := coalesce(getSonTRFPoliceKademe(clob_TRFKimlikSasi),'0');

        --<isSuccessfull>true<
        -- Tarife değişkenleri dolduruluyor.
        -- Null kontrolü yapılmalı.

        if kullanimTarzi is NULL or kullanimTarzi = '0' or kullanimTarzi ='' THEN
            p_kullanimtarzi := cast(cast(removeElement(getSbmDetails(clob_sasiSorgu, 'aracTarifeGrupKodu'), 'aracTarifeGrupKodu') as number) as varchar2);
        ELSE p_kullanimtarzi := trim(kullanimTarzi); END IF;

        /* 27/12/2017 Eklendi. */
        if p_plakaIlKodu is NULL or p_plakaIlKodu = '0' or p_plakaIlKodu = '000' THEN
            p_plakaIlKodu := cast(cast(removeElement(getSbmDetails(clob_sasiSorgu, 'plakaIlKodu'), 'plakaIlKodu') as number) as varchar2);
        ELSE p_plakaIlKodu := trim(plakailkodu); END IF;

        if p_plakaNo is NULL or p_plakaNo = '0' /*or p_plakaNo = 'YK999'*/ THEN
            p_plakaNo := removeElement(getSbmDetails(clob_sasiSorgu, 'plakaNo'), 'plakaNo');
        ELSE p_plakaNo := trim(plakaNo); END IF;
        /* ----------- */

        if removeElement(getSbmDetails(clob_tcknSorgu, 'isSuccessfull'), 'isSuccessfull') = 'false' then p_tcknSorguKontrol := '0'; else p_tcknSorguKontrol := '1'; end if;
        if checkRef = '0' then
            p_cocukdegiskeni := refp_cocukdegiskeni;
        else
            p_cocukdegiskeni := getCocukDegiskeni(clob_aileSorgu, to_date(p_tariffDate,'DD/MM/YYYY'));
        end if;

        p_yasayanOtoUrun := getYasayanOtoUrun(kimlikNo, sasiNo, p_tariffDate);
        p_pertarac := getPertHasar (clob_tcknAracSorgu);
        p_teenCocuk := getTeenCocuk (clob_aileSorgu,to_date(p_tariffDate,'DD/MM/YYYY'));
        p_ErkekTeenCocuk := getErkekTeenCocuk(clob_aileSorgu,to_date(p_tariffDate,'DD/MM/YYYY'));



        if p_debugmode='1' then addlog ('','4', ''); end if;
/* Hasarsızlık Kademesi New */

        if hasarsizlikKademesi is not null and hasarsizlikKademesi!='99' then
            p_hasarsizlikKademesi := hasarsizlikKademesi;
        else
            if referansPoliceBilgileri is not null and trim(REGEXP_SUBSTR(referansPoliceBilgileri, '[^-]+', 1, 1)) is not null then
                SELECT REGEXP_SUBSTR(referansPoliceBilgileri, '[^-]+', 1, 1) col1,
                   REGEXP_SUBSTR(referansPoliceBilgileri, '[^-]+', 1, 2) col2,
                   REGEXP_SUBSTR(referansPoliceBilgileri, '[^-]+', 1, 3) col3,
                   REGEXP_SUBSTR(referansPoliceBilgileri, '[^-]+', 1, 4) col4 into p_eskiPolSirketKodu, p_eskiPolAcenteNo, p_eskiPolPoliceNo, p_eskiPolYenilemeNo FROM dual;
             else
                p_kaskoRefPlakaIlKodu := substr('00' || p_plakaIlKodu,-3);
                p_kaskoReferansSorgu := getKaskoReferansPolice(s_PricingId,kimlikNo,p_kaskoRefPlakaIlKodu,p_plakaNo);
                if p_kaskoReferansSorgu is not null then
                    SELECT REGEXP_SUBSTR(p_kaskoReferansSorgu, '[^-]+', 1, 1) col1,
                       REGEXP_SUBSTR(p_kaskoReferansSorgu, '[^-]+', 1, 2) col2,
                       REGEXP_SUBSTR(p_kaskoReferansSorgu, '[^-]+', 1, 3) col3,
                       REGEXP_SUBSTR(p_kaskoReferansSorgu, '[^-]+', 1, 4) col4,
                       REGEXP_SUBSTR(p_kaskoReferansSorgu, '[^-]+', 1, 5) col5 into p_eskiPolSirketKodu, p_eskiPolAcenteNo, p_eskiPolPoliceNo, p_eskiPolYenilemeNo, p_kaskoReferansKullanimTarzi FROM dual;
                    if p_kaskoReferansKullanimTarzi is not null then
                        if to_number(p_kaskoReferansKullanimTarzi) != to_number(p_kullanimtarzi) then
                            p_eskiPolSirketKodu := null;
                            p_eskiPolAcenteNo := null;
                            p_eskiPolPoliceNo := null;
                            p_eskiPolYenilemeNo := null;
                        end if;
                    else
                            p_eskiPolSirketKodu := null;
                            p_eskiPolAcenteNo := null;
                            p_eskiPolPoliceNo := null;
                            p_eskiPolYenilemeNo := null;
                    end if;
                end if;
             end if;
             if p_eskiPolSirketKodu is not null and p_eskiPolAcenteNo is not null and p_eskiPolPoliceNo is not null and p_eskiPolYenilemeNo is not null then
                 p_hasarsizlikKademesi := getKaskoHasarsizlik(s_PricingId, kimlikNo,p_eskiPolSirketKodu, p_eskiPolAcenteNo, p_eskiPolPoliceNo, p_eskiPolYenilemeNo);
                 SELECT REGEXP_SUBSTR(p_hasarsizlikKademesi, '[^-]+', 1, 1) col1 into p_hasarsizlikKademesi from dual;
--                 select max(uygulanankademesbm) into p_gecmisHasarsizlikIndirimi from tnswin.pricing_motor_ncd_log where reference_id=p_eskiPolSirketKodu||'-'||p_eskiPolAcenteNo||'-'||p_eskiPolPoliceNo||'-'||p_eskiPolYenilemeNo;
             else
                p_hasarsizlikKademesi := '0';
             end if;
        end if;
                if p_debugmode='1' then addlog ('','5', ''); end if;
/* */
p_kimlikno := kimlikno;

p_var:=substr(removeElement(getSbmDetails(clob_tcknSorgu, 'dogumTarihi'), 'dogumTarihi'),1,4);

IF p_var = '<s:E' THEN
  SELECT BIRTH_DATE
  INTO p_var
  FROM (SELECT NVL(UNS.BIRTH_DATE, SYSDATE) BIRTH_DATE
          FROM TNSWIN.T008UNSMAS UNS
         WHERE UNS.CITIZENSHIP_NUMBER = p_kimlikno
           AND UNS.BIRTH_DATE IS NOT NULL
           AND ROWNUM = 1
        UNION ALL
        SELECT SYSDATE
          FROM DUAL) BIRTH_DATE
 WHERE ROWNUM = 1;

END IF ;

/*removeElement(getSbmDetails(clob_tcknSorgu, 'dogumYeri'), 'dogumYeri');
IF p_var='<s:Envelope ' THEN
  select  DISTINCT INFO5 INTO p_var from TNSWIN.T001POLINS T WHERE T.INFO1=7810453056;
  IF p_var IS NOT NULL THEN
    select EXTRACT(YEAR FROM  TO_DATE(p_var,'DD/MM/YYYY')) INTO p_var FROM dual;
    END IF;
ELSE
  p_var:=substr(removeElement(getSbmDetails(clob_tcknSorgu, 'dogumTarihi'), 'dogumTarihi'),1,4);
END IF;*/

select NVL(max(b.uygulanankademesbm),0) into p_gecmisHasarsizlikIndirimi from tnswin.pricing_motor_ncd_log b where b.reference_id in(select a.sirketkodu||'-'|| a.acenteno||'-'||a.policeno||'-'||a.yenilemeno from tnswin.pricing_motor_ref_policy_log a where a.kimlikno=p_kimlikno and cast(a.plakailkodu as number)=cast(p_plakaIlKodu as number) and a.plakano=p_plakaNo and to_date(a.system_date,'DD/MM/YYYY') between to_char(sysdate-30,'DD/MM/YYYY') and to_char(sysdate+30,'DD/MM/YYYY'));


        IF LENGTH(kimlikNo)=11 THEN
            if p_tcknSorguKontrol = '1' then
                if checkRef = '0' then
                    p_sigortaliyas := refp_sigortaliyas;
                    p_cinsiyeti := removeElement(getSbmDetails(clob_tcknSorgu, 'cinsiyeti'), 'cinsiyeti');
                    p_medenihali := refp_medenihali; -- Evli - Bekar
                else          
                    p_sigortaliyas := cast(to_char(p_tariffDate,'YYYY') as number) - cast(to_char(to_date(p_var, 'DD.MM.YYYY'), 'YYYY') as number);                                                                                                                              
                    p_cinsiyeti := removeElement(getSbmDetails(clob_tcknSorgu, 'cinsiyeti'), 'cinsiyeti');
                    p_medenihali := removeElement(getSbmDetails(clob_tcknSorgu, 'medeniHali'), 'medeniHali'); -- Evli - Bekar
                end if;
            else
                p_sigortaliyas := NULL;
                p_cinsiyeti := NULL;
                p_medenihali := NULL;
            end if;
            if p_cinsiyeti not in('E','K') THEN p_cinsiyeti := 'D'; END IF;
            if length(removeElement(getSbmDetails(clob_adresSorgu, 'ilceKod'), 'ilceKod')) < 8 THEN
                p_tramerilce := removeElement(getSbmDetails(clob_adresSorgu, 'ilceKod'), 'ilceKod');
                p_tramerIl := removeElement(getSbmDetails(clob_adresSorgu, 'ilKod'), 'ilKod');
            end if;
            p_ilkPlakaIlKodu := p_plakaIlKodu;
            if p_tramerIl is not null THEN p_plakaIlKodu := p_tramerIl; end if;
--            select count(0) into p_sigortaliskor from pricing_insuredscore_log ab where /*s_PricingId=ab.s_pricingid and*/ kimlikNo=ab.kimlikno and
--                                                                                    p_tariffDate=ab.p_tariffdate and p_aracTarifeGrupKodu=ab.p_aractarifegrupkodu and p_hasarsizlikKademesi=ab.p_hasarsizlikkademesi
--                                                                                    and ab.systemdate=to_char(sysdate,'DD/MM/YYYY');
--            if p_sigortaliskor>0 then
--                select max(ab.s_sigortaliskor) into p_sigortaliskor from pricing_insuredscore_log ab where /*s_PricingId=ab.s_pricingid and*/ kimlikNo=ab.kimlikno and
--                                                                                        p_tariffDate=ab.p_tariffdate and p_aracTarifeGrupKodu=ab.p_aractarifegrupkodu and p_hasarsizlikKademesi=ab.p_hasarsizlikkademesi
--                                                                                        and ab.systemdate=to_char(sysdate,'DD/MM/YYYY');
--            else
            if checkRef = '0' then
                p_sigortaliskor := refp_sigortaliskor;
            else
                p_sigortaliskor := getSigortaliSkor (s_PricingId, clob_tcknAracSorgu, kimlikNo, p_tariffDate, p_kullanimtarzi, p_hasarsizlikKademesi);
            end if;
--            end if;
                p_otor_sigortaliskor := p_sigortaliskor;
            p_meslek := meslek;
            if p_sigortaliskor < 1 THEN p_sigortaliskor := '1'; END IF;
            p_ozelTuzel := '1';
            p_kullanimTipiCap := '1';
        ELSE
            --p_plakaIlKodu := trim(plakailkodu);
            p_sigortaliyas := 'Tüzel';
            p_cinsiyeti := 'Tüzel';
            p_medenihali := 'Tüzel';
            p_tramerIlce := '';
            p_tramerIl := '';
            p_sigortaliskor := '1';
            p_meslek := '';
            p_ozelTuzel := '2';
            p_kullanimTipiCap := '2';
        END IF;
        if model is NULL or model = '0' then p_model := cast(substr(removeElement(getSbmDetails(clob_sasiSorgu, 'modelYili'), 'modelYili'),1,4) as number);
                                            p_aracyasi := cast(to_char(p_tariffDate,'YYYY') as number) - p_model;
                                       else p_model := cast(model as number);
                                            p_aracyasi := cast(to_char(p_tariffDate,'YYYY') as number) - p_model; end if;


        if p_debugmode='1' then addlog ('','6', ''); end if;
if checkRef = '0' then
--        if p_aracyasi = 1 and to_date(to_char(p_tariffDate,'DD/MM/YYYY'),'DD/MM/YYYY')-to_date(trafigeCikisTarihi,'DD/MM/YYYY')<=30 and to_number(to_char(to_date(p_tariffDate,'DD/MM/YYYY'),'MM'))<=6 then
        if p_aracyasi = 1 and to_number(to_char(to_date(p_tariffDate,'DD/MM/YYYY'),'MM'))<=6 then
                p_aracyasi := 0;
                /* 20160613 Güncel bedel için eklendi.*/
                p_guncelbedel:='E';
        end if;
else
--        if p_aracyasi = 1 and to_date(to_char(sysdate,'DD/MM/YYYY'),'DD/MM/YYYY')-to_date(trafigeCikisTarihi,'DD/MM/YYYY')<=30 and to_number(to_char(to_date(sysdate,'DD/MM/YYYY'),'MM'))<=4 then
        if p_aracyasi = 1 and to_number(to_char(to_date(sysdate,'DD/MM/YYYY'),'MM'))<=6 then
                p_aracyasi := 0;
                /* 20160613 Güncel bedel için eklendi.*/
                p_guncelbedel:='E';
        end if;
end if;
        --if p_kullanimtarzi is NULL THEN p_kullanimtarzi := cast(cast(removeElement(getSbmDetails(clob_sasiSorgu, 'aracTarifeGrupKodu'), 'aracTarifeGrupKodu') as number) as varchar2); END IF;
        if checkRef = '0' then
            if refp_aracyasi is NULL or refp_aracyasi = '0' then
                p_aracyasi := p_aracyasi;
            else
                p_aracyasi := refp_aracyasi;
            end if;
        else
            if p_aracyasi = 0 and to_date(to_char(sysdate,'DD/MM/YYYY'),'DD/MM/YYYY')-to_date(trafigeCikisTarihi,'DD/MM/YYYY')<=30 AND p_kullanimtarzi in('1','99','6','3') THEN p_guncelbedel := 'E'; ELSE p_guncelbedel := 'H'; END IF;
        end if;
        if p_debugmode='1' then addlog ('','7', ''); end if;
        --select decode(p_kullanimtarzi,'1','Otomobil','2','Taksi','3','Minibüs','4','Midibüs','5','Otobüs','6','Kamyonet','7','Kamyon','8','İş Makinesi','9','Traktör','10','Römork','11','Motosiklet','12','Tanker',13,'Çekici',14,'Özel Amaçlı Taşıt',15,'Tarım Makinesi',16,'Dolmuş',17,'Minibüs-Dolmuş',18,'Midibüs-Dolmuş',19,'Otobüs-Dolmuş',20,'Diğer Araçlar','Diğer') into p_kullanimsekli from dual;
        p_kullanimsekli := trim(kullanimSekli);
        if removeElement(getSbmDetails(clob_egmSorgu, 'isSuccessfull'), 'isSuccessfull') in ('true','True') THEN p_egmkaydivarmi := 'E';
        else p_egmkaydivarmi := 'H'; end if;
--        p_plaka100502 := getPlaka100502(productNo,p_tariffDate,p_kullanimtarzi,plakailkodu,plakano);
        --p_egmkaydivarmi := decode(removeElement(getSbmDetails(clob_egmSorgu, 'isSuccessfull'), 'isSuccessfull'),'true','E','false','H');
        /*
        if cinsiyet = '' then p_cinsiyeti := removeElement(getSbmDetails(clob_tcknSorgu, 'cinsiyeti'), 'cinsiyeti'); -- E - K
                           else p_cinsiyeti := cinsiyet; end if;
        */
        /*
        if medeniDurum is NULL then p_medenihali := removeElement(getSbmDetails(clob_tcknSorgu, 'medeniHali'), 'medeniHali'); -- Evli - Bekar
                              else p_medenihali := medeniDurum; end if;
        */
        /*
        if sigortaliIkametilce is NULL or sigortaliIkametilce = '0' then p_tramerilce := removeElement(getSbmDetails(clob_adresSorgu, 'ilceKod'), 'ilceKod');
                                                                   else p_tramerilce := sigortaliIkametilce; end if;
        if sigortaliIkametil is NULL or sigortaliIkametil = '0' then p_tramerIl := removeElement(getSbmDetails(clob_adresSorgu, 'ilKod'), 'ilKod');
                                                                   else p_tramerIl := sigortaliIkametil; end if;
        if sigortaliSkor is NULL or sigortaliSkor ='0' then p_sigortaliskor := getSigortaliSkor (clob_tcknAracSorgu, tariffdate, p_kullanimtarzi, hasarsizlikkademesi);
                                                      else p_sigortaliskor := sigortaliSkor; end if;
        */

--        if markaTipKodu is NULL or markaTipKodu = '0' then p_markatipkodu := removeElement(getSbmDetails(clob_sasiSorgu, 'aracMarkaKodu'), 'aracMarkaKodu')||substr('000'||removeElement(getSbmDetails(clob_sasiSorgu, 'aracTipKodu'), 'aracTipKodu'),-4);
        if markaTipKodu is NULL or markaTipKodu = '0' then p_markatipkodu := removeElement(getSbmDetails(clob_sasiSorgu, 'aracMarkaKodu'), 'aracMarkaKodu')||removeElement(getSbmDetails(clob_sasiSorgu, 'aracTipKodu'), 'aracTipKodu');
                                                     else p_markatipkodu := markaTipKodu; end if;
        if length(p_markatipkodu)<7 then p_markatipkodu := substr('00'||p_markatipkodu,-6); end if;
        p_markakodu := substr(p_markatipkodu,1,3);
        if p_markakodu is NULL or p_markakodu ='0' then p_markakodu := removeElement(getSbmDetails(clob_sasiSorgu, 'aracMarkaKodu'), 'aracMarkaKodu');
                                              else p_markakodu := p_markakodu; end if;
        /*
        if yenilemeYeniIs is NULL or yenilemeYeniIs = '0' then p_yenilemeyeniiskod := getYenilemeYeniIsKod(clob_tcknPlakaSorgu);
                                                         else p_yenilemeyeniiskod := yenilemeYeniIs; end if;
        */
        if checkRef = '0' then
            p_yenilemeyeniiskod := refp_yenilemeyeniiskod;
        else
            p_yenilemeyeniiskod := getYenilemeYeniIsKod(p_tariffDate, clob_tcknPlakaSorgu,sasiNo, p_plakaNo, kimlikno);
            p_yenilemeYeniIsKodNew := p_yenilemeyeniiskod;
            --p_yenilemeyeniiskod := '99';
        end if;

        if p_yenilemeyeniiskod in('051','51') THEN p_yenilemeMi := 'E';
        else p_yenilemeMi := 'H'; end if;


/* CAP Kontrol STANDBY */
IF p_yenilemeyeniiskod in('051','51') THEN
            select count(0) into p_gecmisPoliceFiyat
            from t001polmas mas, t001psrcvp cvp, t008unsmas um where mas.firm_code=2 and mas.company_code=2
                                                        and cvp.firm_code=2 and cvp.company_code=2
                                                        and mas.product_no=cvp.product_no
                                                        and mas.policy_no=cvp.policy_no
                                                        and mas.renewal_no=cvp.renewal_no
                                                        and mas.endors_no=cvp.endors_no
                                                        and mas.policy_status='O'
                                                        and cvp.question_code = 5011 and cvp.answer=sasiNo
                                                        and mas.product_no in(500)
                                                        and mas.policy_is_cancelled<>'1'
                                                        and mas.pol_end_date between to_date(p_tariffDate,'DD/MM/YYYY')-45 and to_date(p_tariffDate,'DD/MM/YYYY')+45
                                                        and um.firm_code=mas.insured_firm_code
                                                        and um.unit_type=mas.insured_unit_type
                                                        and um.unit_no=mas.insured_no
                                                        and (um.citizenship_number=kimlikNo or um.tax_no=kimlikNo or um.foreign_citizenship_number=kimlikNo);
            if p_gecmisPoliceFiyat>0 then

            select mas.product_no, mas.policy_no, mas.renewal_no into p_gecmisUrunKod, p_gecmisPoliceNo, p_gecmisYenilemeNo
            from t001polmas mas, t001psrcvp cvp, t008unsmas um where mas.firm_code=2 and mas.company_code=2
                                                        and cvp.firm_code=2 and cvp.company_code=2
                                                        and mas.product_no=cvp.product_no
                                                        and mas.policy_no=cvp.policy_no
                                                        and mas.renewal_no=cvp.renewal_no
                                                        and mas.endors_no=cvp.endors_no
                                                        and mas.policy_status='O'
                                                        and cvp.question_code = 5011 and cvp.answer=sasiNo
                                                        and mas.product_no in(500)
                                                        and mas.policy_is_cancelled<>'1'
                                                        and mas.pol_end_date between to_date(p_tariffDate,'DD/MM/YYYY')-45 and to_date(p_tariffDate,'DD/MM/YYYY')+45
                                                        and um.firm_code=mas.insured_firm_code
                                                        and um.unit_type=mas.insured_unit_type
                                                        and um.unit_no=mas.insured_no
                                                        and (um.citizenship_number=kimlikNo or um.tax_no=kimlikNo or um.foreign_citizenship_number=kimlikNo) and rownum=1;

                select sum(decode(y.prod_cancel,'I',-1,1)*y1.lc_net_premium) into p_gecmisPoliceFiyat from t001polmas y, t001poltem y1 where y.product_no=y1.product_no
                                                                                                    and y.policy_no=y1.policy_no
                                                                                                    and y.renewal_no=y1.renewal_no
                                                                                                    and y.endors_no=y1.endors_no
                                                                                                    and y.policy_status='O'
                                                                                                    and y.firm_code=2 and y.company_code=2
                                                                                                    and y1.firm_code=2 and y1.company_code=2
                                                                                                    and y1.cover_code in(5000,5019,5020,5021,5049)
                                                                                                    and y.product_no = p_gecmisUrunKod
                                                                                                    and y.policy_no = p_gecmisPoliceNo
                                                                                                    and y.renewal_no = p_gecmisYenilemeNo;
                p_capPolice := p_gecmisUrunKod||'-'||p_gecmisPoliceNo||'-'||p_gecmisYenilemeNo;
--                if p_gecmisUrunKod>0 and p_gecmisPoliceNo>0 then
                    select round(sum(z.toplam_hasar),0) toplam_hasar into p_birYilOncekiHasarTutariArac from
                        (select ihb.claim_no,
                                (select sum(mgc.muallak_hasar+mgc.odenen_hasar+mgc.alinan_rucu+mgc.alinan_sovtaj+mgc.muallak_rucu+mgc.muallak_sovtaj)
                                    from tnswin.magic_table mgc where mgc.product_no=ihb.policy_product_no and mgc.policy_no=ihb.policy_no and mgc.renewal_no=ihb.policy_renewal_no) toplam_hasar
                        from tnswin.t001hasihb ihb where ihb.policy_product_no=p_gecmisUrunKod and ihb.policy_no=p_gecmisPoliceNo and ihb.policy_renewal_no=p_gecmisYenilemeNo) z;
--                end if;

            p_birYilOncekiHasarTutariArac := nvl(p_birYilOncekiHasarTutariArac,0);

            select count(0) into p_gecmisServisTuru from tnswin.t001psrcvp c where c.product_no=p_gecmisUrunKod and c.policy_no=p_gecmisPoliceNo and c.renewal_no=p_gecmisYenilemeNo and c.endors_no=0 and c.question_code=5140;
            if p_gecmisServisTuru > 0 then
                select c.answer into p_gecmisServisTuru from tnswin.t001psrcvp c where c.product_no=p_gecmisUrunKod and c.policy_no=p_gecmisPoliceNo and c.renewal_no=p_gecmisYenilemeNo and c.endors_no=0 and c.question_code=5140;
            end if;
            /*
                select sum(decode(y.prod_cancel,'I',-1,1)*y.lc_net_premium) into p_gecmisPoliceFiyat from t001polmas y where (y.product_no, y.policy_no, y.renewal_no) in
                (select mas.product_no, mas.policy_no, mas.renewal_no
                from t001polmas mas, t001psrcvp cvp, t008unsmas um where mas.firm_code=2 and mas.company_code=2
                                                            and cvp.firm_code=2 and cvp.company_code=2
                                                            and mas.product_no=cvp.product_no
                                                            and mas.policy_no=cvp.policy_no
                                                            and mas.renewal_no=cvp.renewal_no
                                                            and mas.endors_no=cvp.endors_no
                                                            and mas.policy_status='O'
                                                            and cvp.question_code = 5011 and cvp.answer=sasiNo
                                                            and mas.product_no in(500)
--                                                            and mas.endors_no=0
                                                            and mas.policy_is_cancelled<>'1'
                                                            and mas.pol_end_date between to_date(p_tariffDate,'DD/MM/YYYY')-45 and to_date(p_tariffDate,'DD/MM/YYYY')+45
                                                            and um.firm_code=mas.insured_firm_code
                                                            and um.unit_type=mas.insured_unit_type
                                                            and um.unit_no=mas.insured_no
                                                            and (um.citizenship_number=kimlikNo or um.tax_no=kimlikNo or um.foreign_citizenship_number=kimlikNo));*/
          /*
                select sum(decode(mas.prod_cancel,'I',-1,1)*mas.lc_net_premium) into p_gecmisPoliceFiyat
                from t001polmas mas, t001psrcvp cvp, t008unsmas um where mas.firm_code=2 and mas.company_code=2
                                                            and cvp.firm_code=2 and cvp.company_code=2
                                                            and mas.product_no=cvp.product_no
                                                            and mas.policy_no=cvp.policy_no
                                                            and mas.renewal_no=cvp.renewal_no
                                                            and mas.endors_no=cvp.endors_no
                                                            and mas.policy_status='O'
                                                            and cvp.question_code = 5011 and cvp.answer=sasiNo
                                                            and mas.product_no in(500)
                                                            and mas.policy_is_cancelled<>'1'
                                                            and mas.pol_end_date between to_date(p_tariffDate,'DD/MM/YYYY')-45 and to_date(p_tariffDate,'DD/MM/YYYY')+45
                                                            and um.firm_code=mas.insured_firm_code
                                                            and um.unit_type=mas.insured_unit_type
                                                            and um.unit_no=mas.insured_no
                                                            and (um.citizenship_number=kimlikNo or um.tax_no=kimlikNo or um.foreign_citizenship_number=kimlikNo);*/
            else
                p_yenilemeCap :=99;
                p_yenilemeFloor :=0;
                p_yenilemeCapMin := 0;
                p_yenilemeCapMax := 99999;
                p_gecmisPoliceFiyat := 99999;
            end if;
else
                p_yenilemeCap :=99;
                p_yenilemeFloor :=0;
                p_yenilemeCapMin := 0;
                p_yenilemeCapMax := 99999;
                p_gecmisPoliceFiyat := 99999;
end if;
/*
            if p_gecmisPoliceFiyat < 400 then
                p_gecmisPoliceFiyat := 400;
            end if;
*/
        if p_debugmode='1' then addlog ('','8', ''); end if;
        --p_yenilemeMi := decode(yenilemeYeniIs,'051','E','51','E','H');
        /*
        if aracSkorCarpani is null or aracSkorCarpani = '0' then p_aracskor := GETARACSKOR(clob_sasiSorgu,p_egmkaydivarmi,p_yenilemeMi,hasarsizlikKademesi,to_date(tariffdate,'DD/MM/YYYY'),tescilTarihi,trafigeCikisTarihi,p_model,plakaNo);
                                                            else p_aracskor := aracSkorCarpani; end if;
                                                            */
        s_key := p_egmkaydivarmi||','||p_yenilemeMi||','||p_hasarsizlikKademesi||','||to_date(p_tariffDate,'DD/MM/YYYY')||','||tescilTarihi||','||trafigeCikisTarihi||','||p_model||','||p_plakaNo;
--        select count(0) into p_aracskor from aracskor_detay ab where ab.systemdate=to_char(sysdate,'DD/MM/YYYY') and ab.key=s_key;
--        if p_aracskor>0 then
--            select max(ab.skor) into p_aracskor from aracskor_detay ab where ab.systemdate=to_char(sysdate,'DD/MM/YYYY') and ab.key=s_key;
--        else
          if checkRef = '0' then
            p_aracskor := refp_aracskor;
          else
            --p_aracskor := GETARACSKOR(clob_sasiSorgu,p_egmkaydivarmi,p_yenilemeMi,p_hasarsizlikKademesi,to_date(p_tariffDate,'DD/MM/YYYY'),tescilTarihi,trafigeCikisTarihi,p_model,plakaNo,s_PricingId);
            p_aracskor := '1';
          end if;
--        end if;



/* Hesaplanacak : Kural gelecek. */

        p_kskGenelBilgi := getKSKGenelBilgi(kimlikNo,clob_tcknAracSorgu);

        SELECT TO_NUMBER(REGEXP_SUBSTR(p_kskGenelBilgi, '[^-]+', 1, 1)) col1,
               TO_NUMBER(REGEXP_SUBSTR(p_kskGenelBilgi, '[^-]+', 1, 2)) col2,
               TO_NUMBER(REGEXP_SUBSTR(p_kskGenelBilgi, '[^-]+', 1, 3)) col3 into p_ksk_sigortalilikSuresi, p_ksk_kismiHasarSayisi, p_ksk_camHasarSayisi FROM dual;

        p_kskHasarSayisi := getKSKHasarSayisi(kimlikNo,p_ilkPlakaIlKodu,p_plakaNo,clob_tcknAracSorgu);

        SELECT TO_NUMBER(REGEXP_SUBSTR(p_kskHasarSayisi, '[^-]+', 1, 1)) col1,
               TO_NUMBER(REGEXP_SUBSTR(p_kskHasarSayisi, '[^-]+', 1, 2)) col2 into p_Otor_kismiHasarSayisi, p_Otor_camHasarSayisi FROM dual;

        p_kskDonemselHasarSayisi := getKSKDonemselHasarSayisi(kimlikNo,p_ilkPlakaIlKodu,p_plakaNo,clob_tcknAracSorgu,455, 0);

        SELECT TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 1)) col1,
               TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 2)) col2,
               TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 3)) col3 into p_kismiHasarSayisi1, p_agirHasar1, p_ortalamaHasarTutar1 FROM dual;

        p_kskDonemselHasarSayisi := getKSKDonemselHasarSayisi(kimlikNo,p_ilkPlakaIlKodu,p_plakaNo,clob_tcknAracSorgu,910,455);

        SELECT TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 1)) col1,
               TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 2)) col2,
               TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 3)) col3 into p_kismiHasarSayisi2, p_agirHasar2, p_ortalamaHasarTutar2 FROM dual;

        p_kskDonemselHasarSayisi := getKSKDonemselHasarSayisi(kimlikNo,p_ilkPlakaIlKodu,p_plakaNo,clob_tcknAracSorgu,1365,910);

        SELECT TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 1)) col1,
               TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 2)) col2,
               TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 3)) col3 into p_kismiHasarSayisi3, p_agirHasar3, p_ortalamaHasarTutar3 FROM dual;

        p_ortalamaHasarTutar1 := nvl(p_ortalamaHasarTutar1,0);
        p_ortalamaHasarTutar2 := nvl(p_ortalamaHasarTutar2,0);
        p_ortalamaHasarTutar3 := nvl(p_ortalamaHasarTutar3,0);
        if p_tariffDate <= to_date('31/01/2018', 'DD/MM/YYYY') then
            birYilOncekiHasar := 'H';
            ikiYilOncekiHasar := 'H';
            ucYilOncekiHasar := 'H';

            if nvl(p_kismiHasarSayisi1,0)!='0' then
                birYilOncekiHasar := 'E';
            end if;
            if nvl(p_kismiHasarSayisi2,0)!='0' then
                ikiYilOncekiHasar := 'E';
            end if;
            if nvl(p_kismiHasarSayisi3,0)!='0' then
                ucYilOncekiHasar := 'E';
            end if;
        else
            if p_agirHasar1 != '0' then
                birYilOncekiHasar := '3';
            else
                birYilOncekiHasar := coalesce(p_kismiHasarSayisi1,'0');
            end if;
            if p_agirHasar2 != '0' then
                ikiYilOncekiHasar := '3';
            else
                ikiYilOncekiHasar := coalesce(p_kismiHasarSayisi2,'0');
            end if;
            if p_agirHasar3 != '0' then
                ucYilOncekiHasar := '3';
            else
                ucYilOncekiHasar := coalesce(p_kismiHasarSayisi3,'0');
            end if;
            if birYilOncekiHasar>4 then birYilOncekiHasar := '4'; end if;
            if ikiYilOncekiHasar>4 then ikiYilOncekiHasar := '4'; end if;
            if ucYilOncekiHasar>4 then ucYilOncekiHasar := '4'; end if;
        end if;

        if (sigortaliliksuresi is not null or trim(sigortaliliksuresi) <> '') then
            p_sigortaliliksuresi := sigortaliliksuresi;
        else
            p_sigortaliliksuresi := p_ksk_sigortalilikSuresi;
        end if;

        if (kismihasarsayisi is not null or trim(kismihasarsayisi) <> '') then
            p_kismihasarsayisi := kismihasarsayisi;
        else
            p_kismihasarsayisi := p_ksk_kismiHasarSayisi;
        end if;

        if (camhasarsayisi is not null or trim(camhasarsayisi) <> '') then
            p_camhasarsayisi := camhasarsayisi;
        else
            p_camhasarsayisi := p_ksk_camHasarSayisi;
        end if;
        if p_debugmode='1' then addlog ('','9', ''); end if;
        /*
        p_kismihasarsayisi := kismihasarsayisi;
        p_sigortaliliksuresi := sigortaliliksuresi;
        p_camhasarsayisi := camhasarsayisi;
        */

        if p_kismihasarsayisi > 15 then p_kismihasarsayisi := 15; end if;
/*  */


        IF p_yenilemeyeniiskod = '051' OR p_yenilemeyeniiskod = '51' THEN p_yenilemeyeniiskod := '51'; ELSE p_yenilemeyeniiskod := '99'; END IF;
        if p_kullanimtarzi in('16','2','02') then p_kullanimtarzi100501 := '1'; elsif p_kullanimtarzi='17' then p_kullanimtarzi100501 := '3'; elsif p_kullanimtarzi = '18' then p_kullanimtarzi100501:='4'; elsif p_kullanimtarzi='19' then p_kullanimtarzi100501:='5'; elsif p_kullanimtarzi='12' then p_kullanimtarzi100501:='7'; else p_kullanimtarzi100501:=p_kullanimtarzi; end if;

        z_sql := 'select count(0) from t001c002u551 a where a.k1='''||p_markatipkodu
                                                                        ||''' and a.k2='''||p_model||'''
                                                                        and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u551 b where b.k1=a.k1
                                                                                                        and b.k2=a.k2
                                                                                                        and b.gecer_tarih<=to_date('''||p_tariffDate||''',''DD/MM/YYYY'')) and rownum=1';
        execute immediate z_sql into p_yakittipi;
        IF p_yakittipi='0' THEN p_yakittipi := 'Diğer'; ELSE
            z_sql := 'select a.d7, a.d5, a.d4 from t001c002u551 a where a.k1='''||p_markatipkodu --(select r.d2 from t001c002u5007 r where r.k1=trim(a.D7))
                                                                                    ||''' and a.k2='''||p_model||''' and rownum=1';
            execute immediate z_sql into p_yakittipi, p_aracyerliyabanci, p_aracSegment;
            p_aracSegment := replace(p_aracSegment,' ','');
        END IF;

if p_tariffDate >='19/04/2018' then
        /* Eurocar bilgileri */
        SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-ARAC BİLGİ'
                       and b.key1=p_markatipkodu AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-ARAC BİLGİ'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
       if p_debugmode='1' then addlog ('','9', cnt99); end if;
        if cnt99 > 0 then
            SELECT   max(b.desc1), max(b.desc2), max(b.desc3) into eurocar_segment, eurocar_kasatipi, eurocar_sanziman
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-ARAC BİLGİ'
                       and b.key1=p_markatipkodu AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-ARAC BİLGİ'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate)
                       AND ROWNUM=1;
        end if;

        /* MarkatipGrup bilgileri */
        SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-MARKA TİP GRUP'
                       and b.key1=p_markatipkodu AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-MARKA TİP GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
       if p_debugmode='1' then addlog ('','9', cnt99); end if;
        if cnt99 > 0 then
            SELECT   max(b.desc1) into p_MARKATIPGRUP
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-MARKA TİP GRUP'
                       and b.key1=p_markatipkodu AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-MARKA TİP GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
        else
            SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-MARKA TİP GRUP'
                       and b.key1=p_markakodu AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-MARKA TİP GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
            if cnt99 > 0 then
                     SELECT   max(b.desc1) into p_MARKATIPGRUP
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-MARKA TİP GRUP'
                       and b.key1=p_markakodu AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-MARKA TİP GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
            end if;
        end if;
else
        /* Eurocar bilgileri */
        SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-ARAC BİLGİ'
                       and b.key1=cast(p_markatipkodu as number) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-ARAC BİLGİ'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
       if p_debugmode='1' then addlog ('','9', cnt99); end if;
        if cnt99 > 0 then
            SELECT   max(b.desc1), max(b.desc2), max(b.desc3) into eurocar_segment, eurocar_kasatipi, eurocar_sanziman
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-ARAC BİLGİ'
                       and b.key1=cast(p_markatipkodu as number) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-ARAC BİLGİ'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate)
                       AND ROWNUM=1;
        end if;

        /* MarkatipGrup bilgileri */
        SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-MARKA TİP GRUP'
                       and b.key1=cast(p_markatipkodu as number) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-MARKA TİP GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
       if p_debugmode='1' then addlog ('','9', cnt99); end if;
        if cnt99 > 0 then
            SELECT   max(b.desc1) into p_MARKATIPGRUP
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-MARKA TİP GRUP'
                       and b.key1=cast(p_markatipkodu as number) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-MARKA TİP GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
        else
            SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-MARKA TİP GRUP'
                       and b.key1=cast(p_markakodu as number) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-MARKA TİP GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
            if cnt99 > 0 then
                     SELECT   max(b.desc1) into p_MARKATIPGRUP
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-MARKA TİP GRUP'
                       and b.key1=cast(p_markakodu as number) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-MARKA TİP GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
            end if;
        end if;
end if;



        /* ililcegrup bilgileri */
        SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'IL ILCE GRUP'
                       and b.key1=p_ilAd||'-'||p_ilceAd AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'IL ILCE GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
       if p_debugmode='1' then addlog ('','9', p_ilAd||'-'||p_ilceAd); end if;
        if cnt99 > 0 then
            SELECT   max(b.desc1) into p_ililcegrup
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'IL ILCE GRUP'
                       and b.key1=p_ilAd||'-'||p_ilceAd AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'IL ILCE GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
        else
            if p_ozelTuzel = '2' then
                SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-IL ILCE GRUP TZL'
                       and b.key1=trim(p_plakaIlKodu) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-IL ILCE GRUP TZL'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
                if cnt99 > 0 then
                    SELECT   max(trim(b.desc1))||'-DIGER' into p_ililcegrup
                                FROM   pricing_parameters b
                               WHERE   b.param_name = 'KSK-IL ILCE GRUP TZL'
                               and b.key1=trim(p_plakaIlKodu) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-IL ILCE GRUP TZL'
                                                        AND a.valid_date IS NOT NULL
                                                        AND a.valid_date <= TariffDate);
                end if;
            else
                p_ililcegrup := p_ilAd||'-DIGER';
            end if;
        end if;


        IF p_agirlik IS NOT NULL AND p_agirlik != '0' and p_agirlik != 'DİĞER' and p_agirlik != 'Diğer' and P_BEYGIRGUCU IS NOT NULL AND P_BEYGIRGUCU != '0' and P_BEYGIRGUCU != 'DİĞER' and P_BEYGIRGUCU != 'Diğer' THEN p_whp := ROUND(TO_NUMBER(p_agirlik)/TO_NUMBER(p_beygirGucu),0); ELSE p_whp:='DİĞER'; END IF;
        IF aracbedeli is null or aracbedeli='0' THEN
            z_sql := 'select max(trim(a.D1)) from t001c002u550 a where a.k1='''||p_markatipkodu ||''' and a.k2='''||p_model||'''
                                                                                    and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u550 b where b.k1=a.k1
                                                                                                                    and b.k2=a.k2
                                                                                                                    and b.gecer_tarih<=to_date('''||p_tariffDate||''',''DD/MM/YYYY''))';
            execute immediate z_sql into p_aracbedeli;
        ELSE
            p_aracbedeli := aracbedeli;
        END IF;
        if p_debugmode='1' then addlog ('','10', ''); end if;
        -- * XML'den alınacak.   T Tablodan çekilecek.   P Parametre olarak gelecek.
        -- *P p_hasarsizlikkademesi
        --select count(0) into p_filosegment from t001c002u100081 a where (a.k1=kimlikno or a.k2=kimlikno) and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100081 b where b.k1=kimlikno or b.k2=kimlikno) and rownum=1;
        --IF p_filosegment <> '0' THEN
        --    select decode(p_kullanimtarzi,'1','a.D8','2','a.D9','3','a.D10','4','a.D11','5','a.D12','6','a.D13','7','a.D14','8','a.D15','9','a.D16','10','a.D17','11','a.D18','12','a.D19',13,'a.D20',14,'a.D21',15,'a.D22',16,'a.D23',17,'a.D24',18,'a.D25',19,'a.D26',20,'a.D27',99,'a.D28','a.D27') into p_filoSegmentD from dual;
        --    p_filoSegmentSql := 'select '||p_filoSegmentD||' from t001c002u100081 a where (a.k1='||kimlikno||' or a.k2='||kimlikno||') and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100081 b where b.k1='||kimlikno||' or b.k2='||kimlikno||') and rownum=1';
        --    execute immediate p_filoSegmentSql into p_filosegment;
        --ELSE
            p_filosegment := 'Yok';
        --END IF;
/* Default değer atamaları Kontrolleri */
        if p_yenilemeyeniiskod is NULL or p_yenilemeyeniiskod = '0' then p_yenilemeyeniiskod := '99'; end if;
        if p_yenilemeyeniiskod != '051' and p_yenilemeyeniiskod != '51' then p_yenilemeyeniiskod := '99'; ELSE p_yenilemeyeniiskod := '051'; end if;
        if p_sigortaliyas is NULL and length(kimlikNo)=11 then p_sigortaliyas := '0'; end if;
/* Tüzel Default değerler*/
        if length(kimlikNo)=10 THEN
            p_cocukdegiskeni := 'Tüzel';
            p_sigortaliyas := 'Tüzel';
            p_cinsiyeti := 'Tüzel';
            if p_ticariFaktor is null then p_ticariFaktor := 1; end if;
        ELSE
            p_ticariFaktor := 1;
        END IF;
        IF P_WHP IS NULL THEN P_WHP := '0'; END IF;
        if yakitTipi is not null or yakitTipi!='0' THEN p_yakitTipi:=yakitTipi; END IF;
        if p_aracyerliyabanci is null THEN p_aracyerliyabanci := '1'; END IF;
        if p_yakittipi is NULL then p_yakittipi := 'Diğer'; end if;
        if p_medenihali is NULL or substr(kimlikNo,1,1) = '9'  then p_medenihali := 'Diğer'; end if;
        if p_cocukdegiskeni is NULL then p_cocukdegiskeni := 'NNNN'; end if;
        if p_kismiHasarSayisi is NULL then p_kismiHasarSayisi := '0'; end if;
        if p_sigortaliliksuresi is NULL then p_sigortaliliksuresi := '0'; end if;
        if p_cinsiyeti is NULL then p_cinsiyeti := 'D'; end if;
        --if hasarsizlikkademesi is NULL then hasarsizlikkademesi :='0'; end if;
        if p_camhasarsayisi is NULL then p_camhasarsayisi := '0'; elsif p_camhasarsayisi>10 then p_camhasarsayisi:=10; end if;
        --if pakettipi is NULL then pakettipi := 'Genişletilmiş Kasko'; end if;
        --if yenilemeCapIndirimi is NULL then yenilemeCapIndirimi := '0'; end if;
        if p_filosegment is NULL then p_filosegment := '1'; end if;
        if p_sigortaliskor is NULL then p_sigortaliskor := '1'; end if;
        if p_aracskor is NULL then p_aracskor := '1'; end if;
        if p_meslek is NULL or p_meslek='' then p_meslek :='Yok'; end if;
        if kasaBedeli is NULL or kasabedeli='' THEN p_kasaBedeli := 0; else p_kasabedeli := kasaBedeli; END IF;
        if digerAksesuarBedeli is NULL or digerAksesuarBedeli='' THEN p_digerAksesuarBedeli := 0; ELSE p_digerAksesuarBedeli := digerAksesuarBedeli; END IF;
        p_ilkAracYas:=p_aracyasi;
-- kıymet
--        if p_ilkAracYas < 16 then p_kiymetKazanma := 'E'; else p_kiymetKazanma := kiymetKazanma; end if;
        p_kiymetKazanma := kiymetKazanma;
        if p_aracyasi > 25 then p_aracyasi := 25; end if;
        if p_aracyasi < 0 then p_aracyasi := 0; end if;

-- TODO : AZ-EL Çekici Römork
-- EĞER(B18="1";EĞER(B17>13;13;B17);EĞER(B3=1;EĞER(B17>20;20;B17);EĞER(B17>7;8;B17)))
  /*      if channel='30043' and (p_kullanimtarzi = '10' or (p_kullanimtarzi = '7' and kullanimTipi = '4')) then
            if p_aracyasi > 13 then
                p_aracyasgrubu := '13';
            else
                p_aracyasgrubu := p_aracyasi;
            end if;
        else
            if p_kullanimtarzi = '1' then
                if p_aracyasi > 20 then
                    p_aracyasgrubu := '20';
                else
                    p_aracyasgrubu := p_aracyasi;
                end if;
            else
                if p_aracyasi > 7 then
                    p_aracyasgrubu := '8';
                else
                    p_aracyasgrubu := p_aracyasi;
                end if;
            end if;
        end if;
*/
        p_minimumFiyatKorunsunMu := minimumFiyatKorunsunMu;
        if p_yenilemeyeniiskod = '051' or p_yenilemeyeniiskod = '51' THEN p_minimumFiyatKorunsunMu := 'H'; END if;
        --if surprim is NULL then surprim := '0'; end if;
        if p_ozelindirim is NULL then p_ozelindirim := '1'; end if;
        if p_surprim is NULL then p_surprim := '1'; end if;
        --if yurtDisiTeminatiSuresi is NULL then yurtDisiTeminatiSuresi := '0'; end if;

--        select case when round(p_aracbedeli/a.desc1,0)>70001 then 70001 else round(p_aracbedeli/a.desc1,0) end into p_yeniaracbedel from pricing_parameters a where a.param_name='Yenileme Araç Bedeli' and a.key1=p_ilkAracYas and a.valid_date=(select max(b.valid_date) from pricing_parameters b where b.param_name='Yenileme Araç Bedeli');
        select p_aracbedeli/(1+mult1) into p_yeniaracbedel from pricing_tables a where a.table_code='KSK-ARAÇ BEDEL ENFLASYONU' and a.key1=to_char(TariffDate,'MM/YYYY') and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code='KSK-ARAÇ BEDEL ENFLASYONU' and b.key1=to_char(TariffDate,'MM/YYYY'));
--        if markaRiskGrubu is not null and markaRiskGrubu <> '0' THEN p_markariskgrubu := markaRiskGrubu; END IF;
        p_ilkAracBedeli := p_aracbedeli;
        p_aracbedeli := to_char(nvl(p_aracbedeli,0) + nvl(p_digerAksesuarBedeli,0) + nvl(p_kasabedeli,0));
        if p_debugmode='1' then addlog ('','11', ''); end if;
/* Commercial Score */
        IF length(trim(kimlikNo)) = 10 THEN
            select packgcommercialscore.getcommercialscoreprocWeb(kimlikNo,to_char(sysdate,'DD/MM/YYYY'),to_char(sysdate,'HH24:MI'),kullaniciAdi,acente, TariffDate) into p_commercialScoreId from dual;
            select score into p_commercialScore from pricing_detail_log where price_id=p_commercialScoreId;
        ELSE
            p_commercialScore := '1';
        END IF;

        if p_commercialScore is null or p_commercialScore='0' then p_commercialScore := '1'; end if;

            if p_tariffDate >='27/12/2016' then
                 select count(0) into p_ililcekontrol from pricing_tables a where a.table_code='Tramerİlçe' and a.key1=p_tramerilce and a.key2=p_kullanimtarzi and a.key3=p_ozelTuzel and a.key4=p_yenilemeyeniiskod and a.valid_date=(select max(b.valid_date) from pricing_tables b where b.table_code=a.table_code and valid_date<=to_char(p_tariffDate,'DD/MM/YYYY'));
                 if p_ililcekontrol = 0 then p_tramerilce := p_plakaIlKodu||'999'; end if;
            end if;
--        END IF;
/* Commercial Score */
--((@S5066='4')|(@S5066='5')|(@S5000$' 1'))?'1':(@B[5005;@X2031S5073]?@B[5005;@X2031S5073;1]:'6')
-- EMBLEM
        if p_yenilemeYeniIsKodNew in ('051','51') THEN
            NBRENEWAL2 := 'YENILEME';
        elsif p_yenilemeYeniIsKodNew='99' THEN
            if p_aracyasi = 0 then
                NBRENEWAL2 := 'SIFIRKMARAC';
            else
                NBRENEWAL2 := 'YENIIS';
            end if;
        else
            NBRENEWAL2 := 'TRANSFER';
        end if;


if trim(kullanimTipi) in('4','5') and trim(p_kullanimtarzi) = '1' then
    p_markariskgrubu := '1';
else
    select count(0) into p_markariskgrubu from t001c002u5005 a where a.k1=p_markakodu and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u5005 b where b.k1=a.k1);
    if p_markariskgrubu>0 then
        select d1 into p_markariskgrubu from t001c002u5005 a where a.k1=p_markakodu and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u5005 b where b.k1=a.k1);
    else
        p_markariskgrubu := '6';
    end if;
end if;
/*
        if channel = '30043' and (p_kullanimtarzi = '10' or (p_kullanimtarzi = '7' and kullanimTipi='4')) then
            p_acenteCarpan := 1;
        else
            if p_kullanimtarzi in('3','4','5','7','8','9','10') then
                p_acenteCarpan := 1.25;
            else
                p_acenteCarpan := 1;
            end if;
        end if;
*/
/*
KEY_DATA_FLD    FIELD_NO    FIELD_NAME
------------    --------    -----------
K               1           IL_KODU
K               2           MARKA_KODU
K               3           ARAC_YASI
K               4           GECER_TARIH

        kontrol1    50011   özel ve otomobil veya kamyonet ve il tablosunda kayıt yok
        kontrol2    50012   tüzel ve otomobil ise
        kontrol3    5015    özel ve otomobil veya kamyonet ve il tablosunda kayıt var
        kontrol4    5001    kontrol1 ve kontrol2 ve kontrol3 false ise

        kontrol5    50300
*/
/*
        if (p_kullanimtarzi = '4' or p_kullanimtarzi = '5') then
            p_kontrol4 := 1;
        end if;

        if (p_kontrol4 is null or p_kontrol4 != 1) then
            select count(0) into p_ilKontrol from t001c002u5015 a where a.k1=p_plakaIlKodu and a.k2=p_markatipkodu and a.k3=p_aracyasi and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u5015 b);
            if (p_ozelTuzel = '1' and (p_kullanimtarzi = '1' or p_kullanimtarzi='6')) then
                if (p_aracyasi>10) then
                    p_kontrol1 := 1;
                else
                    if (p_ilKontrol>0) then
                        p_kontrol3 := 1;
                    else
                        p_kontrol1 := 1;
                    end if;
                end if;
            elsif (p_ozelTuzel = '2' and p_kullanimtarzi = '1') then
                p_kontrol2 := 1;
            else
                p_kontrol4 := 1;
            end if;
        end if;
*/
       -- ((@C1630=30043)&((@S5000='10')|((@S5000=' 7')&(@S5001=' 4'))))?0:(((@S5000=' 3')|(@S5000=' 4')|(@S5000=' 5')|(@S5000=' 7')|(@S5000=' 8')|(@S5000=' 9')|(@S5000='10')))
/*
        if (channel = '30043' and (kullanimTarzi='10' or (kullanimTarzi='7' and kullanimTipi='4'))) then
            p_kontrol5 := 0;
        elsif (kullanimTarzi in('3','4','5','7','8','9','10')) then
            p_kontrol5 := 1;
        end if;

            select count(0) into s8000 from t001c002u551 a where a.k1=markaTipKodu and a.k2=model and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u551 b);
    if s8000 <> '0' then
        if kullanimTarzi = '1' then
            select a.d11, a.d12 into s8000, s8060 from t001c002u551 a where a.k1=markaTipKodu and a.k2=model and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u551 b);
        elsif kullanimTarzi = '6' then
            select a.d11, a.d12 into s8000, s8060 from t001c002u551 a where a.k1=markaTipKodu and a.k2=model and a.d1=kullanimTarzi and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u551 b);
        else
            s8000 := '1';
            s8060 := '1';
        end if;
    else
        s8000 := '1';
        s8060 := '1';
    end if;
*/

if p_tariffDate < '29/08/2019' then
    if p_ilkAracBedeli < 30000 then
        p_aracBedelGrubu := '1';
    elsif p_ilkAracBedeli >= 30000 and p_ilkAracBedeli<50000 then
        p_aracBedelGrubu := '2';
    elsif p_ilkAracBedeli >= 50000 and p_ilkAracBedeli<70000 then
        p_aracBedelGrubu := '3';
    elsif p_ilkAracBedeli >= 70000 and p_ilkAracBedeli<100000 then
        p_aracBedelGrubu := '4';
    elsif p_ilkAracBedeli >= 100000 and p_ilkAracBedeli<150000 then
        p_aracBedelGrubu := '5';
    else
        p_aracBedelGrubu := '6';
    end if;
else
    if p_ilkAracBedeli < 30000 then
        p_aracBedelGrubu := '1';
    elsif p_ilkAracBedeli >= 30000 and p_ilkAracBedeli<50000 then
        p_aracBedelGrubu := '2';
    elsif p_ilkAracBedeli >= 50000 and p_ilkAracBedeli<70000 then
        p_aracBedelGrubu := '3';
    elsif p_ilkAracBedeli >= 70000 and p_ilkAracBedeli<100000 then
        p_aracBedelGrubu := '4';
    elsif p_ilkAracBedeli >= 100000 and p_ilkAracBedeli<150000 then
        p_aracBedelGrubu := '5';
    elsif p_ilkAracBedeli >= 150000 and p_ilkAracBedeli<250000 then
        p_aracBedelGrubu := '6';
    elsif p_ilkAracBedeli >= 250000 and p_ilkAracBedeli<350000 then
        p_aracBedelGrubu := '7';
    elsif p_ilkAracBedeli >= 350000 and p_ilkAracBedeli<400000 then
        p_aracBedelGrubu := '8';
    else
        p_aracBedelGrubu := '9';
    end if;
end if;
        sonucyilhasar := nvl(birYilOncekiHasar,0) + nvl(ikiYilOncekiHasar,0) + nvl(ucYilOncekiHasar,0);

        v_sql := 'select getTariff.getactivefactorsql1('||s_PricingId||','''||productNo||''', to_date('''||p_tariffDate||''',''DD/MM/YYYY''),'''||p_kullanimsekli||''','''|| p_kullanimtarzi||''','''|| p_aracyasi||''','''|| p_plakaIlKodu||''','''|| p_tramerIl ||''','''||p_tramerilce||''','''|| p_yenilemeyeniiskod||''','''|| p_sigortaliyas||''','''|| p_aracbedeli||''','''|| p_yakittipi||''','''|| p_medenihali||''','''|| p_cocukdegiskeni||''','''|| p_kismiHasarSayisi ||''','''|| p_sigortaliliksuresi||''','''|| p_cinsiyeti||''','''|| p_hasarsizlikKademesi||''','''|| p_markariskgrubu||''','''|| p_camhasarsayisi||''','''|| p_pakettipi||''','''|| p_yenilemeCapIndirimi||''','''|| p_filosegment ||''','''|| p_guncelbedel||''','''|| p_sigortaliskor||''','''|| p_aracskor||''','''|| p_surprim||''','''|| p_ozelindirim||''','''|| kullanimtipi||''','''|| yurtDisiTeminatiSuresi||''','''|| p_markakodu||''','''||p_yeniaracbedel||''','''||p_meslek||''','''||p_markatipkodu||''','''||p_trfKademe||''','''||p_commercialScore||''','''||p_kiymetKazanma||''','''||p_ilkAracYas||''','''||p_plaka100502||''','''||p_ozelTuzel||''','''||p_ticariFaktor||''','''||P_WHP||''','''||p_aracSegment||''','''||p_kasaTipi||''','''||camMuafiyetIstisnasi||''',''0'',''0'','''','''','''','''','''',''0'','''','''||p_yasayanOtoUrun||''','''||p_teenCocuk||''','''||p_ErkekTeenCocuk||''','''||p_pertarac||''','''||p_aracyerliyabanci||''','''||p_garaj||''','''||p_resmidaire||''','''||p_servis||''','''||p_muafiyet||''','''||p_anlasmaliServis||''','''||p_parcaTuru||''','''||p_servisTuru||''','''||p_surucuInd||''','''||acente||''','''||araccoklugu||''',''' ||p_acenteCarpan||''','''|| p_aracyasgrubu || ''','''|| p_kontrol1 || ''','''|| p_kontrol2 || ''','''|| p_kontrol3 || ''','''|| p_kontrol4 || ''','''|| s8000 || ''','''|| s8060 || ''','''|| p_kontrol5 || ''','''|| eurocar_segment || ''','''|| eurocar_kasatipi || ''','''|| eurocar_sanziman || ''','''|| NBRENEWAL2 || ''','''|| p_MARKATIPGRUP || ''','''|| p_ililcegrup || ''','''|| birYilOncekiHasar || ''','''|| ikiYilOncekiHasar || ''','''|| ucYilOncekiHasar || ''','''||p_aracBedelGrubu||''','''||p_ortalamaHasarTutar1||''','''||p_ortalamaHasarTutar2||''','''||p_ortalamaHasarTutar3||''','''||sonucyilhasar||''','''||null/*BifurcationSegment*/||''','''') from dual';
        d1_sql := 'select getTariff.getTariffDetay('''||productNo||''', to_date('''||p_tariffDate||''',''DD/MM/YYYY''),'''||p_kullanimsekli||''','''|| p_kullanimtarzi||''','''|| p_aracyasi||''','''|| p_plakaIlKodu||''','''|| p_tramerIl ||''','''||p_tramerilce||''','''|| p_yenilemeyeniiskod||''','''|| p_sigortaliyas||''','''|| p_aracbedeli||''','''|| p_yakittipi||''','''|| p_medenihali||''','''|| p_cocukdegiskeni||''','''|| p_kismiHasarSayisi ||''','''|| p_sigortaliliksuresi||''','''|| p_cinsiyeti||''','''|| p_hasarsizlikKademesi||''','''|| p_markariskgrubu||''','''|| p_camhasarsayisi||''','''|| p_pakettipi||''','''|| p_yenilemeCapIndirimi||''','''|| p_filosegment ||''','''|| p_guncelbedel||''','''|| p_sigortaliskor||''','''|| p_aracskor||''','''|| p_surprim||''','''|| p_ozelindirim||''','''|| kullanimtipi||''','''|| yurtDisiTeminatiSuresi||''','''|| p_markakodu||''','''||p_yeniaracbedel||''','''||p_meslek||''','''||p_markatipkodu||''','''||p_trfKademe||''','''||p_commercialScore||''','''||p_kiymetKazanma||''','''||p_ilkAracYas||''','''||p_plaka100502||''','''||p_ozelTuzel||''','''||p_ticariFaktor||''','''||P_WHP||''','''||p_aracSegment||''','''||p_kasaTipi||''','''||camMuafiyetIstisnasi||''',''0'',''0'','''','''','''','''','''',''0'','''','''||p_yasayanOtoUrun||''','''||p_teenCocuk||''','''||p_ErkekTeenCocuk||''','''||p_pertarac||''','''||p_aracyerliyabanci||''','''||p_garaj||''','''||p_resmidaire||''','''||p_servis||''','''||p_muafiyet||''','''||p_anlasmaliServis||''','''||p_parcaTuru||''','''||p_servisTuru||''','''||p_surucuInd||''','''||acente||''','''||araccoklugu||''','''||p_acenteCarpan||''','''|| p_aracyasgrubu ||''','''|| p_kontrol1 ||''','''|| p_kontrol2 ||''','''|| p_kontrol3 ||''','''|| p_kontrol4 ||''','''|| s8000 ||''','''|| s8060 ||''','''|| p_kontrol5 ||''','''|| eurocar_segment || ''','''|| eurocar_kasatipi || ''','''|| eurocar_sanziman || ''','''|| NBRENEWAL2 || ''','''|| p_MARKATIPGRUP || ''','''|| p_ililcegrup || ''','''|| birYilOncekiHasar || ''','''|| ikiYilOncekiHasar || ''','''|| ucYilOncekiHasar || ''','''||p_aracBedelGrubu||''','''||p_ortalamaHasarTutar1||''','''||p_ortalamaHasarTutar2||''','''||p_ortalamaHasarTutar3||''','''||sonucyilhasar||''','''||null/*BifurcationSegment*/||''','''') from dual';
        execute immediate d1_sql into d2_sql;
        execute immediate v_sql into t_sql;
        execute immediate t_sql into rec;
        --addTestLog(t_sql);
        if p_debugmode='1' then addlog ('','12', ''); end if;

        /* IMM - FK - Taşınan Emtea - Kaskocan */
            -- Koltuk sayısı boş geliyorsa 100501'den çekilecek.
            /*
            p_immPrim := getKaskoIMMPrim(tariffdate, productNo, to_char(p_kullanimtarzi), to_number(immSorumlulukTeminatLimiti), to_number(maneviTazminatLimiti)); --M7
            p_fkPrim := getKaskoFKPrim(tariffdate, to_char(p_kullanimtarzi) , to_number(koltukSayisi), to_number(fkKoltukTeminatLimiti)); --M8
            p_fkSigortaliPrim := getKaskoSigortaliFKPrim(tariffdate, to_number(fkSigortaliTeminatLimiti)); --M9
            p_tasinanEmteaFiyat := getKaskoTasinanEmteaFiyati(tariffdate, tasinanEmtiaCinsi); --M10
            p_sesGoruntuCihaziFiyat := getKaskoSesGoruntuCihaziFiyati(tariffdate); --M11
            p_hukuksalKorumaPrim := getKaskoHukuksalKorumaPrim(tariffdate); --M12
            p_miniOnarimPrim := getKaskoMiniOnarimPrim(tariffdate, p_kullanimtarzi, kullanimTipi); --M13
            p_yanlisAkaryakitPrim := getKaskoYanlisAkaryakitPrim(tariffdate, p_kullanimtarzi); --M14
            p_yolYardimPrim := getKaskoYolYardimPrim(tariffdate, p_kullanimtarzi, kullanimTipi, YolYardimAlternatifTeminat);--M15
            */
            /*
                1   GENİŞLETİLMİŞ KASKO
                2   DAR KASKO
                3   RS KASKO
            */
            p_m19 := 0;
            if p_tariffDate>='25/11/2020' then -- Covid19 teminatı
                select count(0) into p_m19 from tnswin.pricing_tables a where a.table_code='KSK-COVID19 TEMINATI' and a.key1=p_ozelTuzel and a.valid_date=(select max(b.valid_Date) from tnswin.pricing_tables b where b.table_code=a.table_code and b.valid_date<=trunc(sysdate));
                if p_m19 > 0 then
                    select a.mult1 into p_m19 from tnswin.pricing_tables a where a.table_code='KSK-COVID19 TEMINATI' and a.key1=p_ozelTuzel and a.valid_date=(select max(b.valid_Date) from tnswin.pricing_tables b where b.table_code=a.table_code and b.valid_date<=trunc(sysdate));
                end if;
            end if;

           if p_tariffDate >='01/07/2021' then
                if paketTipi = '2' then
                    prm_kilitMekanizmaDeg := 0; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 0; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 0;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := 0; -- M13
                    prm_hukuksalKoruma := 0;--10; -- M14
                elsif paketTipi = '3' then
                    prm_kilitMekanizmaDeg := 25; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 13;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                else
                    prm_kilitMekanizmaDeg := 25; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                     if p_tariffDate >='01/07/2019' then
                         prm_gozMuayenesi := 0; -- M8
                     else
                         prm_gozMuayenesi := 20; -- M8
                     end if;
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 13;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                end if;
           elsif p_tariffDate >='13/05/2020' then
                if paketTipi = '2' then
                    prm_kilitMekanizmaDeg := 0; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 0; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 0;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := 0; -- M13
                    prm_hukuksalKoruma := 0;--10; -- M14
                elsif paketTipi = '3' then
                    prm_kilitMekanizmaDeg := 25; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 11;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                else
                    prm_kilitMekanizmaDeg := 25; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                     if p_tariffDate >='01/07/2019' then
                         prm_gozMuayenesi := 0; -- M8
                     else
                         prm_gozMuayenesi := 20; -- M8
                     end if;
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 11;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                end if;
           elsif p_tariffDate >='31/03/2020' then
                if paketTipi = '2' then
                    prm_kilitMekanizmaDeg := 0; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 0; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 0;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := 0; -- M13
                    prm_hukuksalKoruma := 0;--10; -- M14
                elsif paketTipi = '3' then
                    prm_kilitMekanizmaDeg := 15; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 11;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                else
                    prm_kilitMekanizmaDeg := 15; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                     if p_tariffDate >='01/07/2019' then
                         prm_gozMuayenesi := 0; -- M8
                     else
                         prm_gozMuayenesi := 20; -- M8
                     end if;
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 11;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                end if;
           elsif p_tariffDate >='01/06/2019' then
                if paketTipi = '2' then
                    prm_kilitMekanizmaDeg := 0; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 0; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 0;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := 0; -- M13
                    prm_hukuksalKoruma := 0;--10; -- M14
                elsif paketTipi = '3' then
                    prm_kilitMekanizmaDeg := 15; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 9;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                else
                    prm_kilitMekanizmaDeg := 15; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                     if p_tariffDate >='01/07/2019' then
                         prm_gozMuayenesi := 0; -- M8
                     else
                         prm_gozMuayenesi := 20; -- M8
                     end if;
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 9;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                end if;
            elsif p_tariffDate >='01/03/2019' then
                if paketTipi = '2' then
                    prm_kilitMekanizmaDeg := 0; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 0; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 0;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := 0; -- M13
                    prm_hukuksalKoruma := 0;--10; -- M14
                elsif paketTipi = '3' then
                    prm_kilitMekanizmaDeg := 15; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 7.5;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                else
                    prm_kilitMekanizmaDeg := 15; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 2.5; -- M7
                    prm_gozMuayenesi := 20; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 7.5;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                end if;
            elsif p_tariffDate >='18/12/2018' then
                if p_paketTipi = '2' then
                    prm_kilitMekanizmaDeg := 0; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 0; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 0;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := 0; -- M13
                    prm_hukuksalKoruma := 0;--10; -- M14
                elsif p_paketTipi = '3' then
                    prm_kilitMekanizmaDeg := 15; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 5; -- M7
                    prm_gozMuayenesi := 0; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 20;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                else
                    prm_kilitMekanizmaDeg := 15; -- M6 üzerinden gidiyor. --15; -- M9
                    prm_acilTibbiYardim := 5; -- M7
                    prm_gozMuayenesi := 20; -- M8
                    prm_kisiselEsya := 0; --10; -- M10
                    prm_yurticiTasiyiciSrm := 0; -- M11
                    prm_miniOnarim := 20;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                    prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                    prm_hukuksalKoruma := 5;--10; -- M14
                end if;
            else
                prm_kilitMekanizmaDeg := 15; -- M6 üzerinden gidiyor. --15; -- M9
                prm_acilTibbiYardim := 5; -- M7
                prm_gozMuayenesi := 20; -- M8
                prm_kisiselEsya := 0; --10; -- M10
                prm_yurticiTasiyiciSrm := 0; -- M11
                prm_miniOnarim := 20;--getKaskoMiniOnarimPrim(tariffdate, productNo, p_kullanimtarzi, p_aracSegment); -- M12
                prm_gelirKaybi := getKaskoGelirKaybiPrim(tariffdate, p_kullanimtarzi); -- M13
                prm_hukuksalKoruma := 5;--10; -- M14
            end if;
            
            if p_tariffDate >='22/02/2022' then
                
                    if p_kullanimtarzi = '1' then
                        if p_ilkAracBedeli<650001 then
                            prm_asistans := 345; -- M15
                        else
                            prm_asistans := 555; -- M15
                        end if;
                    end if;

            elsif p_tariffDate >='01/01/2022' then
                
                    if p_kullanimtarzi = '1' then
                        if p_ilkAracBedeli<150001 then
                            prm_asistans := 345; -- M15
                        elsif p_ilkAracBedeli<200001 then
                            prm_asistans := 345; -- M15
                        elsif p_ilkAracBedeli<250001 then
                            prm_asistans := 555; -- M15
                        elsif p_ilkAracBedeli<350001 then
                            prm_asistans := 555; -- M15
                        elsif p_ilkAracBedeli<450001 then
                            prm_asistans := 555; -- M15
                        elsif p_ilkAracBedeli<700001 then
                            prm_asistans := 555; -- M15
                        else
                            prm_asistans := 555; -- M15
                        end if;
                    elsif p_kullanimtarzi = '6' then
                        prm_asistans := 325; -- M15
                    end if;
                
            elsif p_tariffDate >='01/05/2021' then
                if p_paketTipi = '2' then
                    prm_asistans := 50; -- M15
                else
                    if p_kullanimtarzi = '1' then
                        if p_ilkAracBedeli<150001 then
                            prm_asistans := 170; -- M15
                        elsif p_ilkAracBedeli<200001 then
                            prm_asistans := 170; -- M15
                        elsif p_ilkAracBedeli<250001 then
                            prm_asistans := 170; -- M15
                        elsif p_ilkAracBedeli<350001 then
                            prm_asistans := 280; -- M15
                        elsif p_ilkAracBedeli<450001 then
                            prm_asistans := 280; -- M15
                        elsif p_ilkAracBedeli<700001 then
                            prm_asistans := 280; -- M15
                        else
                            prm_asistans := 280; -- M15
                        end if;
                    elsif p_kullanimtarzi = '6' then
                        prm_asistans := 80; -- M15
                    end if;
                end if;
            elsif p_tariffDate >='13/05/2020' then
                if p_paketTipi = '2' then
                    prm_asistans := 50; -- M15
                else
                    if p_kullanimtarzi = '1' then
                        if p_ilkAracBedeli<80001 then
                            prm_asistans := 130; -- M15
                        elsif p_ilkAracBedeli<100001 then
                            prm_asistans := 130; -- M15
                        elsif p_ilkAracBedeli<120001 then
                            prm_asistans := 130; -- M15
                        elsif p_ilkAracBedeli<160001 then
                            prm_asistans := 150; -- M15
                        elsif p_ilkAracBedeli<250001 then
                            prm_asistans := 150; -- M15
                        elsif p_ilkAracBedeli<350001 then
                            prm_asistans := 150; -- M15
                        else
                            prm_asistans := 150; -- M15
                        end if;
                    elsif p_kullanimtarzi = '6' then
                        prm_asistans := 70; -- M15
                    end if;
                end if;
            elsif p_tariffDate >='17/05/2019' then
                if p_paketTipi = '2' then
                    prm_asistans := 50; -- M15
                else
                    if p_kullanimtarzi = '1' then
                        if p_ilkAracBedeli<80001 then
                            prm_asistans := 155; -- M15
                        elsif p_ilkAracBedeli<100001 then
                            prm_asistans := 155; -- M15
                        elsif p_ilkAracBedeli<120001 then
                            prm_asistans := 155; -- M15
                        elsif p_ilkAracBedeli<160001 then
                            prm_asistans := 185; -- M15
                        elsif p_ilkAracBedeli<250001 then
                            prm_asistans := 185; -- M15
                        elsif p_ilkAracBedeli<350001 then
                            prm_asistans := 185; -- M15
                        else
                            prm_asistans := 185; -- M15
                        end if;
                    elsif p_kullanimtarzi = '6' then
                        prm_asistans := 85; -- M15
                    end if;
                end if;
            elsif p_tariffDate >='01/03/2019' then
                if p_paketTipi = '2' then
                    prm_asistans := 50; -- M15
                else
                    prm_asistans := 145; -- M15
                end if;
            elsif p_tariffDate >='01/05/2018' then
                if p_paketTipi = '2' then
                    prm_asistans := 50; -- M15
                else
                    prm_asistans := 155; -- M15
                end if;
            else
                prm_asistans := 140; -- M15
            end if;
            if p_tariffDate >='27/02/2019' then
                prm_diger := 0; -- M16
            elsif p_tariffDate >='13/03/2018' then
                prm_diger := 110; -- M16
            else
                prm_diger := 100; -- M16
            end if;
--            (p_tarifeTarihi date, p_kullanimSekli char, p_immSorumlulukLimiti number, p_maneviTazminat number)
                --    addDebugLog(s_PricingId,'getKaskoIMMPrim('||tariffdate||','||to_char(p_kullanimtarzi)||','||immSorumlulukTeminatLimiti||','||maneviTazminatLimiti||');');

            prm_imm := getKaskoIMMPrim(tariffdate, to_char(p_kullanimtarzi), immSorumlulukTeminatLimiti, maneviTazminatLimiti); --M17
            if p_tariffDate >='19/03/2018' then
               prm_fk := getKaskoFKPrim(tariffdate, to_char(p_kullanimtarzi) , koltukSayisi, fkSigortaliTeminatLimiti, fkKoltukTeminatLimiti)/2; --M18
            else
               prm_fk := getKaskoFKPrim(tariffdate, to_char(p_kullanimtarzi) , koltukSayisi, fkSigortaliTeminatLimiti, fkKoltukTeminatLimiti); --M18
            end if;



            if p_tariffDate >='01/03/2019' then
                prm_imm := prm_imm * 0.6;
                prm_fk := prm_fk * 0.5;
            end if;


            --p_tasinanEmteaPrim := getKaskoTasinanEmteaPrim(p_kullanimtarzi, tasinanEmtiaBedeli, tasinanEmtiaCinsi); --M10
        /* IMM - FK - Taşınan Emtea - Kaskocan */


/* CAP Kontrol
        if (p_yenilemecapmin is not null and p_yenilemecapmax is not null) and (p_yenilemecapmin<>'99' and p_yenilemecapmax<>'0') THEN
            IF p_yenilemeCapMin > rec.m1+rec.m2+rec.m3 THEN
                rec.m1 := p_yenilemeCapMin - (rec.m2+rec.m3);
                rec.prim := (rec.m1+rec.m2+rec.m3+rec.m4+rec.m5+rec.m6)*(aracBedeli+p_kasabedeli+p_digerAksesuarBedeli)/1000;
            END IF;
            IF p_yenilemeCapMax < rec.m1+rec.m2+rec.m3 THEN
                rec.m1 := p_yenilemeCapMax - (rec.m2+rec.m3);
                rec.prim := (rec.m1+rec.m2+rec.m3+rec.m4+rec.m5+rec.m6)*(aracBedeli+p_kasabedeli+p_digerAksesuarBedeli)/1000;
            END IF;
        end if;
 CAP Kontrol
if (p_gecmispolicefiyat > 1) THEN
    rec.m1 := p_gecmispolicefiyat;
end if;
        if to_date(p_tariffDate,'DD/MM/YYYY')>='01/08/2016' then
            select count(0) into p_minimumprim from pricing_tables tt where tt.table_code='Minimum Prim Fiyat' and tt.key1=p_kullanimtarzi and tt.key2=p_yenilemeyeniiskod and tt.key3=p_ozelTuzel and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='Minimum Prim Fiyat' and tt1.valid_date<=p_tariffDate);
        else
            select count(0) into p_minimumprim from pricing_tables tt where tt.table_code='Minimum Prim Fiyat' and tt.key1=p_kullanimtarzi and tt.key2=p_yenilemeyeniiskod and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='Minimum Prim Fiyat' and tt1.valid_date<=p_tariffDate);
        end if;
        if p_minimumprim>0 then
            if to_date(p_tariffDate,'DD/MM/YYYY')>='01/08/2016' then
                select mult1, mult2 into p_minimumprim, p_minimumfiyat from pricing_tables tt where tt.table_code='Minimum Prim Fiyat' and tt.key1=p_kullanimtarzi and tt.key2=p_yenilemeyeniiskod and tt.key3=p_ozelTuzel and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='Minimum Prim Fiyat' and tt1.valid_date<=p_tariffDate);
            else
                select mult1, mult2 into p_minimumprim, p_minimumfiyat from pricing_tables tt where tt.table_code='Minimum Prim Fiyat' and tt.key1=p_kullanimtarzi and tt.key2=p_yenilemeyeniiskod and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='Minimum Prim Fiyat' and tt1.valid_date<=p_tariffDate);
            end if;
        else
            p_minimumfiyat := 0;
        end if;
        if p_minimumFiyatKorunsunMu='E' then
            if p_minimumfiyat >= rec.m1+rec.m2+rec.m3 then
                rec.m1 := p_minimumfiyat - (rec.m2+rec.m3);
                rec.prim := (rec.m1+rec.m2+rec.m3+rec.m4+rec.m5+rec.m6)*(aracBedeli+p_kasabedeli+p_digerAksesuarBedeli)/1000;
            end if;
        end if;
        if minimumPrimKorunsunMu='E' then
            if p_kasabedeli + p_digerAksesuarBedeli > 0 then rec.prim := (rec.m1+rec.m2+rec.m3+rec.m4+rec.m5+rec.m6)*(aracBedeli+p_kasabedeli+p_digerAksesuarBedeli)/1000; END IF;
            if p_minimumprim >= rec.prim then
                rec.prim := p_minimumprim;
            end if;
        end if;

        arac_deger varchar2, markakodu varchar2, kullanimTarzi varchar2, hasarAdedi varchar2,
                kullanimTipi varchar2, modelYili varchar2, plakailkodu varchar2, plakaNo varchar2,
                motorNo varchar2, sasiNo varchar2, kimlikNo varchar2, aracSkor varchar2,
                ozelIndirim varchar2, sigortaliSkor varchar2, surprim varchar2, acenteKodu varchar2,
                kaskoFiyat varchar2, markaTipKodu varchar2, tariffDate varchar2
        */
--        auth := getauthorization.getmotorauth(aracBedeli, p_markakodu, p_kullanimtarzi, p_Otor_kismiHasarSayisi+p_Otor_camHasarSayisi, kullanimTipi, p_model, plakailkodu, plakaNo, '', sasiNo, kimlikNo, p_aracskor, OzelIndirim, p_otor_sigortaliskor, surprim, acente, rec.m1+rec.m2+rec.m3+rec.m4+rec.m5+rec.m6, p_markatipkodu, TariffDate,s_PricingId, p_kasabedeli,p_yenilemeyeniiskod, p_digerAksesuarBedeli,sesGoruntuCihaziBedeli, tasinanEmtiaBedeli);
            if p_tariffDate <='17/12/2018' then
                    select count(0) into p_minimumprim from pricing_tables tt where tt.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and tt1.valid_date<=p_tariffDate);
                    if p_minimumprim > 0 then
                        select mult1 into p_minimumprim from pricing_tables tt where tt.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and tt1.valid_date<=p_tariffDate);
                    end if;
            else
                if p_paketTipi is null or p_paketTipi not in('1','2','3') then
                    select count(0) into p_minimumprim from pricing_tables tt where tt.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and trim(tt.key4)='1' and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and trim(tt.key4)='1' and tt1.valid_date<=p_tariffDate);
                    if p_minimumprim > 0 then
                        select mult1 into p_minimumprim from pricing_tables tt where tt.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and trim(tt.key4)='1' and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and trim(tt.key4)='1' and tt1.valid_date<=p_tariffDate);
                    end if;
                else
                    select count(0) into p_minimumprim from pricing_tables tt where tt.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and trim(tt.key4)=p_paketTipi and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and trim(tt.key4)=p_paketTipi and tt1.valid_date<=p_tariffDate);
                    if p_minimumprim > 0 then
                        select mult1 into p_minimumprim from pricing_tables tt where tt.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and trim(tt.key4)=p_paketTipi and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='KSK-MIN PRM' and trim(tt.key1)=productNo and trim(tt.key2)=p_aracBedelGrubu and trim(tt.key3)=p_hasarsizlikKademesi and trim(tt.key4)=p_paketTipi and tt1.valid_date<=p_tariffDate);
                    end if;
                end if;
            end if;
if (p_Otor_camHasarSayisi>0) then
    p_Otor_nihaiHasarSayisi := p_Otor_kismiHasarSayisi -1;
else
    p_Otor_nihaiHasarSayisi := p_Otor_kismiHasarSayisi;
end if;

        p_toplamprim:=(rec.m1*p_surprim*p_ozelIndirim) ;--+ prm_acilTibbiYardim + prm_gozMuayenesi + prm_kisiselEsya + prm_kilitMekanizmaDeg + prm_yurticiTasiyiciSrm + prm_miniOnarim + prm_gelirKaybi + prm_hukuksalKoruma + prm_asistans + prm_diger + prm_imm + prm_fk;
-- CAP Kontrol
if p_hasarsizlikKademesi>0 and p_Otor_nihaiHasarSayisi='0' and p_gecmisPoliceFiyat != '99999' and length(trim(kimlikNo)) = 11 then
        if p_debugmode='1' then addlog ('','90', rec.m1); end if;
--if p_hasarsizlikKademesi>0 and birYilOncekiHasar='0' and p_gecmisPoliceFiyat < rec.m1 then
    --rec.m1 := (p_gecmisPoliceFiyat*p_surprim*1000/(aracBedeli+p_kasabedeli+p_digerAksesuarBedeli));
    --rec.m1 := rec.prim-(prm_acilTibbiYardim + prm_gozMuayenesi + prm_kisiselEsya + prm_yurticiTasiyiciSrm + prm_miniOnarim + prm_gelirKaybi + prm_hukuksalKoruma + prm_asistans + prm_diger);

-- 0. Basamaktan,  1. Basamağa geçenlerde %30
-- 1. Basamaktan (özel kademe dahil),  2. Basamağa geçenler için %15
-- 2. Basamaktan,  3. Basamağa geçenler için %10
-- 3. Basamaktan,  4. Basamağa geçenler için %10
-- 4. Basamaktan,  5. Basamağa geçenler için %10
-- 5. Basamak ve sonrası için %10**
if p_tariffDate < '01/10/2018' then
        if p_debugmode='1' then addlog ('','91', rec.m1); end if;
    if p_gecmisHasarsizlikIndirimi=0 and p_hasarsizlikKademesi=1 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*70/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=1 and p_hasarsizlikKademesi=2 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*85/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=2 and p_hasarsizlikKademesi=3 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*90/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=3 and p_hasarsizlikKademesi=4 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*90/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=4 and p_hasarsizlikKademesi=5 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*90/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=5 and p_hasarsizlikKademesi>=6 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*90/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    else
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    end if;
elsif p_tariffDate < '28/11/2018' then
        if p_debugmode='1' then addlog ('','92', rec.m1); end if;
--0.    Basamaktan,  1. Basamağa geçenlerde %10 indirim
--1.    Basamaktan (özel kademe dahil),  2. Basamağa geçenler için %0 (indirim yok)
--2.    Basamaktan,  3. Basamağa geçenler için %0 (indirim yok)
--3.    Basamaktan,  4. Basamağa geçenler için %0 (indirim yok)
--4.    Basamaktan,  5. Basamağa geçenler için %0 (indirim yok)
--5.    Basamak ve sonrası için %0 (indirim yok)
    if p_gecmisHasarsizlikIndirimi=0 and p_hasarsizlikKademesi=1 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*90/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=1 and p_hasarsizlikKademesi=2 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*100/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=2 and p_hasarsizlikKademesi=3 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*100/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=3 and p_hasarsizlikKademesi=4 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*100/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=4 and p_hasarsizlikKademesi=5 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*100/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=5 and p_hasarsizlikKademesi>=6 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*100/100;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    else
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    end if;
elsif p_tariffDate < '31/01/2019' then
        if p_debugmode='1' then addlog ('','93', p_gecmisHasarsizlikIndirimi||'-'||p_hasarsizlikKademesi); end if;
/*
0. Basamaktan,  1. Basamağa geçenlerde %5 sürprim
1. Basamaktan (özel kademe dahil),  2. Basamağa geçenler için %10 sürprim
2. Basamaktan,  3. Basamağa geçenler için %10 sürprim
3. Basamaktan,  4. Basamağa geçenler için %10 sürprim
4. Basamaktan,  5. Basamağa geçenler için %10 sürprim
5. Basamak ve sonrası için %10 sürprim
*/
    if p_gecmisHasarsizlikIndirimi=0 and p_hasarsizlikKademesi=1 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*105/100;
            if p_debugmode='1' then addlog ('','94', p_gecmisPoliceFiyat); end if;
            if p_debugmode='1' then addlog ('','95', p_surprim); end if;
            if p_debugmode='1' then addlog ('','96', p_ozelIndirim); end if;
            if p_debugmode='1' then addlog ('','97', p_tmpPrim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=1 and p_hasarsizlikKademesi=2 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*110/100;
                    if p_debugmode='1' then addlog ('','98', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=2 and p_hasarsizlikKademesi=3 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*110/100;
                    if p_debugmode='1' then addlog ('','99', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=3 and p_hasarsizlikKademesi=4 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*110/100;
                    if p_debugmode='1' then addlog ('','100', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=4 and p_hasarsizlikKademesi=5 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*110/100;
                    if p_debugmode='1' then addlog ('','101', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=5 and p_hasarsizlikKademesi>=6 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*110/100;
                    if p_debugmode='1' then addlog ('','102', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    else
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim;
                    if p_debugmode='1' then addlog ('','103', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    end if;
elsif p_tariffDate < '02/08/2019' then
        if p_debugmode='1' then addlog ('','93', p_gecmisHasarsizlikIndirimi||'-'||p_hasarsizlikKademesi); end if;
/*
0. Basamaktan,  1. Basamağa geçenlerde %20 sürprim
1. Basamaktan (özel kademe dahil),  2. Basamağa geçenler için %25 sürprim
2. Basamaktan,  3. Basamağa geçenler için %25 sürprim
3. Basamaktan,  4. Basamağa geçenler için %25 sürprim
4. Basamaktan,  5. Basamağa geçenler için %25 sürprim
5. Basamak ve sonrası için %25 sürprim

*/
    if p_gecmisHasarsizlikIndirimi=0 and p_hasarsizlikKademesi=1 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*120/100;
            if p_debugmode='1' then addlog ('','94', p_gecmisPoliceFiyat); end if;
            if p_debugmode='1' then addlog ('','95', p_surprim); end if;
            if p_debugmode='1' then addlog ('','96', p_ozelIndirim); end if;
            if p_debugmode='1' then addlog ('','97', p_tmpPrim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=1 and p_hasarsizlikKademesi=2 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*125/100;
                    if p_debugmode='1' then addlog ('','98', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=2 and p_hasarsizlikKademesi=3 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*125/100;
                    if p_debugmode='1' then addlog ('','99', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=3 and p_hasarsizlikKademesi=4 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*125/100;
                    if p_debugmode='1' then addlog ('','100', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=4 and p_hasarsizlikKademesi=5 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*125/100;
                    if p_debugmode='1' then addlog ('','101', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=5 and p_hasarsizlikKademesi>=6 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*125/100;
                    if p_debugmode='1' then addlog ('','102', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    else
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim;
                    if p_debugmode='1' then addlog ('','103', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    end if;

else

        if p_debugmode='1' then addlog ('','93', p_gecmisHasarsizlikIndirimi||'-'||p_hasarsizlikKademesi); end if;
/*
0. Basamaktan,  1. Basama?a geçenlerde %35 sürprim
1. Basamaktan (özel kademe dahil),  2. Basama?a geçenler için %40 sürprim
2. Basamaktan,  3. Basama?a geçenler için %40 sürprim
3. Basamaktan,  4. Basama?a geçenler için %35sürprim
4. Basamaktan,  5. Basama?a geçenler için %35sürprim
5. Basamak ve sonrasy için %35sürprim


*/
    if p_gecmisHasarsizlikIndirimi=0 and p_hasarsizlikKademesi=1 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*135/100;
            if p_debugmode='1' then addlog ('','94', p_gecmisPoliceFiyat); end if;
            if p_debugmode='1' then addlog ('','95', p_surprim); end if;
            if p_debugmode='1' then addlog ('','96', p_ozelIndirim); end if;
            if p_debugmode='1' then addlog ('','97', p_tmpPrim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=1 and p_hasarsizlikKademesi=2 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*140/100;
                    if p_debugmode='1' then addlog ('','98', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=2 and p_hasarsizlikKademesi=3 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*140/100;
                    if p_debugmode='1' then addlog ('','99', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=3 and p_hasarsizlikKademesi=4 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*135/100;
                    if p_debugmode='1' then addlog ('','100', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=4 and p_hasarsizlikKademesi=5 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*135/100;
                    if p_debugmode='1' then addlog ('','101', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    elsif p_gecmisHasarsizlikIndirimi=5 and p_hasarsizlikKademesi>=6 then
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*135/100;
                    if p_debugmode='1' then addlog ('','102', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    else
        p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*135/100;
                    if p_debugmode='1' then addlog ('','103', p_tmpprim); end if;
        if (p_tmpPrim<rec.m1) then
            rec.m1 := p_tmpPrim;
        end if;
    end if;


end if;
--        rec.m2 := 0.5; -- GLKHH Terör
--        rec.m3 := 0.5; -- Deprem Yanardağ
 --       rec.m4 := 0.5; -- Sel ve Su Basması
  --      rec.m5 := 0.5; -- Asıl Anahtarla Çalınma
    --    rec.m6 := 0;--12.0; -- Kilit Mekanizma Değişikliği
      --  rec.m1 := (rec.m1*1000/(aracBedeli+p_kasabedeli+p_digerAksesuarBedeli))-(rec.m2 + rec.m3 + rec.m4 + rec.m5);
elsif length(trim(kimlikNo)) = 10 then -- Tüzel
    p_toplamprim:=rec.m1*p_surprim*p_ozelIndirim;
    if p_tariffDate < '04/10/2019' and p_commercialScore <= 1 and p_gecmisPoliceFiyat < 20000 then
        if p_tariffDate < '28/11/2018' then
            rec.m1 := p_gecmisPoliceFiyat*p_surprim*90/100; -- Tüzellerde önceki fiyat üzerinden %10 indirim...
        else
            rec.m1 := p_gecmisPoliceFiyat*p_surprim*110/100; -- Tüzellerde önceki fiyat üzerine %10 sürprim...
        end if;
    elsif p_tariffDate >= '04/10/2019' and p_tariffDate < '27/12/2019' then
        if p_commercialScore < 1.15 and p_gecmisPoliceFiyat < 20000 and p_Otor_nihaiHasarSayisi='0' then
               /*
        0. Basamaktan,  1. Basama?a geçenlerde %10 sürprim
        1. Basamaktan (özel kademe dahil),  2. Basama?a geçenler için %15 sürprim
        2. Basamaktan,  3. Basama?a geçenler için %15 sürprim
        3. Basamaktan,  4. Basama?a geçenler için %15sürprim
        4. Basamaktan,  5. Basama?a geçenler için %15sürprim
        5. Basamak ve sonrasy için %15sürprim


        */
            if p_gecmisHasarsizlikIndirimi=0 and p_hasarsizlikKademesi=1 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*110/100;
                    if p_debugmode='1' then addlog ('','94', p_gecmisPoliceFiyat); end if;
                    if p_debugmode='1' then addlog ('','95', p_surprim); end if;
                    if p_debugmode='1' then addlog ('','96', p_ozelIndirim); end if;
                    if p_debugmode='1' then addlog ('','97', p_tmpPrim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=1 and p_hasarsizlikKademesi=2 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','98', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=2 and p_hasarsizlikKademesi=3 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','99', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=3 and p_hasarsizlikKademesi=4 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','100', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=4 and p_hasarsizlikKademesi=5 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','101', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=5 and p_hasarsizlikKademesi>=6 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','102', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            else
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','103', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            end if;
        end if;
    elsif p_tariffDate >= '27/12/2019' then
        if p_commercialScore < 1.15 and p_gecmisPoliceFiyat < 20000 and p_birYilOncekiHasarTutariArac<1000 then
               /*
        0. Basamaktan,  1. Basama?a geçenlerde %10 sürprim
        1. Basamaktan (özel kademe dahil),  2. Basama?a geçenler için %15 sürprim
        2. Basamaktan,  3. Basama?a geçenler için %15 sürprim
        3. Basamaktan,  4. Basama?a geçenler için %15sürprim
        4. Basamaktan,  5. Basama?a geçenler için %15sürprim
        5. Basamak ve sonrasy için %15sürprim


        */
            if p_gecmisHasarsizlikIndirimi=0 and p_hasarsizlikKademesi=1 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*110/100;
                    if p_debugmode='1' then addlog ('','94', p_gecmisPoliceFiyat); end if;
                    if p_debugmode='1' then addlog ('','95', p_surprim); end if;
                    if p_debugmode='1' then addlog ('','96', p_ozelIndirim); end if;
                    if p_debugmode='1' then addlog ('','97', p_tmpPrim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=1 and p_hasarsizlikKademesi=2 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','98', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=2 and p_hasarsizlikKademesi=3 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','99', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=3 and p_hasarsizlikKademesi=4 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','100', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=4 and p_hasarsizlikKademesi=5 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','101', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            elsif p_gecmisHasarsizlikIndirimi=5 and p_hasarsizlikKademesi>=6 then
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','102', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            else
                p_tmpprim := p_gecmisPoliceFiyat*p_surprim*p_ozelIndirim*115/100;
                            if p_debugmode='1' then addlog ('','103', p_tmpprim); end if;
                if (p_tmpPrim<rec.m1) then
                    rec.m1 := p_tmpPrim;
                end if;
            end if;
        end if;
    end if;
end if;
        if p_debugmode='1' then addlog ('','104', rec.m1); end if;


if p_hasarsizlikKademesi>0 and p_Otor_nihaiHasarSayisi='0' and p_gecmisPoliceFiyat != '99999' and p_tariffDate >='11/11/2018' then
            if p_kiymetKazanma != p_gecmisServisTuru then rec.m1 := rec.m1 * 115/100; end if;
end if;

-- CAP Kontrol



if p_eskiPolSirketKodu = '051' and p_Otor_nihaiHasarSayisi=0 then
            if p_tariffDate >='19/03/2018' and p_tariffDate < '22/03/2018' then
                rec.m1 := ((rec.m1*85)/100)*p_surprim*p_ozelIndirim;
            elsif p_tariffDate >='22/03/2018' and p_tariffDate <'26/04/2018' then
                rec.m1 := ((rec.m1*90)/100)*p_surprim*p_ozelIndirim;
            elsif p_tariffDate >='26/04/2018' and p_tariffDate < '03/05/2018' then
                rec.m1 := ((rec.m1*95)/100)*p_surprim*p_ozelIndirim;
            end if;


end if;
p_filokontrolminprm := '0';
/* Filo Kontrol */
select count(0) into p_filokontrol from t001c002u5556 filo where trim(filo.k1)=trim(kimlikNo) and trim(filo.k2)=trim(sasiNo) and filo.gecer_tarih+90>=trunc(sysdate) and filo.gecer_tarih=(select max(filo1.gecer_tarih) from t001c002u5556 filo1 where filo1.k1=filo.k1 and filo1.k2=filo.k2);
if p_filokontrol > 0 then
    select filo.d1, filo.d2 into p_filokontrol, p_filokontrolminprm from t001c002u5556 filo where trim(filo.k1)=trim(kimlikNo) and trim(filo.k2)=trim(sasiNo) and filo.gecer_tarih+90>=trunc(sysdate) and filo.gecer_tarih=(select max(filo1.gecer_tarih) from t001c002u5556 filo1 where filo1.k1=filo.k1 and filo1.k2=filo.k2);
    rec.m1 := p_filokontrol;
end if;
/* Filo Kontrol */
/* VKN + Acente 'ye göre sabit çarpan */
select count(0) into p_filokontrol from t001c002u55560 filo where trim(filo.k1)=trim(kimlikNo) and trim(filo.k2)=trim(acente) and filo.gecer_tarih=(select max(filo1.gecer_tarih) from t001c002u55560 filo1 where filo1.k1=filo.k1 and filo1.k2=filo.k2);
if p_filokontrol > 0 then
    select filo.d1, filo.d2, filo.d3 into p_filokontrol, p_filokontrolminprm, p_filokontrolassist from t001c002u55560 filo where trim(filo.k1)=trim(kimlikNo) and trim(filo.k2)=trim(acente) and filo.gecer_tarih=(select max(filo1.gecer_tarih) from t001c002u55560 filo1 where filo1.k1=filo.k1 and filo1.k2=filo.k2);
    if p_aracbedeli != 0 then
        if p_filokontrolassist = '1' then
            rec.m1 := (p_filokontrol * p_aracbedeli)-(prm_acilTibbiYardim + prm_gozMuayenesi + prm_kisiselEsya + prm_kilitMekanizmaDeg + prm_yurticiTasiyiciSrm + prm_miniOnarim  + prm_hukuksalKoruma + prm_diger + prm_imm + prm_fk + p_m19);
        ELSE
            rec.m1 := (p_filokontrol * p_aracbedeli)-(prm_acilTibbiYardim + prm_gozMuayenesi + prm_kisiselEsya + prm_kilitMekanizmaDeg + prm_yurticiTasiyiciSrm + prm_miniOnarim  + prm_hukuksalKoruma + prm_diger + prm_imm + prm_fk + p_m19 + prm_asistans);
        end if;
    end if;
end if;
/* VKN + Acente 'ye göre sabit çarpan */

        if rec.m1 < p_minimumprim then
            if p_filokontrolminprm != '1' or p_filokontrolminprm is null then
                rec.m1 := p_minimumprim;
            end if;
        end if;

        rec.prim := rec.m1 + prm_acilTibbiYardim + prm_gozMuayenesi + prm_kisiselEsya + prm_kilitMekanizmaDeg + prm_yurticiTasiyiciSrm + prm_miniOnarim + prm_hukuksalKoruma + prm_asistans + prm_diger + prm_imm + prm_fk + p_m19 + prm_asistans;
        rec.m2 := 0.5; -- GLKHH Terör
        rec.m3 := 0.5; -- Deprem Yanardağ
        rec.m4 := 0.5; -- Sel ve Su Basması
        if p_tariffDate < '13/07/2018' then
            if (p_kullanimtarzi = '1') then
                rec.m5 := 0.5; -- Asıl Anahtarla Çalınma
            else
                rec.m5 := 0;
            end if;
        else
            if (p_kullanimtarzi = '1' or p_kullanimtarzi = '6') then
                rec.m5 := 0.5; -- Asıl Anahtarla Çalınma
            else
                rec.m5 := 0;
            end if;
        end if;
        rec.m6 := 0;--12.0; -- Kilit Mekanizma Değişikliği
--        rec.m1 := ((rec.m1-(1250*rec.m6/1000))*1000/(aracBedeli+p_kasabedeli+p_digerAksesuarBedeli))-(rec.m2 + rec.m3 + rec.m4 + rec.m5);
--        rec.m1 := (rec.m1*1000/(aracBedeli+p_kasabedeli+p_digerAksesuarBedeli))-(rec.m2 + rec.m3 + rec.m4 + rec.m5);

        p_toplamprimcap:=rec.m1;-- + prm_acilTibbiYardim + prm_gozMuayenesi + prm_kisiselEsya + prm_kilitMekanizmaDeg + prm_yurticiTasiyiciSrm + prm_miniOnarim + prm_gelirKaybi + prm_hukuksalKoruma + prm_asistans + prm_diger + prm_imm + prm_fk;

        rec.m1 := (rec.m1*1000/(p_aracbedeli))-(rec.m2 + rec.m3 + rec.m4 + rec.m5);


--        p_sql := 'getauthorization.getmotorauth('''||aracBedeli||''','''|| p_markakodu||''','''|| p_kullanimtarzi||''', nvl(trim('''||kismihasarsayisi||'''),0)+nvl(trim('''||camhasarsayisi||'''),0),'''|| ''||''','''|| p_model||''','''|| p_plakaIlKodu||''','''|| plakaNo||''','''|| ''||''','''|| sasiNo||''','''|| kimlikNo||''','''|| p_aracskor||''','''|| OzelIndirim||''','''|| p_otor_sigortaliskor||''','''|| surprim||''','''|| acente||''','|| rec.m1||'+'||rec.m2||'+'||rec.m3||'+'||rec.m4||'+'||rec.m5||'+'||rec.m6||','''|| p_markatipkodu||''','''|| TariffDate||''','''||s_PricingId||''','|| p_kasabedeli||'+'||p_digerAksesuarBedeli||'+to_number(nvl(trim('''||sesGoruntuCihaziBedeli||'''),''0''))+ to_number(nvl(trim('''||tasinanEmtiaBedeli||'''),''0'')),'''||p_yenilemeyeniiskod||''')';
-- , kasa varchar2, yenilemeYeniIs varchar2, digerAksesuar varchar2, sesGoruntuCihazi varchar2, tasinanEtmea varchar2)
        addTariffLog(productNo,p_tariffdate,kimlikNo,sasiNo,tescilSeriKod,tescilSeriNo,plakailkodu,p_plakaNo,asbisNo, tescilTarihi,trafigeCikisTarihi,s_PricingId,'TARIFF','',d2_sql,p_cocukdegiskeni,p_sigortaliyas,p_aracyasi,p_kullanimtarzi,p_kullanimsekli,p_aracskor,p_cinsiyeti,p_medenihali,p_tramerilce,p_sigortaliskor,p_systemdate,p_systemtime,p_yakittipi,p_markakodu,p_yeniaracbedel,p_filosegment,p_markariskgrubu,p_yenilemeyeniiskod,  p_kismihasarsayisi,  p_sigortaliliksuresi, p_camhasarsayisi, 'SBM', rec.m1, rec.m2, rec.m3, rec.m4, rec.m5, rec.m6, p_sql,p_markatipkodu,p_minimumfiyat,p_minimumprim,p_meslek,p_ilkAracBedeli,p_kasabedeli,p_digerAksesuarBedeli,sesGoruntuCihaziBedeli,p_commercialScore,p_kiymetKazanma,p_ilkAracYas,p_commercialScoreId,p_gecmisHasarSayisi ,p_gecmisHasarsizlikIndirimi,p_gecmisPoliceFiyat ,p_yenilemeCapMin,p_yenilemeCapMax,clob_sbmValues,p_yenilemeFloor,p_yenilemeCap,P_WHP,acente,kullaniciAdi,p_hasarsizlikKademesi,OzelIndirim, surprim, p_capPolice, referancePriceId, NULL,NULL,NULL,NULL,NULL,auth, p_cache_key, '1', prm_acilTibbiYardim , prm_gozMuayenesi , prm_kilitMekanizmaDeg , prm_kisiselEsya, prm_yurticiTasiyiciSrm, prm_miniOnarim, prm_gelirKaybi, prm_hukuksalKoruma, prm_asistans, prm_diger, prm_imm, prm_fk, p_toplamprim, p_toplamprimcap, p_Otor_nihaiHasarSayisi, p_gecmisServisTuru, p_birYilOncekiHasarTutariArac,null,null,null,null,null,null,null,null,null,null,null,p_m19);
else
--        t_sql := 'select price_id priceid, m1,m2,m3,m4,m5,m6,'''' prim from pricing_tariff_log where system_date=to_char(sysdate,''DD/MM/YYYY'') and cast(psql as varchar2(1000))='''||to_char(p_sql)||'''';
--        execute immediate t_sql into rec;
          select price_id priceid, m1,m2,m3,m4,m5,m6,((m1+m2+m3+m4+m5)*(aracBedeli+nvl(p_kasabedeli,0)+nvl(p_digerAksesuarBedeli,0))/1000)+nvl(m7,0)+nvl(m8,0)+nvl(m9,0)+nvl(m10,0)+nvl(m11,0)+nvl(m12,0)+nvl(m13,0)+nvl(m14,0)+nvl(m15,0)+nvl(m16,0)+nvl(m17,0)+nvl(m18,0) prim into rec from pricing_tariff_log a where cast(psql as varchar2(1000))=to_char(p_sql) and m1<>'99' and a.status='1' and to_date(a.system_date||' '||substr(a.system_time,1,8),'DD/MM/YYYY HH24:MI:SS')=(select max(to_date(b.system_date||' '||substr(b.system_time,1,8),'DD/MM/YYYY HH24:MI:SS')) from tnswin.pricing_tariff_log b where cast(a.psql as varchar2(4000))=cast(b.psql as varchar2(4000)) and a.m1=b.m1 and a.status=b.status and to_date(b.system_date,'DD/MM/YYYY')>=to_char(sysdate-p_cachedays,'DD/MM/YYYY'));
end if;
        PIPE ROW (rec);
        RETURN;
        EXCEPTION WHEN OTHERS THEN
            --v_errm := SUBSTR(SQLERRM, 1, 4000);
            v_errm :=   substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
            addTariffLog(productNo,p_tariffdate,kimlikNo,sasiNo,tescilSeriKod,tescilSeriNo,plakailkodu,p_plakaNo,asbisNo, tescilTarihi,trafigeCikisTarihi,s_PricingId,'TARIFF',v_errm,v_sql,p_cocukdegiskeni,p_sigortaliyas,p_aracyasi,p_kullanimtarzi,p_kullanimsekli,p_aracskor,p_cinsiyeti,p_medenihali,p_tramerilce,p_sigortaliskor,p_systemdate,p_systemtime,p_yakittipi, p_markakodu,p_yeniaracbedel,p_filosegment,p_markariskgrubu,p_yenilemeyeniiskod,  p_kismihasarsayisi,  p_sigortaliliksuresi,  p_camhasarsayisi, 'SBM', 99,99,99,99,99,99,p_sql,p_markatipkodu,p_minimumfiyat,p_minimumprim,p_meslek,p_ilkAracBedeli,p_kasabedeli,p_digerAksesuarBedeli,sesGoruntuCihaziBedeli,p_commercialScore,p_kiymetKazanma,p_ilkAracYas,p_commercialScoreId,p_gecmisHasarSayisi ,p_gecmisHasarsizlikIndirimi,p_gecmisPoliceFiyat ,p_yenilemeCapMin,p_yenilemeCapMax,clob_sbmValues,p_yenilemeFloor,p_yenilemeCap,P_WHP,acente,kullaniciAdi,p_hasarsizlikKademesi,OzelIndirim, surprim, p_capPolice, referancePriceId,NULL,NULL,NULL,NULL,NULL,NULL, p_cache_key, '0',prm_acilTibbiYardim , prm_gozMuayenesi , prm_kilitMekanizmaDeg , prm_kisiselEsya, prm_yurticiTasiyiciSrm, prm_miniOnarim, prm_gelirKaybi, prm_hukuksalKoruma, prm_asistans, prm_diger, prm_imm, prm_fk, p_toplamprim, p_toplamprimcap, p_Otor_nihaiHasarSayisi, p_gecmisServisTuru, p_birYilOncekiHasarTutariArac,null,null,null,null,null,null,null,null,null,null,null,p_m19);
        RETURN;
    END getTariffMain;

    FUNCTION getTariffTRF(productNo varchar2,TariffDate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,tescilTarihi varchar2,trafigeCikisTarihi varchar2,
    kullanimSekli varchar2,model varchar2,markaTipKodu varchar2,kaskoHasarsizlikKademesi varchar2,yakitTipi varchar2,trafikKademesi varchar2, sigortaliliksuresi number, kismihasarsayisi varchar2, oncekiTrafikKademesi varchar2,
    hatliMi varchar2, gecikmeSurprimi varchar2, yenilemeYili varchar2, acente varchar2, kullaniciAdi varchar2, referancePriceId varchar2)
       RETURN stablex
        PIPELINED IS
        rec srecordx;
        /*
            HasarSayısı -- Kısmi Hasar Sayısı
            SigortalılıkSüresi -- Sigortalılık Süresi
            HatlıMı
            GecikmeSürprimi
            YenilemeYılı
        */
        v_sql CLOB;
        t_sql CLOB;
        p_tariffDate date;
        p_ofacKontrol NUMBER;
        p_aracSayisiNewKontrol NUMBER;
        p_trafikKayitliAracSayisi NUMBER;
        p_karaListeKontrol NUMBER;
        p_bedeniWinsureKontrol NUMBER;
        p_bedeniAS400Kontrol NUMBER;
        clob_sbmValues CLOB;
        clob_aileSorgu CLOB;
        clob_sasiSorgu CLOB;
        clob_tcknSorgu CLOB;
        clob_adresSorgu CLOB;
        clob_tcknAracSorgu CLOB;
        clob_tcknPlakaSorgu CLOB;
        clob_egmSorgu CLOB;
        clob_trafikPoliceSorguKimlik CLOB;
        clob_hasarBelgeSorgu CLOB;
        p_cocukdegiskeni VARCHAR2(5);
        p_aracyasi VARCHAR2(10);
        p_sigortaliyas VARCHAR2(10);
        p_aracskor VARCHAR2(10);
        p_kullanimsekli VARCHAR2(20);
        p_kullanimtarzi100501 VARCHAR2(2);
        p_kullanimtarzi VARCHAR2(2);
        p_kullanimTipiCap VARCHAR2(1);
        p_cinsiyeti VARCHAR(5);
        p_medenihali VARCHAR2(25);
        p_tramerIl VARCHAR2(3);
        p_tramerilce VARCHAR2(7);
        p_sigortaliskor NUMBER;
        p_systemdate VARCHAR2(10);
        p_systemtime VARCHAR2(25);
        s_PricingId NUMBER;
        p_yakittipi VARCHAR2(15);
        v_errm CLOB;
        p_markatipkodu VARCHAR2(10);
        p_markakodu VARCHAR2(10);
        z_sql CLOB;
        d1_sql CLOB;
        d2_sql CLOB;
        p_meslek varchar2(20);
        p_yeniaracbedel NUMBER(15);
        p_aracbedeli NUMBER(15);
        p_filosegment VARCHAR2(3);
        p_markariskgrubu VARCHAR2(3);
        p_yenilemeyeniiskod VARCHAR2(3);
        p_kismihasarsayisi NUMBER;
        p_sigortaliliksuresi NUMBER;
        p_camhasarsayisi NUMBER;
        p_sql CLOB;
        p_model NUMBER(4);
        p_maxPrim NUMBER(11,2);
        p_minimumprim NUMBER(11,2);
        p_minimumfiyat NUMBER(11,5);
        p_egmkaydivarmi VARCHAR2(1);
        p_yenilemeMi VARCHAR2(1);
        p_kasabedeli NUMBER(11,2);
        p_digerAksesuarBedeli NUMBER(11,2);
        p_yenilemeCapIndirimi NUMBER;
        p_guncelbedel VARCHAR2(1);
        p_ilkAracBedeli NUMBER(15);
        p_commercialScore VARCHAR2(10);
        p_commercialScoreId NUMBER(20);
        p_hasarsizlikOran VARCHAR2(10);
        p_ilkAracYas VARCHAR2(10);
        p_ozelIndirim NUMBER(11,5);
        p_surprim NUMBER(11,5);
        p_plakaIlKodu VARCHAR2(3);
        p_gecmisHasarSayisi VARCHAR2(5);
        p_gecmisHasarsizlikIndirimi VARCHAR2(5);
        p_gecmisPoliceFiyat NUMBER(11,5);
        p_yenilemeCapMin VARCHAR2(15);
        p_yenilemeCapMax VARCHAR2(15);
        p_yenilemeCap VARCHAR(15);
        p_yenilemeFloor VARCHAR(15);
        p_plaka100502 NUMBER;
        p_filoSegmentD VARCHAR2(10);
        p_filoSegmentSql CLOB;
        p_ozelTuzel VARCHAR2(1);
        p_ticariFaktor NUMBER;
        p_minimumFiyatKorunsunMu VARCHAR2(1);
        p_agirlik VARCHAR2(5);
        p_beygirGucu VARCHAR2(5);
        p_whp VARCHAR2(5);
        p_aracSegment VARCHAR2(7);
        p_kasaTipi varchar(30);
        p_cache number;
        p_capPolice VARCHAR2(30);
        p_tcknSorguKontrol VARCHAR2(1);
        s_key VARCHAR2(4000);
        p_productNo VARCHAR2(50);
        refproductNo VARCHAR2(50);
        p_trafikKademesi VARCHAR2(5);
        p_oncekiTrafikKademesi VARCHAR2(5);
        p_cocukSayisi varchar(5);
        p_cocukSayisiMax NUMBER;
        p_gecikmeSurprimi VARCHAR2(3);
        p_yenilemeYili NUMBER;
        p_hatliMi VARCHAR2(1);
        p_hatliSayisi NUMBER;
        p_kullanimSekliSbm VARCHAR2(10);
refTariffdate varchar2(50);
refkimlikNo varchar2(50);
refsasiNo varchar2(50);
reftescilSeriKod varchar2(50);
reftescilSeriNo varchar2(50);
refplakailkodu varchar2(50);
refplakaNo varchar2(50);
refasbisNo varchar2(50);
reftescilTarihi varchar2(50);
reftrafigeCikisTarihi varchar2(50);
refreferansPoliceBilgileri varchar2(50);
refkullanimSekli varchar2(50);
refmodel varchar2(50);
refmarkaTipKodu varchar2(50);
refhasarsizlikKademesi varchar2(50);
refyakitTipi varchar2(50);
refaracBedeli varchar2(50);
refkasaBedeli varchar2(50);
reftasinanEmtiaBedeli varchar2(50);
reftasinanEmtiaCinsi varchar2(50);
refsesGoruntuCihaziBedeli varchar2(50);
refdigerAksesuarBedeli varchar2(50);
refyurtDisiTeminatiSuresi varchar2(50);
reftrafikKademesi varchar2(50);
refpaketTipi varchar2(50);
refkullanimTipi varchar2(50);
refOzelIndirim varchar2(50);
refsurprim varchar2(50);
refmeslek varchar2(50);
refkullanimTarzi varchar2(50);
refkiymetKazanma varchar2(50);
refsigortaliliksuresi varchar2(50);
refkismihasarsayisi varchar2(50);
refcamhasarsayisi varchar2(50);
refminimumFiyatKorunsunMu varchar2(50);
refminimumPrimKorunsunMu varchar2(50);
refacente varchar2(50);
refkullaniciAdi varchar2(50);
refreferancePriceId varchar2(50);
checkRef varchar2(1);
refp_cocukdegiskeni varchar2(50);
refp_sigortaliyas varchar2(50);
refp_aracyasi varchar2(50);
refp_aracskor varchar2(50);
refp_sigortaliskor varchar2(50);
refp_yakittipi varchar2(50);
refp_commercialScore varchar2(50);
refp_medenihali varchar2(50);
refp_yenilemeyeniiskod varchar2(50);
checkReferansId number;
p_kiymetKazanma varchar2(5);
clob_marka CLOB;
clob_tip CLOB;
p_hasarSayisi NUMBER;
p_trfFrekans NUMBER;
p_yasayanOtoUrun varchar2(2); -- Kullanılmıyor
p_pertarac varchar2(2); -- Kullanılmıyor
p_teenCocuk varchar2(2); -- Kullanılmıyor
p_ErkekTeenCocuk varchar2(2); -- Kullanılmıyor
p_cache_key varchar2(2000);
clob_trafikteklifislemid clob;
p_trfisliduyggerbasamakkodu varchar2(5);
p_trfisliduygbasamakkodu varchar2(5);
p_trfislidgecikmesurprim varchar2(5);
p_referancePriceId varchar(36);
price_type varchar2(15);
p_debugmode varchar2(1);
p_appsorgukontrol number;
p_cachepriceid varchar(50);
p_issbmpolendors varchar2(1);

eurocar_segment varchar2(50);
eurocar_kasatipi varchar2(50);
eurocar_sanziman varchar2(50);
NBRENEWAL2 varchar2(50);
p_MARKATIPGRUP varchar2(50);
p_ililcegrup varchar2(50);
p_trfDonemselHasarSayisi varchar2(100);
birYilOncekiHasar varchar2(3);
ikiYilOncekiHasar varchar2(3);
ucYilOncekiHasar varchar2(3);
p_aracBedelGrubu varchar2(15);
sonUcYilHasarSayisi varchar2(3);
        p_ilceAd varchar2(20);
        p_ilAd varchar2(20);
        cnt99 number(11,0);
        p_gecikmesurprimoran number(11,2);
        p_referans varchar2(4000);
        p_filoIndirim number(11,0);
        p_kimlikNo varchar2(11);
        p_yabanciSigortali varchar2(1);
        p_yabanciSigortaliInd number(11,2);
        refKontrol number(3,0);
        p_m19 number(11,5);
        p_bifurcationSegment varchar2(2);
        p_bifurcationSubSegment varchar2(3);
        p_toplamhasaradedi number(5,0);
        p_sigortalilikSuresiNew number(11,2);
        p_beklenenSigortalilikSuresiNew number(11,2);
        p_bifurcationSegmentValue varchar2(100);
        p_checkkk number(5);
    BEGIN
        p_systemdate := to_char(SYSDATE,'DD/MM/YYYY');
        p_systemtime := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF');
        price_type := 'TRF_TARIFF';
        p_debugmode := '0';
        p_cache := 0;
        p_issbmpolendors := '0';

        p_productno := productno;

        if kullanimSekli is not null then p_kullanimSekliSbm := substr('0'||trim(kullanimSekli),-2); end if;

        p_yabanciSigortali := '0';
if length(kimlikNo)=11 then
    if substr(kimlikno,1,1)='9' then
        p_yabanciSigortali := '1';
    end if;
end if;

         --   insert into pricing_tariff_log(price_id, system_date) values('9','28/09/2016');
        if p_debugmode='1' then addlog ('','1', ''); end if;
        p_sql := 'select * from table(getTariff.getTariffTRF('''||productNo||''','''||Tariffdate ||''','''||kimlikNo ||''','''||sasiNo ||''','''||tescilSeriKod ||''','''||
        tescilSeriNo ||''','''||plakailkodu ||''','''||plakaNo ||''','''||asbisNo ||''','''||tescilTarihi ||''','''||trafigeCikisTarihi ||''','''||
        kullanimSekli ||''','''||model ||''','''||markaTipKodu ||''','''||kaskoHasarsizlikKademesi ||''','''||yakitTipi ||''','''||
        trafikKademesi || ''','''|| sigortalilikSuresi || ''','''|| kismihasarsayisi || ''',''' ||oncekiTrafikKademesi||''','''||hatliMi||''','''||gecikmeSurprimi||''','''||p_yenilemeYili||''','''|| acente || ''',''' || kullaniciAdi || ''',''' || referancePriceId ||'''))';
        p_tariffDate := TariffDate;




--        select count(0) into p_cache from pricing_tariff_log where system_date=to_char(sysdate,'DD/MM/YYYY') and cast(psql as varchar2(1000))=to_char(p_sql) and m1<>'999999';
/* SBM Cache Yapısı */
        if length(referancePriceId)=36 then
                if p_debugmode='1' then addlog ('','01', ''); end if;
            price_type := 'TRF_SBM';
                        if tescilSeriNo is null then
                            select GETTARIFFTOSBM(kimlikNo, plakailkodu /*p_plakaIlKodu*/, plakaNo, NULL, asbisNo, sasiNo, '123', 'TRF', tescilTarihi, trafigeCikisTarihi, model , p_kullanimSekliSbm, '', '', '', '', referancePriceId) into clob_sbmValues from dual;
                        else
                            select GETTARIFFTOSBM(kimlikNo, plakailkodu /*p_plakaIlKodu*/, plakaNo, tescilSeriKod, tescilSeriNo, sasiNo, '123', 'TRF', tescilTarihi, trafigeCikisTarihi, model , p_kullanimSekliSbm, '', '', '', '', referancePriceId) into clob_sbmValues from dual;
                        end if;
                                        if p_debugmode='1' then addlog ('','02', ''); end if;
            if removeElement(getSbmDetails(getSbmDetails(clob_sbmValues, 'trafikTeklifDataSorguResponse'), 'isSuccessfull'), 'isSuccessfull') = 'true' then
                clob_trafikteklifislemid := getSbmDetails(clob_sbmValues, 'trafikTeklifDataSorguOutput');
                clob_sasiSorgu := getSbmDetails(clob_sbmValues, 'ovmtrafikPoliceSorguSasiKimlikSorgu');
                clob_trafikPoliceSorguKimlik := getSbmDetails(clob_sbmValues, 'trafikPoliceSorguKimlikSorgu');
                
                
                if length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenTarifeBasamakKodu'),'uygulanmasiGerekenTarifeBasamakKodu')) < 3 and length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenTarifeBasamakKodu'),'uygulanmasiGerekenTarifeBasamakKodu')) > 0 then
                    p_trfisliduyggerbasamakkodu := removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenTarifeBasamakKodu'),'uygulanmasiGerekenTarifeBasamakKodu');
                end if;
                if length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmisTarifeBasamakKodu'),'uygulanmisTarifeBasamakKodu')) < 3 and length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmisTarifeBasamakKodu'),'uygulanmisTarifeBasamakKodu')) > 0 then
                    p_trfisliduygbasamakkodu := removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmisTarifeBasamakKodu'),'uygulanmisTarifeBasamakKodu');
                end if;
                if length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenGecikmeSurprimYuzde'),'uygulanmasiGerekenGecikmeSurprimYuzde')) < 3 and length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenGecikmeSurprimYuzde'),'uygulanmasiGerekenGecikmeSurprimYuzde')) > 0 then
                    p_trfislidgecikmesurprim := removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenGecikmeSurprimYuzde'),'uygulanmasiGerekenGecikmeSurprimYuzde');
                end if;
                                if p_debugmode='1' then addlog ('','03', ''); end if;
--               select count(0) into p_cache from pricing_tariff_log where cache_key='TRF'||','||kimlikNo||','||sasiNo||','||p_trfislidgecikmesurprim||','||p_trfisliduygbasamakkodu||','||p_trfisliduyggerbasamakkodu||','||markaTipKodu||','||model||','||kullanimSekli||','||plakailkodu||','||plakaNo||','||acente and /*m1<>'999999'*/ status='1' and (to_char(to_date(system_date,'DD/MM/YYYY'),'MM/YYYY')=to_char(sysdate,'MM/YYYY') or (to_char(sysdate,'DD')<4 and (to_date('01/'||to_char(sysdate,'MM/YYYY'))-1)=to_date(system_date,'DD/MM/YYYY') ));
               select count(0) into p_cache from pricing_tariff_log where cache_key='TRF'||','||kimlikNo||','||sasiNo||','||p_trfislidgecikmesurprim||','||p_trfisliduygbasamakkodu||','||p_trfisliduyggerbasamakkodu||','||markaTipKodu||','||model||','||kullanimSekli||','||plakailkodu||','||plakaNo||','||acente and /*m1<>'999999'*/ status='1' and system_date=to_char(sysdate,'DD/MM/YYYY');
               p_referancePriceId := referancePriceId;
                               if p_debugmode='1' then addlog ('','04', ''); end if;
            else
                p_referancePriceId := null;
            end if;
        else
           select count(0) into p_cache from pricing_tariff_log where system_date=to_char(sysdate,'DD/MM/YYYY') and cast(psql as varchar2(1000))=to_char(p_sql) and status='1';
        end if;

        if p_debugmode='1' then addlog ('','2', p_cache); end if;

        /*
<referansPoliceBilgileri>
               <uygulanmasiGerekenGecikmeSurprimYuzde>25.0</uygulanmasiGerekenGecikmeSurprimYuzde>
               <uygulanmasiGerekenTarifeBasamakKodu>7</uygulanmasiGerekenTarifeBasamakKodu>
               <uygulanmisTarifeBasamakKodu>7</uygulanmisTarifeBasamakKodu>
*/

/*
Plaka il kodu
Plaka
Kullanım şekli
Model
Marka tip kodu
Önceki ve uygulanan kademe
Gecikme sürprimi
TCK/VKN
Şasi
*/
        if p_cache=0 then

        if referancePriceId is not null and referancePriceId<>'0' and length(referancePriceId)<>36 then
            select count(0) into checkReferansId from pricing_tariff_log where price_id=referancePriceId and price_type='TRF_TARIFF' AND STATUS=1;
            if checkReferansId>0 then
                select trim(p2)
                into refTariffdate
                from
                (select replace(cast(substr(psql,instr(psql,',',1,1)+1,instr(psql,',',1,2)-instr(psql,',',1,1)-1)as varchar2(100)),'''','') p2
                from pricing_tariff_log where price_id=referancePriceId and price_type='TRF_TARIFF' AND STATUS=1) t;

                     p_tariffDate:=refTariffDate;
                     checkRef := '0';
            else
                select count(0) into checkReferansId from pricing_tariff_log where price_id=referancePriceId and price_type='TRF_SBM' AND STATUS=1;
                if checkReferansId > 0 then
                    p_issbmpolendors := '1';
                end if;
               end if;
        end if;
                if p_debugmode='1' then addlog ('','3', ''); end if;
--                 addlog (p_cache,'2');
            p_sigortalilikSuresi := cast(to_number('0'||sigortaliliksuresi) as varchar2);
            select seq_pricing_id.nextval into s_PricingId from dual;
            p_systemdate := to_char(SYSDATE,'DD/MM/YYYY');
            p_systemtime := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF');

--         addlog ('','3');

            --select d10 into p_kullanimSekliSbm from t001c002u101008 a where a.k1 = kullanimSekli and a.gecer_tarih in (select max(b.gecer_tarih) from t001c002u101008 b where b.k1 = a.k1);
                    if kullanimSekli is not null then p_kullanimSekliSbm := substr('0'||trim(kullanimSekli),-2); end if;
--            p_kullanimSekliSbm := kullanimSekli;
--         addlog ('','5');
        if p_debugmode='1' then addlog ('','4', ''); end if;
        -- SBM 'den veriler çekiliyor.


        if length(p_referancePriceId)=36 or p_issbmpolendors = '1' then
            if length(p_referancePriceId)<36 then
                select ssbm into clob_sbmValues from pricing_tariff_log where price_id=referancePriceId and price_type='TRF_SBM' AND STATUS=1;
                    if removeElement(getSbmDetails(getSbmDetails(clob_sbmValues, 'trafikTeklifDataSorguResponse'), 'isSuccessfull'), 'isSuccessfull') = 'true' then
                        clob_trafikteklifislemid := getSbmDetails(clob_sbmValues, 'trafikTeklifDataSorguOutput');
                        clob_sasiSorgu := getSbmDetails(clob_sbmValues, 'ovmtrafikPoliceSorguSasiKimlikSorgu');
                        clob_trafikPoliceSorguKimlik := getSbmDetails(clob_sbmValues, 'trafikPoliceSorguKimlikSorgu');
                        if length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenTarifeBasamakKodu'),'uygulanmasiGerekenTarifeBasamakKodu')) < 3 and length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenTarifeBasamakKodu'),'uygulanmasiGerekenTarifeBasamakKodu')) > 0 then
                            p_trfisliduyggerbasamakkodu := removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenTarifeBasamakKodu'),'uygulanmasiGerekenTarifeBasamakKodu');
                        end if;
                        if length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmisTarifeBasamakKodu'),'uygulanmisTarifeBasamakKodu')) < 3 and length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmisTarifeBasamakKodu'),'uygulanmisTarifeBasamakKodu')) > 0 then
                            p_trfisliduygbasamakkodu := removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmisTarifeBasamakKodu'),'uygulanmisTarifeBasamakKodu');
                        end if;
                        if length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenGecikmeSurprimYuzde'),'uygulanmasiGerekenGecikmeSurprimYuzde')) < 3 and length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenGecikmeSurprimYuzde'),'uygulanmasiGerekenGecikmeSurprimYuzde')) > 0 then
                            p_trfislidgecikmesurprim := removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'referansPoliceBilgileri'),'uygulanmasiGerekenGecikmeSurprimYuzde'),'uygulanmasiGerekenGecikmeSurprimYuzde');
                        end if;
--                       select count(0) into p_cache from pricing_tariff_log where cache_key='TRF'||','||kimlikNo||','||sasiNo||','||p_trfislidgecikmesurprim||','||p_trfisliduygbasamakkodu||','||p_trfisliduyggerbasamakkodu||','||markaTipKodu||','||model||','||kullanimSekli||','||plakailkodu||','||plakaNo and /*m1<>'999999'*/ status='1' and (to_char(to_date(system_date,'DD/MM/YYYY'),'MM/YYYY')=to_char(sysdate,'MM/YYYY') or (to_char(sysdate,'DD')<4 and (to_date('01/'||to_char(sysdate,'MM/YYYY'))-1)=to_date(system_date,'DD/MM/YYYY') ));
--                       p_referancePriceId := referancePriceId;
--                    else
--                        p_referancePriceId := null;
                    end if;

            end if;
           if kullanimSekli is NULL or kullanimSekli = '0' or kullanimSekli ='' THEN
                p_kullanimtarzi := cast(cast(removeElement(getSbmDetails(clob_sasiSorgu, 'aracTarifeGrupKod'), 'aracTarifeGrupKod') as number) as varchar2);
            ELSE p_kullanimtarzi := kullanimSekli; END IF;

            if kullanimSekli is null or kullanimSekli='0' then
                select decode(p_kullanimtarzi,'1','Otomobil','2','Taksi','3','Minibüs','4','Midibüs','5','Otobüs','6','Kamyonet','7','Kamyon','8','İş Makinesi','9','Traktör','10','Römork','11','Motosiklet','12','Tanker',13,'Çekici',14,'Özel Amaçlı Taşıt',15,'Tarım Makinesi',16,'Dolmuş',17,'Minibüs-Dolmuş',18,'Midibüs-Dolmuş',19,'Otobüs-Dolmuş',20,'Diğer Araçlar','Diğer') into p_kullanimsekli from dual;
                        if p_kullanimsekli is not null then p_kullanimSekliSbm := substr('0'||trim(p_kullanimsekli),-2); end if;
            end if;

                if p_debugmode='1' then addlog ('','5', ''); end if;
            p_hasarSayisi := getHasarSayisi(clob_sasiSorgu);
            if p_tariffDate is null then
                p_tariffDate := sysdate;
            end if;
                    if p_debugmode='1' then addlog ('','6', ''); end if;
            if markaTipKodu is null or markaTipKodu='0' then
                if length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'marka'), 'kod'),'kod')||removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'tip'), 'kod'),'kod'))>7 then
                    p_markatipkodu := '999999';
                else
                    p_markatipkodu:=removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'marka'), 'kod'),'kod')||removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'tip'), 'kod'),'kod');
                end if;
            else
                p_markatipkodu := markaTipKodu;
            end if;
        if p_debugmode='1' then addlog ('','7', ''); end if;
            if (p_trfisliduyggerbasamakkodu is not null or trim(p_trfisliduyggerbasamakkodu) <> '') and p_trfisliduyggerbasamakkodu <> '0' then
                p_trafikKademesi := p_trfisliduyggerbasamakkodu;
            else
                p_trafikKademesi := '4';
            end if;
        if p_debugmode='1' then addlog ('','8', ''); end if;
            if (p_trfisliduygbasamakkodu is not null or trim(p_trfisliduygbasamakkodu) <> '') and trim(p_trfisliduygbasamakkodu) <> '0' then
                p_oncekiTrafikKademesi := p_trfisliduygbasamakkodu;
            else
                p_oncekiTrafikKademesi := '4';
            end if;
        if p_debugmode='1' then addlog ('','9', ''); end if;
            if p_trfislidgecikmesurprim is not null or trim(p_trfislidgecikmesurprim) <> '' then
                p_gecikmeSurprimi := p_trfislidgecikmesurprim;
            else
                if clob_marka is null and p_aracyasi in('0','1') then
                    p_gecikmeSurprimi := getTRFGecikmeSurprimi(sysdate, TO_DATE(tescilTarihi,'DD/MM/YYYY'),'TIPY');
                else
                    p_gecikmeSurprimi := getTRFGecikmeSurprimi(sysdate, TO_DATE(tescilTarihi,'DD/MM/YYYY'),'TIPX');
                end if;
            end if;
        if p_debugmode='1' then addlog ('','10', ''); end if;
            if length(removeElement(getSbmDetails(getSbmDetails(clob_trafikteklifislemid, 'sigortaliBilgileri'), 'kimlikNo'), 'kimlikNo')) <> 11 then p_tcknSorguKontrol := '0'; else p_tcknSorguKontrol := '1'; end if;
        if p_debugmode='1' then addlog ('','11', ''); end if;

            IF LENGTH(kimlikNo)=11 THEN
                if p_tcknSorguKontrol = '1' then
                   /* if checkRef = '0' then
                        p_sigortaliyas := refp_sigortaliyas;
                        p_cinsiyeti := removeElement(getSbmDetails(clob_tcknSorgu, 'cinsiyeti'), 'cinsiyeti');
                        p_medenihali := refp_medenihali; -- Evli - Bekar
                    else*/
                        p_sigortaliyas := cast(to_char(p_tariffDate,'YYYY') as number) - cast(substr(removeElement(getSbmDetails(clob_trafikteklifislemid, 'dogumTarihi'), 'dogumTarihi'),1,4) as number);
                        p_cinsiyeti := removeElement(getSbmDetails(clob_trafikteklifislemid, 'cinsiyet'), 'cinsiyet');
                        p_medenihali := removeElement(getSbmDetails(clob_trafikteklifislemid, 'medeniHali'), 'medeniHali'); -- Evli - Bekar
                    --end if;
                else
                    p_sigortaliyas := NULL;
                    p_cinsiyeti := NULL;
                    p_medenihali := NULL;
                end if;
                --p_cocukdegiskeni := getCocukDegiskeni(clob_aileSorgu, to_date(p_tariffDate,'DD/MM/YYYY'));
                --p_cocukSayisi := getCocukSayisi(clob_aileSorgu, to_date(p_tariffDate,'DD/MM/YYYY'));

                if p_cinsiyeti not in('E','K') THEN p_cinsiyeti := 'D'; END IF;
                if length(removeElement(getSbmDetails(clob_trafikteklifislemid, 'ikametIlceKodu'), 'ikametIlceKodu')) < 8 THEN
                    p_tramerilce := removeElement(getSbmDetails(clob_trafikteklifislemid, 'ikametIlceKodu'), 'ikametIlceKodu');
                    p_tramerIl := removeElement(getSbmDetails(clob_trafikteklifislemid, 'ikametIlKodu'), 'ikametIlKodu');
                    p_ilad := p_ilad;
                    p_ilcead := p_tramerilce;
                            p_ilceAd := UPPER(removeElement(getSbmDetails(clob_adresSorgu, 'ilceAd'), 'ilceAd'));
                            p_ilAd := UPPER(removeElement(getSbmDetails(clob_adresSorgu, 'ilAd'), 'ilAd'));

                            p_ilceAd := trim(replace(replace(replace(replace(replace(replace(p_ilceAd,'Ğ','G'),'Ü','U'),'Ş','S'),'İ','I'),'Ö','O'),'Ç','C'));
                            p_ilAd := trim(replace(replace(replace(replace(replace(replace(p_ilAd,'Ğ','G'),'Ü','U'),'Ş','S'),'İ','I'),'Ö','O'),'Ç','C'));

                            -- Bazy durumlarda SBM'den AFYONKARAHYSAR ?eklinde veri gelmesi sebebiyle eklendi. 26/08/2019
                            if p_ilAd like 'AFYONKARA%' then p_ilAd := 'AFYON KARAHISAR'; end if;
                            if p_ilAd like 'KAHRA%' then p_ilAd := 'K.MARAS'; end if;
                end if;
                if p_tramerIl is not null THEN p_plakaIlKodu := p_tramerIl; else p_plakaIlKodu := plakailkodu; end if;
    --            select count(0) into p_sigortaliskor from pricing_insuredscore_log ab where /*s_PricingId=ab.s_pricingid and*/ kimlikNo=ab.kimlikno and
    --                                                                                    p_tariffDate=ab.p_tariffdate and p_aracTarifeGrupKodu=ab.p_aractarifegrupkodu and p_hasarsizlikKademesi=ab.p_hasarsizlikkademesi
    --                                                                                    and ab.systemdate=to_char(sysdate,'DD/MM/YYYY');
    --            if p_sigortaliskor>0 then
    --                select max(ab.s_sigortaliskor) into p_sigortaliskor from pricing_insuredscore_log ab where /*s_PricingId=ab.s_pricingid and*/ kimlikNo=ab.kimlikno and
    --                                                                                        p_tariffDate=ab.p_tariffdate and p_aracTarifeGrupKodu=ab.p_aractarifegrupkodu and p_hasarsizlikKademesi=ab.p_hasarsizlikkademesi
    --                                                                                        and ab.systemdate=to_char(sysdate,'DD/MM/YYYY');
    --            else
    --            end if;
                --p_meslek := meslek;

                --p_sigortaliskor := getTrafikSigortaliSkor (s_PricingId, clob_trafikPoliceSorguKimlik, kimlikNo, p_tariffDate, p_kullanimtarzi, to_number(p_trafikKademesi));
                p_sigortaliskor := 1;
                p_ozelTuzel := '1';
            ELSE
                if plakailKodu is not null then p_plakaIlKodu := plakailkodu; end if;
                p_sigortaliyas := 'Tüzel';
                p_cinsiyeti := 'Tüzel';
                p_medenihali := 'Tüzel';
                p_tramerIlce := '';
                p_tramerIl := '';
                p_ozelTuzel := '2';
                p_sigortaliskor := 1;

                /*  */
                p_cocukSayisi := 'Tüzel';
                /*  */

            END IF;
        if p_debugmode='1' then addlog ('','12', ''); end if;
        else
                if p_debugmode='1' then addlog ('','13', ''); end if;
            if checkRef = '0' then
                select ssbm into clob_sbmValues from pricing_tariff_log where price_id=referancePriceId and price_type='TRF_TARIFF' AND STATUS=1;
            else
                if tescilSeriNo is null then
                    select GETTARIFFTOSBM(kimlikNo, plakailkodu /*p_plakaIlKodu*/, plakaNo, NULL, asbisNo, sasiNo, '123', 'TRF', tescilTarihi, trafigeCikisTarihi, model , p_kullanimSekliSbm, '', '', '', '', '') into clob_sbmValues from dual;
                else
                    select GETTARIFFTOSBM(kimlikNo, plakailkodu /*p_plakaIlKodu*/, plakaNo, tescilSeriKod, tescilSeriNo, sasiNo, '123', 'TRF', tescilTarihi, trafigeCikisTarihi, model , p_kullanimSekliSbm, '', '', '', '', '') into clob_sbmValues from dual;
                end if;
            end if;
                    if p_debugmode='1' then addlog ('','14', ''); end if;
            clob_aileSorgu := getSbmDetails(clob_sbmValues, 'aileSorgu');
            clob_sasiSorgu := getSbmDetails(clob_sbmValues, 'ovmtrafikPoliceSorguSasiKimlikSorgu');
            clob_hasarBelgeSorgu := getSbmDetails(clob_sbmValues, 'ovmtrafikPoliceHasarBelgeBilgileri');
            clob_marka := getSbmDetails(clob_sasiSorgu, 'marka');
            clob_tip := getSbmDetails(clob_sasiSorgu, 'tip');
            clob_tcknAracSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceByTckSorgu');
            clob_tcknPlakaSorgu := getSbmDetails(clob_sbmValues, 'ovmKaskoPoliceByKimlikPlakaSorgu');
            clob_egmSorgu := getSbmDetails(clob_sbmValues, 'tescilBilgiSorgu');
            clob_trafikPoliceSorguKimlik := getSbmDetails(clob_sbmValues, 'trafikPoliceSorguKimlikSorgu');
            if kullanimSekli is NULL or kullanimSekli = '0' or kullanimSekli ='' THEN
                p_kullanimtarzi := cast(cast(removeElement(getSbmDetails(clob_sasiSorgu, 'aracTarifeGrupKod'), 'aracTarifeGrupKod') as number) as varchar2);
            ELSE p_kullanimtarzi := kullanimSekli; END IF;

            if kullanimSekli is null or kullanimSekli='0' then
                select decode(p_kullanimtarzi,'1','Otomobil','2','Taksi','3','Minibüs','4','Midibüs','5','Otobüs','6','Kamyonet','7','Kamyon','8','İş Makinesi','9','Traktör','10','Römork','11','Motosiklet','12','Tanker',13,'Çekici',14,'Özel Amaçlı Taşıt',15,'Tarım Makinesi',16,'Dolmuş',17,'Minibüs-Dolmuş',18,'Midibüs-Dolmuş',19,'Otobüs-Dolmuş',20,'Diğer Araçlar','Diğer') into p_kullanimsekli from dual;
                                        if p_kullanimsekli is not null then p_kullanimSekliSbm := substr('0'||trim(p_kullanimsekli),-2); end if;
            end if;

            p_hasarSayisi := getHasarSayisi(clob_sasiSorgu);
                    if p_debugmode='1' then addlog ('','15', ''); end if;
            if p_tariffDate is null then
                p_tariffDate := to_date(removeElement(getSbmDetails(clob_sbmValues, 'trafikTeklifBaslangicTarihi'),'trafikTeklifBaslangicTarihi'),'DD/MM/YYYY');
            end if;
        if p_debugmode='1' then addlog ('','16', ''); end if;
            if markaTipKodu is null or markaTipKodu='0' then
                p_markatipkodu:=p_markakodu||removeElement(getSbmDetails(clob_tip, 'kod'),'kod');
            else
                p_markatipkodu := markaTipKodu;
            end if;
        if p_debugmode='1' then addlog ('','17', ''); end if;
            if length(p_markatipkodu)<7 then p_markatipkodu := substr('00'||p_markatipkodu,-6); end if;
            p_markakodu := substr(p_markatipkodu,1,3);
            if (trafikKademesi is not null or trim(trafikKademesi) <> '') and trafikKademesi <> '0' then
                p_trafikKademesi := trafikKademesi;
            else
                if removeElement(getSbmDetails(clob_hasarBelgeSorgu, 'isSuccessfull'),'isSuccessfull') = 'true' then
                    p_trafikKademesi := removeElement(getSbmDetails(getSbmDetails(clob_hasarBelgeSorgu, 'kazaHasarBelgeBilgileri'),'uygulanmasiGerekenTarifeBasamakKodu'),'uygulanmasiGerekenTarifeBasamakKodu');
                else
                    p_trafikKademesi := '4';
                end if;
            end if;
        if p_debugmode='1' then addlog ('','18', ''); end if;
            if (oncekiTrafikKademesi is not null or trim(oncekiTrafikKademesi) <> '') and trim(oncekiTrafikKademesi) <> '0' then
                p_oncekiTrafikKademesi := oncekiTrafikKademesi;
            else
                if removeElement(getSbmDetails(clob_hasarBelgeSorgu, 'isSuccessfull'),'isSuccessfull') = 'true' then
                    p_oncekiTrafikKademesi := removeElement(getSbmDetails(getSbmDetails(clob_hasarBelgeSorgu, 'kazaHasarBelgeBilgileri'),'uygulanmisTarifeBasamakKodu'),'uygulanmisTarifeBasamakKodu');
                else
                    p_oncekiTrafikKademesi := '4';
                end if;
            end if;
        if p_debugmode='1' then addlog ('','19', ''); end if;
            if gecikmeSurprimi is not null or trim(gecikmeSurprimi) <> '' then
                p_gecikmeSurprimi := gecikmeSurprimi;
            else
                if removeElement(getSbmDetails(clob_hasarBelgeSorgu, 'isSuccessfull'),'isSuccessfull') = 'true' then
                    p_gecikmeSurprimi := removeElement(getSbmDetails(getSbmDetails(clob_hasarBelgeSorgu, 'kazaHasarBelgeBilgileri'),'uygulanmasiGerekenGecikmeSurprimYuzde'),'uygulanmasiGerekenGecikmeSurprimYuzde');
                else
                    p_gecikmeSurprimi := getTRFGecikmeSurprimi(sysdate, TO_DATE(tescilTarihi,'DD/MM/YYYY'),'TIPX');
                                if length(clob_marka) < 30 and (model=to_char(sysdate,'YYYY') or model=to_char(sysdate-365,'YYYY')) then--if clob_marka is null and p_aracyasi in('0','1') then
                                    p_gecikmeSurprimi := getTRFGecikmeSurprimi(sysdate, TO_DATE(tescilTarihi,'DD/MM/YYYY'),'TIPY');
                                end if;
                end if;
            end if;
        if p_debugmode='1' then addlog ('','20', ''); end if;
            if length(kimlikNo) = 11 and substr(kimlikNo,1,1)='9' THEN
                clob_tcknSorgu := getSbmDetails(clob_sbmValues, 'yabanciKimlikSorgu');
                clob_adresSorgu := getSbmDetails(clob_sbmValues, 'yabanciAdresSorgu');
            else
                clob_tcknSorgu := getSbmDetails(clob_sbmValues, 'tcknSorgu');
                clob_adresSorgu := getSbmDetails(clob_sbmValues, 'adresSorgu');
            end if;
        if p_debugmode='1' then addlog ('','21', ''); end if;
            if removeElement(getSbmDetails(clob_tcknSorgu, 'isSuccessfull'), 'isSuccessfull') = 'true' then p_tcknSorguKontrol := '1'; else p_tcknSorguKontrol := '0'; end if;
        if p_debugmode='1' then addlog ('','22', ''); end if;

            IF LENGTH(kimlikNo)=11 THEN
                if p_tcknSorguKontrol = '1' then
                   /* if checkRef = '0' then
                        p_sigortaliyas := refp_sigortaliyas;
                        p_cinsiyeti := removeElement(getSbmDetails(clob_tcknSorgu, 'cinsiyeti'), 'cinsiyeti');
                        p_medenihali := refp_medenihali; -- Evli - Bekar
                    else*/
                        p_sigortaliyas := cast(to_char(p_tariffDate,'YYYY') as number) - cast(substr(removeElement(getSbmDetails(clob_tcknSorgu, 'dogumTarihi'), 'dogumTarihi'),1,4) as number);
                        p_cinsiyeti := removeElement(getSbmDetails(clob_tcknSorgu, 'cinsiyeti'), 'cinsiyeti');
                        p_medenihali := removeElement(getSbmDetails(clob_tcknSorgu, 'medeniHali'), 'medeniHali'); -- Evli - Bekar
                                p_ilceAd := UPPER(removeElement(getSbmDetails(clob_adresSorgu, 'ilceAd'), 'ilceAd'));
                                p_ilAd := UPPER(removeElement(getSbmDetails(clob_adresSorgu, 'ilAd'), 'ilAd'));
                            if p_ilAd like 'AFYONKARA%' then p_ilAd := 'AFYON KARAHISAR'; end if;
                            if p_ilAd like 'KAHRA%' then p_ilAd := 'K.MARAS'; end if;
                                p_ilceAd := trim(replace(replace(replace(replace(replace(replace(p_ilceAd,'Ğ','G'),'Ü','U'),'Ş','S'),'İ','I'),'Ö','O'),'Ç','C'));
                                p_ilAd := trim(replace(replace(replace(replace(replace(replace(p_ilAd,'Ğ','G'),'Ü','U'),'Ş','S'),'İ','I'),'Ö','O'),'Ç','C'));
                    --end if;
                else
                    p_sigortaliyas := NULL;
                    p_cinsiyeti := NULL;
                    p_medenihali := NULL;
                end if;
                p_cocukdegiskeni := getCocukDegiskeni(clob_aileSorgu, to_date(p_tariffDate,'DD/MM/YYYY'));
                p_cocukSayisi := getCocukSayisi(clob_aileSorgu, to_date(p_tariffDate,'DD/MM/YYYY'));

                if p_cinsiyeti not in('E','K') THEN p_cinsiyeti := 'D'; END IF;
                if length(removeElement(getSbmDetails(clob_adresSorgu, 'ilceKod'), 'ilceKod')) < 8 THEN
                    p_tramerilce := removeElement(getSbmDetails(clob_adresSorgu, 'ilceKod'), 'ilceKod');
                    p_tramerIl := removeElement(getSbmDetails(clob_adresSorgu, 'ilKod'), 'ilKod');
                end if;
                if p_tramerIl is not null THEN p_plakaIlKodu := p_tramerIl; else p_plakaIlKodu := plakailkodu; end if;
    --            select count(0) into p_sigortaliskor from pricing_insuredscore_log ab where /*s_PricingId=ab.s_pricingid and*/ kimlikNo=ab.kimlikno and
    --                                                                                    p_tariffDate=ab.p_tariffdate and p_aracTarifeGrupKodu=ab.p_aractarifegrupkodu and p_hasarsizlikKademesi=ab.p_hasarsizlikkademesi
    --                                                                                    and ab.systemdate=to_char(sysdate,'DD/MM/YYYY');
    --            if p_sigortaliskor>0 then
    --                select max(ab.s_sigortaliskor) into p_sigortaliskor from pricing_insuredscore_log ab where /*s_PricingId=ab.s_pricingid and*/ kimlikNo=ab.kimlikno and
    --                                                                                        p_tariffDate=ab.p_tariffdate and p_aracTarifeGrupKodu=ab.p_aractarifegrupkodu and p_hasarsizlikKademesi=ab.p_hasarsizlikkademesi
    --                                                                                        and ab.systemdate=to_char(sysdate,'DD/MM/YYYY');
    --            else
    --            end if;
                --p_meslek := meslek;

                --p_sigortaliskor := getTrafikSigortaliSkor (s_PricingId, clob_trafikPoliceSorguKimlik, kimlikNo, p_tariffDate, p_kullanimtarzi, to_number(p_trafikKademesi));
                p_sigortaliskor := 1;
                p_ozelTuzel := '1';
            ELSE
                if plakailKodu is not null then p_plakaIlKodu := plakailkodu; end if;
                p_sigortaliyas := 'Tüzel';
                p_cinsiyeti := 'Tüzel';
                p_medenihali := 'Tüzel';
                p_tramerIlce := '';
                p_tramerIl := '';
                p_ozelTuzel := '2';
                p_sigortaliskor := 1;

                /*  */
                p_cocukSayisi := 'Tüzel';
                /*  */

            END IF;
                    if p_debugmode='1' then addlog ('','23', ''); end if;
        end if;
/*
            if tescilSeriNo is null then
                select GETTARIFFTOSBM(kimlikNo, plakailkodu , plakaNo, NULL, asbisNo, sasiNo, '123', 'TRF', tescilTarihi, trafigeCikisTarihi, model , p_kullanimSekliSbm, '', '', '', '') into clob_sbmValues from dual;
            else
                select GETTARIFFTOSBM(kimlikNo, plakailkodu , plakaNo, tescilSeriKod, tescilSeriNo, sasiNo, '123', 'TRF', tescilTarihi, trafigeCikisTarihi, model , p_kullanimSekliSbm, '', '', '', '') into clob_sbmValues from dual;
            end if;
            */
/* 16/09/2020 */
/*
                    if p_debugmode='1' then addlog ('','24', 'AB-'||p_gecikmeSurprimi); end if;
if p_gecikmeSurprimi is null then
                if length(clob_marka) < 30 and (model=to_char(sysdate,'YYYY') or model=to_char(sysdate-365,'YYYY')) then
                    p_gecikmeSurprimi := getTRFGecikmeSurprimi(sysdate, TO_DATE(tescilTarihi,'DD/MM/YYYY'),'TIPY');
                    if p_debugmode='1' then addlog ('','24', 'A-'||p_gecikmeSurprimi); end if;
                else
                    p_gecikmeSurprimi := getTRFGecikmeSurprimi(sysdate, TO_DATE(tescilTarihi,'DD/MM/YYYY'),'TIPX');
                    if p_debugmode='1' then addlog ('','24', 'B-'||p_gecikmeSurprimi); end if;
                end if;

end if;
*/
/*
            if TariffDate is not null then
                p_tariffDate := TariffDate;
            else
                p_tariffDate := to_date(removeElement(getSbmDetails(clob_sbmValues, 'trafikTeklifBaslangicTarihi'),'trafikTeklifBaslangicTarihi'),'DD/MM/YYYY');
            end if;
*/
begin
                p_tariffDate := to_date(removeElement(getSbmDetails(clob_sbmValues, 'trafikTeklifBaslangicTarihi'),'trafikTeklifBaslangicTarihi'),'DD/MM/YYYY');
exception
    when OTHERS Then
    goto goo;
end;
<<goo>>
--         addlog ('','5');

            --p_markakodu:=removeElement(getSbmDetails(clob_marka, 'kod'),'kod');
            if length(p_markatipkodu)<7 then p_markatipkodu := substr('00'||p_markatipkodu,-6); end if;
            p_markakodu := substr(p_markatipkodu,1,3);


        if p_debugmode='1' then addlog ('','24', ''); end if;

                birYilOncekiHasar := getTRFDonemselHasarSayisi(kimlikNo,p_plakaIlKodu,plakaNo,clob_sasiSorgu,455, 0);
        if p_debugmode='1' then addlog ('','241', ''); end if;
                ikiYilOncekiHasar := getTRFDonemselHasarSayisi(kimlikNo,p_plakaIlKodu,plakaNo,clob_sasiSorgu,910,455);
        if p_debugmode='1' then addlog ('','242', ''); end if;
                ucYilOncekiHasar := getTRFDonemselHasarSayisi(kimlikNo,p_plakaIlKodu,plakaNo,clob_sasiSorgu,1365,910);
        if p_debugmode='1' then addlog ('','243', ''); end if;
            birYilOncekiHasar := nvl(birYilOncekiHasar,0);
            ikiYilOncekiHasar :=nvl(ikiYilOncekiHasar,0);
            ucYilOncekiHasar :=nvl(ucYilOncekiHasar,0);

            sonUcYilHasarSayisi := birYilOncekiHasar+ikiYilOncekiHasar+ucYilOncekiHasar;


--        else


            --end if;
            p_yenilemeyeniiskod := getTrfYenilemeYeniIsKod(p_tariffDate, clob_sasiSorgu,sasiNo, plakaNo, kimlikno);

        if p_yenilemeyeniiskod in ('051','51') THEN
            NBRENEWAL2 := 'YENILEME';
        elsif p_yenilemeyeniiskod='99' THEN
            if p_aracyasi = 0 then
                NBRENEWAL2 := 'SIFIRKMARAC';
            else
                NBRENEWAL2 := 'YENIIS';
            end if;
        else
            NBRENEWAL2 := 'TRANSFER';
        end if;
        if p_debugmode='1' then addlog ('','25', ''); end if;

            if model is NULL or model = '0' then p_model := cast(substr(removeElement(getSbmDetails(clob_sasiSorgu, 'modelYili'), 'modelYili'),1,4) as number);
                                        p_aracyasi := cast(to_char(p_tariffDate,'YYYY') as number) - p_model;
                                   else p_model := cast(model as number);
                                        p_aracyasi := cast(to_char(p_tariffDate,'YYYY') as number) - p_model; end if;

            IF p_yenilemeyeniiskod = '051' OR p_yenilemeyeniiskod = '51' THEN p_yenilemeyeniiskod := '51'; ELSE p_yenilemeyeniiskod := '99'; END IF;
            if p_kullanimtarzi in('16','2','02') then p_kullanimtarzi100501 := '1'; elsif p_kullanimtarzi='17' then p_kullanimtarzi100501 := '3'; elsif p_kullanimtarzi = '18' then p_kullanimtarzi100501:='4'; elsif p_kullanimtarzi='19' then p_kullanimtarzi100501:='5'; elsif p_kullanimtarzi='12' then p_kullanimtarzi100501:='7'; else p_kullanimtarzi100501:=p_kullanimtarzi; end if;

        if p_debugmode='1' then addlog ('','26', ''); end if;
            /*  */
--            if p_aracyasi > 10 then
                select count(0) into p_checkkk from pricing_tables a WHERE  a.table_code = 'TRF-Araç Yaş Çarpanı'
                                                                                            and a.key1=p_aracyasi
                                                                                            and a.valid_date = (select max(valid_date) from pricing_tables b WHERE  b.table_code = 'TRF-Araç Yaş Çarpanı'
                                                                                                                                                                        and b.valid_date<=to_date(p_tariffDate,'DD/MM/YYYY')
                                                                                                                                                                        and a.key1=b.key1);
            if p_checkkk > 0 then
                select max(to_number(mult1)) into p_aracyasi from pricing_tables a WHERE  a.table_code = 'TRF-Araç Yaş Çarpanı'
                                                                                            and a.key1=p_aracyasi
                                                                                            and a.valid_date = (select max(valid_date) from pricing_tables b WHERE  b.table_code = 'TRF-Araç Yaş Çarpanı'
                                                                                                                                                                        and b.valid_date<=to_date(p_tariffDate,'DD/MM/YYYY')
                                                                                                                                                                        and a.key1=b.key1);
            end if;
        if p_debugmode='1' then addlog ('','27', ''); end if;
            if p_hasarSayisi > 10 then
                select max(to_number(key3)) into p_hasarSayisi from pricing_tables a WHERE  a.table_code = 'TRF-Hasar Sayısı' and a.key1 = p_kullanimtarzi and a.key2 = p_ozelTuzel
                                                                                                and a.valid_date = (select max(valid_date) from pricing_tables b WHERE  b.table_code = 'TRF-Hasar Sayısı'
                                                                                                                                                                            and b.key1 = p_kullanimtarzi and b.key2 = p_ozelTuzel
                                                                                                                                                                            and b.valid_date<=to_date(p_tariffDate,'DD/MM/YYYY'));
            end if;
        if p_debugmode='1' then addlog ('','28', ''); end if;

            select max(to_number(key2)) into p_cocukSayisiMax from pricing_tables a
                                    WHERE  a.table_code = 'TRF-Çocuk Sayısı' and trim(a.key2) not in ('DİĞER','Tüzel')
                                            and a.valid_date = (select max(valid_date) from pricing_tables b WHERE  b.table_code = 'TRF-Çocuk Sayısı'
                                                                                                                        and b.key1 = p_kullanimtarzi
                                                                                                                        and b.valid_date<=to_date(p_tariffDate,'DD/MM/YYYY'));
        if p_debugmode='1' then addlog ('','29', ''); end if;
            if (p_cocukSayisi is not null and p_cocukSayisi <> '' ) and to_number(p_cocukSayisi) > p_cocukSayisiMax then
                p_cocukSayisi := p_cocukSayisiMax;
            end if;
            /*  */
        if p_debugmode='1' then addlog ('','30', ''); end if;
            IF substr(trim(p_markatipkodu),1,3) = '999' or substr(trim(p_markatipkodu),4,length(p_markatipkodu)-3) = '999' THEN
                p_yakittipi:='DİĞER'; p_markariskgrubu:=''; p_ticariFaktor:=1; p_agirlik:='DİĞER'; p_beygirGucu:='DİĞER'; p_aracSegment:='DİĞER'; p_kasaTipi:='DİĞER';
            ELSE
                z_sql := 'select count(0) from t001c002u100501 a where a.k1='''||p_markatipkodu
                                                                      ||''' and a.k2='''||model||'''
                                                                      and a.k3='''||p_kullanimtarzi100501||'''
                                                                      and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100501 b where b.k1=a.k1
                                                                                                      and b.k2=a.k2
                                                                                                      and b.k3=a.k3
                                                                                                      and b.gecer_tarih<=to_date('''||p_tariffDate||''',''DD/MM/YYYY'')) and rownum=1';
                execute immediate z_sql into p_yakittipi;
                        if p_debugmode='1' then addlog ('','31', ''); end if;
                IF p_yakittipi='0' THEN p_yakittipi := 'Diğer'; ELSE
                    z_sql := 'select trim(a.D11), trim(a.d3), trim(a.d21), trim(a.d17), trim(a.d14), trim(a.d12), trim(a.d15) from t001c002u100501 a where a.k1='''||p_markatipkodu
                                                                                            ||''' and a.k2='''||model||'''
                                                                                            and a.k3='''||p_kullanimtarzi100501||'''
                                                                                            and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100501 b where b.k1=a.k1
                                                                                                                            and b.k2=a.k2
                                                                                                                            and b.k3=a.k3
                                                                                                                            and b.gecer_tarih<=to_date('''||p_tariffDate||''',''DD/MM/YYYY'')) and rownum=1';
                    execute immediate z_sql into p_yakittipi, p_markariskgrubu, p_ticariFaktor, p_agirlik, p_beygirGucu, p_aracSegment, p_kasaTipi;
                END IF;
                        if p_debugmode='1' then addlog ('','32', ''); end if;
            END IF;


                            if p_ilAd like 'AFYONKARA%' then p_ilAd := 'AFYON KARAHISAR'; end if;
                            if p_ilAd like 'KAHRA%' then p_ilAd := 'K.MARAS'; end if;

        /* ililcegrup bilgileri */
        SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'TRF-IL ILCE GRUP'
                       and b.key1=p_ilAd||'-'||p_ilceAd AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'TRF-IL ILCE GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
       if p_debugmode='1' then addlog ('','9', p_ilAd||'-'||p_ilceAd); end if;
        if cnt99 > 0 then
            SELECT   max(b.desc1) into p_ililcegrup
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'TRF-IL ILCE GRUP'
                       and b.key1=p_ilAd||'-'||p_ilceAd AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'TRF-IL ILCE GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
        else
            if p_ozelTuzel = '2' then
                SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'KSK-IL ILCE GRUP TZL'
                       and b.key1=trim(p_plakaIlKodu) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-IL ILCE GRUP TZL'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
                if cnt99 > 0 then
                    SELECT   max(trim(b.desc1))||'-DIGER' into p_ililcegrup
                                FROM   pricing_parameters b
                               WHERE   b.param_name = 'KSK-IL ILCE GRUP TZL'
                               and b.key1=trim(p_plakaIlKodu) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-IL ILCE GRUP TZL'
                                                        AND a.valid_date IS NOT NULL
                                                        AND a.valid_date <= TariffDate);
                end if;
            else
                p_ililcegrup := p_ilAd||'-DIGER';
            end if;
        end if;

            p_trafikKayitliAracSayisi := fncTrafikKayitliAracSayisi(kimlikNo);
        if p_debugmode='1' then addlog ('','33', ''); end if;
            if p_yakittipi='Diğer' then p_yakittipi:='DİĞER'; end if;
            if p_agirlik='Diğer' then p_agirlik:='DİĞER'; end if;
            if p_beygirGucu='Diğer' then p_beygirGucu:='DİĞER'; end if;
            if p_aracSegment='Diğer' then p_aracSegment:='DİĞER'; end if;
            if p_kasaTipi='Diğer' then p_kasaTipi:='DİĞER'; end if;
            if p_cocukdegiskeni='Diğer' then p_cocukdegiskeni:='DİĞER'; end if;
            if p_ticariFaktor is null or p_ozelTuzel = '1' then p_ticariFaktor:='1'; end if;
    /*TODO : HP değişkeni eklenmeli. = beygirgucu*/
            IF p_agirlik IS NOT NULL AND p_agirlik != '0' and p_agirlik != 'DİĞER' and p_agirlik != 'Diğer' and P_BEYGIRGUCU IS NOT NULL AND P_BEYGIRGUCU != '0' and P_BEYGIRGUCU != 'DİĞER' and P_BEYGIRGUCU != 'Diğer' THEN p_whp := ROUND(TO_NUMBER(p_agirlik)/TO_NUMBER(p_beygirGucu),0); ELSE p_whp:='0'; END IF;
            --p_aracbedeli := aracbedeli;
        if p_debugmode='1' then addlog ('','34', ''); end if;

            /* Sigortalılık Süresi */
            select getTRFSigortalilikSuresi(clob_sasiSorgu) into p_sigortaliliksuresi from dual;


        if p_debugmode='1' then addlog ('','35', ''); end if;
            IF p_sigortaliliksuresi != 0 THEN
                p_trfFrekans := round((p_hasarSayisi / p_sigortaliliksuresi) * 100,0);
            ELSE
                p_trfFrekans := 0;
            END IF;
            p_aracbedeli := 1000;
        if p_debugmode='1' then addlog ('','36', ''); end if;
            p_kismihasarsayisi := p_hasarSayisi;

            /* Yenileme Yılı */
            select getTRFYenilemeYil(clob_sasiSorgu) into p_yenilemeYili from dual;
        if p_debugmode='1' then addlog ('','37', ''); end if;
            /* Hatlı Mı */
            /*
            if hatliMi is null or trim(hatliMi) = '' then
               if p_kullanimtarzi = '1' or p_kullanimtarzi = '2' or p_kullanimtarzi = '3' or p_kullanimtarzi = '4' or p_kullanimtarzi = '5' or p_kullanimtarzi = '6' or p_kullanimtarzi = '99' then
                   select count(*) into p_hatliSayisi from (
                        select * from t001c002u100502
                            where k1 = to_number(productNo) and k2 = to_number(p_kullanimtarzi)
                            and k3 = to_number(p_plakaIlKodu)
                            and (trim(k4) = substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),1,1) || replace(substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),2,length(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') )-1),substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),2,length(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') )-1),'XX')
                                or trim(k4) = substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),1,2) || replace(substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),3,length(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') )-2),substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),3,length(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') )-2),'X')
                                or trim(k4) = REGEXP_REPLACE(plakaNo,'[^a-zA-Z]',''))
                            and k5=0 and k6=0
                            and gecer_tarih = (select max(gecer_tarih) from t001c002u100502)
                        union all
                        select * from t001c002u100502
                            where k1 = to_number(productNo) and k2 = to_number(p_kullanimtarzi)
                            and k3 = to_number(p_plakaIlKodu)
                            and (trim(k4) = substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),1,1) || replace(substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),2,length(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') )-1),substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),2,length(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') )-1),'XX')
                                or trim(k4) = substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),1,2) || replace(substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),3,length(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') )-2),substr(trim(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') ),3,length(REGEXP_REPLACE(plakaNo,'[^a-zA-Z]','') )-2),'X')
                                or trim(k4) = REGEXP_REPLACE(plakaNo,'[^a-zA-Z]',''))
                            and TO_NUMBER(NVL(REGEXP_REPLACE(plakaNo,'[a-zA-Z]',''),'0')) between k5 and k6
                            and gecer_tarih = (select max(gecer_tarih) from t001c002u100502)
                    );
                    if p_hatliSayisi > 0 then p_hatliMi:='E'; else p_hatliMi:='H'; end if;
               else
                    p_hatliMi:='H';
               end if;
            else
               p_hatliMi := hatliMi;
            end if;*/
            /* Hatlı Mı */
        if p_debugmode='1' then addlog ('','38', ''); end if;
            --select count(0) into p_aracSayisiNewKontrol from t001c002u545011 a where cast(trim(a.k1) as number(2))=p_kullanimtarzi and replace(replace(trim(a.k2),CHR(10),''),CHR(13),'')=kimlikNo and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u545011 b where b.k1=a.k1 and b.k2=a.k2 and b.gecer_tarih<=to_date(p_TariffDate,'DD/MM/YYYY'));
            --if p_aracSayisiNewKontrol>0 then
            --    select d1 into p_aracSayisiNewKontrol from t001c002u545011 a where cast(trim(a.k1) as number(2))=p_kullanimtarzi and replace(replace(trim(a.k2),CHR(10),''),CHR(13),'')=kimlikNo and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u545011 b where b.k1=a.k1 and b.k2=a.k2 and b.gecer_tarih<=to_date(p_TariffDate,'DD/MM/YYYY'));
                p_trafikKayitliAracSayisi:=0;
            --else
            --    p_aracSayisiNewKontrol := 1;
            --end if;
/* ProductNo Kontrolü 550 - 554 */
            if p_kullanimtarzi in ('2','3','4','5','7','13','02','03','04','05','07') or p_trafikkademesi in ('1','2','3') then
                p_productno := '554';
                p_plakaIlKodu := plakailkodu;
            else
                p_productno := productNo;
            end if;

if p_tariffDate > '01/08/2020' then
    p_gecikmeSurprimi := p_gecikmeSurprimi;
elsif p_tariffDate > '30/03/2020' then
    if p_gecikmeSurprimi = 5 then
--        if to_char(sysdate,'DD/MM/YYYY')<='30/04/2020' then
            p_gecikmeSurprimi := 0;
--        end if;
    end if;
else
    if p_gecikmeSurprimi > 0 then
        if to_char(sysdate,'DD/MM/YYYY')<='30/04/2020' then
            p_gecikmeSurprimi := 0;
        end if;
    end if;
end if;

        if p_debugmode='1' then addlog ('','39', ''); end if;
            p_cache_key:='TRF'||','||kimlikNo||','||sasiNo||','||p_gecikmeSurprimi||','||p_oncekiTrafikKademesi||','||p_trafikKademesi||','||p_markatipkodu||','||p_model||','||kullanimSekli||','||p_plakaIlKodu||','||plakaNo||','||acente;
--            select count(0) into p_cache from pricing_tariff_log where cache_key=p_cache_key and status='1' and (to_char(to_date(system_date,'DD/MM/YYYY'),'MM/YYYY')=to_char(sysdate,'MM/YYYY') or (to_char(sysdate,'DD')<4 and (to_date('01/'||to_char(sysdate,'MM/YYYY'))-1)=to_date(system_date,'DD/MM/YYYY') ));
            select count(0) into p_cache from pricing_tariff_log where cache_key=p_cache_key and status='1' and system_date=to_char(sysdate,'DD/MM/YYYY');
        if p_debugmode='1' then addlog ('','40', ''); end if;
            if p_cache = 0 then
                if referancePriceId is not null and length(referancePriceId)<20 then
                    select count(0) into refKontrol from tnswin.pricing_Tariff_log where price_id=referancePriceId and length(output)>100;
                    if refKontrol>0 then

                    select
                        --cast(REGEXP_SUBSTR(output, '[^||]+', 1, 1) as varchar2(100)) p1,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 2) as varchar2(100)),'~','') p2,
                        --cast(REGEXP_SUBSTR(output, '[^||]+', 1, 3) as varchar2(100)) p3,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 4) as varchar2(100)),'~','') p4,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 5) as varchar2(100)),'~','') p5,
                        --cast(REGEXP_SUBSTR(output, '[^||]+', 1, 6) as varchar2(100)) p6,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 7) as varchar2(100)),'~','') p7,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 8) as varchar2(100)),'~','') p8,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 9) as varchar2(100)),'~','') p9,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 10) as varchar2(100)),'~','') p10,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 11) as varchar2(100)),'~','') p11,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 12) as varchar2(100)),'~','') p12,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 13) as varchar2(100)),'~','') p13,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 14) as varchar2(100)),'~','') p14,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 15) as varchar2(100)),'~','') p15,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 16) as varchar2(100)),'~','') p16,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 17) as varchar2(100)),'~','') p17,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 18) as varchar2(100)),'~','') p18,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 19) as varchar2(100)),'~','') p19,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 20) as varchar2(100)),'~','') p20,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 21) as varchar2(100)),'~','') p21,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 22) as varchar2(100)),'~','') p22,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 23) as varchar2(100)),'~','') p23,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 24) as varchar2(100)),'~','') p24,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 25) as varchar2(100)),'~','') p25,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 26) as varchar2(100)),'~','') p26,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 27) as varchar2(100)),'~','') p27,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 28) as varchar2(100)),'~','') p28,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 29) as varchar2(100)),'~','') p29,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 30) as varchar2(100)),'~','') p30,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 31) as varchar2(100)),'~','') p31,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 32) as varchar2(100)),'~','') p32,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 33) as varchar2(100)),'~','') p33,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 34) as varchar2(100)),'~','') p34,
                        replace(cast(REGEXP_SUBSTR(output, '[^||]+', 1, 35) as varchar2(100)),'~','') p35 into /*s_productNo , */p_tariffDate , /*p_kullanimsekli , */p_kullanimtarzi ,p_ilkAracBedeli , /*s_plakailkodu ,*/p_tramerilce ,p_yenilemeyeniiskod , p_sigortaliyas , p_aracbedeli , p_yakittipi , p_medenihali , p_cocukdegiskeni ,  p_kismihasarsayisi ,  p_sigortaliliksuresi , p_cinsiyeti ,p_trafikKademesi ,p_markariskgrubu ,  p_camhasarsayisi ,p_filosegment , p_surprim , p_ozelIndirim , p_markakodu ,      p_meslek ,       p_markatipkodu , p_trafikKademesi , p_commercialScore ,p_kiymetKazanma , p_aracyasi ,p_ozelTuzel,p_gecmisHasarSayisi ,p_oncekiTrafikKademesi,p_gecikmeSurprimi,p_trfFrekans,p_trafikKayitliAracSayisi
                        from tnswin.pricing_Tariff_log where price_id=referancePriceId AND STATUS=1;
                end if;
            end if;

            /* BifurcationSegment */
            /*
            Müşteri Tipi Özel
            Gecikme Sürprim 0
            Kullanım Tarzı 1 ve ya  6'ysa
            Tramer geçmişi 5 yıldan fazla ve poliçeler arasında boşluk yoksa,
            toplam hasar adedi 0'sa
            */
        select getTRFSigortalilikSuresiNew(clob_sasiSorgu) into p_bifurcationSegmentValue from dual;

-- addlog ('','996', p_bifurcationSegmentValue);

       select CAST(replace(cast(REGEXP_SUBSTR(p_bifurcationSegmentValue, '[^-]+', 1, 1) as varchar2(100)),'-','')AS NUMBER),
        CAST(replace(cast(REGEXP_SUBSTR(p_bifurcationSegmentValue, '[^-]+', 1, 2) as varchar2(100)),'-','')AS NUMBER),
        CAST(replace(cast(REGEXP_SUBSTR(p_bifurcationSegmentValue, '[^-]+', 1, 3) as varchar2(100)),'-','')AS NUMBER)  into p_sigortalilikSuresiNew, p_beklenenSigortalilikSuresiNew, p_toplamhasaradedi  from dual;

-- addlog ('','997', p_sigortalilikSuresiNew||'-'||p_beklenenSigortalilikSuresiNew||'-'||p_toplamhasaradedi);
-- addlog ('','998', p_ozelTuzel||'-'||p_gecikmeSurprimi||'-'||p_kullanimtarzi||'-'||(p_beklenenSigortalilikSuresiNew-p_sigortalilikSuresiNew)||'-'||p_toplamhasaradedi);
--begin
        if p_ozelTuzel = '1' and p_gecikmeSurprimi = '0' and p_kullanimtarzi in('1','6','01','06') and (p_beklenenSigortalilikSuresiNew-p_sigortalilikSuresiNew) < 0.1 and (p_beklenenSigortalilikSuresiNew-p_sigortalilikSuresiNew) > -0.1 and p_sigortalilikSuresiNew > 4.9 and p_toplamhasaradedi = 0 then
            p_bifurcationSegment := '1';
        else
            p_bifurcationSegment := '0';
        end if;
        p_bifurcationSubSegment := '0';
        if p_ilAd = 'BURSA' and to_number(p_markakodu) = 090 and p_trafikKademesi = '6' then
            p_bifurcationSubSegment :='1';
        elsif p_ilAd in('İSTANBUL','ISTANBUL') and to_number(p_markakodu) = 153 and p_sigortaliyas in('36','37','38','39','40') and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='2';
        elsif p_ilAd = 'KONYA' and to_number(p_markakodu) = 153 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='3';
        elsif p_ilAd in('İSTANBUL','ISTANBUL') and to_number(p_markakodu) = 21 and p_trafikKademesi = '4' and p_oncekiTrafikKademesi = '0' then
            p_bifurcationSubSegment :='4';
        elsif p_ilAd in('İSTANBUL','ISTANBUL') and to_number(p_markakodu) = 100 and p_sigortaliyas in('41','42','43','44','45') and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='5';
        elsif p_ilAd = 'ANKARA' and to_number(p_markakodu) = 34 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='6';
        elsif p_ilAd in ('KOCAELİ','KOCAELI','İZMİT','IZMIT') and to_number(p_markakodu) = 445 then
            p_bifurcationSubSegment :='7';
        elsif p_ilAd in('GAZİANTEP','GAZIANTEP','G.ANTEP') and to_number(p_markakodu) = 153 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='8';
        elsif p_ilAd = 'ANKARA' and to_number(p_markakodu) = 153 and p_sigortaliyas in('31','32','33','34','35') and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='9';
        elsif p_ilAd in ('KOCAELİ','KOCAELI','İZMİT','IZMIT') and to_number(p_markakodu) = 111 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='10';
        elsif p_ilAd in('İSTANBUL','ISTANBUL') and to_number(p_markakodu) = 111 and p_sigortaliyas in('51','52','53','54','55') and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='11';
        elsif p_ilAd = 'ANKARA' and to_number(p_markakodu) = 107 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='12';
        elsif p_ilAd in('İSTANBUL','ISTANBUL') and to_number(p_markakodu) = 100 and p_model<1999 and p_sigortaliyas not in('26','27','28','29','30') and p_trafikKademesi = '4' and p_oncekiTrafikKademesi = '0' then
            p_bifurcationSubSegment :='13';
        elsif p_ilAd in('İSTANBUL','ISTANBUL') and to_number(p_markakodu) = 125 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='14';
        elsif p_ilAd = 'ADANA' and to_number(p_markakodu) = 111 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='15';
        elsif p_ilAd in('MUS','MUŞ') and to_number(p_markakodu) = 53 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='16';
        elsif p_ilAd = 'BURSA' and to_number(p_markakodu) = 100 and p_model<1999 and p_sigortaliyas in('31','32','33','34','35') then
            p_bifurcationSubSegment :='17';
        elsif p_ilAd = 'ANKARA' and to_number(p_markakodu) = 122 and p_model<1999 and p_sigortaliyas in('46','47','48','49','50') and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='18';
        elsif p_ilAd in('İSTANBUL','ISTANBUL') and to_number(p_markakodu) = 53 and p_sigortaliyas in('56','57','58','59','60') and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='19';
        elsif p_ilAd = 'HATAY' and to_number(p_markakodu) = 100 then
            p_bifurcationSubSegment :='20';
        elsif p_ilAd = 'ADANA' and to_number(p_markakodu) = 177 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='21';
        elsif p_ilAd in('MERSIN','MERSİN','İÇEL','ICEL') and to_number(p_markakodu) = 100 and p_sigortaliyas in('26','27','28','29','30') then
            p_bifurcationSubSegment :='22';
        elsif p_ilAd in('DIYARBAKIR','DİYARBAKIR','D.BAKIR') and to_number(p_markakodu) = 177 then
            p_bifurcationSubSegment :='23';
        elsif p_ilAd = 'KONYA' and to_number(p_markakodu) = 122 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='24';
        elsif p_ilAd in('İSTANBUL','ISTANBUL') and to_number(p_markakodu) = 445 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='25';
        elsif p_ilAd in('KAYSERI','KAYSERİ') and to_number(p_markakodu) = 53 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='26';
        elsif p_ilAd = 'ANKARA' and to_number(p_markakodu) = 800 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='27';
        elsif p_ilAd in('IZMIR','İZMİR') and to_number(p_markakodu) = 27 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='28';
        elsif p_ilAd in('İSTANBUL','ISTANBUL') and to_number(p_markakodu) = 520 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '7' then
            p_bifurcationSubSegment :='29';
        elsif p_ilAd in('KAHRAMANMARAŞ','KAHRAMANMARAS','K.MARAŞ','K.MARAS') and to_number(p_markakodu) = 144 then
            p_bifurcationSubSegment :='30';
        elsif p_ilAd = 'BURSA' and to_number(p_markakodu) = 177 and p_trafikKademesi = '7' and p_oncekiTrafikKademesi = '6' then
            p_bifurcationSubSegment :='31';
        end if;
--exception
--    when OTHERS Then
--    p_bifurcationSegment := '0';
--    goto gooo;
--end;
--<<gooo>>


-- addlog ('','999', p_bifurcationSegment);
            /**********************/

                v_sql := 'select getTariff.getactivefactorsql1('||s_PricingId||','''|| p_productNo ||''', to_date('''||p_tariffDate||''',''DD/MM/YYYY''),'''||p_kullanimsekli||''','''|| p_kullanimtarzi||''','''|| p_aracyasi||''','''|| p_plakaIlKodu||''','''|| p_tramerIl ||''','''||p_tramerilce||''','''|| p_yenilemeyeniiskod||''','''|| p_sigortaliyas||''','''|| p_aracbedeli ||''','''|| p_yakittipi||''','''|| p_medenihali||''','''|| p_cocukdegiskeni||''','''|| p_kismiHasarSayisi ||''','''|| p_sigortaliliksuresi||''','''|| p_cinsiyeti||''','''|| kaskoHasarsizlikKademesi||''','''|| p_markariskgrubu||''','''|| p_camhasarsayisi||''',''0'|| /*pakettipi||*/''','''|| p_yenilemeCapIndirimi||''','''|| p_filosegment ||''','''|| p_guncelbedel||''','''|| p_sigortaliskor||''','''|| p_aracskor||''','''|| p_surprim||''','''|| p_ozelindirim||''',''0'||/* kullanimtipi||*/''',''0'||/* yurtDisiTeminatiSuresi||*/''','''|| p_markakodu||''','''||p_yeniaracbedel||''','''||p_meslek||''','''||p_markatipkodu||''','''||p_trafikkademesi||''','''||p_commercialScore||''','''||p_kiymetKazanma||''','''||p_ilkAracYas||''','''||p_plaka100502||''','''||p_ozelTuzel||''','''||p_ticariFaktor||''','''||P_WHP||''','''||p_aracSegment||''','''||p_kasaTipi||''',''0'||/*camMuafiyetIstisnasi||*/''','''||p_cocukSayisi||''','''||p_hasarSayisi||''','''||p_oncekiTrafikKademesi||''','''||hatliMi||''','''|| p_gecikmeSurprimi ||''','''||p_yenilemeYili ||''','''||p_trfFrekans||''','''||p_trafikKayitliAracSayisi||''','''||p_aracSayisiNewKontrol||''','''||p_yasayanOtoUrun||''','''||p_teenCocuk||''','''||p_ErkekTeenCocuk||''','''||p_pertarac||''','''||/*p_aracyerliyabanci*/null||''','''||/*p_garaj*/null||''','''||/*p_resmidaire*/null||''','''||/*p_servis*/ null||''','''||/*p_muafiyet*/ null||''','''||/*p_anlasmaliServis*/null||''','''||/*p_parcaTuru*/null||''','''||/*p_servisTuru*/null||''','''||/*p_surucuInd*/null||''','''||acente||''','''||/*araccoklugu*/null||''',''' ||/*p_acenteCarpan*/ null||''','''|| /*p_aracyasgrubu*/null || ''','''|| /*p_kontrol1*/null || ''','''|| /*p_kontrol2*/null || ''','''|| /*p_kontrol3*/null || ''','''|| /*p_kontrol4*/NULL || ''','''|| /*s8000*/null || ''','''|| /*s8060*/null || ''','''|| /*p_kontrol5*/null || ''','''|| eurocar_segment || ''','''|| eurocar_kasatipi || ''','''|| eurocar_sanziman || ''','''|| NBRENEWAL2 || ''','''|| p_MARKATIPGRUP || ''','''|| p_ililcegrup || ''','''|| birYilOncekiHasar || ''','''|| ikiYilOncekiHasar || ''','''|| ucYilOncekiHasar || ''','''||p_aracBedelGrubu||''','''||null||''','''||null||''','''||null||''','''||sonUcYilHasarSayisi||''','''||p_bifurcationSegment||''','''||p_bifurcationSubSegment||''') from dual'; --p_aracBedelGrubu varchar2, p_ortalamaHasarTutar1 varchar2,p_ortalamaHasarTutar2 varchar2,p_ortalamaHasarTutar3 varchar2, p_sonUcYilHasarSayisi varchar2
                d1_sql := 'select getTariff.getTariffDetay('''|| p_productNo ||''', to_date('''||p_tariffDate||''',''DD/MM/YYYY''),'''||p_kullanimsekli||''','''|| p_kullanimtarzi||''','''|| p_aracyasi||''','''|| p_plakaIlKodu||''','''|| p_tramerIl ||''','''||p_tramerilce||''','''|| p_yenilemeyeniiskod||''','''|| p_sigortaliyas||''','''|| p_aracbedeli||''','''|| p_yakittipi||''','''|| p_medenihali||''','''|| p_cocukdegiskeni||''','''|| p_kismiHasarSayisi ||''','''|| p_sigortaliliksuresi||''','''|| p_cinsiyeti||''','''|| kaskoHasarsizlikKademesi||''','''|| p_markariskgrubu||''','''|| p_camhasarsayisi||''',''0'||/* pakettipi||*/''','''|| p_yenilemeCapIndirimi||''','''|| p_filosegment ||''','''|| p_guncelbedel||''','''|| p_sigortaliskor||''','''|| p_aracskor||''','''|| p_surprim||''','''|| p_ozelindirim||''',''0'||/* kullanimtipi||*/''',''0'||/* yurtDisiTeminatiSuresi||*/''','''|| p_markakodu||''','''||p_yeniaracbedel||''','''||p_meslek||''','''||p_markatipkodu||''','''||p_trafikkademesi||''','''||p_commercialScore||''','''||p_kiymetKazanma||''','''||p_ilkAracYas||''','''||p_plaka100502||''','''||p_ozelTuzel||''','''||p_ticariFaktor||''','''||P_WHP||''','''||p_aracSegment||''','''||p_kasaTipi||''',''0'||/*camMuafiyetIstisnasi||*/''','''||p_cocukSayisi||''','''||p_hasarSayisi||''','''||p_oncekiTrafikKademesi||''','''||hatliMi||''','''|| p_gecikmeSurprimi ||''','''||p_yenilemeYili ||''','''||p_trfFrekans||''','''||p_trafikKayitliAracSayisi||''','''||p_aracSayisiNewKontrol||''','''||p_yasayanOtoUrun||''','''||p_teenCocuk||''','''||p_ErkekTeenCocuk||''','''||p_pertarac||''','''||/*p_aracyerliyabanci*/null||''','''||/*p_garaj*/null||''','''||/*p_resmidaire*/ null||''','''||/*p_servis*/ null||''','''||/*p_muafiyet*/null||''','''||/*p_anlasmaliServis*/null||''','''||/*p_parcaTuru*/null||''','''||/*p_servisTuru*/null||''','''||/*p_surucuInd*/null||''','''||acente||''','''||/*araccoklugu*/null||''','''||/*p_acenteCarpan*/null||''','''|| /*p_aracyasgrubu*/null ||''','''|| /*p_kontrol1*/null ||''','''|| /*p_kontrol2*/ null ||''','''|| /*p_kontrol3*/ null ||''','''|| /*p_kontrol4*/null ||''','''|| /*s8000*/null ||''','''|| /*s8060*/null ||''','''|| /*p_kontrol5*/null ||''','''|| eurocar_segment || ''','''|| eurocar_kasatipi || ''','''|| eurocar_sanziman || ''','''|| NBRENEWAL2 || ''','''|| p_MARKATIPGRUP || ''','''|| p_ililcegrup || ''','''|| birYilOncekiHasar || ''','''|| ikiYilOncekiHasar || ''','''|| ucYilOncekiHasar || ''','''||p_aracBedelGrubu||''','''||null||''','''||null||''','''||null||''','''||sonUcYilHasarSayisi||''','''||p_bifurcationSegment||''','''||p_bifurcationSubSegment||''') from dual'; --p_aracBedelGrubu varchar2, p_ortalamaHasarTutar1 varchar2,p_ortalamaHasarTutar2 varchar2,p_ortalamaHasarTutar3 varchar2, p_sonUcYilHasarSayisi varchar2
                execute immediate d1_sql into d2_sql;
                execute immediate v_sql into t_sql;
                execute immediate t_sql into rec;
        if p_debugmode='1' then addlog ('','41', ''); end if;

/*
            if acente = '30588' and substr(kimlikNo,1,1) = '9' and length(kimlikNo)=11 and (plakailkodu = '38' or plakailkodu = '038') then
                if p_kullanimtarzi = '1' then
                    rec.m1:=rec.m1*77/100;
                elsif p_kullanimtarzi = '6' then
                    rec.m1:=rec.m1*70/100;
                end if;
            end if;

            if acente = '30075' and substr(kimlikNo,1,1) = '9' and length(kimlikNo)=11 and (plakailkodu = '38' or plakailkodu = '038' or plakailkodu = '27' or plakailkodu = '027' or plakailkodu = '79' or plakailkodu = '079' or plakailkodu = '63' or plakailkodu = '063' or plakailkodu = '31' or plakailkodu = '031') then
                if p_kullanimtarzi = '1' then
                    rec.m1:=rec.m1*77/100;
                elsif p_kullanimtarzi = '6' then
                    rec.m1:=rec.m1*70/100;
                end if;
            end if;
*/

                rec.m2 := rec.m1;

                --select count(0) into p_minimumprim from pricing_tables tt where tt.table_code='TRF-Minimum Prim' and tt.key1=p_kullanimtarzi and tt.key2=p_plakaIlKodu and tt.valid_date=(select max(tt1.valid_date) from pricing_tables tt1 where tt1.table_code='TRF-Minimum Prim' and tt1.valid_date<=p_tariffDate);
                select count(0) into p_minimumprim from pricing_parameters where param_name = 'TRF Prim Alt Limit' and key1 = cast(p_kullanimtarzi as number) and key2 =cast(p_trafikKademesi as number) and valid_date = (select max(valid_date) from pricing_parameters where param_name = 'TRF Prim Alt Limit' and key1 = cast(p_kullanimtarzi as number) and key2=cast(p_trafikKademesi as number) and valid_date<=p_tariffDate);
                if p_minimumprim>0 then
                    select to_number(desc1) into p_minimumprim from pricing_parameters where param_name = 'TRF Prim Alt Limit' and key1 = cast(p_kullanimtarzi as number) and key2 =cast(p_trafikKademesi as number) and valid_date = (select max(valid_date) from pricing_parameters where param_name = 'TRF Prim Alt Limit' and key1 = cast(p_kullanimtarzi as number) and key2=cast(p_trafikKademesi as number) and valid_date<=p_tariffDate);
                else
                    p_minimumPrim := 0;
                end if;
        if p_debugmode='1' then addlog ('','42', ''); end if;
                /*
                if minimumPrimKorunsunMu='E' then
                    if p_kasabedeli + p_digerAksesuarBedeli > 0 then rec.prim := (rec.m1+rec.m2+rec.m3+rec.m4+rec.m5+rec.m6)*(aracBedeli+p_kasabedeli+p_digerAksesuarBedeli)/1000; END IF;
                    if p_minimumprim >= rec.prim then
                        rec.prim := p_minimumprim;
                    end if;
                end if;
                */
                if p_minimumprim > rec.m1 then rec.m1 := p_minimumprim; end if;
        if p_debugmode='1' then addlog ('','43', p_kullanimtarzi||'-'||p_trafikKademesi); end if;
                /* Max Prim */
--                substr(replace('000 05',' ',''),-3)
                    select count(0) into p_maxPrim from pricing_tables where table_code = 'TRF-PRİM ÜST LİMİT' and key1 = substr(replace('00'||p_plakaIlKodu,' ',''),-3) and key2 =substr('00'||cast(p_kullanimtarzi as number),-2) and key3 =cast(p_trafikKademesi as number) and valid_date = (select max(valid_date) from pricing_tables where table_code = 'TRF-PRİM ÜST LİMİT' and key1 = substr(replace('00'||p_plakaIlKodu,' ',''),-3) and key2 =substr('00'||cast(p_kullanimtarzi as number),-2) and key3 =cast(p_trafikKademesi as number) and valid_date<=p_tariffDate);
                    if p_maxPrim>0 then
                       select mult1 into p_maxPrim from pricing_tables where table_code = 'TRF-PRİM ÜST LİMİT' and key1 = substr(replace('00'||p_plakaIlKodu,' ',''),-3) and key2 =substr('00'||cast(p_kullanimtarzi as number),-2)  and key3 =cast(p_trafikKademesi as number) and valid_date = (select max(valid_date) from pricing_tables where table_code = 'TRF-PRİM ÜST LİMİT' and key1 = substr(replace('00'||p_plakaIlKodu,' ',''),-3) and key2 =substr('00'||cast(p_kullanimtarzi as number),-2) and key3 =cast(p_trafikKademesi as number) and valid_date<=p_tariffDate);
                    else
                        p_maxPrim := 9999999;
                    end if;

        if p_debugmode='1' then addlog ('','44', ''); end if;
                if rec.m1 > p_maxPrim then rec.m1 := p_maxPrim; end if;
                    /* Karaliste Kontrol */
                    /*select count(0) into p_karaListeKontrol from
                    (select * from t001c002u100100 where k1=kimlikNo or k2=kimlikNo
                    union all
                    select * from t001c002u100101 where k1=kimlikNo or k2=kimlikNo
                    union all
                    select * from t001c002u100102 where k1=kimlikNo or k2=kimlikNo) t;*/
        if p_debugmode='1' then addlog ('','45', ''); end if;
                    /*select count(0) into p_bedeniWinsureKontrol
                    from t001hasihb a , t001hasmag b, t008unsmas u
                    WHERE a.claim_no=b.claim_no and a.company_code=2 and b.company_code=2
                    AND b.CLAIM_VARIANCE=3 and a.client_unit_type=u.unit_type and a.client_no=u.unit_no and u.firm_code=2 and u.citizenship_number=kimlikNo  and u.personal_commercial='O';
                    select count(0)into p_bedeniAS400Kontrol FROM L034AS400BEDDOSYA where trim(tckn_vn)=trim(kimlikNo) and length(kimlikno)=11;
                    */
--                    if length(p_referancePriceId) = 36 then
--                        select count(0) into p_ofacKontrol from t001c002u500 where replace(k1,' ','')=(trim(removeElement(getSbmDetails(clob_trafikteklifislemid, 'adUnvan'), 'adUnvan'))||trim(removeElement(getSbmDetails(clob_trafikteklifislemid, 'soyad'), 'soyad')));
--                        p_ofacKontrol := fncOfacKontrol (clob_trafikteklifislemid, kimlikNo, '2');
--                    else
--                        p_ofacKontrol := fncOfacKontrol (clob_sbmValues, kimlikNo, '1');
--                    end if;
                            if p_debugmode='1' then addlog ('','46', ''); end if;
                --if p_karaListeKontrol>0 or p_bedeniWinsureKontrol>0 or p_bedeniAS400Kontrol>0 or p_ofacKontrol>0 then rec.m1 := p_maxPrim; end if;

                    /* Karaliste Kontrol */

                /* Max Prim */

        /*
            m1 : TRF tarife primi (sgk dahil) - Üst limit kontrolü yapılmış
            m2 : Üst limit kontrolü yapılmayan tarife prim
            m3 : sgk primi - Üst limit kontrolü yapılmış
            m4 : üst limit uygulanmış prim, sgk hariç net prim
            m5 : üst limit
            prim : Sgk ve fonlar, vergi dahil brüt prim
        */
                if rec.m2>999999 then rec.m2:=999999; end if;
                /* Gecikme sürprimi için eklendi. */
                SELECT   count(0) into p_gecikmesurprimoran FROM   pricing_tables b WHERE       b.table_code = 'TRF-GECİKME SÜRPRİMİ' AND key1 = p_productNo AND key2 = CAST (p_gecikmeSurprimi AS number) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_tables a WHERE       a.table_code = 'TRF-GECİKME SÜRPRİMİ' AND a.valid_date IS NOT NULL AND a.valid_date <= p_tariffDate);
                if p_gecikmesurprimoran > 0 then
                    SELECT   b.mult1 into p_gecikmesurprimoran FROM   pricing_tables b WHERE       b.table_code = 'TRF-GECİKME SÜRPRİMİ' AND key1 = p_productNo AND key2 = CAST (p_gecikmeSurprimi AS number) AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_tables a WHERE       a.table_code = 'TRF-GECİKME SÜRPRİMİ' AND a.valid_date IS NOT NULL AND a.valid_date <= p_tariffDate);
                else
                    p_gecikmesurprimoran := 1;
                end if;

--if acente = '30295' then
--                addDebugLog(s_PricingId,'select count(0) into p_filoIndirim from (select a.*, coalesce(coalesce(um.citizenship_number, um.tax_no), um.foreign_citizenship_number) s_kimlikno from tnswin.T001C002U5507 a, tnswin.t008unsmas um where a.k3=um.unit_no and um.unit_type=''MS'' and um.firm_code=2 and a.gecer_tarih=(select max(y.gecer_tarih) from tnswin.t001c002u5507 y where y.k1=a.k1 and y.k2=a.k2 and y.k3=a.k3 and y.gecer_tarih<='||p_tariffDate||')) t where t.s_kimlikno='||kimlikNo||' and t.k2='||acente||' and t.k1='||p_productNo);
--end if;

                select count(0) into p_filoIndirim from (select a.*, coalesce(coalesce(um.citizenship_number, um.tax_no), um.foreign_citizenship_number) s_kimlikno from tnswin.T001C002U5507 a, tnswin.t008unsmas um where a.k3=um.unit_no and um.unit_type='MS' and um.firm_code=2 and a.gecer_tarih=(select max(y.gecer_tarih) from tnswin.t001c002u5507 y where y.k1=a.k1 and y.k2=a.k2 and y.k3=a.k3 and cast(y.k4 as number)=cast(p_kullanimtarzi as number) and y.gecer_tarih<=p_tariffDate)) t where t.s_kimlikno=kimlikNo and t.k2=acente and t.k1=p_productNo and cast(t.k4 as number)=cast(p_kullanimtarzi as number);
--if acente = '30295' then
--                addDebugLog(s_PricingId,'p_filoIndirim=' || p_filoIndirim || '&p_tariffDate='||p_tariffDate||'&p_productNo='||p_productNo||'&acente='||acente||'&kimlikNo='||kimlikNo);
--end if;
                if p_filoIndirim>0 then
                    select d1 into p_filoIndirim from (select a.*, coalesce(coalesce(um.citizenship_number, um.tax_no), um.foreign_citizenship_number) s_kimlikno from tnswin.T001C002U5507 a, tnswin.t008unsmas um where a.k3=um.unit_no and um.unit_type='MS' and um.firm_code=2 and a.gecer_tarih=(select max(y.gecer_tarih) from tnswin.t001c002u5507 y where y.k1=a.k1 and y.k2=a.k2 and y.k3=a.k3 and cast(y.k4 as number)=cast(p_kullanimtarzi as number)and y.gecer_tarih<=p_tariffDate)) t where t.s_kimlikno=kimlikNo and t.k2=acente and t.k1=p_productNo and cast(t.k4 as number)=cast(p_kullanimtarzi as number);
                end if;

select count(0) into p_yabanciSigortaliInd FROM   pricing_tables b WHERE b.table_code = 'TRF-YABANCI INDIRIM' AND key1 = p_productNo AND key2 = acente AND key3 = CAST (p_plakaIlKodu AS number) AND key4 = CAST (p_kullanimtarzi AS number) AND key5 = p_yabanciSigortali and b.valid_Date=(select max(c.valid_date) from tnswin.pricing_tables c where c.table_code=b.table_code and c.valid_date<=p_tariffDate);
if p_yabanciSigortaliInd > 0 then
    select max(mult1) into p_yabanciSigortaliInd FROM   pricing_tables b WHERE b.table_code = 'TRF-YABANCI INDIRIM' AND key1 = p_productNo AND key2 = acente AND key3 = CAST (p_plakaIlKodu AS number) AND key4 = CAST (p_kullanimtarzi AS number) AND key5 = p_yabanciSigortali and b.valid_Date=(select max(c.valid_date) from tnswin.pricing_tables c where c.table_code=b.table_code and c.valid_date<=p_tariffDate);
    rec.m1 := rec.m1*p_yabanciSigortaliInd;
end if;

                rec.m1 := rec.m1*p_gecikmesurprimoran;
                /* Gecikme sürprimi için eklendi. */

--                insert into tnswin.pricing_tariff_debug (price_id, system_date, slog) values(s_PricingId, sysdate, 'p_filoIndirim=' || p_filoIndirim || '&p_trafikKademesi='||p_trafikKademesi||'&p_kullanimtarzi='||p_kullanimtarzi);
--if acente = '30295' then
--                addDebugLog(s_PricingId,'p_filoIndirim=' || p_filoIndirim || '&p_trafikKademesi='||p_trafikKademesi||'&p_kullanimtarzi='||p_kullanimtarzi);
--end if;
                if p_filoIndirim >0 and p_trafikKademesi in('4','5','6','7') and p_kullanimtarzi in('1','01','6','06') then
--                    insert into tnswin.pricing_tariff_debug (price_id, system_date, slog) values(s_PricingId, sysdate, 'if blogu içi m1=' || rec.m1 || '&new_m1='||(rec.m1*(100-p_filoIndirim))/100);
--                    addDebugLog(s_PricingId,'if blogu içi m1=' || rec.m1 || '&new_m1='||(rec.m1*(100-p_filoIndirim))/100);
                    rec.m1 := (rec.m1*(100-p_filoIndirim))/100;
                end if;

                rec.m3 := (rec.m1*10/100);
                rec.prim := (rec.m1) *112/100;
                rec.m4 := rec.m1 - rec.m3;
                rec.m5 := p_maxPrim;
                rec.m6 := p_gecikmesurprimoran;


if acente = '20048' and p_productNo = '556' then
    p_m19 := (rec.m3 + rec.m4)*10/100; -- m19
    if p_m19< 40 then p_m19 := 40; end if;
end if;


                if price_type = 'TRF_TARIFF' then
                    addTariffLog(p_productNo,p_tariffDate,kimlikNo,sasiNo,tescilSeriKod,tescilSeriNo,plakailkodu,plakaNo,asbisNo, tescilTarihi,trafigeCikisTarihi,s_PricingId,price_type,NULL  ,d2_sql/*v_sql||'~'||d1_sql*/,p_cocukdegiskeni,p_sigortaliyas,p_aracyasi,p_kullanimtarzi,p_kullanimsekli,p_aracskor,p_cinsiyeti,p_medenihali,p_tramerilce,p_sigortaliskor,p_systemdate,p_systemtime,p_yakittipi,p_markakodu,p_aracbedeli,p_filosegment,p_markariskgrubu,p_yenilemeyeniiskod,  p_kismihasarsayisi,  p_sigortaliliksuresi, p_camhasarsayisi, 'SBM', rec.m1, rec.m2, rec.m3, rec.m4, rec.m5, rec.m6, p_sql,p_markatipkodu,p_minimumfiyat,p_minimumprim,p_meslek,p_ilkAracBedeli,p_kasabedeli,p_digerAksesuarBedeli,clob_hasarBelgeSorgu,p_commercialScore,p_kiymetKazanma,p_ilkAracYas,p_commercialScoreId,p_gecmisHasarSayisi ,p_gecmisHasarsizlikIndirimi,p_gecmisPoliceFiyat ,p_yenilemeCapMin,p_yenilemeCapMax,clob_sbmValues,p_yenilemeFloor,p_yenilemeCap,P_WHP,acente,kullaniciAdi,kaskoHasarsizlikKademesi,'', '', '', referancePriceId, p_trafikKademesi,p_karaListeKontrol, p_bedeniWinsureKontrol, p_bedeniAS400Kontrol, p_ofacKontrol,'',p_cache_key, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null,null,null,null, p_ozelTuzel , p_oncekiTrafikKademesi , p_gecikmeSurprimi , p_trfFrekans , p_trafikKayitliAracSayisi , p_markaTipGrup , p_ilIlcegrup , birYilOncekiHasar , ikiYilOncekiHasar , ucYilOncekiHasar , sonUcYilHasarSayisi ,p_m19/*m19*/);
                else
                    addTariffLog(p_productNo,p_tariffDate,kimlikNo,sasiNo,tescilSeriKod,tescilSeriNo,plakailkodu,plakaNo,asbisNo, tescilTarihi,trafigeCikisTarihi,s_PricingId,price_type,null   ,d2_sql/*v_sql||'~'||d1_sql*/,p_cocukdegiskeni,p_sigortaliyas,p_aracyasi,p_kullanimtarzi,p_kullanimsekli,p_aracskor,p_cinsiyeti,p_medenihali,p_tramerilce,p_sigortaliskor,p_systemdate,p_systemtime,p_yakittipi,p_markakodu,p_aracbedeli,p_filosegment,p_markariskgrubu,p_yenilemeyeniiskod,  p_kismihasarsayisi,  p_sigortaliliksuresi, p_camhasarsayisi, 'SBM', rec.m1, rec.m2, rec.m3, rec.m4, rec.m5, rec.m6, p_sql,p_markatipkodu,p_minimumfiyat,p_minimumprim,p_meslek,p_ilkAracBedeli,p_kasabedeli,p_digerAksesuarBedeli,clob_hasarBelgeSorgu,p_commercialScore,p_kiymetKazanma,p_ilkAracYas,p_commercialScoreId,p_gecmisHasarSayisi ,p_gecmisHasarsizlikIndirimi,p_gecmisPoliceFiyat ,p_yenilemeCapMin,p_yenilemeCapMax,clob_sbmValues,p_yenilemeFloor,p_yenilemeCap,P_WHP,acente,kullaniciAdi,kaskoHasarsizlikKademesi,'', '', '', referancePriceId, p_trafikKademesi,p_karaListeKontrol, p_bedeniWinsureKontrol, p_bedeniAS400Kontrol, p_ofacKontrol,'',p_cache_key, '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null,null,null,null, p_ozelTuzel , p_oncekiTrafikKademesi , p_gecikmeSurprimi , p_trfFrekans , p_trafikKayitliAracSayisi , p_markaTipGrup , p_ilIlcegrup , birYilOncekiHasar , ikiYilOncekiHasar , ucYilOncekiHasar , sonUcYilHasarSayisi ,p_m19/*m19*/);
                end if;

        if p_debugmode='1' then addlog ('','47', ''); end if;
            else
--                select max(price_id) into p_cachepriceid from pricing_tariff_log where cache_key=p_cache_key and status='1' and (to_char(to_date(system_date,'DD/MM/YYYY'),'MM/YYYY')=to_char(sysdate,'MM/YYYY') or (to_char(sysdate,'DD')<4 and (to_date('01/'||to_char(sysdate,'MM/YYYY'))-1)=to_date(system_date,'DD/MM/YYYY') ));
                select max(price_id) into p_cachepriceid from pricing_tariff_log where cache_key=p_cache_key and status='1' and system_date=to_char(sysdate,'DD/MM/YYYY');
                select price_id priceid, m1,m2,m3,m4,m5,m6,(m1*112/100) prim into rec from pricing_tariff_log where status='1' and price_id=p_cachepriceid;
            end if;
        else
--            select price_id priceid, m1,m2,m3,m4,m5,m6,(m1*112/100) prim into rec from pricing_tariff_log where system_date=to_char(sysdate,'DD/MM/YYYY') and cast(psql as varchar2(1000))=to_char(p_sql) and m1<>'999999';
            if length(referancePriceId) = 36 then
--                select max(price_id) into p_cachepriceid                              from pricing_tariff_log where cache_key='TRF'||','||kimlikNo||','||sasiNo||','||p_trfislidgecikmesurprim||','||p_trfisliduygbasamakkodu||','||p_trfisliduyggerbasamakkodu||','||markaTipKodu||','||model||','||kullanimSekli||','||plakailkodu||','||plakaNo||','||acente and status='1' and (to_char(to_date(system_date,'DD/MM/YYYY'),'MM/YYYY')=to_char(sysdate,'MM/YYYY') or (to_char(sysdate,'DD')<4 and (to_date('01/'||to_char(sysdate,'MM/YYYY'))-1)=to_date(system_date,'DD/MM/YYYY') ));
                select max(price_id) into p_cachepriceid                              from pricing_tariff_log where cache_key='TRF'||','||kimlikNo||','||sasiNo||','||p_trfislidgecikmesurprim||','||p_trfisliduygbasamakkodu||','||p_trfisliduyggerbasamakkodu||','||markaTipKodu||','||model||','||kullanimSekli||','||plakailkodu||','||plakaNo||','||acente and status='1' and system_date=to_char(sysdate,'DD/MM/YYYY');
                select price_id priceid, m1,m2,m3,m4,m5,m6,(m1*112/100) prim into rec from pricing_tariff_log where price_id=p_cachepriceid and status='1';
            else
                select price_id priceid, m1,m2,m3,m4,m5,m6,(m1*112/100) prim into rec from pricing_tariff_log where system_date=to_char(sysdate,'DD/MM/YYYY') and cast(psql as varchar2(1000))=to_char(p_sql) and status='1' and rownum=1;
            end if;
        end if;
        if p_debugmode='1' then addlog ('','48', ''); end if;
        PIPE ROW (rec);
        RETURN;
        EXCEPTION WHEN OTHERS THEN
            --v_errm := SUBSTR(SQLERRM, 1, 4000);
            v_errm :=   substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
addTariffLog(p_productNo,p_tariffDate,kimlikNo,sasiNo,tescilSeriKod,tescilSeriNo,plakailkodu,plakaNo,asbisNo, tescilTarihi,trafigeCikisTarihi,s_PricingId,'TRF_TARIFF',v_errm,v_sql,p_cocukdegiskeni,p_sigortaliyas,p_aracyasi,p_kullanimtarzi,p_kullanimsekli,p_aracskor,p_cinsiyeti,p_medenihali,p_tramerilce,p_sigortaliskor,p_systemdate,p_systemtime,p_yakittipi, p_markakodu,p_aracbedeli,p_filosegment,p_markariskgrubu,p_yenilemeyeniiskod,  p_kismihasarsayisi,  p_sigortaliliksuresi,  p_camhasarsayisi, 'SBM', 999999,999999,999999,999999,999999,999999,p_sql,p_markatipkodu,p_minimumfiyat,p_minimumprim,p_meslek,p_ilkAracBedeli,p_kasabedeli,p_digerAksesuarBedeli,clob_hasarBelgeSorgu,p_commercialScore,p_kiymetKazanma,p_ilkAracYas,p_commercialScoreId,p_gecmisHasarSayisi ,p_gecmisHasarsizlikIndirimi,p_gecmisPoliceFiyat ,p_yenilemeCapMin,p_yenilemeCapMax,clob_sbmValues,p_yenilemeFloor,p_yenilemeCap,P_WHP,acente,kullaniciAdi,kaskoHasarsizlikKademesi,'', '', '', referancePriceId,p_trafikKademesi,p_karaListeKontrol, p_bedeniWinsureKontrol, p_bedeniAS400Kontrol, p_ofacKontrol,null, p_cache_key, '0', null, null, null, null,null, null, null, null, null, null, null, null, null, null,null,null,null, p_ozelTuzel , p_oncekiTrafikKademesi , p_gecikmeSurprimi , p_trfFrekans , p_trafikKayitliAracSayisi , p_markaTipGrup , p_ilIlcegrup , birYilOncekiHasar , ikiYilOncekiHasar , ucYilOncekiHasar , sonUcYilHasarSayisi ,null/*m19*/);
        RETURN;

    END getTariffTRF;

    FUNCTION getTariffMainDogalgaz(tariffDate varchar2, gazDagitimSirketKodu varchar2, sigortaBedeli number)
        RETURN NUMBER as
        sResult NUMBER(11,5);
        v_errm CLOB;
        p_sql CLOB;
        s_PricingId NUMBER;
        BEGIN
            p_sql := 'select * from table(getTariff.getTariffMainDogalgaz('''||tariffDate||''','''||gazDagitimSirketKodu||''','''||sigortaBedeli ||'''))';
            select seq_pricing_id.nextval into s_PricingId from dual;
            select m.mult1 into sResult from pricing_tables m where m.table_code='3Elma' and m.key1=gazDagitimSirketKodu and m.key2<=sigortaBedeli and m.key3>=sigortaBedeli and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
            addTariffLog('405',tariffdate,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,s_PricingId,'TARIFF',''    ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,to_char(sysdate,'DD/MM/YYYY'),TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,  NULL, NULL, '3Elma', sResult, '0', '0', '0', '0', '0', p_sql,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,NULL,NULL ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,null, null, '1', null, null, null, null,null, null, null, null,null,null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
            return s_PricingId;
        EXCEPTION WHEN OTHERS THEN
            v_errm := SUBSTR(SQLERRM, 1, 4000);
            addTariffLog('405',tariffdate,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,s_PricingId,'TARIFF',v_errm,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,to_char(sysdate,'DD/MM/YYYY'),TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,  NULL, NULL, '3Elma', '999999', '0', '0', '0', '0', '0', p_sql,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,NULL,NULL ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,null,null,null,'0',NULL, null, null, null, null, null, null,null, null, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
            return s_PricingId;
    END;
-- günSayısı, kapsam (GENİŞ,DAR), cagrafikapsam (ülke)

    FUNCTION getTariffMainSeyahat(tariffDate varchar2,yas varchar2,teminatTipi varchar2,cografiAlan varchar2,ekTeminat varchar2,seyahatSuresi varchar2, acenteKodu varchar2)
        RETURN NUMBER as
        sM1 NUMBER(11,5);
        sM2 NUMBER(11,5);
        sM3 NUMBER(11,5);
        v_errm CLOB;
        p_sql CLOB;
        p_cache NUMBER;
        s_PricingId NUMBER;
        exc_rate NUMBER(11,5);
        BEGIN
            p_sql := 'select getTariff.getTariffMainSeyahat('''||tariffDate||''','''||yas||''','''||teminatTipi ||''','''||cografiAlan ||''','''||ekTeminat ||''','''||seyahatSuresi ||''','''||acenteKodu||''') from dual';

            /*select count(0) into p_cache from pricing_tariff_log where system_date=to_char(sysdate,'DD/MM/YYYY') and cast(psql as varchar2(1000))=to_char(p_sql) and m1<>'999999';
            if p_cache=0 then*/
                select seq_pricing_id.nextval into s_PricingId from dual;

                select count(0) into sM1 /*Standart*/ from pricing_tables m where m.table_code='Seyahat'
                        and m.key1=yas
                        and m.key2='1'
                        and m.key3=cografiAlan
                        and m.key4='H'
                        and m.key5=seyahatSuresi
                        and m.key6=acenteKodu
                        and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.key2=m.key2 and m1.key3=m.key3 and m1.key4=m.key4 and m1.key5=m.key5 and m1.key6=m.key6 and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
                if sM1>0 then
                select m.mult1 into sM1 /*Standart*/ from pricing_tables m where m.table_code='Seyahat'
                        and m.key1=yas
                        and m.key2='1'
                        and m.key3=cografiAlan
                        and m.key4='H'
                        and m.key5=seyahatSuresi
                        and m.key6=acenteKodu
                        and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.key2=m.key2 and m1.key3=m.key3 and m1.key4=m.key4 and m1.key5=m.key5 and m1.key6=m.key6 and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
                else
                select m.mult1 into sM1 /*Standart*/ from pricing_tables m where m.table_code='Seyahat'
                        and m.key1=yas
                        and m.key2='1'
                        and m.key3=cografiAlan
                        and m.key4='H'
                        and m.key5=seyahatSuresi
                        and m.key6 is null
                        and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.key2=m.key2 and m1.key3=m.key3 and m1.key4=m.key4 and m1.key5=m.key5 and m1.key6 is null and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
                end if;
                select count(0) into sM2 /*Geniş*/ from pricing_tables m where m.table_code='Seyahat'
                        and m.key1=yas
                        and m.key2='2'
                        and m.key3=cografiAlan
                        and m.key4='H'
                        and m.key5=seyahatSuresi
                        and m.key6=acenteKodu
                        and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.key2=m.key2 and m1.key3=m.key3 and m1.key4=m.key4 and m1.key5=m.key5 and m1.key6=m.key6  and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
                if sM2>0 then
                select m.mult1 into sM2 /*Geniş*/ from pricing_tables m where m.table_code='Seyahat'
                        and m.key1=yas
                        and m.key2='2'
                        and m.key3=cografiAlan
                        and m.key4='H'
                        and m.key5=seyahatSuresi
                        and m.key6=acenteKodu
                        and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.key2=m.key2 and m1.key3=m.key3 and m1.key4=m.key4 and m1.key5=m.key5 and m1.key6=m.key6  and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
                else
                select m.mult1 into sM2 /*Geniş*/ from pricing_tables m where m.table_code='Seyahat'
                        and m.key1=yas
                        and m.key2='2'
                        and m.key3=cografiAlan
                        and m.key4='H'
                        and m.key5=seyahatSuresi
                        and m.key6 is null
                        and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.key2=m.key2 and m1.key3=m.key3 and m1.key4=m.key4 and m1.key5=m.key5 and m1.key6 is null and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
                end if;

                select count(0) into sM3 /*Geniş + Ek*/ from pricing_tables m where m.table_code='Seyahat'
                        and m.key1=yas
                        and m.key2='2'
                        and m.key3=cografiAlan
                        and m.key4='E'
                        and m.key5=seyahatSuresi
                        and m.key6=acenteKodu
                        and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.key2=m.key2 and m1.key3=m.key3 and m1.key4=m.key4 and m1.key5=m.key5 and m1.key6=m.key6  and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
                if sM3 >0 then
                select m.mult1 into sM3 /*Geniş + Ek*/ from pricing_tables m where m.table_code='Seyahat'
                        and m.key1=yas
                        and m.key2='2'
                        and m.key3=cografiAlan
                        and m.key4='E'
                        and m.key5=seyahatSuresi
                        and m.key6=acenteKodu
                        and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.key2=m.key2 and m1.key3=m.key3 and m1.key4=m.key4 and m1.key5=m.key5 and m1.key6=m.key6  and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
                else
                select m.mult1 into sM3 /*Geniş + Ek*/ from pricing_tables m where m.table_code='Seyahat'
                        and m.key1=yas
                        and m.key2='2'
                        and m.key3=cografiAlan
                        and m.key4='E'
                        and m.key5=seyahatSuresi
                        and m.key6 is null
                        and m.valid_date=(select max(m1.valid_date) from pricing_tables m1 where m1.table_code=m.table_code and m1.key1=m.key1 and m1.key2=m.key2 and m1.key3=m.key3 and m1.key4=m.key4 and m1.key5=m.key5 and m1.key6 is null and m1.valid_date is not null and m1.valid_date<=to_date(tariffDate,'DD/MM/YYYY'));
                end if;
                select exchange_rate into exc_rate from t009dovkur where cur_type='EUR' and exc_type=4 and exc_date=(select max(aa.exc_date) from t009dovkur aa where aa.cur_type='EUR' and aa.exc_type=4 and aa.exc_date<=tariffDate);

                addTariffLog('600',tariffdate,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,s_PricingId,'TARIFF','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,to_char(sysdate,'DD/MM/YYYY'),TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,  NULL, NULL, 'Seyahat', sM1, sM2, sM3, '0', '0', exc_rate, p_sql,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,NULL,NULL ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, null, null, null, null, null, null,null, null, null, null, null, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
            /*else
                select price_id into s_PricingId from pricing_tariff_log where system_date=to_char(sysdate,'DD/MM/YYYY') and cast(psql as varchar2(1000))=to_char(p_sql) and m1<>'999999';
            end if;*/
            return s_PricingId;
        EXCEPTION WHEN OTHERS THEN
            v_errm := SUBSTR(SQLERRM, 1, 4000);
            addTariffLog('600',tariffdate,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,s_PricingId,'TARIFF',v_errm,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,to_char(sysdate,'DD/MM/YYYY'),TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,  NULL, NULL, 'Seyahat', '999999', '0', '0', '0', '0', '0', p_sql,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,NULL,NULL ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, null, null, null, null, null, null,null, null, null, null, null, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
            return s_PricingId;
    END;

    FUNCTION kasko_debug (kullanimsekli varchar2, kullanimtarzi varchar2, aracyasi varchar2, plakailkodu varchar2, tramerilce varchar2, yenilemeyeniiskod varchar2, sigortaliyas varchar2, aracbedeli varchar2, yakittipi varchar2, medenidurum varchar2, cocukdegiskeni varchar2, kismiHasarSayisi varchar2, sigortaliliksuresi varchar2, cinsiyet varchar2, hasarsizlikkademesi varchar2, markariskgrubu varchar2, camhasarsayisi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, filosegment varchar2, guncelbedel varchar2, sigortaliskor number, aracskor varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, markakodu varchar2)
        RETURN sonuc_tb PIPELINED AS
        v_sql CLOB;
        t_sql CLOB;
        BEGIN
         FOR satir IN  (
/*    select b.table_code, b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='AracYaşı' and b.key1=kullanimsekli and b.key2=kullanimtarzi and b.key3=aracyasi and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='AracYaşı' and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='İlFaktörleri' and b.key1=kullanimsekli and b.key2=kullanimtarzi and b.key3=plakailkodu and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='İlFaktörleri'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Tramerİlçe' and b.key2=kullanimtarzi and b.key1=tramerilce  and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Tramerİlçe'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Yenileme-Yeniiş' and b.key2=kullanimtarzi and b.key1=yenilemeyeniiskod  and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Yenileme-Yeniiş'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Sigortalı Yaş' and b.key1=kullanimtarzi and b.key2=sigortaliyas and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Sigortalı Yaş'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Bedel Aralığı' and b.key1=kullanimtarzi and b.key2<=cast(aracbedeli as int) and b.key3>=cast(aracbedeli as int) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Bedel Aralığı'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Yakıt Türü' and b.key1=kullanimtarzi and b.key2=yakittipi and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Yakıt Türü'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Medeni Durum' and b.key1=kullanimtarzi and b.key2=medenidurum and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Medeni Durum'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Çocuk Değişkeni' and b.key1=kullanimtarzi and b.key2=cocukdegiskeni and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Çocuk Değişkeni'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Kısmi Hasar Sayısı' and b.key1=kullanimtarzi and b.key2=kismiHasarSayisi and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kısmi Hasar Sayısı'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Sigortalılık Süresi' and b.key1=kullanimtarzi and b.key2<=sigortaliliksuresi and b.key3>=sigortaliliksuresi and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Sigortalılık Süresi'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Cinsiyet' and b.key1=kullanimtarzi and b.key2=cinsiyet and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Cinsiyet'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Kullanım Tarzı' and b.key1=kullanimtarzi and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kullanım Tarzı'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Hasarsızlık İndirimi' and b.key1=kullanimtarzi and b.key2=hasarsizlikkademesi and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Hasarsızlık İndirimi'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Marka Risk Grubu' and b.key1=kullanimtarzi and b.key2=markariskgrubu and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Marka Risk Grubu'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Cam Hasar Sayısı' and b.key1=kullanimtarzi and b.key2=camhasarsayisi and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Cam Hasar Sayısı'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Kasko Yenileme Faktör' and b.key1=markariskgrubu and b.key2=aracyasi and b.key3=hasarsizlikkademesi and b.key4=kullanimtarzi and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kasko Yenileme Faktör'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Kasko Yenileme İl' and b.key1=plakailkodu and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kasko Yenileme İl'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Paket' and b.key1=pakettipi and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Paket'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Yenileme Araç Bedeli' and b.key1=kullanimtarzi and b.key2<=CAST(aracbedeli AS DECIMAL(11,5))/(select bn.desc1 from pricing_parameters bn where bn.param_name='Yenileme Araç Bedeli' and key1=aracyasi and bn.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Yenileme Araç Bedeli'  and valid_date is not null)) and b.key3>=CAST(aracbedeli AS DECIMAL(11,5))/(select bn.desc1 from pricing_parameters bn where bn.param_name='Yenileme Araç Bedeli' and key1=aracyasi and bn.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Yenileme Araç Bedeli'  and valid_date is not null)) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Yenileme Araç Bedeli'  and valid_date is not null)
    union all

    select 'Yenileme Cam İndirimi',cast(nvl(yenilemecamindirimi,0) as decimal(11,5)), cast(nvl(yenilemecamindirimi,0) as decimal(11,5)), cast(nvl(yenilemecamindirimi,0) as decimal(11,5)), cast(nvl(yenilemecamindirimi,0) as decimal(11,5)), cast(nvl(yenilemecamindirimi,0) as decimal(11,5)), cast(nvl(yenilemecamindirimi,0) as decimal(11,5)) from dual
    union all
    select bn.param_name,cast(bn.desc1 as decimal(11,5)),cast(bn.desc1 as decimal(11,5)),cast(bn.desc1 as decimal(11,5)),cast(bn.desc1 as decimal(11,5)),cast(bn.desc1 as decimal(11,5)),cast(bn.desc1 as decimal(11,5)) from pricing_parameters bn where bn.param_name='Güncel Bedel' and key1=guncelbedel and bn.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Güncel Bedel'  and valid_date is not null)
    union all
    select 'SigortalıSkor',cast(nvl(sigortaliskor,0) as decimal(11,5)), cast(nvl(sigortaliskor,0) as decimal(11,5)), cast(nvl(sigortaliskor,0) as decimal(11,5)), cast(nvl(sigortaliskor,0) as decimal(11,5)), cast(nvl(sigortaliskor,0) as decimal(11,5)), cast(nvl(sigortaliskor,0) as decimal(11,5)) from dual
    union all
    select 'Araç Skor',cast(nvl(aracskor,0) as decimal(11,5)), cast(nvl(aracskor,0) as decimal(11,5)), cast(nvl(aracskor,0) as decimal(11,5)), cast(nvl(aracskor,0) as decimal(11,5)), cast(nvl(aracskor,0) as decimal(11,5)), cast(nvl(aracskor,0) as decimal(11,5)) from dual
    union all
    select 'Özel İndirim',1-(ozelindirim/100), 1-(ozelindirim/100), 1-(ozelindirim/100), 1-(ozelindirim/100), 1-(ozelindirim/100), 1-(ozelindirim/100) from dual
    union all
    select 'Sürprim',1-(surprim/100), 1-(surprim/100), 1-(surprim/100), 1-(surprim/100), 1-(surprim/100), 1-(surprim/100) from dual
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Kullanım Tipi' and b.key1=kullanimtarzi and b.key2=kullanimtipi and b.key3=markariskgrubu and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kullanım Tipi'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Yurt Dışı' and b.key1<=yurtdisiay and b.key2>=yurtdisiay and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Yurt Dışı'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where kullanimtarzi='1' and kullanimtipi='2' and b.table_code='Ticari Faktör' and b.key1=markakodu and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Ticari Faktör'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Kasa Tipi' and b.key1=kullanimtarzi and b.key2=(select bn.desc1 from pricing_parameters bn where bn.param_name='Kasa Tipi' and key1=markakodu and bn.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Kasa Tipi'  and valid_date is not null)) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kasa Tipi'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='WHP' and b.key1=kullanimtarzi and b.key2=(select bn.desc1 from pricing_parameters bn where bn.param_name='WHP' and key1=markakodu and bn.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='WHP'  and valid_date is not null)) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='WHP'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Segment' and b.key1=kullanimtarzi and b.key2=(select bn.desc1 from pricing_parameters bn where bn.param_name='Segment' and key1=markakodu and bn.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Segment'  and valid_date is not null)) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Segment'  and valid_date is not null)
    union all
    select b.table_code,b.mult1, b.mult2, b.mult3, b.mult4, b.mult5, b.mult6 from pricing_tables b where b.table_code='Kıymet Kazanma' and b.key1=kullanimtarzi and b.key2=(select bn.desc1 from pricing_parameters bn where bn.param_name='Kıymet Kazanma' and key1=to_char(sysdate,'YYYY')-aracyasi and bn.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Kıymet Kazanma'  and valid_date is not null)) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kıymet Kazanma'  and valid_date is not null)*/

SELECT b.param_name TABLE_CODE, cast(b.desc1 as decimal(11,5)) MULT1, cast(b.desc1 as decimal(11,5)) MULT2, cast(b.desc1 as decimal(11,5)) MULT3, cast(b.desc1 as decimal(11,5)) MULT4, cast(b.desc1 as decimal(11,5)) MULT5, cast(b.desc1 as decimal(11,5)) MULT6 FROM pricing_parameters b WHERE b.param_name='Güncel Bedel' AND key1='Yok' and b.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Güncel Bedel' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='AracYaşı' AND key1='Otomobil' AND key2=Cast('1' as NUMBER) AND key3='14' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='AracYaşı' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Bedel Aralığı' AND key1=Cast('1' as NUMBER) AND key2<=Cast('30000' as NUMBER) AND key3>=Cast('30000' as NUMBER) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Bedel Aralığı' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Cam Hasar Sayısı' AND key1=Cast('1' as NUMBER) AND key2='0' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Cam Hasar Sayısı' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Cinsiyet' AND key1=Cast('1' as NUMBER) AND key2='Kadın' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Cinsiyet' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Çocuk Değişkeni' AND key1=Cast('1' as NUMBER) AND key2='NNNN' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Çocuk Değişkeni' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Hasarsızlık İndirimi' AND key1=Cast('1' as NUMBER) AND key2='0' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Hasarsızlık İndirimi' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='İlFaktörleri' AND key1='Otomobil' AND key2=Cast('1' as NUMBER) AND key3=Cast('33' as NUMBER) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='İlFaktörleri' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Kasa Tipi' AND key1=Cast('1' as NUMBER) AND key2=(select g.desc1 from pricing_parameters g where g.param_name='Kasa Tipi' and g.key1='123194' and g.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Kasa Tipi'  and valid_date is not null)) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kasa Tipi' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Kasko Yenileme Faktör' AND key1='2' AND key2='14' AND key3='0' AND key4=Cast('1' as NUMBER) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kasko Yenileme Faktör' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Kasko Yenileme İl' AND key1=Cast('33' as NUMBER) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kasko Yenileme İl' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Kısmi Hasar Sayısı' AND key1=Cast('1' as NUMBER) AND key2='0' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kısmi Hasar Sayısı' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Kıymet Kazanma' AND key1=Cast('1' as NUMBER) AND key2=(select g.desc1 from pricing_parameters g where g.param_name='Kıymet Kazanma' and g.key1='14' and g.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Kıymet Kazanma'  and valid_date is not null)) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kıymet Kazanma' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Kullanım Tarzı' AND key1=Cast('1' as NUMBER) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kullanım Tarzı' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Kullanım Tipi' AND key1=Cast('1' as NUMBER) AND key2=Cast('2' as NUMBER) AND key3='2' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Kullanım Tipi' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Marka Risk Grubu' AND key1=Cast('1' as NUMBER) AND key2='2' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Marka Risk Grubu' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Medeni Durum' AND key1=Cast('1' as NUMBER) AND key2='0' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Medeni Durum' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Paket' AND key1='Genisletilmis Kasko' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Paket' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Segment' AND key1=Cast('1' as NUMBER) AND key2=(select g.desc1 from pricing_parameters g where g.param_name='Segment' and g.key1='123194' and g.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='Segment'  and valid_date is not null)) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Segment' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Sigortalı Yaş' AND key1=Cast('1' as NUMBER) AND key2='35' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Sigortalı Yaş' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Sigortalılık Süresi' AND key1=Cast('1' as NUMBER) AND key2<='2' AND key3>'2' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Sigortalılık Süresi' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Ticari Faktör' AND key1='123194' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Ticari Faktör' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Tramerİlçe' AND key1='34001' AND key2=Cast('1' as NUMBER) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Tramerİlçe' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='WHP' AND key1=Cast('1' as NUMBER) AND key2=(select g.desc1 from pricing_parameters g where g.param_name='WHP' and g.key1='123194' and g.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='WHP'  and valid_date is not null)) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='WHP' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Yakıt Türü' AND key1=Cast('1' as NUMBER) AND key2='2' and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Yakıt Türü' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Yenileme-Yeniiş' AND key1='04' AND key2=Cast('1' as NUMBER) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Yenileme-Yeniiş' and valid_date is not null)
UNION ALL SELECT b.TABLE_CODE, b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6 FROM pricing_tables b WHERE b.table_code='Yurt Dışı' AND key1<=Cast('0' as NUMBER) AND key2>=Cast('0' as NUMBER) and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='Yurt Dışı' and valid_date is not null)
  )

          LOOP
          PIPE ROW(tariff_result(satir.table_code, satir.mult1, satir.mult2, satir.mult3, satir.mult4, satir.mult5, satir.mult6 ));
          END LOOP;
          RETURN;
          END;

    FUNCTION getVariableDetail
    (varIable varchar2,kullanImseklI varchar2,kullanImtarzI varchar2,aracyasI varchar2,plakaIlkodu varchar2,tramerIl varchar2,tramerIlce varchar2,yenIlemeyenIIskod varchar2,sIgortalIyas varchar2,aracbedelI varchar2,yakIttIpI varchar2,medenIdurum varchar2,cocukdegIskenI varchar2,kIsmIHasarSayIsI varchar2,sIgortalılıksuresI varchar2,cInsIyet varchar2,kaskoHasarsIzlIkkademesI varchar2,markarIskgrubu varchar2,camhasarsayIsI varchar2,pakettIpI varchar2,yenIlemecamIndIrImI varchar2,fIlosegment varchar2,guncelbedel varchar2,sIgortalIskor varchar2,aracskor varchar2,surprIm varchar2,ozelIndIrIm varchar2,kullanImtIpI varchar2,yurtdIsIay varchar2,markakodu varchar2,yeniaracbedel varchar2, meslek varchar2, markatipkodu varchar2, trafikkademesi varchar2, commercialScore varchar2, kiymetKazanma varchar2, ilkAracYasi varchar2, plaka100502 varchar2, ozelTuzel varchar2, ticariFaktor varchar2, P_WHP VARCHAR2, p_aracsegment varchar2, p_kasaTipi varchar2,cammuafiyetIstisnasi varchar2, p_cocukSayisi varchar2, p_hasarSayisi varchar2, oncekiTrafikKademesi varchar2,hatliMi varchar2, gecikmeSurprimi varchar2, yenilemeYili varchar2, trfFrekans varchar2,p_trafikKayitliAracSayisi NUMBER, p_aracSayisiKimlik NUMBER,p_yasayanOtoUrun varchar2,p_teenCocuk varchar2,p_ErkekTeenCocuk varchar2,p_pertarac varchar2, productNoo varchar2, p_aracyerliyabanci varchar2, p_garaj varchar2, p_resmidaire varchar2, p_servis varchar2, p_muafiyet varchar2, p_anlasmaliServis varchar2, p_parcaTuru varchar2, p_servisTuru varchar2, p_surucuInd varchar2, channel varchar2, araccoklugu varchar2, acenteCarpan varchar2, aracYasGrubu varchar2, kontrol1 varchar2, kontrol2 varchar2, kontrol3 varchar2, kontrol4 varchar2, s8000 varchar2, s8060 varchar2, kontrol5 varchar2, eurocar_segment varchar2, eurocar_kasatipi varchar2, eurocar_sanziman varchar2, NBRENEWAL2 varchar2, markaTipGrup varchar2, ililcegrup varchar2, birYilOncekiHasar varchar2, ikiYilOncekiHasar varchar2, ucYilOncekiHasar varchar2, p_aracBedelGrubu varchar2,  p_ortalamaHasarTutar1 varchar2,p_ortalamaHasarTutar2 varchar2,p_ortalamaHasarTutar3 varchar2, p_sonUcYilHasarSayisi varchar2, p_bifurcationSegment varchar2, p_bifurcationSubSegment varchar2)
    RETURN VARCHAR2
    IS
        var1 varchar2(100);
    BEGIN
                if upper(varIable)='KULLANIMSEKLI' THEN var1 := kullanImseklI;
                elsif upper(varIable)='KULLANIMTARZI' THEN var1 := kullanImtarzI;
                elsif upper(varIable)='ARACYASI' THEN var1 := aracyasI;
                elsif upper(varIable)='PLAKAILKODU' THEN var1 := plakaIlkodu;
                elsif upper(varIable)='TRAMERIL' THEN var1 := tramerIl;
                elsif upper(varIable)='TRAMERILCE' THEN var1 := tramerIlce;
                elsif upper(varIable)='YENILEMEYENIISKOD' THEN var1 := yenIlemeyenIIskod;
                elsif upper(varIable)='SIGORTALIYAS' THEN var1 := sIgortalIyas;
                elsif upper(varIable)='ARACBEDELI' THEN var1 := aracbedelI;
                elsif upper(varIable)='YAKITTIPI' THEN var1 := yakIttIpI;
                elsif upper(varIable)='MEDENIDURUM' THEN var1 := medenIdurum;
                elsif upper(varIable)='COCUKDEGISKENI' THEN var1 := cocukdegIskenI;
                elsif upper(varIable)='KISMIHASARSAYISI' THEN var1 := kIsmIHasarSayIsI;
                elsif upper(varIable)='SIGORTALILIKSÜRESI' THEN var1 := sIgortalılıksuresI;
                elsif upper(varIable)='CINSIYET' THEN var1 := cInsIyet;
                elsif upper(varIable)='KASKOHASARSIZLIKKADEMESI' THEN var1 := kaskoHasarsIzlIkkademesI;
                elsif upper(varIable)='MARKARISKGRUBU' THEN var1 := markarIskgrubu;
                elsif upper(varIable)='CAMHASARSAYISI' THEN var1 := camhasarsayIsI;
                elsif upper(varIable)='PAKETTIPI' THEN var1 := pakettIpI;
                elsif upper(varIable)='YENILEMECAMINDIRIMI' THEN var1 := yenIlemecamIndIrImI;
                elsif upper(varIable)='FILOSEGMENT' THEN var1 := fIlosegment;
                elsif upper(varIable)='GUNCELBEDEL' THEN var1 := guncelbedel;
                elsif upper(varIable)='SIGORTALISKOR' THEN var1 := sIgortalIskor;
                elsif upper(varIable)='ARACSKOR' THEN var1 := aracskor;
                elsif upper(varIable)='SURPRIM' THEN var1 := surprIm;
                elsif upper(varIable)='OZELINDIRIM' THEN var1 := ozelIndIrIm;
                elsif upper(varIable)='KULLANIMTIPI' THEN var1 := kullanImtIpI;
                elsif upper(varIable)='YURTDISIAY' THEN var1 := yurtdIsIay;
                elsif upper(varIable)='MARKAKODU' THEN var1 := markakodu;
                elsif upper(varIable)='YENIARACBEDEL' THEN var1 := yeniaracbedel;
                elsif upper(varIable)='MESLEK' THEN var1 := meslek;
                elsif upper(varIable)='MARKATIPKODU' THEN var1 := markatipkodu;
                elsif upper(varIable)='TRAFIKKADEMESI' THEN var1 := trafikkademesi;
                elsif upper(varIable)='COMMERCIALSCORE' THEN var1 := commercialScore;
                elsif upper(varIable)='KIYMETKAZANMA' THEN var1 := kiymetKazanma;
                elsif upper(varIable)='ILKARACYASI' THEN var1 := ilkAracYasi;
                elsif upper(varIable)='PLAKA100502' THEN var1 := plaka100502;
                elsif upper(varIable)='OZELTUZEL' THEN var1 := ozelTuzel;
                elsif upper(varIable)='TICARIFAKTOR' THEN var1 := ticariFaktor;
                ELSIF UPPER(varIable)='WHP' THEN var1 := P_WHP;
                ELSIF UPPER(varIable)='ARACSEGMENT' THEN var1 := p_aracsegment;
                ELSIF UPPER(varIable)='KASATIPI' THEN var1 := p_kasaTipi;
                ELSIF UPPER(varIable)='CAMMUAFIYETISTISNASI' THEN var1 := cammuafiyetIstisnasi;
                ELSIF UPPER(varIable)='COCUKSAYISI' THEN var1 := p_cocukSayisi;
                ELSIF UPPER(varIable)='HASARSAYISI' THEN var1 := p_hasarSayisi;
                ELSIF UPPER(varIable)='ONCEKITRAFIKKADEMESI' THEN var1 := oncekiTrafikKademesi;
                ELSIF UPPER(varIable)='HATLIMI' THEN var1 := hatliMi;
                ELSIF UPPER(varIable)='GECIKMESURPRIMI' THEN var1 := gecikmeSurprimi;
                ELSIF UPPER(varIable)='YENILEMEYILI' THEN var1 := yenilemeYili;
                ELSIF UPPER(varIable)='TRFFREKANS' THEN var1 := trfFrekans;
                ELSIF UPPER(varIable)='TRAFIKKAYITLIARACSAYISI' THEN var1 := p_trafikKayitliAracSayisi;
                ELSIF UPPER(varIable)='ARACSAYISIKIMLIK' THEN var1 := p_aracSayisiKimlik;
                ELSIF UPPER(varIable)='YASAYANOTOURUN' THEN var1 := p_yasayanOtoUrun;
                ELSIF UPPER(varIable)='TEENAGERCOCUK' THEN var1 := p_teenCocuk;
                ELSIF UPPER(varIable)='ERKEKTEENAGERCOCUK' THEN var1 := p_ErkekTeenCocuk;
                ELSIF UPPER(varIable)='PERTHASAR' THEN var1 := p_pertarac;
                ELSIF UPPER(varIable)='URUNKODU' THEN var1 := productNoo;
                ELSIF UPPER(varIable)='ARACYERLIYABANCI' THEN var1 := p_aracyerliyabanci;
                ELSIF UPPER(varIable)='GARAJ' THEN var1 := p_garaj;
                ELSIF UPPER(varIable)='RESMIDAIRE' THEN var1 := p_resmidaire;
                ELSIF UPPER(varIable)='SERVIS' THEN var1 := p_servis;
                ELSIF UPPER(varIable)='MUAFIYET' THEN var1 := p_muafiyet;
                ELSIF UPPER(varIable)='ANLASMALISERVIS' THEN var1 := p_anlasmaliServis;
                ELSIF UPPER(varIable)='PARCATURU' THEN var1 := p_parcaTuru;
                ELSIF UPPER(varIable)='SERVISTURU' THEN var1 := p_servisTuru;
                ELSIF UPPER(varIable)='SURUCU' THEN var1 := p_surucuInd;
                ELSIF UPPER(varIable)='ACENTE' THEN var1 := channel;
                ELSIF UPPER(varIable)='ARACCOKLUGU' THEN var1 := araccoklugu;
                ELSIF UPPER(varIable)='ACENTECARPAN' THEN var1 := acenteCarpan;
                ELSIF UPPER(varIable)='ARACYASGRUBU' THEN var1 := aracYasGrubu;
                ELSIF UPPER(varIable)='KONTROL1' THEN var1 := kontrol1;
                ELSIF UPPER(varIable)='KONTROL2' THEN var1 := kontrol2;
                ELSIF UPPER(varIable)='KONTROL3' THEN var1 := kontrol3;
                ELSIF UPPER(varIable)='KONTROL4' THEN var1 := kontrol4;
                ELSIF UPPER(varIable)='S8000' THEN var1 := s8000;
                ELSIF UPPER(varIable)='S8060' THEN var1 := s8060;
                ELSIF UPPER(varIable)='KONTROL5' THEN var1 := kontrol5;
                ELSIF UPPER(varIable)='EUROCARSEGMENT' THEN var1 := eurocar_segment;
                ELSIF UPPER(varIable)='EUROCARKASATIPI' THEN var1 := eurocar_kasatipi;
                ELSIF UPPER(varIable)='EUROCARSANZIMAN' THEN var1 := eurocar_sanziman;
                ELSIF UPPER(varIable)='NBRENEWAL2' THEN var1 := NBRENEWAL2;
                ELSIF UPPER(varIable)='MARKATIPGRUP' THEN var1 := markaTipGrup;
                ELSIF UPPER(varIable)='ILILCEGRUP' THEN var1 := ililcegrup;
                ELSIF UPPER(varIable)='BIRYILONCEKIHASAR' THEN var1 := birYilOncekiHasar;
                ELSIF UPPER(varIable)='IKIYILONCEKIHASAR' THEN var1 := ikiYilOncekiHasar;
                ELSIF UPPER(varIable)='UCYILONCEKIHASAR' THEN var1 := ucYilOncekiHasar;
                ELSIF UPPER(varIable)='ARACBEDELGRUBU' THEN var1 := p_aracBedelGrubu;
                ELSIF UPPER(varIable)='BIRYILONCEKIORTALAMAHASAR' THEN var1 := p_ortalamaHasarTutar1;
                ELSIF UPPER(varIable)='IKIYILONCEKIORTALAMAHASAR' THEN var1 := p_ortalamaHasarTutar2;
                ELSIF UPPER(varIable)='UCYILONCEKIORTALAMAHASAR' THEN var1 := p_ortalamaHasarTutar3;
                ELSIF UPPER(varIable)='SONUCYILHASARSAYISI' THEN var1 := p_sonUcYilHasarSayisi;
                ELSIF UPPER(varIable)='BIFURCATIONSEGMENT' THEN var1 := p_bifurcationSegment;
                ELSIF UPPER(varIable)='BIFURCATIONSUBSEGMENT' THEN var1 := p_bifurcationSubSegment;
            end if;
    RETURN var1;
END;

    FUNCTION getactivefactorsql1
   (priceId number, productNoo varchar2, TariffDate IN date,kullanimsekli varchar2, kullanimtarzi varchar2, aracyasi varchar2, plakailkodu varchar2, tramerIl varchar2, tramerilce varchar2, yenilemeyeniiskod varchar2, sigortaliyas varchar2, aracbedeli varchar2, yakittipi varchar2, medenidurum varchar2, cocukdegiskeni varchar2, kismiHasarSayisi varchar2, sigortaliliksuresi varchar2, cinsiyet varchar2, hasarsizlikkademesi varchar2, markariskgrubu varchar2, camhasarsayisi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, filosegment varchar2, guncelbedel varchar2, sigortaliskor number, aracskor varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, markakodu varchar2, yeniaracbedel number, meslek varchar2, markatipkodu varchar2, trafikkademesi varchar2, commercialScore varchar2, kiymetKazanma varchar2, ilkAracYasi VARCHAR2, plaka100502 VARCHAR2, ozelTuzel varchar2, ticariFaktor varchar2, P_WHP VARCHAR2, p_aracSegment varchar2, p_kasaTipi varchar2, camMuafiyetIstisnasi varchar2, p_cocukSayisi varchar2, p_hasarSayisi varchar2, oncekiTrafikKademesi varchar2,hatliMi varchar2, gecikmeSurprimi varchar2, yenilemeYili varchar2, trfFrekans varchar2, p_trafikKayitliAracSayisi NUMBER, p_aracSayisiKimlik NUMBER,p_yasayanOtoUrun varchar2,p_teenCocuk varchar2,p_ErkekTeenCocuk varchar2,p_pertarac varchar2,p_aracyerliyabanci varchar2, p_garaj varchar2, p_resmidaire varchar2, p_servis varchar2, p_muafiyet varchar2, p_anlasmaliServis varchar2, p_parcaTuru varchar2, p_servisTuru varchar2, p_surucuInd varchar2, channel varchar2, araccoklugu varchar2, acenteCarpan varchar2, aracyasgrubu varchar2, kontrol1 varchar2, kontrol2 varchar2, kontrol3 varchar2, kontrol4 varchar2, s8000 varchar2, s8060 varchar2, kontrol5 varchar2, eurocar_segment varchar2, eurocar_kasatipi varchar2, eurocar_sanziman varchar2, NBRENEWAL2 varchar2, markaTipGrup varchar2, ililcegrup varchar2, birYilOncekiHasar varchar2, ikiYilOncekiHasar varchar2, ucYilOncekiHasar varchar2, p_aracBedelGrubu varchar2, p_ortalamaHasarTutar1 varchar2,p_ortalamaHasarTutar2 varchar2,p_ortalamaHasarTutar3 varchar2, p_sonUcYilHasarSayisi varchar2, p_bifurcationSegment varchar2, p_bifurcationSubSegment varchar2)
   RETURN CLOB
IS
   OldFactorName varchar2(30);
   var1 varchar2(100);
   var2 varchar2(100);
   var3 varchar2(100);
   var4 varchar2(100);
   var5 varchar2(100);
   var6 varchar2(100);
   var7 varchar2(100);
   var8 varchar2(100);
   var9 varchar2(100);
   var11 varchar2(100);
   var12 varchar2(100);
   var21 varchar2(100);
   var22 varchar2(100);
   var31 varchar2(100);
   var32 varchar2(100);
   var41 varchar2(100);
   var42 varchar2(100);
   var51 varchar2(100);
   var52 varchar2(100);
   var61 varchar2(100);
   var62 varchar2(100);
   var71 varchar2(100);
   var72 varchar2(100);
   var81 varchar2(100);
   var82 varchar2(100);
   var91 varchar2(100);
   var92 varchar2(100);

   tarSelectVal varchar2(300);
   tarTableVal varchar2(50);
   tarCondVal varchar2(50);
   f_sql CLOB;

   cursor c1 is
   SELECT x.factorType, x.factorName, x.TableName, x.startdate, x.OrderType, x.condition1, x.variable1, operator1, datatype1,ParameterName1,TargetValue1,ParameterOrderType1,ParameterColumnName11,ParameterVariable11,ParameterOperator11,ParameterColumnName12,ParameterVariable12,ParameterOperator12,
        x.condition2, x.variable2, operator2, datatype2, ParameterName2,TargetValue2,ParameterOrderType2,ParameterColumnName21,ParameterVariable21,ParameterOperator21,ParameterColumnName22,ParameterVariable22,ParameterOperator22,
        x.condition3, x.variable3, operator3, datatype3,ParameterName3,TargetValue3,ParameterOrderType3,ParameterColumnName31,ParameterVariable31,ParameterOperator31,ParameterColumnName32,ParameterVariable32,ParameterOperator32,
        x.condition4, x.variable4, operator4, datatype4,ParameterName4,TargetValue4,ParameterOrderType4,ParameterColumnName41,ParameterVariable41,ParameterOperator41,ParameterColumnName42,ParameterVariable42,ParameterOperator42,
        x.condition5, x.variable5, operator5, datatype5,ParameterName5,TargetValue5,ParameterOrderType5,ParameterColumnName51,ParameterVariable51,ParameterOperator51,ParameterColumnName52,ParameterVariable52,ParameterOperator52,
        x.condition6, x.variable6, operator6, datatype6,ParameterName6,TargetValue6,ParameterOrderType6,ParameterColumnName61,ParameterVariable61,ParameterOperator61,ParameterColumnName62,ParameterVariable62,ParameterOperator62,
        x.condition7, x.variable7, operator7, datatype7,ParameterName7,TargetValue7,ParameterOrderType7,ParameterColumnName71,ParameterVariable71,ParameterOperator71,ParameterColumnName72,ParameterVariable72,ParameterOperator72,
        x.condition8, x.variable8, operator8, datatype8,ParameterName8,TargetValue8,ParameterOrderType8,ParameterColumnName81,ParameterVariable81,ParameterOperator81,ParameterColumnName82,ParameterVariable82,ParameterOperator82,
        x.condition9, x.variable9, operator9, datatype9,ParameterName9,TargetValue9,ParameterOrderType9,ParameterColumnName91,ParameterVariable91,ParameterOperator91,ParameterColumnName92,ParameterVariable92,ParameterOperator92
    FROM (select xmltype(t.factorxml) data from tarife_1 t where t.productNo=productNoo and t.startdate=(select max(t1.startdate) from tarife_1 t1 where t1.startdate<=TariffDate and t1.productNo=productNoo)) t,
    XMLTABLE ('/Tariff/Factor'      PASSING t.data
            COLUMNS FactorType VARCHAR2(30) PATH 'FactorType',
            FactorName VARCHAR2(30) PATH 'FactorName',
            TableName VARCHAR2(30)  PATH 'TableName',
            StartDate VARCHAR2(30) PATH 'StartDate',
            OrderType VARCHAR2(30) PATH 'OrderType',
            Condition1 VARCHAR2(30) PATH 'Condition[1]/ColumnName',
            Variable1 VARCHAR2(30) PATH 'Condition[1]/Variable',
            Operator1 VARCHAR2(30) PATH 'Condition[1]/Operator',
            DataType1 VARCHAR2(30) PATH 'Condition[1]/DataType',
            ParameterName1 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterName',
            TargetValue1 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/TargetValue',
            ParameterOrderType1 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/OrderType',
            ParameterColumnName11 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[1]/ColumnName',
            ParameterVariable11 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[1]/Variable',
            ParameterOperator11 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[1]/Operator',
            ParameterColumnName12 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[2]/ColumnName',
            ParameterVariable12 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[2]/Variable',
            ParameterOperator12 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[2]/Operator',

            Condition2 VARCHAR2(30) PATH 'Condition[2]/ColumnName',
            Variable2 VARCHAR2(30) PATH 'Condition[2]/Variable',
            Operator2 VARCHAR2(30) PATH 'Condition[2]/Operator',
            DataType2 VARCHAR2(30) PATH 'Condition[2]/DataType',
            ParameterName2 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterName',
            TargetValue2 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/TargetValue',
            ParameterOrderType2 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/OrderType',
            ParameterColumnName21 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[1]/ColumnName',
            ParameterVariable21 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[1]/Variable',
            ParameterOperator21 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[1]/Operator',
            ParameterColumnName22 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[2]/ColumnName',
            ParameterVariable22 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[2]/Variable',
            ParameterOperator22 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[2]/Operator',

            Condition3 VARCHAR2(30) PATH 'Condition[3]/ColumnName',
            Variable3 VARCHAR2(30) PATH 'Condition[3]/Variable',
            Operator3 VARCHAR2(30) PATH 'Condition[3]/Operator',
            DataType3 VARCHAR2(30) PATH 'Condition[3]/DataType',
            ParameterName3 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterName',
            TargetValue3 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/TargetValue',
            ParameterOrderType3 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/OrderType',
            ParameterColumnName31 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[1]/ColumnName',
            ParameterVariable31 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[1]/Variable',
            ParameterOperator31 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[1]/Operator',
            ParameterColumnName32 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[2]/ColumnName',
            ParameterVariable32 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[2]/Variable',
            ParameterOperator32 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[2]/Operator',

            Condition4 VARCHAR2(30) PATH 'Condition[4]/ColumnName',
            Variable4 VARCHAR2(30) PATH 'Condition[4]/Variable',
            Operator4 VARCHAR2(30) PATH 'Condition[4]/Operator',
            DataType4 VARCHAR2(30) PATH 'Condition[4]/DataType',
            ParameterName4 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterName',
            TargetValue4 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/TargetValue',
            ParameterOrderType4 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/OrderType',
            ParameterColumnName41 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[1]/ColumnName',
            ParameterVariable41 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[1]/Variable',
            ParameterOperator41 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[1]/Operator',
            ParameterColumnName42 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[2]/ColumnName',
            ParameterVariable42 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[2]/Variable',
            ParameterOperator42 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[2]/Operator',

            Condition5 VARCHAR2(30) PATH 'Condition[5]/ColumnName',
            Variable5 VARCHAR2(30) PATH 'Condition[5]/Variable',
            Operator5 VARCHAR2(30) PATH 'Condition[5]/Operator',
            DataType5 VARCHAR2(30) PATH 'Condition[5]/DataType',
            ParameterName5 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterName',
            TargetValue5 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/TargetValue',
            ParameterOrderType5 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/OrderType',
            ParameterColumnName51 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[1]/ColumnName',
            ParameterVariable51 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[1]/Variable',
            ParameterOperator51 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[1]/Operator',
            ParameterColumnName52 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[2]/ColumnName',
            ParameterVariable52 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[2]/Variable',
            ParameterOperator52 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[2]/Operator',

            Condition6 VARCHAR2(30) PATH 'Condition[6]/ColumnName',
            Variable6 VARCHAR2(30) PATH 'Condition[6]/Variable',
            Operator6 VARCHAR2(30) PATH 'Condition[6]/Operator',
            DataType6 VARCHAR2(30) PATH 'Condition[6]/DataType',
            ParameterName6 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterName',
            TargetValue6 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/TargetValue',
            ParameterOrderType6 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/OrderType',
            ParameterColumnName61 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[1]/ColumnName',
            ParameterVariable61 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[1]/Variable',
            ParameterOperator61 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[1]/Operator',
            ParameterColumnName62 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[2]/ColumnName',
            ParameterVariable62 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[2]/Variable',
            ParameterOperator62 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[2]/Operator',

            Condition7 VARCHAR2(30) PATH 'Condition[7]/ColumnName',
            Variable7 VARCHAR2(30) PATH 'Condition[7]/Variable',
            Operator7 VARCHAR2(30) PATH 'Condition[7]/Operator',
            DataType7 VARCHAR2(30) PATH 'Condition[7]/DataType',
            ParameterName7 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterName',
            TargetValue7 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/TargetValue',
            ParameterOrderType7 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/OrderType',
            ParameterColumnName71 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[1]/ColumnName',
            ParameterVariable71 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[1]/Variable',
            ParameterOperator71 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[1]/Operator',
            ParameterColumnName72 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[2]/ColumnName',
            ParameterVariable72 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[2]/Variable',
            ParameterOperator72 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[2]/Operator',

            Condition8 VARCHAR2(30) PATH 'Condition[8]/ColumnName',
            Variable8 VARCHAR2(30) PATH 'Condition[8]/Variable',
            Operator8 VARCHAR2(30) PATH 'Condition[8]/Operator',
            DataType8 VARCHAR2(30) PATH 'Condition[8]/DataType',
            ParameterName8 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterName',
            TargetValue8 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/TargetValue',
            ParameterOrderType8 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/OrderType',
            ParameterColumnName81 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[1]/ColumnName',
            ParameterVariable81 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[1]/Variable',
            ParameterOperator81 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[1]/Operator',
            ParameterColumnName82 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[2]/ColumnName',
            ParameterVariable82 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[2]/Variable',
            ParameterOperator82 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[2]/Operator',

            Condition9 VARCHAR2(30) PATH 'Condition[9]/ColumnName',
            Variable9 VARCHAR2(30) PATH 'Condition[9]/Variable',
            Operator9 VARCHAR2(30) PATH 'Condition[9]/Operator',
            DataType9 VARCHAR2(30) PATH 'Condition[9]/DataType',
            ParameterName9 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterName',
            TargetValue9 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/TargetValue',
            ParameterOrderType9 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/OrderType',
            ParameterColumnName91 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[1]/ColumnName',
            ParameterVariable91 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[1]/Variable',
            ParameterOperator91 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[1]/Operator',
            ParameterColumnName92 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[2]/ColumnName',
            ParameterVariable92 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[2]/Variable',
            ParameterOperator92 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[2]/Operator'
            ) x where to_date(x.startdate,'DD/MM/YYYY')<=TariffDate
    order by factortype, factorName, startdate desc;
BEGIN
OldFactorName := '0';
   FOR factor_detail in c1
   LOOP
   var1 := '';
   var2 := '';
   var3 := '';
   var4 := '';
   var5 := '';
   var6 := '';
   var7 := '';
   var8 := '';
   var9 := '';
   var11 := '';
   var12 := '';
   var21 := '';
   var22 := '';
   var31 := '';
   var32 := '';
   var41 := '';
   var42 := '';
   var51 := '';
   var52 := '';
   var61 := '';
   var62 := '';
   var71 := '';
   var72 := '';
   var81 := '';
   var82 := '';
   var91 := '';
   var92 := '';

   if factor_detail.FactorType='TariffTable' OR factor_detail.FactorType='ParameterTable' OR factor_detail.FactorType='Const' THEN
    if factor_detail.FactorType='TariffTable' THEN
        tarSelectVal := 'b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6';
        tarTableVal := 'pricing_tables';
        tarCondVal := 'table_code';
    ELSIF factor_detail.FactorType='ParameterTable' THEN
        tarSelectVal := 'cast(b.desc1 as decimal(11,5)) MULT1, cast(b.desc1 as decimal(11,5)) MULT2, cast(b.desc1 as decimal(11,5)) MULT3, cast(b.desc1 as decimal(11,5)) MULT4, cast(b.desc1 as decimal(11,5)) MULT5, cast(b.desc1 as decimal(11,5)) MULT6';
        tarTableVal := 'pricing_parameters';
        tarCondVal := 'param_name';
    END IF;

    if factor_detail.factorname <> OldFactorName THEN
        var1 := getVariableDetail(factor_detail.varIable1,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var2 := getVariableDetail(factor_detail.varIable2,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor ,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili, trfFrekans ,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var3 := getVariableDetail(factor_detail.varIable3,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor ,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var4 := getVariableDetail(factor_detail.varIable4,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi , camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var5 := getVariableDetail(factor_detail.varIable5,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor ,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var6 := getVariableDetail(factor_detail.varIable6,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var7 := getVariableDetail(factor_detail.varIable7,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var8 := getVariableDetail(factor_detail.varIable8,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var9 := getVariableDetail(factor_detail.varIable9,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var11 := getVariableDetail(factor_detail.ParameterVariable11,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var12 := getVariableDetail(factor_detail.ParameterVariable12,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek , markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var21 := getVariableDetail(factor_detail.ParameterVariable21,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var22 := getVariableDetail(factor_detail.ParameterVariable22,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi , camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var31 := getVariableDetail(factor_detail.ParameterVariable31,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var32 := getVariableDetail(factor_detail.ParameterVariable32,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi , camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var41 := getVariableDetail(factor_detail.ParameterVariable41,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi , camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var42 := getVariableDetail(factor_detail.ParameterVariable42,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi , camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var51 := getVariableDetail(factor_detail.ParameterVariable51,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi , camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var52 := getVariableDetail(factor_detail.ParameterVariable52,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi , camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var61 := getVariableDetail(factor_detail.ParameterVariable61,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var62 := getVariableDetail(factor_detail.ParameterVariable62,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var71 := getVariableDetail(factor_detail.ParameterVariable61,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var72 := getVariableDetail(factor_detail.ParameterVariable62,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var81 := getVariableDetail(factor_detail.ParameterVariable61,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var82 := getVariableDetail(factor_detail.ParameterVariable62,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var91 := getVariableDetail(factor_detail.ParameterVariable61,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
        var92 := getVariableDetail(factor_detail.ParameterVariable62,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl, tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel , meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi ,plaka100502, ozelTuzel, ticariFaktor,P_WHP, p_aracsegment, p_kasaTipi, camMuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracyasgrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);

IF factor_detail.factorname='Özel İndirim' THEN
  var1:=REPLACE(var1,',','.');
END IF;

if factor_detail.FactorType='Const' THEN
    if OldFactorName = '0' then
        f_sql := 'select '||priceid||' priceid, round(exp(sum(ln(nvl(t.mult1,1)))),6) m1, round(exp(sum(ln(nvl(t.mult2,1)))),6) m2, round(exp(sum(ln(nvl(t.mult3,1)))),6) m3, round(exp(sum(ln(nvl(t.mult4,1)))),6) m4, round(exp(sum(ln(nvl(t.mult5,1)))),6) m5, round(exp(sum(ln(nvl(t.mult6,1)))),6) m6, (round(exp(sum(ln(nvl(t.mult1,1)))),6) + round(exp(sum(ln(nvl(t.mult2,1)))),6) + round(exp(sum(ln(nvl(t.mult3,1)))),6) + round(exp(sum(ln(nvl(t.mult4,1)))),6) + round(exp(sum(ln(nvl(t.mult5,1)))),6) + round(exp(sum(ln(nvl(t.mult6,1)))),6))*'||aracbedeli||'/1000 prim from    (';
        f_sql := f_sql || 'SELECT '||var1||' mult1,'||var1||' mult2,'||var1||' mult3,'||var1||' mult4,'||var1||' mult5,'||var1||' mult6 from dual';
    else
        f_sql := f_sql || ' UNION ALL SELECT '||var1||' mult1,'||var1||' mult2,'||var1||' mult3,'||var1||' mult4,'||var1||' mult5,'||var1||' mult6 from dual';
    end if;
ELSE
        if OldFactorName = '0' then
            f_sql := 'select '||priceid||' priceid, round(exp(sum(ln(nvl(t.mult1,1)))),6) m1, round(exp(sum(ln(nvl(t.mult2,1)))),6) m2, round(exp(sum(ln(nvl(t.mult3,1)))),6) m3, round(exp(sum(ln(nvl(t.mult4,1)))),6) m4, round(exp(sum(ln(nvl(t.mult5,1)))),6) m5, round(exp(sum(ln(nvl(t.mult6,1)))),6) m6, (round(exp(sum(ln(nvl(t.mult1,1)))),6) + round(exp(sum(ln(nvl(t.mult2,1)))),6) + round(exp(sum(ln(nvl(t.mult3,1)))),6) + round(exp(sum(ln(nvl(t.mult4,1)))),6) + round(exp(sum(ln(nvl(t.mult5,1)))),6) + round(exp(sum(ln(nvl(t.mult6,1)))),6))*'||aracbedeli||'/1000 prim from    (';
            f_sql := f_sql || 'SELECT ' || tarSelectVal || ' FROM ' || tarTableVal || ' b WHERE b.' || tarCondVal || '=''' || factor_detail.TableName || '''';
            if factor_detail.condition1 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable1,factor_detail.DataType1,factor_detail.Operator1,var1,factor_detail.condition1,factor_detail.targetvalue1,factor_detail.parametername1,factor_detail.parametercolumnname11,factor_detail.parameteroperator11,var11,factor_detail.parametercolumnname12,factor_detail.parameteroperator12,var12);
            END IF;
            if factor_detail.condition2 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable2,factor_detail.DataType2,factor_detail.Operator2,var2,factor_detail.condition2,factor_detail.targetvalue2,factor_detail.parametername2,factor_detail.parametercolumnname21,factor_detail.parameteroperator21,var21,factor_detail.parametercolumnname22,factor_detail.parameteroperator22,var22);
            END IF;
            if factor_detail.condition3 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable3,factor_detail.DataType3,factor_detail.Operator3,var3,factor_detail.condition3,factor_detail.targetvalue3,factor_detail.parametername3,factor_detail.parametercolumnname31,factor_detail.parameteroperator31,var31,factor_detail.parametercolumnname32,factor_detail.parameteroperator32,var32);
            END IF;
            if factor_detail.condition4 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable4,factor_detail.DataType4,factor_detail.Operator4,var4,factor_detail.condition4,factor_detail.targetvalue4,factor_detail.parametername4,factor_detail.parametercolumnname41,factor_detail.parameteroperator41,var41,factor_detail.parametercolumnname42,factor_detail.parameteroperator42,var42);
            END IF;
            if factor_detail.condition5 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable5,factor_detail.DataType5,factor_detail.Operator5,var5,factor_detail.condition5,factor_detail.targetvalue5,factor_detail.parametername5,factor_detail.parametercolumnname51,factor_detail.parameteroperator51,var51,factor_detail.parametercolumnname52,factor_detail.parameteroperator52,var52);
            END IF;
            if factor_detail.condition6 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable6,factor_detail.DataType6,factor_detail.Operator6,var6,factor_detail.condition6,factor_detail.targetvalue6,factor_detail.parametername6,factor_detail.parametercolumnname61,factor_detail.parameteroperator61,var61,factor_detail.parametercolumnname62,factor_detail.parameteroperator62,var62);
            END IF;
            if factor_detail.condition7 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable7,factor_detail.DataType7,factor_detail.Operator7,var7,factor_detail.condition7,factor_detail.targetvalue7,factor_detail.parametername7,factor_detail.parametercolumnname71,factor_detail.parameteroperator71,var71,factor_detail.parametercolumnname72,factor_detail.parameteroperator72,var72);
            END IF;
            if factor_detail.condition8 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable8,factor_detail.DataType8,factor_detail.Operator8,var8,factor_detail.condition8,factor_detail.targetvalue8,factor_detail.parametername8,factor_detail.parametercolumnname81,factor_detail.parameteroperator81,var81,factor_detail.parametercolumnname82,factor_detail.parameteroperator82,var82);
            END IF;
            if factor_detail.condition9 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable9,factor_detail.DataType9,factor_detail.Operator9,var9,factor_detail.condition9,factor_detail.targetvalue9,factor_detail.parametername9,factor_detail.parametercolumnname91,factor_detail.parameteroperator91,var91,factor_detail.parametercolumnname92,factor_detail.parameteroperator92,var92);
            END IF;
        else
            f_sql := f_sql || ' UNION ALL SELECT ' || tarSelectVal || ' FROM ' || tarTableVal || ' b WHERE b.' || tarCondVal || '=''' || factor_detail.TableName || '''';
            if factor_detail.condition1 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable1,factor_detail.DataType1,factor_detail.Operator1,var1,factor_detail.condition1,factor_detail.targetvalue1,factor_detail.parametername1,factor_detail.parametercolumnname11,factor_detail.parameteroperator11,var11,factor_detail.parametercolumnname12,factor_detail.parameteroperator12,var12);
            END IF;
            if factor_detail.condition2 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable2,factor_detail.DataType2,factor_detail.Operator2,var2,factor_detail.condition2,factor_detail.targetvalue2,factor_detail.parametername2,factor_detail.parametercolumnname21,factor_detail.parameteroperator21,var21,factor_detail.parametercolumnname22,factor_detail.parameteroperator22,var22);
            END IF;
            if factor_detail.condition3 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable3,factor_detail.DataType3,factor_detail.Operator3,var3,factor_detail.condition3,factor_detail.targetvalue3,factor_detail.parametername3,factor_detail.parametercolumnname31,factor_detail.parameteroperator31,var31,factor_detail.parametercolumnname32,factor_detail.parameteroperator32,var32);
            END IF;
            if factor_detail.condition4 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable4,factor_detail.DataType4,factor_detail.Operator4,var4,factor_detail.condition4,factor_detail.targetvalue4,factor_detail.parametername4,factor_detail.parametercolumnname41,factor_detail.parameteroperator41,var41,factor_detail.parametercolumnname42,factor_detail.parameteroperator42,var42);
            END IF;
            if factor_detail.condition5 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable5,factor_detail.DataType5,factor_detail.Operator5,var5,factor_detail.condition5,factor_detail.targetvalue5,factor_detail.parametername5,factor_detail.parametercolumnname51,factor_detail.parameteroperator51,var51,factor_detail.parametercolumnname52,factor_detail.parameteroperator52,var52);
            END IF;
            if factor_detail.condition6 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable6,factor_detail.DataType6,factor_detail.Operator6,var6,factor_detail.condition6,factor_detail.targetvalue6,factor_detail.parametername6,factor_detail.parametercolumnname61,factor_detail.parameteroperator61,var61,factor_detail.parametercolumnname62,factor_detail.parameteroperator62,var62);
            END IF;
            if factor_detail.condition7 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable7,factor_detail.DataType7,factor_detail.Operator7,var7,factor_detail.condition7,factor_detail.targetvalue7,factor_detail.parametername7,factor_detail.parametercolumnname71,factor_detail.parameteroperator71,var71,factor_detail.parametercolumnname72,factor_detail.parameteroperator72,var72);
            END IF;
            if factor_detail.condition8 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable8,factor_detail.DataType8,factor_detail.Operator8,var8,factor_detail.condition8,factor_detail.targetvalue8,factor_detail.parametername8,factor_detail.parametercolumnname81,factor_detail.parameteroperator81,var81,factor_detail.parametercolumnname82,factor_detail.parameteroperator82,var82);
            END IF;
            if factor_detail.condition9 is not null THEN
                f_sql := getTariffSqlDetail (f_sql,factor_detail.variable9,factor_detail.DataType9,factor_detail.Operator9,var9,factor_detail.condition9,factor_detail.targetvalue9,factor_detail.parametername9,factor_detail.parametercolumnname91,factor_detail.parameteroperator91,var91,factor_detail.parametercolumnname92,factor_detail.parameteroperator92,var92);
            END IF;
        end if;
      if factor_detail.ordertype='MaxDate' THEN
        f_sql := f_sql || ' and b.valid_date=(select max(a.valid_date) from ' || tarTableVal || ' a where a.' || tarCondVal || '=''' || factor_detail.TableName || ''' and a.valid_date is not null and a.valid_date<=''' || TariffDate || ''')';
      else
        f_sql := f_sql || ' and b.valid_date=(select max(a.valid_date) from ' || tarTableVal || ' a where a.' || tarCondVal || '=''' || factor_detail.TableName || ''' and a.valid_date is not null and a.valid_date<=''' || TariffDate || ''')';
      END IF;
END IF;
      OldFactorName := factor_detail.factorname;
    end if;
   END IF;
   END LOOP;
   f_sql := f_sql || ' ) t';
   RETURN f_sql;
END;

    FUNCTION getCocukDegiskeni (
      value in CLOB,
      teklifBaslangicTarihi in DATE
    )
    RETURN VARCHAR2 AS
     s_CocukDegiskeni VARCHAR2(4);
    BEGIN
    select decode(max(c.aralik1),'Y','Y','N') || decode(max(c.aralik2),'Y','Y','N') || decode(max(c.aralik3),'Y','Y','N') || decode(max(c.aralik4),'Y','Y','N') degisken into s_CocukDegiskeni
    from
    (select case when b.yas<=6 then 'Y' end aralik1,
           case when b.yas>=7 and b.yas<=15 then 'Y' end aralik2,
           case when b.yas>=16 and b.yas<=24 then 'Y' end aralik3,
           case when b.yas>=25 then 'Y' end aralik4
    from
    (SELECT round(cast(cast(to_char(teklifBaslangicTarihi, 'YYYY') as number(4))-cast(to_char(to_date(substr(x.dogumtarihi,1,10),'YYYY-MM-DD'),'YYYY') as number(4)) AS NUMBER),0) yas
        FROM (select xmltype(value) data from dual) t,
        XMLTABLE ('/aileSorgu/kisiBilgisiTypeList/kisiBilgisiType'      PASSING t.data
                COLUMNS yakinlik VARCHAR2(30) PATH 'yakinlik',
                dogumTarihi VARCHAR2(30) PATH 'dogumTarihi'
                ) x where x.yakinlik in('Kızı') or x.yakinlik like 'O%lu') b) c;

        return s_CocukDegiskeni;
    EXCEPTION WHEN OTHERS THEN
        return 'Diğer';
    END getCocukDegiskeni;

    FUNCTION getCocukSayisi (
      value in CLOB,
      teklifBaslangicTarihi in DATE
    )
    RETURN VARCHAR2 AS
     s_CocukDegiskeni VARCHAR2(4);
    BEGIN
    SELECT count(0) into s_CocukDegiskeni
        FROM (select xmltype(value) data from dual) t,
        XMLTABLE ('/aileSorgu/kisiBilgisiTypeList/kisiBilgisiType'      PASSING t.data
                COLUMNS yakinlik VARCHAR2(30) PATH 'yakinlik',
                dogumTarihi VARCHAR2(30) PATH 'dogumTarihi'
                ) x where x.yakinlik in('Kızı') or x.yakinlik like 'O%lu';

        return s_CocukDegiskeni;
    EXCEPTION WHEN OTHERS THEN
        return '0';
    END getCocukSayisi;

    FUNCTION getHasarSayisi (
      value in CLOB
    )
    RETURN NUMBER AS
     s_HasarSayisi NUMBER;
    BEGIN
    SELECT count(0) into s_HasarSayisi
        FROM (select xmltype(value) data from dual) t,
        XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/policeninHasarlari'      PASSING t.data
                COLUMNS hasarDosyaDurumKod VARCHAR2(30) PATH 'hasarDosyaDurumKod'
                ) x where x.hasarDosyaDurumKod in('1','2','5');
/*
Dosya Durum Kodları
1   Açık
2   Kapalı - Ödeme
3   Kapalı - Red
4   Kapalı - İptal
5   Yeniden Açıldı
*/
    if s_HasarSayisi>10 then s_HasarSayisi := 11; end if;
        return s_HasarSayisi;
    EXCEPTION WHEN OTHERS THEN
        return 0;
    END getHasarSayisi;

    FUNCTION getSbmDetails (
      value in CLOB,
      returnType in VARCHAR2
    )
    RETURN CLOB AS
     s_ReturnType CLOB;
    BEGIN
        select substr(value,instr(value,'<'||returnType),instr(value,'</'||returnType)-instr(value,'<'||returnType)+length(returnType)+3) into s_ReturnType from dual;
        return s_ReturnType;
    EXCEPTION WHEN OTHERS THEN
        return '';
    END getSbmDetails;

    FUNCTION removeElement (
      value in VARCHAR2,
      elementName in VARCHAR2
    )
    RETURN VARCHAR2 AS
     s_ReturnType VARCHAR2(100);
    BEGIN
        select replace(replace(value, '<'||elementName||'>'),'</'||elementName||'>') into s_ReturnType from dual;
        return s_ReturnType;
    EXCEPTION WHEN OTHERS THEN
        return '';
    END removeElement;

    FUNCTION getaracskor (value CLOB,p_egmKaydiVarMi in varchar2,yenilemeMi in varchar2,p_HasarslkIndrm VARCHAR2,
    p_PolBasTarh in DATE ,p_TesclTarh in DATE,p_TrafkCksTarh in DATE,p_ModelYl in varchar2,p_Plaka in varchar2,s_PricingId NUMBER)
    RETURN VARCHAR2 AS
    APP varchar2(5);
    AP varchar2(5):='AP9';
    p_PrePolBtsTarh varchar2(10);
    p_errdesc varchar2(100);
    v_PoliceBasFarkTrafigeCikis NUMBER;
    v_BasTescilFark NUMBER;
    v_PolBasFarkPreBts NUMBER;
    v_sigortasizliksuresi NUMBER ;
    v_aracSifirKmMi varchar2(1):='H';
    v_geciciPlakaMi varchar2(1):='H';
    v_yeniSatinAlinmisMi varchar2(1):='H';
    v_surekliSigortaliMi varchar2(1):='H';
    v_asbisRuhsatVarMi varchar2(1):='H';
    v_sigortaKaydiVarMi   varchar2(1):='H';
    v_cnt number;
    c_sigortasizgecensure number:=15;
    c_aracyili number;
    c_ay number;
    v_errm VARCHAR2(4000);
    s_key varchar2(4000);
    p_cache number;
    s_sql CLOB;
    BEGIN
    s_sql := 'select * from table(getTariff.getaracskor(''Sorgu Sonucu CLOB'','''||p_egmKaydiVarMi||''','''||yenilemeMi||''','''||p_PolBasTarh||''','''||p_TesclTarh||''','''||p_TrafkCksTarh||''','''||p_ModelYl||''','''||p_Plaka||''',''PRICE ID''))';

    select count(0) into p_cache from aracskor_detay p where p.systemdate = to_char(sysdate,'DD/MM/YYYY') and cast(p.p_sql as varchar2(1000))=cast(to_char(s_sql) as varchar2(1000));

    if p_cache=0 then

    s_key := p_egmKaydiVarMi||','||yenilemeMi||','||p_HasarslkIndrm||','||p_PolBasTarh||','||p_TesclTarh||','||p_TrafkCksTarh||','||p_ModelYl||','||p_Plaka;
-- update sigortaliskor_test set txt=value where idx=2; commit;

    select to_date(p_PolBasTarh ,'DD.MM.YYYY')-to_date(p_TrafkCksTarh ,'DD.MM.YYYY')    into v_PoliceBasFarkTrafigeCikis from dual;
    select to_date(p_PolBasTarh ,'DD.MM.YYYY') -to_date(p_TesclTarh ,'DD.MM.YYYY')      into v_BasTescilFark from dual;

    SELECT EXTRACT(month FROM SYSDATE) into c_ay from dual;
    c_aracyili:=CAST(SUBSTR(SYSDATE,7,10) AS NUMBER) - cast(p_ModelYl as number);

    IF (p_HasarslkIndrm IS NOT NULL) and (p_HasarslkIndrm<>'0')  then c_sigortasizgecensure:=45;  END IF;

    if  (v_PoliceBasFarkTrafigeCikis <=30) and (c_aracyili=0 or (c_aracyili=1 and c_ay<=4)) then  v_aracSifirKmMi:='E';  END IF;

    if  fncgeciciplaka(p_Plaka)=1 then   v_geciciPlakaMi:='E';   END IF;

    if v_BasTescilFark<=30 then   v_yeniSatinAlinmisMi:='E';  END IF;

 /* if (p_AsbsNo is not null and p_AsbsNo<>'') or (p_TesclBelge is not null and p_TesclBelge<>'') then   v_asbisRuhsatVarMi:='E';  END IF;
    burası değişecek egm sorgusu yapılacak eğer arasın asbno veya tescilbelgo kaydı egm de bulunuyorsa v_asbisRuhsatVarMi değişkeni evet olacak */

      if  p_egmKaydiVarMi IS NOT NULL and  p_egmKaydiVarMi='E' then   v_asbisRuhsatVarMi:='E';  END IF;


    SELECT count(*) into v_cnt
    from (SELECT
       ( case
        when y.iptalmi=1 then y.PrePolZeyilBas_Tarih
        else y.PrePolBitis_Tarih end) as BITISTARIH  ,y.modelYili AS MODELYIL,y.plakaNo AS PLAKANO
        FROM
            (  SELECT
             to_date(substr(x.policebaslamatarihi,1,10),'YYYY-MM-DD') PrePolBaslangic_Tarih,
            to_date(substr(x.policeBitisTarihi,1,10),'YYYY-MM-DD') PrePolBitis_Tarih,
              to_date(substr(x.policeEkiBaslamaTarihi,1,10),'YYYY-MM-DD') PrePolZeyilBas_Tarih,
             x.modelYili,
             x.plakaNo,
             case when x.zeylTuru in(8,9,13,38,43,44) then 1 else 0 end iptalmi,
                  case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi
            FROM (select xmltype(value) data from dual) t,
            XMLTABLE ('/ovmkaskoPoliceBySasiSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType' PASSING t.data
                    COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                    policeBitisTarihi VARCHAR2(30) PATH 'policeBitisTarihi',
                    policeEkiBaslamaTarihi VARCHAR2(30) PATH 'policeEkiBaslamaTarihi',

                    modelYili VARCHAR2(10) PATH 'arac/modelYili' ,
                    plakaNo VARCHAR2(30) PATH 'arac/plakaNo',
                    zeylTuru VARCHAR2(3) PATH 'zeylTuru'
                        ) x
                        ) y where y.PrePolBitis_Tarih <sysdate+30  and (SYSDATE-y.PrePolBaslangic_Tarih)>30  and  y.mebiptalmi=0
                        ORDER BY Y.PrePolBitis_Tarih desc ) ;


    if v_cnt>0
    then
    v_sigortaKaydiVarMi:='E';

     select mas.BITISTARIH into p_PrePolBtsTarh from (SELECT
       ( case
        when y.iptalmi=1 then y.PrePolZeyilBas_Tarih
        else y.PrePolBitis_Tarih end) as BITISTARIH  ,y.modelYili AS MODELYIL,y.plakaNo AS PLAKANO
        FROM
            (  SELECT
             to_date(substr(x.policebaslamatarihi,1,10),'YYYY-MM-DD') PrePolBaslangic_Tarih,
            to_date(substr(x.policeBitisTarihi,1,10),'YYYY-MM-DD') PrePolBitis_Tarih,
              to_date(substr(x.policeEkiBaslamaTarihi,1,10),'YYYY-MM-DD') PrePolZeyilBas_Tarih,
             x.modelYili,
             x.plakaNo,
             case when x.zeylTuru in(8,9,13,38,43,44) then 1 else 0 end iptalmi,
                  case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi
            FROM (select xmltype(value) data from dual) t,
            XMLTABLE ('/ovmkaskoPoliceBySasiSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType' PASSING t.data
                    COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                    policeBitisTarihi VARCHAR2(30) PATH 'policeBitisTarihi',
                    policeEkiBaslamaTarihi VARCHAR2(30) PATH 'policeEkiBaslamaTarihi',

                    modelYili VARCHAR2(10) PATH 'arac/modelYili' ,
                    plakaNo VARCHAR2(30) PATH 'arac/plakaNo',
                    zeylTuru VARCHAR2(3) PATH 'zeylTuru'
                        ) x
                        ) y where  (SYSDATE-y.PrePolBaslangic_Tarih)>30  and  y.mebiptalmi=0
                        ORDER BY Y.PrePolBitis_Tarih desc ) mas where rownum =1;


        select to_date(p_PolBasTarh ,'DD.MM.YYYY')-to_date(p_PrePolBtsTarh ,'DD.MM.YYYY')   into v_PolBasFarkPreBts from dual;

        v_sigortasizliksuresi:=v_PolBasFarkPreBts;

        if  c_sigortasizgecensure>= v_PolBasFarkPreBts   then    v_surekliSigortaliMi:='E';  END IF;



       ELSE
       v_surekliSigortaliMi:='H';
       v_sigortasizliksuresi:= v_PoliceBasFarkTrafigeCikis;
       END IF;


    if v_aracSifirKmMi='E'  THEN
            AP:='AP1';
        ELSIF v_geciciPlakaMi='E' then
            AP:='AP6';
    END IF;


    if AP='AP9'
    THEN

        if (yenilemeMi is NOT null) and (yenilemeMi='E')
             then   AP:='AP2';
             elsif  (p_HasarslkIndrm IS NOT NULL) and (p_HasarslkIndrm<>'0')
             then    AP:='AP4';
        END IF;

    END IF;


    if AP='AP9' THEN

      if v_asbisRuhsatVarMi='E'
      THEN
        if v_yeniSatinAlinmisMi='E' AND v_surekliSigortaliMi='E' then  AP:='AP2'; END IF;

        if v_yeniSatinAlinmisMi='E' AND v_surekliSigortaliMi='H'
         then
           IF  v_sigortasizliksuresi  <=90
            THEN  AP:='AP31';
            ELSIF  v_sigortasizliksuresi >90 AND  v_sigortasizliksuresi <181
            THEN  AP:='AP32';
            ELSE  AP:='AP33';
           END IF;
        END IF;

        if v_yeniSatinAlinmisMi='H' AND v_surekliSigortaliMi='E' then  AP:='AP4'; END IF;

        if v_yeniSatinAlinmisMi='H' AND v_surekliSigortaliMi='H' then
            IF  v_sigortasizliksuresi  <=90
            THEN  AP:='AP51';
            ELSIF  v_sigortasizliksuresi >90 AND  v_sigortasizliksuresi <181
            THEN  AP:='AP52';
            ELSE  AP:='AP53';
           END IF;
        END IF;
      ELSE

         if v_surekliSigortaliMi='H' then  AP:='AP7'; END IF;
          if v_surekliSigortaliMi='E' then  AP:='AP8'; END IF;
      END if;


    END IF;


    SELECT desc1 INTO APP from pricing_parameters where key1=AP;
AP:=SUBSTR(AP,1,3);
addAracSkorLog (p_HasarslkIndrm ,p_PolBasTarh , p_TesclTarh ,p_TrafkCksTarh , p_ModelYl , p_Plaka ,v_PolBasFarkPreBts ,v_aracSifirKmMi ,v_geciciPlakaMi , yenilemeMi ,v_asbisRuhsatVarMi ,v_yeniSatinAlinmisMi ,v_surekliSigortaliMi , v_sigortasizliksuresi ,p_PrePolBtsTarh ,AP ,APP ,v_sigortaKaydiVarMi,s_PricingId,s_key,s_sql,'');
    else
        addAracSkorLogCache(s_PricingId, s_sql);
        select p.skor into APP from aracskor_detay p where p.systemdate = to_char(sysdate,'DD/MM/YYYY') and cast(p.p_sql as varchar2(1000))=cast(to_char(s_sql) as varchar2(1000)) and rownum = 1;
    end if;
 RETURN APP;

    EXCEPTION WHEN OTHERS THEN
     v_errm := SUBSTR(SQLERRM, 1, 4000);
        SELECT desc1 INTO APP from pricing_parameters where key1='AP9';
     -- log kaydı atmak gerekebilir
           return APP;
    END GETARACSKOR;

    FUNCTION getTariffSqlDetail (
      s_fsql in CLOB,
      s_variable in VARCHAR2,
      s_dataType in VARCHAR2,
      s_operator in VARCHAR2,
      s_var in VARCHAR2,
      s_condition in VARCHAR2,
      s_targetValue in VARCHAR2,
      s_parameterName in VARCHAR2,
      s_parameterColumnName1 in VARCHAR2,
      s_parameterOperator1 in VARCHAR2,
      s_var1 in VARCHAR2,
      s_parameterColumnName2 in VARCHAR2,
      s_parameterOperator2 in VARCHAR2,
      s_var2 in VARCHAR2
    )
    RETURN CLOB AS
     s_ReturnType CLOB;
    BEGIN
        s_ReturnType := s_fsql;
        if s_variable is not null THEN
            if s_dataType = 'Number' then
                s_ReturnType := s_ReturnType || ' AND '||s_condition||s_operator||'Cast('''||s_var||''' as NUMBER)';
            elsif s_dataType = 'Upper' then
                s_ReturnType := s_ReturnType || ' AND '||s_condition||s_operator||'UPPER('''||s_var||''')';
            else
                s_ReturnType := s_ReturnType || ' AND '||s_condition||s_operator||''''||s_var||'''';
            end if;
        else
            s_ReturnType := s_ReturnType || ' AND '||s_condition||s_operator||'(select g.'||s_targetValue||' from pricing_parameters g where g.param_name='''||s_parameterName||'''';
            if s_parameterColumnName1 is not null THEN
                s_ReturnType := s_ReturnType || ' and g.'||s_parameterColumnName1||s_parameterOperator1||''''||s_var1||'''';
            end if;
            if s_parameterColumnName2 is not null THEN
                s_ReturnType := s_ReturnType || ' and g.'||s_parameterColumnName2||s_parameterOperator2||''''||s_var2||'''';
            end if;
            s_ReturnType := s_ReturnType || ' and g.valid_date=(select max(a.valid_date) from pricing_parameters a where a.param_name='''||s_parameterName||'''  and valid_date is not null))';
        end if;
        return s_ReturnType;
    END getTariffSqlDetail;

    -- Sigortalı Skor
    FUNCTION getSigortaliSkor (
      s_PricingId in NUMBER,
      p_xml_value in CLOB,
      kimlikNo in varchar2,
      p_tariffDate in Date,
      p_aracTarifeGrupKodu in varchar2,
      p_hasarsizlikKademesi in number
    )
    RETURN NUMBER AS
    s_SigortaliSkor NUMBER(11,5);
    s_Fx NUMBER(11,5);
    s_Mhs NUMBER(5,2);
    s_Akps NUMBER(5,2);
    s_fonk1 NUMBER(11,5);
    s_fonk2 NUMBER(11,5);
    s_KazanilmisPolice NUMBER(11,5);
    s_SkoraTabiHasarlar NUMBER(15);
    s_RucusuzHasarlar NUMBER(15);
    s_yururPoliceler NUMBER(11);
    s_camHasarSayisi NUMBER(11);
    s_minTutarHasarSayisi NUMBER(11);
    s_hasarSayisi NUMBER(11);
    s_PoliceSuresiBasinaHasSay NUMBER(3);
    s_policeSuresiBasinaHasSayYil NUMBER(3);
    s_BaslangicTarihi DATE;
    s_BitisTarihi DATE;
    s_AkpsKontrolOrani NUMBER(5,2);
    s_year1 NUMBER(5,2);
    s_year2 NUMBER(5,2);
    s_year3 NUMBER(5,2);
    s_year4 NUMBER(5,2);
    s_year5 NUMBER(5,2);
    s_SigAracKontrol NUMBER(3,0);
    s_minimumHasarTutari NUMBER(11,2);
    v_errm VARCHAR2(4000);
    p_cache number;
    s_sql CLOB;
    BEGIN

    --update sigortaliskor_test set TXT=p_xml_value where IDX=3;

    s_sql := 'select * from table(getTariff.getSigortaliSkor(''PRICE ID'',''Sorgu Sonucu CLOB'','''|| kimlikNo ||''','''||p_tariffDate||''','''||p_aracTarifeGrupKodu||''','''||p_hasarsizlikKademesi||'''))';

    select count(0) into p_cache from pricing_insuredscore_log p where p.systemdate = to_char(sysdate,'DD/MM/YYYY')
                                                                            --and cast(substr(replace(replace(p.p_xml_value,CHR(10),''),CHR(13),''),1,4000) as varchar2(4000)) = cast(substr(replace(replace(p_xml_value,CHR(10),''),CHR(13),''),1,4000) as varchar2(4000))
                                                                            and cast(p.p_sql as varchar2(1000))=to_char(s_sql);

    if p_cache=0 then

    -------------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------------
    /* Fx */

    select cast(a.DESC1 as NUMBER(11)) into s_minimumHasarTutari from pricing_parameters a where a.param_name='Sigortali Min Hasar Tutari' and a.valid_date=(select max(b.valid_date) from pricing_parameters b where b.param_name=a.param_name and b.valid_date<=p_tariffDate);

    select
        sum(z.kazanilmispolice), sum(z.rucusuzhasarsayisi),
         (case when sum(z.kazanilmispolice) = 0.00 then 0 else
                  round((sum(z.rucusuzhasarsayisi) + case when sum(z.camhasarsayisi)>0 OR sum(z.minTutarHasarSayisi)>0 then -1 else 0 end) / sum(z.kazanilmispolice),2) end) fonk1,
        sum(z.yururPoliceler), sum(z.camHasarSayisi),sum(z.minTutarHasarSayisi), sum(z.hasarsayisi),
        round((sum(z.rucusuzhasarsayisi) + case when sum(z.camhasarsayisi)>0 OR sum(z.minTutarHasarSayisi)>0 then -1 else 0 end),2)
        into s_KazanilmisPolice, s_RucusuzHasarlar, s_fonk1, s_yururPoliceler, s_camHasarSayisi,s_minTutarHasarSayisi,s_hasarSayisi,s_SkoraTabiHasarlar
    from
    (
        select
        system_date, policeno, yenilemeno, policeekino, zeylturu, iptalmi, mebiptalmi, policebaslamatarihi, policebitistarihi, policeekibaslamatarihi,
        aracmarkakodu, aractarifegrupkodu, aractipkodu, kullanimsekli, modelyili, plakailkodu, plakano, uygulananKademe,
        SUM(hasarsayisi) hasarsayisi, SUM(kismihasarsayisi) kismihasarsayisi, SUM(camhasarsayisi) camhasarsayisi, SUM(rucusuzhasarsayisi) rucusuzhasarsayisi,
        SUM(mintutarhasarsayisi) mintutarhasarsayisi,
        round(nvl(case when iptalmi=1 then to_date(substr(policeekibaslamatarihi,1,10),'YYYY-MM-DD') - to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD')
                        else case when to_date(substr(policebitistarihi,1,10),'YYYY-MM-DD')>system_date then system_date-to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD')
                        else to_date(substr(policebitistarihi,1,10),'YYYY-MM-DD')-to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD') end
                        end,0)/365,2) kazanilmispolice,
         case when iptalmi=1 then case when replace(substr(policeEkiBaslamaTarihi,1,10),'-','')>to_char(system_date,'YYYYMMDD')
                 and replace(substr(policeBaslamaTarihi,1,10),'-','')<to_char(system_date,'YYYYMMDD') then 1 else 0 end
                 else case when replace(substr(policeBaslamaTarihi,1,10),'-','')<to_char(system_date,'YYYYMMDD') and replace(substr(policeBitisTarihi,1,10),'-','')>to_char(system_date,'YYYYMMDD')
                 then 1 else 0 end end yururPoliceler

        from
        (
            select
                v.*,
                SUM(case when dosyadurumkodu is not null then 1 else 0 end) hasarsayisi,
                sum(case when kaskoHasarTipi='2' and dosyaDurumKodu not in ('3','4') and rucuOrani != '100' then 1 else 0 end) kismiHasarSayisi,
                sum(case when hasarNedenTipi='20' and dosyaDurumKodu not in ('3','4') and rucuOrani != '100' then 1 else 0 end) camHasarSayisi,
                sum(case when rucuOrani!='100' and dosyaDurumKodu not in ('3','4') then 1 else 0 end) rucusuzHasarSayisi,
                (case when sum(rucudusulmustutar)<500 and dosyaDurumKodu not in ('3','4') and rucuOrani != '100' then 1 else 0 end) minTutarHasarSayisi
                from
                    ( select distinct t.system_date, x.policeNo ,x.yenilemeno ,x.policeEkino ,x.zeylTuru ,
                            case when x.zeylTuru in(8,9,13,38,43,44) then 1 else 0 end iptalmi,
                            case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi,
                            x.policeBaslamaTarihi ,x.policeBitisTarihi ,x.policeEkiBaslamaTarihi
                            ,x.aracMarkaKodu ,x.aracTarifeGrupKodu ,x.aracTipKodu ,x.kullanimSekli ,x.modelYili ,x.plakaIlKodu ,x.plakaNo ,x.uygulananKademe,
                            x2.dosyaDurumKodu, x2.kaskoHasarTipi, x2.hasarNedenTipi, x2.rucuOrani,x3.hasarTutari, (x3.hasartutari*(100-x2.rucuorani)/100) as rucudusulmustutar
                            from
                            (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(p_xml_value) data from dual) t,
                                XMLTABLE ('/ovmkaskoPoliceByTckSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'      PASSING t.data
                                           COLUMNS
                                             policeNo VARCHAR2(30) PATH 'policeNo',
                                             yenilemeno VARCHAR2(3) PATH 'yenilemeNo',
                                             policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                             zeylTuru VARCHAR2(3) PATH 'zeylTuru',
                                             policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                                             policeBitisTarihi varchar2(30) PATH 'policeBitisTarihi',
                                             policeEkiBaslamaTarihi varchar2(30) PATH 'policeEkiBaslamaTarihi',
                                             aracMarkaKodu varchar2(4) PATH 'arac/aracMarkaKodu',
                                             aracTarifeGrupKodu varchar2(4) PATH 'arac/aracTarifeGrupKodu',
                                             aracTipKodu varchar2(4) PATH 'arac/aracTipKodu',
                                             kullanimSekli varchar2(4) PATH 'arac/kullanimSekli',
                                             modelYili varchar2(4) PATH 'arac/modelYili',
                                             plakaIlKodu varchar2(4) PATH 'arac/plakaIlKodu',
                                             plakaNo varchar2(4) PATH 'arac/plakaNo',
                                             uygulananKademe varchar2(2) PATH 'uygulananKademe',
                                             hasarList xmltype PATH 'hasarList'
                                         ) x
                                LEFT OUTER JOIN XMLTABLE('hasarList' PASSING x.hasarList
                                    COLUMNS
                                            dosyaDurumKodu varchar2(5) PATH 'dosyaDurumKodu',
                                            kaskoHasarTipi varchar2(5) PATH 'kaskoHasarTipi',
                                            hasarNedenTipi varchar2(5) PATH 'hasarNedenTipi',
                                            rucuOrani varchar2(5) PATH 'rucuOrani',
                                            odemeList xmltype PATH 'odemeList'
                                ) x2 ON 1=1
                                LEFT OUTER JOIN XMLTABLE('odemeList' PASSING x2.odemeList
                                    COLUMNS
                                            hasarTutari varchar2(10) PATH 'tutar'
                                ) x3 ON 1=1
                    )  v
                     group by v.system_date, v.policeNo,v.yenilemeno ,v.policeEkino ,v.zeylTuru ,v.iptalmi, v.mebiptalmi, v.policeBaslamaTarihi
                     ,v.policeBitisTarihi, v.policeEkiBaslamaTarihi ,v.aracMarkaKodu ,v.aracTarifeGrupKodu ,v.aracTipKodu
                     ,v.kullanimSekli, v.modelYili ,v.plakaIlKodu ,v.plakaNo ,v.uygulananKademe,v.rucudusulmustutar, v.dosyaDurumKodu,
                      v.kaskoHasarTipi, v.hasarNedenTipi, v.rucuOrani,v.hasarTutari
        ) y group by system_date, policeno, yenilemeno, policeekino, zeylturu, iptalmi, mebiptalmi, policebaslamatarihi, policebitistarihi, policeekibaslamatarihi,
        aracmarkakodu, aractarifegrupkodu, aractipkodu, kullanimsekli, modelyili, plakailkodu, plakano, uygulananKademe
        having mebiptalmi<>1
    ) z;


    select count(0) into s_Fx from pricing_tables b
            where b.table_code='Sigortali Skor' and b.key1=p_hasarsizlikKademesi and b.key2 = s_fonk1*100 and b.key3 = s_fonk1*100
                and b.valid_date=(select max(aa.valid_Date) from pricing_tables aa where aa.table_code='Sigortali Skor' and b.key1=p_hasarsizlikKademesi
                                                                                                and aa.key2 = s_fonk1*100 and aa.key3 = s_fonk1*100 and aa.valid_Date<=to_char(sysdate,'DD/MM/YYYY'));
    IF s_Fx = 1 THEN
        select b.Mult1 into s_Fx from pricing_tables b
                where b.table_code='Sigortali Skor' and b.key1=p_hasarsizlikKademesi and b.key2 = s_fonk1*100 and b.key3 = s_fonk1*100
                    and b.valid_date=(select max(aa.valid_Date) from pricing_tables aa where aa.table_code='Sigortali Skor' and b.key1=p_hasarsizlikKademesi
                                                                                                    and aa.key2 = s_fonk1*100 and aa.key3 = s_fonk1*100 and aa.valid_Date<=to_char(sysdate,'DD/MM/YYYY'));
    ELSE
        select b.Mult1 into s_Fx from pricing_tables b
                where b.table_code='Sigortali Skor' and b.key1=p_hasarsizlikKademesi and b.key2 <= s_fonk1*100 and b.key3 > s_fonk1*100
                    and b.valid_date=(select max(aa.valid_Date) from pricing_tables aa where aa.table_code='Sigortali Skor' and b.key1=p_hasarsizlikKademesi
                                                                                                    and aa.key2 <= s_fonk1*100 and aa.key3 > s_fonk1*100 and aa.valid_Date<=to_char(sysdate,'DD/MM/YYYY'));
    END IF;

    IF s_RucusuzHasarlar + (case when s_camhasarsayisi>0 OR s_minTutarHasarSayisi>0 then -1 else 0 end) < 2 AND s_Fx > 1.14 THEN s_Fx := 1.14; END IF;

    -------------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------------
    /* Mhs */

    s_policeSuresiBasinaHasSay:=0;
    FOR i IN 0..4 LOOP
        s_BaslangicTarihi:= sysdate - (i+1)*365;
        s_BitisTarihi:= sysdate - i*365 ;

        select NVL(sum(z.result),0) into s_policeSuresiBasinaHasSayYil from
        (
            select
            y.hasarTarihi, SUM(y.say + (case when y.ruculuHasarlar>0 then -1 else (case when y.camHasarSayisi>0 OR y.minTutarHasarSayisi>0 then -1 else 0 end) end)) result
            from
            (
                select
                    (case when v.hasarTarihi is not null then 1 else 0 end) as say, v.hasarTarihi, v.dosyaDurumKodu,
                    sum(case when hasarNedenTipi='20' then 1 else 0 end) camHasarSayisi,
                    sum(case when rucuOrani='100' then 1 else 0 end) ruculuHasarlar,
                    (case when sum(rucudusulmustutar)<500 then 1 else 0 end) minTutarHasarSayisi
                    from
                    ( select distinct t.system_date,
                            x2.hasarTarihi, x2.dosyaDurumKodu, x2.kaskoHasarTipi, x2.hasarNedenTipi, x2.rucuOrani,
                            x3.hasarTutari, (x3.hasartutari*(100-x2.rucuorani)/100) as rucudusulmustutar
                            from
                            (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(p_xml_value) data from dual) t,
                            XMLTABLE ('/ovmkaskoPoliceByTckSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'      PASSING t.data
                                       COLUMNS
                                         hasarList xmltype PATH 'hasarList'
                                     ) x
                            LEFT OUTER JOIN XMLTABLE('hasarList' PASSING x.hasarList
                                COLUMNS
                                        hasarTarihi varchar2(50) PATH 'hasarTarihi',
                                        dosyaDurumKodu varchar2(5) PATH 'dosyaDurumKodu',
                                        kaskoHasarTipi varchar2(5) PATH 'kaskoHasarTipi',
                                        hasarNedenTipi varchar2(5) PATH 'hasarNedenTipi',
                                        rucuOrani varchar2(5) PATH 'rucuOrani',
                                        odemeList xmltype PATH 'odemeList'
                            ) x2 ON 1=1
                            LEFT OUTER JOIN XMLTABLE('odemeList' PASSING x2.odemeList
                                COLUMNS
                                        hasarTutari varchar2(10) PATH 'tutar'
                            ) x3 ON 1=1
                           where (x2.dosyaDurumKodu is null or x2.dosyaDurumKodu not in ('3','4')) and (x2.rucuOrani is null or x2.rucuOrani != '100')
                    ) v
                    group by v.hasarTarihi, v.dosyaDurumKodu
            ) y
            group by y.hasarTarihi
            --having to_char(to_date(substr(hasartarihi,1,10),'YYYY-MM-DD'),'YYYY-MM-DD') between to_char((s_BaslangicTarihi),'YYYY-MM-DD') AND to_char((s_BitisTarihi),'YYYY-MM-DD')
            having to_char(to_date(substr(hasartarihi,1,10),'YYYY-MM-DD'),'YYYY-MM-DD') > to_char(s_BaslangicTarihi,'YYYY-MM-DD')
                    and to_char(to_date(substr(hasartarihi,1,10),'YYYY-MM-DD'),'YYYY-MM-DD') <= to_char(s_BitisTarihi,'YYYY-MM-DD')
        ) z;

        IF (s_policeSuresiBasinaHasSayYil is null OR s_policeSuresiBasinaHasSayYil<0) then s_policeSuresiBasinaHasSayYil:=0;  END IF;
        --s_policeSuresiBasinaHasSay:= s_policeSuresiBasinaHasSay + (case when s_policeSuresiBasinaHasSayYil<0 then 0 else s_policeSuresiBasinaHasSayYil end);
        s_policeSuresiBasinaHasSay:= (case when s_policeSuresiBasinaHasSayYil > s_policeSuresiBasinaHasSay then s_policeSuresiBasinaHasSayYil else s_policeSuresiBasinaHasSay  end);

    END LOOP;

    s_fonk2 := s_policeSuresiBasinaHasSay;

    select b.Mult1 into s_Mhs from pricing_tables b where b.table_code='Sigortali Hasar Sayisi' and b.key1=p_hasarsizlikKademesi and b.key2 <= s_fonk2 and b.key3 >= s_fonk2
                    and b.valid_date=(select max(aa.valid_Date) from pricing_tables aa where aa.table_code='Sigortali Hasar Sayisi' and b.key1=p_hasarsizlikKademesi
                                                                                                and aa.key2 <= s_fonk2
                                                                                                and aa.key3 >= s_fonk2
                                                                                                and aa.valid_Date <= to_char(sysdate,'DD/MM/YYYY'));

    -------------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------------
    /* AKPS */

    select SUM(s.year1), SUM(s.year2), SUM(s.year3), SUM(s.year4), SUM(s.year5) into s_year1, s_year2, s_year3, s_year4, s_year5
    from
        (select
                ROUND(
                ((CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-365 AND SYSDATE) OR (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-365 AND SYSDATE)
                      THEN (CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-365 AND SYSDATE) AND (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-365 AND SYSDATE)
                                    THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') - to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD')
                                 ELSE
                                    (CASE WHEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') < SYSDATE THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE END) -
                                    (CASE WHEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') > SYSDATE-365 THEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE-365 END)
                            END)
                      ELSE 0
                END)/365)
                  * (select TO_NUMBER(a.mult1) from pricing_tables a where a.TABLE_CODE='Sigortali Agirlik Faktoru' and a.KEY1 = 0 and a.KEY2 = 1 AND
                                                                    a.VALID_DATE = (select MAX(VALID_DATE) from pricing_tables b where a.TABLE_CODE = b.TABLE_CODE))
                , 2) AS YEAR1,
                ROUND(
                ((CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-2*365 AND SYSDATE-365) OR (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-2*365 AND SYSDATE-365)
                      THEN (CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-2*365 AND SYSDATE-365) AND (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-2*365 AND SYSDATE-365)
                                    THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') - to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD')
                                 ELSE
                                    (CASE WHEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') < SYSDATE-365 THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE-365 END) -
                                    (CASE WHEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') > SYSDATE-2*365 THEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE-2*365 END)
                            END)
                      ELSE 0
                END)/365)
                  * (select TO_NUMBER(a.mult1) from pricing_tables a where a.TABLE_CODE='Sigortali Agirlik Faktoru' and a.KEY1 = 1 and a.KEY2 = 2 AND
                                                                    a.VALID_DATE = (select MAX(VALID_DATE) from pricing_tables b where a.TABLE_CODE = b.TABLE_CODE))
                , 2) AS YEAR2,
                                ROUND(
                ((CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-3*365 AND SYSDATE-2*365) OR (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-3*365 AND SYSDATE-2*365)
                      THEN (CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-3*365 AND SYSDATE-2*365) AND (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-3*365 AND SYSDATE-2*365)
                                    THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') - to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD')
                                 ELSE
                                    (CASE WHEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') < SYSDATE-2*365 THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE-2*365 END) -
                                    (CASE WHEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') > SYSDATE-3*365 THEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE-3*365 END)
                            END)
                      ELSE 0
                END)/365)
                  * (select TO_NUMBER(a.mult1) from pricing_tables a where a.TABLE_CODE='Sigortali Agirlik Faktoru' and a.KEY1 = 2 and a.KEY2 = 3 AND
                                                                    a.VALID_DATE = (select MAX(VALID_DATE) from pricing_tables b where a.TABLE_CODE = b.TABLE_CODE))
                , 2) AS YEAR3,
                                ROUND(
                ((CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-4*365 AND SYSDATE-3*365) OR (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-4*365 AND SYSDATE-3*365)
                      THEN (CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-4*365 AND SYSDATE-3*365) AND (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-4*365 AND SYSDATE-3*365)
                                    THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') - to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD')
                                 ELSE
                                    (CASE WHEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') < SYSDATE-3*365 THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE-3*365 END) -
                                    (CASE WHEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') > SYSDATE-4*365 THEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE-4*365 END)
                            END)
                      ELSE 0
                END)/365)
                  * (select TO_NUMBER(a.mult1) from pricing_tables a where a.TABLE_CODE='Sigortali Agirlik Faktoru' and a.KEY1 = 3 and a.KEY2 = 4 AND
                                                                    a.VALID_DATE = (select MAX(VALID_DATE) from pricing_tables b where a.TABLE_CODE = b.TABLE_CODE))
                , 2) AS YEAR4,
                                ROUND(
                ((CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-5*365 AND SYSDATE-4*365) OR (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-5*365 AND SYSDATE-4*365)
                      THEN (CASE WHEN (to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') between SYSDATE-5*365 AND SYSDATE-4*365) AND (to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') between SYSDATE-5*365 AND SYSDATE-4*365)
                                    THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') - to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD')
                                 ELSE
                                    (CASE WHEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') < SYSDATE-4*365 THEN to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE-4*365 END) -
                                    (CASE WHEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') > SYSDATE-5*365 THEN to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD') ELSE SYSDATE-5*365 END)
                            END)
                      ELSE 0
                END)/365)
                  * (select TO_NUMBER(a.mult1) from pricing_tables a where a.TABLE_CODE='Sigortali Agirlik Faktoru' and a.KEY1 = 4 and a.KEY2 = 5 AND
                                                                    a.VALID_DATE = (select MAX(VALID_DATE) from pricing_tables b where a.TABLE_CODE = b.TABLE_CODE))
                , 2) AS YEAR5
        from
        (select y.policeNo,y.yenilemeno,y.policeEkino, y.policeBaslamaTarihi,y.policeEkiBaslamaTarihi,
                (case when y.iptalmi=1 then y.policeEkiBaslamaTarihi else y.policeBitisTarihi end) as policeBitisTarihi, y.iptalmi,y.mebiptalmi
            from
            (SELECT  t.system_date, x.policeNo,x.yenilemeno,x.policeEkino,x.zeylTuru,
                     case when x.zeylTuru in(8,9,13,38,43,44) then 1 else 0 end iptalmi , case when x.zeylTuru in(3) then 1 else 0 end mebiptalmi ,
                     x.policeBaslamaTarihi,x.policeBitisTarihi,x.policeEkiBaslamaTarihi
               FROM (select  to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(p_xml_value) data from dual) t,
               XMLTABLE ('/ovmkaskoPoliceByTckSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'  PASSING t.data
                        COLUMNS policeNo VARCHAR2(30) PATH 'policeNo',
                        yenilemeno VARCHAR2(3) PATH 'yenilemeNo',
                        policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                        zeylTuru VARCHAR2(3) PATH 'zeylTuru',
                        policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
                        policeBitisTarihi varchar2(30) PATH 'policeBitisTarihi',
                        policeEkiBaslamaTarihi varchar2(30) PATH 'policeEkiBaslamaTarihi'
                        ) x ) y where y.mebiptalmi <> 1) z ) s ;

    select SUM(s_year1+s_year2+s_year3+s_year4+s_year5) into s_Akps from  dual;

    -------------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------------

    s_SigortaliSkor:= s_Fx * s_Mhs;


    select count(0) into s_SigAracKontrol from pricing_tables where table_code ='Sigortali Arac Tarife Kodu' and KEY1=TO_NUMBER(p_aracTarifeGrupKodu);
    IF s_SigAracKontrol=0 AND s_SigortaliSkor < 1 THEN s_SigortaliSkor := 1; END IF;


    select b.Mult1 into s_AkpsKontrolOrani from pricing_tables b where b.table_code='Sigortali Akps Kontrol Orani'
        and b.valid_date=(select max(aa.valid_Date) from pricing_tables aa where aa.table_code='Sigortali Skor' and aa.valid_Date<=to_char(sysdate,'DD/MM/YYYY'));

    IF s_Akps <= s_AkpsKontrolOrani and s_SigortaliSkor < 1 THEN s_SigortaliSkor:= 1; END IF;

    s_SigortaliSkor := round(s_SigortaliSkor,2);

    addInsuredScoreLog (s_PricingId, kimlikNo, to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), p_xml_value, p_tariffDate, p_aracTarifeGrupKodu, p_hasarsizlikKademesi,
                        s_SigortaliSkor, s_Fx, s_mhs, s_akps, s_fonk1, s_fonk2, s_KazanilmisPolice, s_SkoraTabiHasarlar, s_RucusuzHasarlar, s_yururPoliceler, s_camHasarSayisi,
                        s_minTutarHasarSayisi, s_hasarSayisi, s_year1, s_year2, s_year3, s_year4, s_year5, s_SigAracKontrol, s_minimumHasarTutari, s_AkpsKontrolOrani, '', s_sql);
    else
        addInsuredScoreLogCache (s_PricingId, p_xml_value, s_sql);
        select p.s_sigortaliskor into s_SigortaliSkor from pricing_insuredscore_log p where p.systemdate = to_char(sysdate,'DD/MM/YYYY')
                                                                                                --and cast(substr(p.p_xml_value,1,4000) as varchar2(4000)) = cast(p_xml_value as varchar2(4000))
                                                                                                and cast(p.p_sql as varchar2(1000))=to_char(s_sql) and rownum = 1;
    end if;


    RETURN s_SigortaliSkor;

    EXCEPTION WHEN OTHERS THEN
       v_errm :=   'ERROR: ' || substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       s_SigortaliSkor:= 1;
       addInsuredScoreLog (s_PricingId, kimlikNo, to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), p_xml_value, p_tariffDate, p_aracTarifeGrupKodu, p_hasarsizlikKademesi,
                            s_SigortaliSkor, s_Fx, s_mhs, s_akps, s_fonk1, s_fonk2, s_KazanilmisPolice, s_SkoraTabiHasarlar, s_RucusuzHasarlar, s_yururPoliceler, s_camHasarSayisi,
                            s_minTutarHasarSayisi, s_hasarSayisi, s_year1, s_year2, s_year3, s_year4, s_year5, s_SigAracKontrol, s_minimumHasarTutari, s_AkpsKontrolOrani, v_errm, s_sql);
       return s_SigortaliSkor;
    end getSigortaliSkor;

    PROCEDURE addLog (
      s_priceid VARCHAR2,
      s_error VARCHAR2, p_error varchar2)is PRAGMA AUTONOMOUS_TRANSACTION;
    v_errm varchar2(4000);
    begin
        insert into pricing_tariff_log(price_id, system_date, system_time, m1, error_desc) values(s_priceid, sysdate, TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF'),s_error, p_error);
        commit;
    end;
    
     PROCEDURE insertXMLtoTable (
      p_xml_value clob)is PRAGMA AUTONOMOUS_TRANSACTION;
      sqlstring varchar2(4000);
    begin
      sqlstring := q'{drop table TNSWIN.IA_XMLS; create table TNSWIN.IA_XMLS
      SELECT * FROM (select 'gecmisPoliceler', x1.*
                             from
                                (select xmltype(p_xml_value) data from dual) t,
                                --(select  xmltype(txt) data from test where idx = 10) t,
                                XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                          ) x1
                    UNION ALL
                     select 'yururPoliceler',x2.*
                             from
                                 (select xmltype(p_xml_value) data from dual) t,
                                 --(select  xmltype(txt) data from test where idx = 10) t,
                                 XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                          ) x2)X3;}';
    execute immediate sqlstring;

    end;
  
             
             
                                    
              
     
                                                                                      
         
    

PROCEDURE addYetkiliIndLog(s_price_id NUMBER,
                s_biryiloncekihasar varchar2,
                s_ikiyiloncekihasar varchar2,
                s_ucyiloncekihasar varchar2,
                s_maxindirim number,
                s_yenilemeyeniiskod varchar2,
                s_kullaniciadi varchar2,
                s_cacheKey varchar2)is PRAGMA AUTONOMOUS_TRANSACTION;
    output_x CLOB;
    v_errm varchar2(4000);
    p_status varchar2(1);
    begin
    insert into tnswin.pricing_ncd_log(price_id, system_date, system_time, biryiloncekihasar, ikiyiloncekihasar, ucyiloncekihasar, maxindirim, yenilemeyeniiskod,  username, cachekey) values(s_price_id,to_char(sysdate,'DD/MM/YYYY'),to_char(sysdate,'HH24:MI:SS'),s_biryiloncekihasar,s_ikiyiloncekihasar,s_ucyiloncekihasar, s_maxindirim, s_yenilemeyeniiskod, s_kullaniciadi, s_cachekey);
    commit;

    EXCEPTION WHEN OTHERS THEN
        v_errm :=   'ERROR: ' || substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        insert into tnswin.pricing_ncd_log(price_id, system_date, system_time, biryiloncekihasar, ikiyiloncekihasar, ucyiloncekihasar, err_desc, yenilemeyeniiskod, username, cachekey) values(s_price_id,to_char(sysdate,'DD/MM/YYYY'),to_char(sysdate,'HH24:MI:SS'),s_biryiloncekihasar,s_ikiyiloncekihasar,s_ucyiloncekihasar, v_errm, s_yenilemeyeniiskod, s_kullaniciadi, s_cachekey);
    end;

    PROCEDURE addDebugLog (
      s_priceid VARCHAR2,
      p_val varchar2)is PRAGMA AUTONOMOUS_TRANSACTION;
    v_errm varchar2(4000);
    begin
        insert into pricing_tariff_debug(price_id, system_date, slog) values(s_priceid, sysdate, p_val);
        commit;
    end;


    -- Log işlemleri
    PROCEDURE addTariffLog (
      s_productNo VARCHAR2,
      s_tariffdate VARCHAR2,
      s_kimlikNo VARCHAR2,
      s_sasiNo VARCHAR2,
      s_tescilSeriKod VARCHAR2,
      s_tescilSeriNo VARCHAR2,
      s_plakailkodu VARCHAR2,
      s_plakaNo VARCHAR2,
      s_asbisNo varchar2,
      s_tescilTarihi VARCHAR2,
      s_trafigeCikisTarihi VARCHAR2,

      s_PricingId NUMBER,
      s_PriceType VARCHAR2,
      s_errorDesc VARCHAR2,
      s_ssql CLOB,

      p_cocukdegiskeni VARCHAR2,
      p_sigortaliyas VARCHAR2,
      p_aracyasi VARCHAR2,
      p_kullanimtarzi VARCHAR2,
      p_kullanimsekli VARCHAR2,
      p_aracskor VARCHAR2,
      p_cinsiyeti VARCHAR2,
      p_medenihali VARCHAR2,
      p_tramerilce VARCHAR2,
      p_sigortaliskor VARCHAR2,
      s_systemdate VARCHAR2,
      s_systemtime VARCHAR2,
      p_yakittipi VARCHAR2,
      p_markakodu VARCHAR2,
      p_aracbedeli VARCHAR2,
      p_filosegment VARCHAR2,
      p_markariskgrubu VARCHAR2,
      p_yenilemeyeniiskod VARCHAR2,
      p_kismihasarsayisi VARCHAR2,
      p_sigortaliliksuresi VARCHAR2,
      p_camhasarsayisi VARCHAR2,
      s_PricingType VARCHAR2,
      s_m1 NUMBER,
      s_m2 NUMBER,
      s_m3 NUMBER,
      s_m4 NUMBER,
      s_m5 NUMBER,
      s_m6 NUMBER,
      p_sql CLOB,
      p_markatipkodu VARCHAR2,
      p_minimumfiyat VARCHAR2,
      p_minimumprim VARCHAR2,
      p_meslek VARCHAR2,
      p_ilkAracBedeli VARCHAR2,
      p_kasaBedeli VARCHAR2,
      p_digerAksesuarBedeli VARCHAR2,
      p_sesGoruntuCihazBedeli VARCHAR2,
      p_commercialScore varchar2,
      p_kiymetKazanma varchar2,
      p_ilkAracYasi varchar2,
      p_commercialScoreId varchar2,
      p_gecmisHasarSayisi varchar2,
      p_gecmisHasarsizlikIndirimi varchar2,
      p_gecmisPoliceFiyat varchar2,
      p_yenilemeCapMin varchar2,
      p_yenilemeCapMax varchar2,
      p_sbm CLOB,
      p_capMin varchar2,
      p_capMax varchar2,
      P_WHP VARCHAR2,
      acente varchar2,
      kullaniciAdi varchar2,
      hasarsizlikKademesi varchar2,
      OzelIndirim varchar2,
      surprim varchar2,
      p_capPolice varchar2,
      p_refpriceid varchar2,
      trafikHasarsizlikKademesi varchar2,
      p_karaListeKontrol VARCHAR2,
      p_bedeniWinsureKontrol VARCHAR2,
      p_bedeniAS400Kontrol VARCHAR2,
      p_ofacKontrol VARCHAR2,
      auth varchar2,
      cache_key varchar2,
      status varchar2,
      s_m7 NUMBER,
      s_m8 NUMBER,
      s_m9 NUMBER,
      s_m10 NUMBER,
      s_m11 NUMBER,
      s_m12 NUMBER,
      s_m13 NUMBER,
      s_m14 NUMBER,
      s_m15 NUMBER,
      s_m16 NUMBER,
      s_m17 NUMBER,
      s_m18 NUMBER,
      s_toplamprim number,
      s_toplamprimcap number,
      s_otorNihaiHasarAdet number,
      s_gecmisServisTuru varchar2,
      p_birYilOncekiHasarTutariArac varchar2,
      p_ozelTuzel varchar2, p_oncekiTrafikKademesi varchar2, p_gecikmeSurprimi varchar2, p_trfFrekans varchar2, p_trafikKayitliAracSayisi varchar2, p_markaTipGrup varchar2, p_ilIlcegrup varchar2, birYilOncekiHasar varchar2, ikiYilOncekiHasar varchar2, ucYilOncekiHasar varchar2, sonUcYilHasarSayisi varchar2,
      p_m19 number
      ) is PRAGMA AUTONOMOUS_TRANSACTION;
    output_x CLOB;
    v_errm varchar2(4000);
    p_status varchar2(1);
    p_systemtime varchar2(50);
    ppil varchar2(500);
    ppilce varchar2(500);
    detaillogcheck number(1);
    begin
    if s_productNo in('500') then
    output_x :='<Tariff>
        <Parameters>
            <PricingId>' || s_PricingId || '</PricingId>
            <PricingType>' || s_PricingType || '</PricingType>
            <ProductNo>' || s_productNo || '</ProductNo>
            <TariffDate>' || s_tariffdate || '</TariffDate>
            <KimlikNo>' || s_kimlikNo || '</KimlikNo>
            <SasiNo>' || s_sasiNo || '</SasiNo>
            <TescilSeriKod>' || s_tescilSeriKod || '</TescilSeriKod>
            <TescilSeriNo>' || s_tescilSeriNo || '</TescilSeriNo>
            <PlakaIlKodu>' || s_plakailkodu || '</PlakaIlKodu>
            <PlakaNo>' || s_plakaNo || '</PlakaNo>
            <AsbisNo>' || s_asbisNo || '</AsbisNo>
            <TescilTarihi>' || s_tescilTarihi || '</TescilTarihi>
            <TrafigeCikisTarihi>' || s_trafigeCikisTarihi || '</TrafigeCikisTarihi>
            <IlkAracBedeli>' || p_ilkAracBedeli || '</IlkAracBedeli>
            <KasaBedeli>' || p_kasaBedeli || '</KasaBedeli>
            <DigerAksesuarBedeli>' ||p_digerAksesuarBedeli||'</DigerAksesuarBedeli>
            <SesGoruntuCihazBedeli>' ||p_sesGoruntuCihazBedeli || '</SesGoruntuCihazBedeli>
            <IlkAracYasi>'||p_ilkAracYasi||'</IlkAracYasi>
            <TuzelSkorId>'||p_commercialScoreId||'</TuzelSkorId>
            <Acente>'||acente||'</Acente>
            <KullaniciAdi>'||kullaniciAdi||'</KullaniciAdi>
            <HasarsizlikKademesi>'||hasarsizlikKademesi||'</HasarsizlikKademesi>
            <OzelIndirim>'||OzelIndirim||'</OzelIndirim>
            <Surprim>'||surprim||'</Surprim>
            <RefPriceId>'||p_refpriceid||'</RefPriceId>
        </Parameters>
        <Calculated>
            <TrafikHasarsizlikKademesi>' || trafikHasarsizlikKademesi || '</TrafikHasarsizlikKademesi>
            <CocukDegiskeni>' || p_cocukdegiskeni || '</CocukDegiskeni>
            <SigortaliYas>' || p_sigortaliyas || '</SigortaliYas>
            <AracYasi>' || p_aracyasi || '</AracYasi>
            <KullanimTarzi>' || p_kullanimtarzi || '</KullanimTarzi>
            <KullanimSekli>' || p_kullanimsekli || '</KullanimSekli>
            <AracSkor>' || p_aracskor || '</AracSkor>
            <Cinsiyeti>' || p_cinsiyeti || '</Cinsiyeti>
            <MedeniHali>' || p_medenihali || '</MedeniHali>
            <TramerIlce>' || p_tramerilce || '</TramerIlce>
            <SigortaliSkor>' || p_sigortaliskor || '</SigortaliSkor>
            <YakitTipi>' || p_yakittipi || '</YakitTipi>
            <MarkaKodu>' || p_markaKodu || '</MarkaKodu>
            <AracBedeli>' || p_aracbedeli || '</AracBedeli>
            <FiloSegment>' || p_filosegment || '</FiloSegment>
            <MarkaRiskGrubu>' || p_markariskgrubu || '</MarkaRiskGrubu>
            <YenilemeYeniIsKod>' || p_yenilemeyeniiskod || '</YenilemeYeniIsKod>
            <KismiHasarSayisi>' || p_kismihasarsayisi || '</KismiHasarSayisi>
            <SigortalilikSuresi>' || p_sigortaliliksuresi || '</SigortalilikSuresi>
            <CamHasarSayisi>' || p_camhasarsayisi || '</CamHasarSayisi>
            <MarkaTipKodu>' || p_markatipkodu || '</MarkaTipKodu>
            <MinimumFiyat>' || p_minimumfiyat || '</MinimumFiyat>
            <MinimumPrim>' || p_minimumprim || '</MinimumPrim>
            <Meslek>' || p_meslek || '</Meslek>
            <TuzelSkor>' || p_commercialScore || '</TuzelSkor>
            <ServisTuru>' ||p_kiymetKazanma || '</ServisTuru>
            <CAPGecmisHasarSayisi>' ||p_gecmisHasarSayisi ||'</CAPGecmisHasarSayisi>
            <CAPGecmisHasarsizlikIndirimi>'||p_gecmisHasarsizlikIndirimi ||'</CAPGecmisHasarsizlikIndirimi>
            <CAPGecmisPoliceFiyat>'||p_gecmisPoliceFiyat ||'</CAPGecmisPoliceFiyat>
            <CAP>'||p_yenilemeCapMax ||'</CAP>
            <Floor>'||p_yenilemeCapMin ||'</Floor>
            <CAPMin>'||p_capMin||'</CAPMin>
            <CAPMax>'||p_capMax||'</CAPMax>
            <CapPoliceNo>'||p_capPolice||'</CapPoliceNo>
            <Whp>'||P_WHP||'</Whp>
            <KaraListeKontrol>'||p_karaListeKontrol||'</KaraListeKontrol>
            <BedeniWinsureKontrol>'||p_bedeniWinsureKontrol||'</BedeniWinsureKontrol>
            <BedeniAS400Kontrol>'||p_bedeniAS400Kontrol||'</BedeniAS400Kontrol>
            <OfacKontrol>'||p_ofacKontrol||'</OfacKontrol>
            <GecmisServisTuru>'||s_gecmisServisTuru||'</GecmisServisTuru>
            <CapNihaiHasarSayisi>'||s_otorNihaiHasarAdet||'</CapNihaiHasarSayisi>
            <CapRucusuzToplamHasarTutari>'||p_birYilOncekiHasarTutariArac||'</CapRucusuzToplamHasarTutari>
        </Calculated>
    </Tariff>';
    elsif s_productNo = '405' then
    output_x :='<Tariff>
        <Parameters>
            <PricingId>' || s_PricingId || '</PricingId>
            <PricingType>' || s_PricingType || '</PricingType>
            <ProductNo>' || s_productNo || '</ProductNo>
            <TariffDate>' || s_tariffdate || '</TariffDate>
            <KimlikNo>' || s_kimlikNo || '</KimlikNo>
        </Parameters>
    </Tariff>';
    elsif s_productNo in('550','554','556') then
    --output_x :=s_PricingId||'||'||s_PricingType||'||'||s_productNo||'||'||s_tariffdate||'||'||s_kimlikNo||'||'||s_sasiNo||'||'||s_plakailkodu||'||'||s_plakaNo||'||'||trafikHasarsizlikKademesi;
    output_x :=(case when s_productNo  is null then '~' else s_productNo  end)||'||'||(case when  s_tariffdate  is null then '~' else  s_tariffdate  end)||'||'||(case when  p_kullanimsekli  is null then '~' else  p_kullanimsekli  end)||'||'||(case when  p_kullanimtarzi  is null then '~' else  p_kullanimtarzi  end)||'||'||(case when p_ilkAracBedeli  is null then '~' else p_ilkAracBedeli  end)||'||'||(case when  s_plakailkodu  is null then '~' else  s_plakailkodu  end)||'||'||(case when p_tramerilce  is null then '~' else p_tramerilce  end)||'||'||(case when p_yenilemeyeniiskod  is null then '~' else p_yenilemeyeniiskod  end)||'||'||(case when  p_sigortaliyas  is null then '~' else  p_sigortaliyas  end)||'||'||(case when  p_aracbedeli  is null then '~' else  p_aracbedeli  end)||'||'||(case when  p_yakittipi  is null then '~' else  p_yakittipi  end)||'||'||(case when  p_medenihali  is null then '~' else  p_medenihali  end)||'||'||(case when  p_cocukdegiskeni  is null then '~' else  p_cocukdegiskeni  end)||'||'||(case when   p_kismihasarsayisi  is null then '~' else   p_kismihasarsayisi  end)||'||'||(case when   p_sigortaliliksuresi  is null then '~' else   p_sigortaliliksuresi  end)||'||'||(case when  p_cinsiyeti  is null then '~' else  p_cinsiyeti  end)||'||'||(case when HasarsizlikKademesi  is null then '~' else HasarsizlikKademesi  end)||'||'||(case when p_markariskgrubu  is null then '~' else p_markariskgrubu  end)||'||'||(case when   p_camhasarsayisi  is null then '~' else   p_camhasarsayisi  end)||'||'||(case when p_filosegment  is null then '~' else p_filosegment  end)||'||'||(case when  surprim  is null then '~' else  surprim  end)||'||'||(case when  OzelIndirim  is null then '~' else  OzelIndirim  end)||'||'||(case when  p_markakodu  is null then '~' else  p_markakodu  end)||'||'||(case when       p_meslek  is null then '~' else       p_meslek  end)||'||'||(case when        p_markatipkodu  is null then '~' else        p_markatipkodu  end)||'||'||(case when  trafikHasarsizlikKademesi  is null then '~' else  trafikHasarsizlikKademesi  end)||'||'||(case when  p_commercialScore  is null then '~' else  p_commercialScore  end)||'||'||(case when p_kiymetKazanma  is null then '~' else p_kiymetKazanma  end)||'||'||(case when  p_ilkAracYasi  is null then '~' else  p_ilkAracYasi  end)||'||'||(case when p_ozelTuzel is null then '~' else p_ozelTuzel end)||'||'||(case when p_gecmisHasarSayisi  is null then '~' else p_gecmisHasarSayisi  end)||'||'||(case when p_oncekiTrafikKademesi is null then '~' else p_oncekiTrafikKademesi end)||'||'||(case when p_gecikmeSurprimi is null then '~' else p_gecikmeSurprimi end)||'||'||(case when p_trfFrekans is null then '~' else p_trfFrekans end)||'||'||(case when p_trafikKayitliAracSayisi is null then '~' else p_trafikKayitliAracSayisi end);
    end if;
    if s_m1 = 999999 then p_status := '0'; else p_status := '1'; end if;
        if s_systemtime is null then p_systemtime := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF'); else p_systemtime := s_systemtime; end if;
        insert into pricing_tariff_log(price_id,price_type,system_Date,system_time,output, error_Desc,finish_time,SSQL,M1,M2,M3,M4,M5,M6,psql,ssbm,authorization_msg,cache_key,status,M7,M8,M9,M10,M11,M12,M13,M14,M15,M16, M17, M18, tarifeprim, tarifeprimcapdahil, kimlikplakaoncekihasaradet, M19)
        values(s_PricingId,s_PriceType,to_char(sysdate,'DD/MM/YYYY'),p_systemtime,output_x,s_errorDesc,TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF'),s_ssql,s_m1,s_m2,s_m3,s_m4,s_m5,s_m6,p_sql,p_sbm ,auth,cache_key,p_status,s_m7,s_m8,s_m9,s_m10,s_m11,s_m12,s_m13,s_m14,s_m15,s_m16,s_m17,s_m18, s_toplamprim, s_toplamprimcap,s_otorNihaiHasarAdet, p_m19);-- returning input_xml,output_xml into inputx,outputx,;
      --  DBMS_LOB.WRITE(inputx, LENGTH(UTL_RAW.CAST_TO_RAW(x_input)), 1, UTL_RAW.CAST_TO_RAW(x_input));
      --  DBMS_LOB.WRITE(outputx, LENGTH(UTL_RAW.CAST_TO_RAW(x_output)), 1, UTL_RAW.CAST_TO_RAW(x_output));
        commit;
        insert into tnswin.pricing_tariff_trf_table select * from tnswin.pricing_tariff_trf where price_id=s_PricingId;
        commit;
        if s_productNo in ('550','554','556') then
            insert into tnswin.pricing_tariff_trf_bastar(price_id, begdate)
            select a.price_id, tnswin.gettariff.removeelement(cast(tnswin.gettariff.getSbmDetails(a.ssbm,'trafikTeklifBaslangicTarihi') as varchar2(100)),'trafikTeklifBaslangicTarihi') from tnswin.pricing_tariff_log a where a.price_id=s_PricingId;
            commit;
        end if;
        update tnswin.pricing_tariff_log set ssbm=null where price_id=s_PricingId;
        commit;
            ppil:=(case when substr(s_kimlikNo,1,1)='9' then UPPER(tnswin.gettariff.removeElement(tnswin.gettariff.getSbmDetails(tnswin.gettariff.getSbmDetails(p_sbm, 'kisiAdresBilgisiType'), 'ilAd'), 'ilAd')) else UPPER(tnswin.gettariff.removeElement(tnswin.gettariff.getSbmDetails(tnswin.gettariff.getSbmDetails(p_sbm, 'adresSorgu'), 'ilAd'), 'ilAd')) end);
            ppilce:=(case when substr(s_kimlikNo,1,1)='9' then UPPER(tnswin.gettariff.removeElement(tnswin.gettariff.getSbmDetails(tnswin.gettariff.getSbmDetails(p_sbm, 'kisiAdresBilgisiType'), 'ilceAd'), 'ilceAd')) else UPPER(tnswin.gettariff.removeElement(tnswin.gettariff.getSbmDetails(tnswin.gettariff.getSbmDetails(p_sbm, 'adresSorgu'), 'ilceAd'), 'ilceAd')) end);
        update tnswin.pricing_tariff_log set ssbm=ppil||'-'||ppilce where price_id=s_PricingId;
        commit;
        select count(0) into detaillogcheck from tnswin.pricing_tariff_log_check;
        if (detaillogcheck>0) then
            select usedetaillog into detaillogcheck from tnswin.pricing_tariff_log_check;
            if (detaillogcheck>0) then
                insert into tnswin.pricing_tariff_log_detail(price_id, ssbm) values(s_PricingId, p_sbm);
                commit;
            end if;
        end if;
    EXCEPTION WHEN OTHERS THEN
    if s_systemtime is null then
       p_systemtime := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF');
    else
        if length(s_systemtime)<=15 then
            p_systemtime := s_systemtime;
        else
            p_systemtime := substr(s_systemtime,1,15);
        end if;
    end if;
            v_errm := SUBSTR(SQLERRM, 1, 4000);
        insert into pricing_tariff_log(price_id,price_type,system_Date,system_time,output, error_Desc,finish_time,SSQL,M1,M2,M3,M4,M5,M6,psql,ssbm,authorization_msg,cache_key,status,M7,M8,M9,M10,M11,M12,M13,M14,M15,M16,M17,M18,tarifeprim, tarifeprimcapdahil,kimlikplakaoncekihasaradet,M19)
        values(s_PricingId,s_PriceType,to_char(sysdate,'DD/MM/YYYY'),p_systemtime,'',s_errorDesc,TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF'),v_errm,s_m1,s_m2,s_m3,s_m4,s_m5,s_m6,p_sql,p_sbm ,auth,cache_key,'0',s_m7,s_m8,s_m9,s_m10,s_m11,s_m12,s_m13,s_m14,s_m15,s_m16,s_m17,s_m18,s_toplamprim,s_toplamprimcap,s_otorNihaiHasarAdet,p_m19);
        commit;
    end;

     FUNCTION getYenilemeYeniIsKod (
       tariffDate varchar2,
       clob_tcknPlakaSorgu in CLOB,
       sasi VARCHAR2,
       plakaNo VARCHAR2,
       kimlikNo VARCHAR2
     )
     RETURN VARCHAR2 AS
      s_ReturnType VARCHAR2(3);
      s_ReturnValue NUMBER;
     BEGIN
     select z.sirketkodu into s_ReturnType from
     (select y.sirketKodu, y.plakano, y.sasino, to_date(substr(y.policebaslamatarihi,1,10),'YYYY-MM-DD') policebaslamatarihi, to_date(substr(y.policebitistarihi,1,10),'YYYY-MM-DD') policebitistarihi, to_date(substr(y.policeekibaslamatarihi,1,10),'YYYY-MM-DD') policeekibaslamatarihi, y.zeylturu
  FROM (select xmltype(clob_tcknPlakaSorgu) as data from dual) t,
    XMLTABLE ('/ovmKaskoPoliceByKimlikPlakaSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'      PASSING t.data
             COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
             policeBitisTarihi VARCHAR2(30) PATH 'policeBitisTarihi',
             policeEkiBaslamaTarihi VARCHAR2(30) PATH 'policeEkiBaslamaTarihi',
             zeylTuru VARCHAR2(5) PATH 'zeylTuru',
             sasiNo VARCHAR2(25) PATH 'arac/sasiNo',
             plakaNo VARCHAR2(10) PATH 'arac/plakaNo',
             sirketKodu VARCHAR2(3) PATH 'sirketKodu') y) z where (z.plakaNo='YK' and z.sasino=sasi and z.zeylturu not in('3','38','43','44') and ((z.policeEkiBaslamaTarihi is not null and z.policeEkiBaslamaTarihi between sysdate-45 and sysdate+45 and zeylturu in('8','9')) or (z.policebitisTarihi between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45 and zeylturu  not in('8','9'))))
                                                               or (z.plakaNo<>'YK' and z.zeylturu not in('3','38','43','44') and ((z.policeEkiBaslamaTarihi is not null and z.policeEkiBaslamaTarihi between sysdate-45 and sysdate+45 and zeylturu in('8','9')) or (z.policebitisTarihi between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45 and zeylturu  not in('8','9'))));
   /* if s_ReturnType not in('051','51') THEN
        select count(0) into s_ReturnValue
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=10011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500)
                                                                                and p.policy_status='O'
                                                                                and (um.tax_no=kimlikno or um.citizenship_number=kimlikno or um.foreign_citizenship_number=kimlikno)
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45;
        if s_ReturnValue > 0 THEN s_ReturnType := '051'; end if;
    end if;*/
     return s_ReturnType;
     EXCEPTION WHEN OTHERS THEN
        select sum(adet) into s_ReturnValue from
        (select count(0) adet
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=10011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500,504)
                                                                                and p.policy_status='O'
                                                                                and um.tax_no=kimlikno
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45
        union all
        select count(0) adet
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=10011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500,504)
                                                                                and p.policy_status='O'
                                                                                and um.citizenship_number=kimlikno
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45
        union all
        select count(0) adet
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=10011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500,504)
                                                                                and p.policy_status='O'
                                                                                and um.foreign_citizenship_number=kimlikno
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45);
        if s_ReturnValue > 0 THEN s_ReturnType := '051'; else s_ReturnType := '99'; end if;
     return s_ReturnType;
     END getYenilemeYeniIsKod;

/*
     FUNCTION getYenilemeYeniIsKod (
       tariffDate varchar2,
       clob_tcknPlakaSorgu in CLOB,
       sasi VARCHAR2,
       plakaNo VARCHAR2,
       kimlikNo VARCHAR2
     )
     RETURN VARCHAR2 AS
      s_ReturnType VARCHAR2(3);
      s_ReturnValue NUMBER;
     BEGIN
     select z.sirketkodu into s_ReturnType from
     (select y.sirketKodu, y.plakano, y.sasino, to_date(substr(y.policebaslamatarihi,1,10),'YYYY-MM-DD') policebaslamatarihi, to_date(substr(y.policebitistarihi,1,10),'YYYY-MM-DD') policebitistarihi, to_date(substr(y.policeekibaslamatarihi,1,10),'YYYY-MM-DD') policeekibaslamatarihi, y.zeylturu
  FROM (select xmltype(clob_tcknPlakaSorgu) as data from dual) t,
    XMLTABLE ('/ovmKaskoPoliceByKimlikPlakaSorgu/kaskoPoliceSonucTypeList/kaskoPoliceSonucType'      PASSING t.data
             COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'policeBaslamaTarihi',
             policeBitisTarihi VARCHAR2(30) PATH 'policeBitisTarihi',
             policeEkiBaslamaTarihi VARCHAR2(30) PATH 'policeEkiBaslamaTarihi',
             zeylTuru VARCHAR2(5) PATH 'zeylTuru',
             sasiNo VARCHAR2(25) PATH 'arac/sasiNo',
             plakaNo VARCHAR2(10) PATH 'arac/plakaNo',
             sirketKodu VARCHAR2(3) PATH 'sirketKodu') y) z where (z.plakaNo='YK' and z.sasino=sasi and z.zeylturu not in('3','38','43','44') and ((z.policeEkiBaslamaTarihi is not null and z.policeEkiBaslamaTarihi between sysdate-45 and sysdate+45 and zeylturu in('8','9')) or (z.policebitisTarihi between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45 and zeylturu  not in('8','9'))))
                                                               or (z.plakaNo<>'YK' and z.zeylturu not in('3','38','43','44') and ((z.policeEkiBaslamaTarihi is not null and z.policeEkiBaslamaTarihi between sysdate-45 and sysdate+45 and zeylturu in('8','9')) or (z.policebitisTarihi between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45 and zeylturu  not in('8','9')))) and rownum<2;
if s_ReturnType = '051' or s_ReturnType = '51' then
        select sum(adet) into s_ReturnValue from
        (select count(0) adet
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=5011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500,504)
                                                                                and p.policy_status='O'
                                                                                and um.tax_no=kimlikno
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45
        union all
        select count(0) adet
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=5011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500,504)
                                                                                and p.policy_status='O'
                                                                                and um.citizenship_number=kimlikno
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45
        union all
        select count(0) adet
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=5011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500,504)
                                                                                and p.policy_status='O'
                                                                                and um.foreign_citizenship_number=kimlikno
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45);
end if;
        if s_ReturnValue > 0 THEN s_ReturnType := '051'; end if;
  return s_ReturnType;
     EXCEPTION WHEN OTHERS THEN
        select sum(adet) into s_ReturnValue from
        (select count(0) adet
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=5011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500,504)
                                                                                and p.policy_status='O'
                                                                                and um.tax_no=kimlikno
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45
        union all
        select count(0) adet
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=5011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500,504)
                                                                                and p.policy_status='O'
                                                                                and um.citizenship_number=kimlikno
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45
        union all
        select count(0) adet
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=5011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(500,504)
                                                                                and p.policy_status='O'
                                                                                and um.foreign_citizenship_number=kimlikno
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45);
        if s_ReturnValue > 0 THEN s_ReturnType := '051'; else s_ReturnType := '99'; end if;
     return s_ReturnType;
     END getYenilemeYeniIsKod;
*/

    FUNCTION getTrfYenilemeYeniIsKod (
       tariffDate varchar2,
       clob_KimlikSasiSorgu in CLOB,
       sasi VARCHAR2,
       plakaNo VARCHAR2,
       kimlikNo VARCHAR2
     )
     RETURN VARCHAR2 AS
      s_ReturnType VARCHAR2(3);
      s_ReturnValue NUMBER;
     BEGIN
        select count(0) into s_ReturnType from
            (select y.sirketKodu, y.plakano, y.sasino, to_date(substr(y.policebaslamatarihi,1,10),'YYYY-MM-DD') policebaslamatarihi, to_date(substr(y.policebitistarihi,1,10),'YYYY-MM-DD') policebitistarihi, to_date(substr(y.policeekibaslamatarihi,1,10),'YYYY-MM-DD') policeekibaslamatarihi, y.zeylturu
                FROM (select xmltype(clob_KimlikSasiSorgu) as data from dual) t,
                     XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler'      PASSING t.data
                     COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/gecmisTarihi',
                             policeBitisTarihi VARCHAR2(30) PATH 'tarihBilgileri/bitisTarihi',
                             policeEkiBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                             zeylTuru VARCHAR2(5) PATH 'policeEkiTuru',
                             sasiNo VARCHAR2(25) PATH 'aracTemelBilgileri/sasiNo',
                             plakaNo VARCHAR2(10) PATH 'aracTemelBilgileri/plakaNo',
                             sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y) z
            where (z.zeylturu not in('3','38','43','44')
                   and ((z.policeEkiBaslamaTarihi is not null and z.policeEkiBaslamaTarihi between sysdate-45 and sysdate+45 and zeylturu not in ('8','9'))
                   or (z.policebitisTarihi between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45 and zeylturu  not in('8','9'))));

        if s_ReturnType='0' THEN
           select count(0) into s_ReturnType from
                (select y.sirketKodu, y.plakano, y.policeNo, y.sasino, to_date(substr(y.policebaslamatarihi,1,10),'YYYY-MM-DD') policebaslamatarihi, to_date(substr(y.policebitistarihi,1,10),'YYYY-MM-DD') policebitistarihi, to_date(substr(y.policeekibaslamatarihi,1,10),'YYYY-MM-DD') policeekibaslamatarihi, y.zeylturu
                    FROM (select xmltype(clob_KimlikSasiSorgu) as data from dual) t,
                         XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'      PASSING t.data
                         COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/gecmisTarihi',
                                 policeBitisTarihi VARCHAR2(30) PATH 'tarihBilgileri/bitisTarihi',
                                 policeEkiBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                 zeylTuru VARCHAR2(5) PATH 'policeEkiTuru',
                                 sasiNo VARCHAR2(25) PATH 'aracTemelBilgileri/sasiNo',
                                 plakaNo VARCHAR2(10) PATH 'aracTemelBilgileri/plakaNo',
                                 policeNo VARCHAR2(25) PATH 'policeAnahtari/policeNo',
                                 sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y) z
                where (z.zeylturu not in('3','38','43','44')
                      and policeNo not in (
                         select distinct oncekiPoliceNo from
                                    (select y.oncekiPoliceNo
                         FROM (select xmltype(clob_KimlikSasiSorgu) as data from dual) t,
                                   XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'      PASSING t.data
                                            COLUMNS oncekiPoliceNo VARCHAR2(25) PATH 'belgeBilgileri/oncekiPoliceAnahtari/policeNo') y) z
                                            where (z.zeylturu not in('3','38','43','44'))
                      )
                      and ((z.policeEkiBaslamaTarihi is not null and z.policeEkiBaslamaTarihi between sysdate-360 and sysdate+45 and zeylturu not in('8','9'))
                      or (z.policebitisTarihi between to_date(tariffDate,'DD/MM/YYYY')-360 and to_date(tariffDate,'DD/MM/YYYY')+45 and zeylturu  not in('8','9'))));
            if s_ReturnType <> '0' THEN
                select z.sirketkodu into s_ReturnType from
                    (select y.sirketKodu, y.plakano, y.policeNo, y.sasino, to_date(substr(y.policebaslamatarihi,1,10),'YYYY-MM-DD') policebaslamatarihi, to_date(substr(y.policebitistarihi,1,10),'YYYY-MM-DD') policebitistarihi, to_date(substr(y.policeekibaslamatarihi,1,10),'YYYY-MM-DD') policeekibaslamatarihi, y.zeylturu
                        FROM (select xmltype(clob_KimlikSasiSorgu) as data from dual) t,
                             XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'      PASSING t.data
                             COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/gecmisTarihi',
                                     policeBitisTarihi VARCHAR2(30) PATH 'tarihBilgileri/bitisTarihi',
                                     policeEkiBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                     zeylTuru VARCHAR2(5) PATH 'policeEkiTuru',
                                     sasiNo VARCHAR2(25) PATH 'aracTemelBilgileri/sasiNo',
                                     plakaNo VARCHAR2(10) PATH 'aracTemelBilgileri/plakaNo',
                                     policeNo VARCHAR2(25) PATH 'policeAnahtari/policeNo',
                                     sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y) z
                    where (z.zeylturu not in('3','38','43','44')
                          and policeNo not in (
                              select distinct oncekiPoliceNo from
                                         (select y.oncekiPoliceNo
                              FROM (select xmltype(clob_KimlikSasiSorgu) as data from dual) t,
                                        XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'      PASSING t.data
                                                 COLUMNS oncekiPoliceNo VARCHAR2(25) PATH 'belgeBilgileri/oncekiPoliceAnahtari/policeNo') y) z
                                                 where (z.zeylturu not in('3','38','43','44'))
                          )
                          and ((z.policeEkiBaslamaTarihi is not null and z.policeEkiBaslamaTarihi between sysdate-360 and sysdate+45 and zeylturu not in('8','9'))
                          or (z.policebitisTarihi between to_date(tariffDate,'DD/MM/YYYY')-360 and to_date(tariffDate,'DD/MM/YYYY')+45 and zeylturu  not in('8','9'))));
            end if;
        else
            select z.sirketkodu into s_ReturnType from
                (select y.sirketKodu, y.plakano, y.sasino, to_date(substr(y.policebaslamatarihi,1,10),'YYYY-MM-DD') policebaslamatarihi, to_date(substr(y.policebitistarihi,1,10),'YYYY-MM-DD') policebitistarihi, to_date(substr(y.policeekibaslamatarihi,1,10),'YYYY-MM-DD') policeekibaslamatarihi, y.zeylturu
                    FROM (select xmltype(clob_KimlikSasiSorgu) as data from dual) t,
                         XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler'      PASSING t.data
                         COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/gecmisTarihi',
                                 policeBitisTarihi VARCHAR2(30) PATH 'tarihBilgileri/bitisTarihi',
                                 policeEkiBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                 zeylTuru VARCHAR2(5) PATH 'policeEkiTuru',
                                 sasiNo VARCHAR2(25) PATH 'aracTemelBilgileri/sasiNo',
                                 plakaNo VARCHAR2(10) PATH 'aracTemelBilgileri/plakaNo',
                                 sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y) z
                 where (z.zeylturu not in('3','38','43','44')
                       and ((z.policeEkiBaslamaTarihi is not null and z.policeEkiBaslamaTarihi between sysdate-45 and sysdate+45 and zeylturu not in('8','9'))
                       or (z.policebitisTarihi between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45 and zeylturu  not in('8','9'))));

        end if;

    if s_ReturnType not in('051','51') THEN
        select count(0) into s_ReturnValue
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=5011 and c.answer=sasi
                                                                            and p.firm_code=2 and p.company_code=2
                                                                            and c.firm_code=2 and c.company_code=2
                                                                            and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                            and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                            and p.cancellation_date = '31/12/2029'
                                                                            and p.client_firm_code=um.firm_code
                                                                            and p.client_unit_type=um.unit_type
                                                                            and p.client_no=um.unit_no
                                                                            and p.product_no in(550,554,556)
                                                                            and p.policy_status='O'
                                                                            and (um.tax_no=kimlikno or um.citizenship_number=kimlikno or um.foreign_citizenship_number=kimlikno)
                                                                            and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45;

        if s_ReturnValue > 0 THEN s_ReturnType := '051'; end if;
    end if;
     return s_ReturnType;
     EXCEPTION WHEN OTHERS THEN
        select count(0) into s_ReturnValue
        from t001psrcvp c, t001polmas p, t008unsmas um where c.question_code=5011 and c.answer=sasi
                                                                                and p.firm_code=2 and p.company_code=2
                                                                                and c.firm_code=2 and c.company_code=2
                                                                                and p.product_no=c.product_no and p.policy_no=c.policy_no
                                                                                and p.renewal_no=c.renewal_no and p.endors_no=c.endors_no
                                                                                and p.cancellation_date = '31/12/2029'
                                                                                and p.client_firm_code=um.firm_code
                                                                                and p.client_unit_type=um.unit_type
                                                                                and p.client_no=um.unit_no
                                                                                and p.product_no in(550,554,556)
                                                                                and p.policy_status='O'
                                                                                and (um.tax_no=kimlikno or um.citizenship_number=kimlikno or um.foreign_citizenship_number=kimlikno)
                                                                                and p.pol_end_date between to_date(tariffDate,'DD/MM/YYYY')-45 and to_date(tariffDate,'DD/MM/YYYY')+45;
        if s_ReturnValue > 0 THEN s_ReturnType := '051'; else s_ReturnType := '99'; end if;
     return s_ReturnType;
     END getTrfYenilemeYeniIsKod;

    FUNCTION getTRFYenilemeYil (
      p_xml_value in CLOB
    )
    RETURN NUMBER AS
    s_yenilemeYil NUMBER(11);
    sira date;
    sira1 date;
    sirason date;
    v_errm VARCHAR2(4000);
    BEGIN

    select max(to_date(substr(t.policebaslamatarihi,1,10),'YYYY-MM-DD')) into sira from
         (select z.* from
         (select y.*
      FROM (select xmltype(p_xml_value) as data from dual) t,
        XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler'      PASSING t.data
                 COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                 uygulanmasiGerekenGecikmeSurp VARCHAR2(30) PATH 'belgeBilgileri/uygulanmasiGerekenGecikmeSurprimYuzde',
                 policeEkiTuru varchar2(5) PATH 'policeEkiTuru',
                 sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y
        union all
        select y.*
      FROM (select xmltype(p_xml_value) as data from dual) t,
        XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'      PASSING t.data
                 COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                 uygulanmasiGerekenGecikmeSurp VARCHAR2(30) PATH 'belgeBilgileri/uygulanmasiGerekenGecikmeSurprimYuzde',
                 policeEkiTuru varchar2(5) PATH 'policeEkiTuru',
                 sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y
        ) z order by to_date(substr(z.policebaslamatarihi,1,10),'YYYY-MM-DD')) t

        where to_date(substr(t.policebaslamatarihi,1,10),'YYYY-MM-DD')>='01/01/2009'
        and t.sirketkodu<>'051'
    --        and t.uygulanmasiGerekenGecikmeSurp >= 6
        and t.policeekituru not in('3','4','8','9')
            and to_date(substr(t.policebaslamatarihi,1,10),'YYYY-MM-DD')<to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD');

    select max(to_date(substr(t.policebaslamatarihi,1,10),'YYYY-MM-DD')) into sira1 from
         (select z.* from
         (select y.*
      FROM (select xmltype(p_xml_value) as data from dual) t,
        XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler'      PASSING t.data
                 COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                 uygulanmasiGerekenGecikmeSurp VARCHAR2(30) PATH 'belgeBilgileri/uygulanmasiGerekenGecikmeSurprimYuzde',
                 policeEkiTuru varchar2(5) PATH 'policeEkiTuru',
                 sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y
        union all
        select y.*
      FROM (select xmltype(p_xml_value) as data from dual) t,
        XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'      PASSING t.data
                 COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                 uygulanmasiGerekenGecikmeSurp VARCHAR2(30) PATH 'belgeBilgileri/uygulanmasiGerekenGecikmeSurprimYuzde',
                 policeEkiTuru varchar2(5) PATH 'policeEkiTuru',
                 sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y
        ) z order by to_date(substr(z.policebaslamatarihi,1,10),'YYYY-MM-DD')) t

        where to_date(substr(t.policebaslamatarihi,1,10),'YYYY-MM-DD')>='01/01/2009'
        and t.sirketkodu='051'
            and t.policeekituru not in('3','4','8','9')
        and t.uygulanmasiGerekenGecikmeSurp >= 6
        and to_date(substr(t.policebaslamatarihi,1,10),'YYYY-MM-DD')<to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD');
    if sira1 is not null then
        if sira is not null then
            if sira1>sira then sirason:=sira1; else sirason:=sira; end if;
        else
            sirason := sira1;
        end if;
    else
        if sira is not null then
            sirason:=sira;
        else
            sirason := '01/01/1990';
        end if;
    end if;
    if sirason is null then sirason:='01/01/1990'; end if;

    select count(0) into s_yenilemeYil from
         (select z.* from
         (select y.*
      FROM (select xmltype(p_xml_value) as data from dual) t,
        XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler'      PASSING t.data
                 COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                 uygulanmasiGerekenGecikmeSurp VARCHAR2(30) PATH 'belgeBilgileri/uygulanmasiGerekenGecikmeSurprimYuzde',
                 sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y
        union all
        select y.*
      FROM (select xmltype(p_xml_value) as data from dual) t,
        XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'      PASSING t.data
                 COLUMNS policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                 uygulanmasiGerekenGecikmeSurp VARCHAR2(30) PATH 'belgeBilgileri/uygulanmasiGerekenGecikmeSurprimYuzde',
                 sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu') y
        ) z order by to_date(substr(z.policebaslamatarihi,1,10),'YYYY-MM-DD')) t

        where to_date(substr(t.policebaslamatarihi,1,10),'YYYY-MM-DD')>='01/01/2009'
            and t.sirketKodu='051'
            and to_date(substr(t.policebaslamatarihi,1,10),'YYYY-MM-DD')>=sirason
            and to_date(substr(t.policebaslamatarihi,1,10),'YYYY-MM-DD')<to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD');
    if s_yenilemeYil>0 then s_yenilemeYil:=s_yenilemeYil-1; end if;
    if s_yenilemeYil>6 then s_yenilemeYil:=6; end if;
    RETURN s_yenilemeYil;

    EXCEPTION WHEN OTHERS THEN
       v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       --select decode(nvl(s_CommercialScor,1),0,1,nvl(s_CommercialScor,1)) into s_CommercialScor99 from dual;
       --addpricinglog ('SigortalıSkor',s_poolNo, s_Fx, s_Gls, s_Ngls, s_Severity, s_OrtalamaBedel, s_CommercialScor99, s_MinScor, s_MaxScor, s_PricingId,  p_taxNo,  p_kullanimSekli,  p_aracBedeli,  p_hasarsizlikKademesi,  p_hasarsizlikIndirimOrani,  p_tarifePrimi, s_KazanilmisPolice, s_RucusuzHasarlar, s_yururPoliceler, s_camHasarSayisi, p_tarih, p_saat,  p_kullanici,  p_acenteKodu, s_hasarsizlikFaktor, s_cachePriceId, v_errm);
       return 0;

    end getTRFYenilemeYil;

    FUNCTION getTRFSigortalilikSuresi (
      p_xml_value in CLOB
    )
    RETURN NUMBER AS
    s_sigortalilikSuresi NUMBER(11);
    v_errm VARCHAR2(4000);
    BEGIN

    select NVL(sum(sigortalilikSuresi),0) into s_sigortalilikSuresi
        from
        (
            select
                v.*,
                round(nvl(case when v.iptalmi=1 then to_date(substr(v.policeekibaslamatarihi,1,10),'YYYY-MM-DD') - to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD')
                                        else case when to_date(substr(v.policebitistarihi,1,10),'YYYY-MM-DD')>system_date then system_date-to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD')
                                        else to_date(substr(v.policebitistarihi,1,10),'YYYY-MM-DD')-to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD') end
                                        end,0)/365,2) sigortalilikSuresi
            from
            (
                select
                distinct to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, y.policeNo ,y.yenilemeno ,y.policeEkino ,y.policeEkiTuru ,
                case when y.policeEkiTuru in(8,9,13) then 1 else 0 end iptalmi,
                case when y.policeEkiTuru in(3) then 1 else 0 end mebiptalmi,
                y.policeBaslamaTarihi ,y.policeBitisTarihi ,y.policeEkiBaslamaTarihi,
                y.aracMarkaKodu ,y.aracTarifeGrupKodu ,y.aracTipKodu ,y.kullanimSekli ,y.modelYili ,y.plakaIlKodu ,y.plakaNo
                from
                (
                     select 'gecmisPoliceler', x1.*
                             from
                                (select xmltype(p_xml_value) data from dual) t,
                                --(select  xmltype(txt) data from test where idx = 10) t,
                                XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                          ) x1
                    UNION ALL
                     select 'yururPoliceler',x2.*
                             from
                                 (select xmltype(p_xml_value) data from dual) t,
                                 --(select  xmltype(txt) data from test where idx = 10) t,
                                 XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                          ) x2
                ) y
            ) v where v.mebiptalmi != 1
        ) s;

    RETURN s_sigortalilikSuresi;

    EXCEPTION WHEN OTHERS THEN
       v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       --select decode(nvl(s_CommercialScor,1),0,1,nvl(s_CommercialScor,1)) into s_CommercialScor99 from dual;
       --addpricinglog ('SigortalıSkor',s_poolNo, s_Fx, s_Gls, s_Ngls, s_Severity, s_OrtalamaBedel, s_CommercialScor99, s_MinScor, s_MaxScor, s_PricingId,  p_taxNo,  p_kullanimSekli,  p_aracBedeli,  p_hasarsizlikKademesi,  p_hasarsizlikIndirimOrani,  p_tarifePrimi, s_KazanilmisPolice, s_RucusuzHasarlar, s_yururPoliceler, s_camHasarSayisi, p_tarih, p_saat,  p_kullanici,  p_acenteKodu, s_hasarsizlikFaktor, s_cachePriceId, v_errm);
       return 0;

    end getTRFSigortalilikSuresi;


    FUNCTION getSonTRFPoliceKademe (
      p_xml_value in CLOB
    )
    RETURN NUMBER AS
    s_kademe NUMBER(11);
    v_errm VARCHAR2(4000);
    BEGIN

    select nvl(kademe,0) into s_kademe
        from
        (
            select
                v.*,
                round(nvl(case when v.iptalmi=1 then to_date(substr(v.policeekibaslamatarihi,1,10),'YYYY-MM-DD') - to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD')
                                        else case when to_date(substr(v.policebitistarihi,1,10),'YYYY-MM-DD')>system_date then system_date-to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD')
                                        else to_date(substr(v.policebitistarihi,1,10),'YYYY-MM-DD')-to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD') end
                                        end,0)/365,2) sigortalilikSuresi
            from
            (
                select
                distinct to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, y.policeNo ,y.yenilemeno ,y.policeEkino ,y.policeEkiTuru ,
                case when y.policeEkiTuru in(8,9,13) then 1 else 0 end iptalmi,
                case when y.policeEkiTuru in(3) then 1 else 0 end mebiptalmi,
                y.policeBaslamaTarihi ,y.policeBitisTarihi ,y.policeEkiBaslamaTarihi,
                y.aracMarkaKodu ,y.aracTarifeGrupKodu ,y.aracTipKodu ,y.kullanimSekli ,y.modelYili ,y.plakaIlKodu ,y.plakaNo, kademe
                from
                (
                     select 'gecmisPoliceler', x1.*
                             from
                                (select xmltype(p_xml_value) data from dual) t,
                                --(select  xmltype(value) data from tarife_test where id = 22) t,
                                XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no',
                                              kademe varchar2(10) PATH 'belgeBilgileri/uygulanmasiGerekenTarifeBasamakKodu'
                                          ) x1
                    UNION ALL
                     select 'yururPoliceler',x2.*
                             from
                                 (select xmltype(p_xml_value) data from dual) t,
                                 --(select  xmltype(value) data from tarife_test where id = 22) t,
                                 XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no',
                                              kademe varchar2(10) PATH 'belgeBilgileri/uygulanmasiGerekenTarifeBasamakKodu'
                                          ) x2
                ) y
            ) v where v.mebiptalmi != 1 order by policebaslamatarihi desc
        ) s where rownum=1;

    RETURN s_kademe;

    EXCEPTION WHEN OTHERS THEN
       v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       --select decode(nvl(s_CommercialScor,1),0,1,nvl(s_CommercialScor,1)) into s_CommercialScor99 from dual;
       --addpricinglog ('SigortalıSkor',s_poolNo, s_Fx, s_Gls, s_Ngls, s_Severity, s_OrtalamaBedel, s_CommercialScor99, s_MinScor, s_MaxScor, s_PricingId,  p_taxNo,  p_kullanimSekli,  p_aracBedeli,  p_hasarsizlikKademesi,  p_hasarsizlikIndirimOrani,  p_tarifePrimi, s_KazanilmisPolice, s_RucusuzHasarlar, s_yururPoliceler, s_camHasarSayisi, p_tarih, p_saat,  p_kullanici,  p_acenteKodu, s_hasarsizlikFaktor, s_cachePriceId, v_errm);
       return 0;

    end getSonTRFPoliceKademe;


    FUNCTION getTRFGecikmeSurprimi (p_system_date in date, p_registry_date in date, p_type varchar2)
    RETURN NUMBER AS
    surcharge NUMBER := 0;
    differenceDays NUMBER;
    v_errm VARCHAR2(4000);
    BEGIN
        select round(TO_DATE(TO_CHAR(p_system_date,'DD/MM/YYYY'),'DD/MM/YYYY') - TO_DATE(TO_CHAR(p_registry_date,'DD/MM/YYYY'),'DD/MM/YYYY') ,0) into differenceDays from dual;
/*        IF differenceDays > 300 THEN
            surcharge := 50;
        ELSIF differenceDays > 270 THEN
            surcharge := 45;
        ELSIF differenceDays > 240 THEN
            surcharge := 40;
        ELSIF differenceDays > 210 THEN
            surcharge := 35;
        ELSIF differenceDays > 180 THEN
            surcharge := 30;
        ELSIF differenceDays > 150 THEN
            surcharge := 25;
        ELSIF differenceDays > 120 THEN
            surcharge := 20;
        ELSIF differenceDays > 90 THEN
            surcharge := 15;
        ELSIF differenceDays > 60 THEN
            surcharge := 10;
        ELSIF differenceDays > 30 THEN
            surcharge := 5;
        ELSE
            surcharge := 0;
        END IF;*/
        if p_type = 'TIPX' then
            IF differenceDays > 285 THEN
                surcharge := 50;
            ELSIF differenceDays > 255 THEN
                surcharge := 45;
            ELSIF differenceDays > 225 THEN
                surcharge := 40;
            ELSIF differenceDays > 195 THEN
                surcharge := 35;
            ELSIF differenceDays > 165 THEN
                surcharge := 30;
            ELSIF differenceDays > 135 THEN
                surcharge := 25;
            ELSIF differenceDays > 105 THEN
                surcharge := 20;
            ELSIF differenceDays > 75 THEN
                surcharge := 15;
            ELSIF differenceDays > 45 THEN
                surcharge := 10;
            ELSIF differenceDays > 15 THEN
                surcharge := 5;
            ELSE
                surcharge := 0;
            END IF;
        elsif p_type = 'TIPY' then
            IF differenceDays > 270 THEN
                surcharge := 50;
            ELSIF differenceDays > 240 THEN
                surcharge := 45;
            ELSIF differenceDays > 210 THEN
                surcharge := 40;
            ELSIF differenceDays > 180 THEN
                surcharge := 35;
            ELSIF differenceDays > 150 THEN
                surcharge := 30;
            ELSIF differenceDays > 120 THEN
                surcharge := 25;
            ELSIF differenceDays > 90 THEN
                surcharge := 20;
            ELSIF differenceDays > 60 THEN
                surcharge := 15;
            ELSIF differenceDays > 30 THEN
                surcharge := 10;
            ELSIF differenceDays = 0 THEN
                surcharge := 0;
            ELSE
                surcharge := 5;
            END IF;
        end if;
        RETURN surcharge;
    end getTRFGecikmeSurprimi;


    FUNCTION  getTariffDetay(productNoo varchar2, TariffDate IN date,kullanimsekli varchar2, kullanimtarzi varchar2, aracyasi varchar2, plakailkodu varchar2, tramerIl varchar2,tramerilce varchar2, yenilemeyeniiskod varchar2, sigortaliyas varchar2, aracbedeli varchar2, yakittipi varchar2, medenidurum varchar2, cocukdegiskeni varchar2, kismiHasarSayisi varchar2, sigortaliliksuresi varchar2, cinsiyet varchar2, hasarsizlikkademesi varchar2, markariskgrubu varchar2, camhasarsayisi varchar2, pakettipi varchar2, yenilemecamindirimi varchar2, filosegment varchar2, guncelbedel varchar2, sigortaliskor number, aracskor varchar2, surprim number, ozelindirim number, kullanimtipi varchar2, yurtdisiay varchar2, markakodu varchar2, yeniaracbedel number, meslek varchar2, markatipkodu varchar2, trafikkademesi varchar2, commercialScore varchar2 , kiymetKazanma varchar2, ilkAracYasi varchar2, plaka100502 varchar2, ozelTuzel varchar2, ticariFaktor varchar2,P_WHP VARCHAR2,p_aracsegment varchar2,p_kasaTipi varchar2, cammuafiyetIstisnasi varchar2, p_cocukSayisi varchar2, p_hasarSayisi varchar2, oncekiTrafikKademesi varchar2,hatliMi varchar2, gecikmeSurprimi varchar2, yenilemeYili varchar2, trfFrekans varchar2,p_trafikKayitliAracSayisi NUMBER, p_aracSayisiKimlik NUMBER,p_yasayanOtoUrun varchar2,p_teenCocuk varchar2,p_ErkekTeenCocuk varchar2,p_pertarac varchar2, p_aracyerliyabanci varchar2, p_garaj varchar2, p_resmidaire varchar2, p_servis varchar2, p_muafiyet varchar2, p_anlasmaliservis varchar2, p_parcaTuru varchar2, p_servisTuru varchar2, p_surucuInd varchar2, channel varchar2, araccoklugu varchar2, acenteCarpan varchar2, aracYasGrubu varchar2, kontrol1 varchar2, kontrol2 varchar2, kontrol3 varchar2, kontrol4 varchar2, s8000 varchar2, s8060 varchar2, kontrol5 varchar2, eurocar_segment varchar2, eurocar_kasatipi varchar2, eurocar_sanziman varchar2, NBRENEWAL2 varchar2, markaTipGrup varchar2, ililcegrup varchar2, birYilOncekiHasar varchar2, ikiYilOncekiHasar varchar2, ucYilOncekiHasar varchar2, p_aracBedelGrubu varchar2, p_ortalamaHasarTutar1 varchar2,p_ortalamaHasarTutar2 varchar2,p_ortalamaHasarTutar3 varchar2, p_sonUcYilHasarSayisi varchar2, p_bifurcationSegment varchar2, p_bifurcationSubSegment varchar2)
       RETURN CLOB
    IS
       OldFactorName varchar2(30);
       var1 varchar2(100);
       var2 varchar2(100);
       var3 varchar2(100);
       var4 varchar2(100);
       var5 varchar2(100);
       var6 varchar2(100);
       var7 varchar2(100);
       var8 varchar2(100);
       var9 varchar2(100);
       var11 varchar2(100);
       var12 varchar2(100);
       var21 varchar2(100);
       var22 varchar2(100);
       var31 varchar2(100);
       var32 varchar2(100);
       var41 varchar2(100);
       var42 varchar2(100);
       var51 varchar2(100);
       var52 varchar2(100);
       var61 varchar2(100);
       var62 varchar2(100);
       var71 varchar2(100);
       var72 varchar2(100);
       var81 varchar2(100);
       var82 varchar2(100);
       var91 varchar2(100);
       var92 varchar2(100);
       d1 varchar2(70);
       d2 varchar2(70);
       d3 varchar2(70);
       d4 varchar2(70);
       d5 varchar2(70);
       d6 varchar2(70);
       d7 varchar2(70);
       d8 varchar2(70);
       d9 varchar2(70);
       tarSelectVal varchar2(300);
       tarTableVal varchar2(50);
       tarCondVal varchar2(50);
       f_sql CLOB;

       cursor c1 is
       SELECT x.factorType, x.factorName, x.TableName, x.startdate, x.OrderType, x.condition1, x.variable1, operator1, datatype1,ParameterName1,TargetValue1,ParameterOrderType1,ParameterColumnName11,ParameterVariable11,ParameterOperator11,ParameterColumnName12,ParameterVariable12,ParameterOperator12,
            x.condition2, x.variable2, operator2, datatype2, ParameterName2,TargetValue2,ParameterOrderType2,ParameterColumnName21,ParameterVariable21,ParameterOperator21,ParameterColumnName22,ParameterVariable22,ParameterOperator22,
            x.condition3, x.variable3, operator3, datatype3,ParameterName3,TargetValue3,ParameterOrderType3,ParameterColumnName31,ParameterVariable31,ParameterOperator31,ParameterColumnName32,ParameterVariable32,ParameterOperator32,
            x.condition4, x.variable4, operator4, datatype4,ParameterName4,TargetValue4,ParameterOrderType4,ParameterColumnName41,ParameterVariable41,ParameterOperator41,ParameterColumnName42,ParameterVariable42,ParameterOperator42,
            x.condition5, x.variable5, operator5, datatype5,ParameterName5,TargetValue5,ParameterOrderType5,ParameterColumnName51,ParameterVariable51,ParameterOperator51,ParameterColumnName52,ParameterVariable52,ParameterOperator52,
            x.condition6, x.variable6, operator6, datatype6,ParameterName6,TargetValue6,ParameterOrderType6,ParameterColumnName61,ParameterVariable61,ParameterOperator61,ParameterColumnName62,ParameterVariable62,ParameterOperator62,
            x.condition7, x.variable7, operator7, datatype7,ParameterName7,TargetValue7,ParameterOrderType7,ParameterColumnName71,ParameterVariable71,ParameterOperator71,ParameterColumnName72,ParameterVariable72,ParameterOperator72,
            x.condition8, x.variable8, operator8, datatype8,ParameterName8,TargetValue8,ParameterOrderType8,ParameterColumnName81,ParameterVariable81,ParameterOperator81,ParameterColumnName82,ParameterVariable82,ParameterOperator82,
            x.condition9, x.variable9, operator9, datatype9,ParameterName9,TargetValue9,ParameterOrderType9,ParameterColumnName91,ParameterVariable91,ParameterOperator91,ParameterColumnName92,ParameterVariable92,ParameterOperator92
        FROM (select xmltype(t.factorxml) data from tarife_1 t where t.productNo=productNoo and t.startdate=(select max(t1.startdate) from tarife_1 t1 where t1.startdate<=TariffDate and t1.productNo=productNoo)) t,
        XMLTABLE ('/Tariff/Factor'      PASSING t.data
                COLUMNS FactorType VARCHAR2(30) PATH 'FactorType',
                FactorName VARCHAR2(30) PATH 'FactorName',
                TableName VARCHAR2(30)  PATH 'TableName',
                StartDate VARCHAR2(30) PATH 'StartDate',
                OrderType VARCHAR2(30) PATH 'OrderType',
                Condition1 VARCHAR2(30) PATH 'Condition[1]/ColumnName',
                Variable1 VARCHAR2(30) PATH 'Condition[1]/Variable',
                Operator1 VARCHAR2(30) PATH 'Condition[1]/Operator',
                DataType1 VARCHAR2(30) PATH 'Condition[1]/DataType',
                ParameterName1 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterName',
                TargetValue1 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/TargetValue',
                ParameterOrderType1 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/OrderType',
                ParameterColumnName11 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[1]/ColumnName',
                ParameterVariable11 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[1]/Variable',
                ParameterOperator11 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[1]/Operator',
                ParameterColumnName12 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[2]/ColumnName',
                ParameterVariable12 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[2]/Variable',
                ParameterOperator12 VARCHAR2(30) PATH 'Condition[1]/VariableParameter/ParameterCondition[2]/Operator',

                Condition2 VARCHAR2(30) PATH 'Condition[2]/ColumnName',
                Variable2 VARCHAR2(30) PATH 'Condition[2]/Variable',
                Operator2 VARCHAR2(30) PATH 'Condition[2]/Operator',
                DataType2 VARCHAR2(30) PATH 'Condition[2]/DataType',
                ParameterName2 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterName',
                TargetValue2 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/TargetValue',
                ParameterOrderType2 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/OrderType',
                ParameterColumnName21 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[1]/ColumnName',
                ParameterVariable21 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[1]/Variable',
                ParameterOperator21 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[1]/Operator',
                ParameterColumnName22 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[2]/ColumnName',
                ParameterVariable22 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[2]/Variable',
                ParameterOperator22 VARCHAR2(30) PATH 'Condition[2]/VariableParameter/ParameterCondition[2]/Operator',

                Condition3 VARCHAR2(30) PATH 'Condition[3]/ColumnName',
                Variable3 VARCHAR2(30) PATH 'Condition[3]/Variable',
                Operator3 VARCHAR2(30) PATH 'Condition[3]/Operator',
                DataType3 VARCHAR2(30) PATH 'Condition[3]/DataType',
                ParameterName3 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterName',
                TargetValue3 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/TargetValue',
                ParameterOrderType3 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/OrderType',
                ParameterColumnName31 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[1]/ColumnName',
                ParameterVariable31 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[1]/Variable',
                ParameterOperator31 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[1]/Operator',
                ParameterColumnName32 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[2]/ColumnName',
                ParameterVariable32 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[2]/Variable',
                ParameterOperator32 VARCHAR2(30) PATH 'Condition[3]/VariableParameter/ParameterCondition[2]/Operator',

                Condition4 VARCHAR2(30) PATH 'Condition[4]/ColumnName',
                Variable4 VARCHAR2(30) PATH 'Condition[4]/Variable',
                Operator4 VARCHAR2(30) PATH 'Condition[4]/Operator',
                DataType4 VARCHAR2(30) PATH 'Condition[4]/DataType',
                ParameterName4 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterName',
                TargetValue4 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/TargetValue',
                ParameterOrderType4 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/OrderType',
                ParameterColumnName41 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[1]/ColumnName',
                ParameterVariable41 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[1]/Variable',
                ParameterOperator41 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[1]/Operator',
                ParameterColumnName42 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[2]/ColumnName',
                ParameterVariable42 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[2]/Variable',
                ParameterOperator42 VARCHAR2(30) PATH 'Condition[4]/VariableParameter/ParameterCondition[2]/Operator',

                Condition5 VARCHAR2(30) PATH 'Condition[5]/ColumnName',
                Variable5 VARCHAR2(30) PATH 'Condition[5]/Variable',
                Operator5 VARCHAR2(30) PATH 'Condition[5]/Operator',
                DataType5 VARCHAR2(30) PATH 'Condition[5]/DataType',
                ParameterName5 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterName',
                TargetValue5 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/TargetValue',
                ParameterOrderType5 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/OrderType',
                ParameterColumnName51 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[1]/ColumnName',
                ParameterVariable51 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[1]/Variable',
                ParameterOperator51 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[1]/Operator',
                ParameterColumnName52 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[2]/ColumnName',
                ParameterVariable52 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[2]/Variable',
                ParameterOperator52 VARCHAR2(30) PATH 'Condition[5]/VariableParameter/ParameterCondition[2]/Operator',

                Condition6 VARCHAR2(30) PATH 'Condition[6]/ColumnName',
                Variable6 VARCHAR2(30) PATH 'Condition[6]/Variable',
                Operator6 VARCHAR2(30) PATH 'Condition[6]/Operator',
                DataType6 VARCHAR2(30) PATH 'Condition[6]/DataType',
                ParameterName6 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterName',
                TargetValue6 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/TargetValue',
                ParameterOrderType6 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/OrderType',
                ParameterColumnName61 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[1]/ColumnName',
                ParameterVariable61 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[1]/Variable',
                ParameterOperator61 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[1]/Operator',
                ParameterColumnName62 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[2]/ColumnName',
                ParameterVariable62 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[2]/Variable',
                ParameterOperator62 VARCHAR2(30) PATH 'Condition[6]/VariableParameter/ParameterCondition[2]/Operator',

                Condition7 VARCHAR2(30) PATH 'Condition[7]/ColumnName',
                Variable7 VARCHAR2(30) PATH 'Condition[7]/Variable',
                Operator7 VARCHAR2(30) PATH 'Condition[7]/Operator',
                DataType7 VARCHAR2(30) PATH 'Condition[7]/DataType',
                ParameterName7 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterName',
                TargetValue7 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/TargetValue',
                ParameterOrderType7 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/OrderType',
                ParameterColumnName71 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[1]/ColumnName',
                ParameterVariable71 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[1]/Variable',
                ParameterOperator71 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[1]/Operator',
                ParameterColumnName72 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[2]/ColumnName',
                ParameterVariable72 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[2]/Variable',
                ParameterOperator72 VARCHAR2(30) PATH 'Condition[7]/VariableParameter/ParameterCondition[2]/Operator',

                Condition8 VARCHAR2(30) PATH 'Condition[8]/ColumnName',
                Variable8 VARCHAR2(30) PATH 'Condition[8]/Variable',
                Operator8 VARCHAR2(30) PATH 'Condition[8]/Operator',
                DataType8 VARCHAR2(30) PATH 'Condition[8]/DataType',
                ParameterName8 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterName',
                TargetValue8 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/TargetValue',
                ParameterOrderType8 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/OrderType',
                ParameterColumnName81 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[1]/ColumnName',
                ParameterVariable81 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[1]/Variable',
                ParameterOperator81 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[1]/Operator',
                ParameterColumnName82 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[2]/ColumnName',
                ParameterVariable82 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[2]/Variable',
                ParameterOperator82 VARCHAR2(30) PATH 'Condition[8]/VariableParameter/ParameterCondition[2]/Operator',

                Condition9 VARCHAR2(30) PATH 'Condition[9]/ColumnName',
                Variable9 VARCHAR2(30) PATH 'Condition[9]/Variable',
                Operator9 VARCHAR2(30) PATH 'Condition[9]/Operator',
                DataType9 VARCHAR2(30) PATH 'Condition[9]/DataType',
                ParameterName9 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterName',
                TargetValue9 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/TargetValue',
                ParameterOrderType9 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/OrderType',
                ParameterColumnName91 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[1]/ColumnName',
                ParameterVariable91 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[1]/Variable',
                ParameterOperator91 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[1]/Operator',
                ParameterColumnName92 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[2]/ColumnName',
                ParameterVariable92 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[2]/Variable',
                ParameterOperator92 VARCHAR2(30) PATH 'Condition[9]/VariableParameter/ParameterCondition[2]/Operator'
                ) x where to_date(x.startdate,'DD/MM/YYYY')<=TariffDate
        order by factortype, factorName, startdate desc;
    BEGIN
    OldFactorName := '0';
       FOR factor_detail in c1
       LOOP
       var1 := '';
       var2 := '';
       var3 := '';
       var4 := '';
       var5 := '';
       var6 := '';
       var7 := '';
       var8 := '';
       var9 := '';
       var11 := '';
       var12 := '';
       var21 := '';
       var22 := '';
       var31 := '';
       var32 := '';
       var41 := '';
       var42 := '';
       var51 := '';
       var52 := '';
       var61 := '';
       var62 := '';
       var71 := '';
       var72 := '';
       var81 := '';
       var82 := '';
       var91 := '';
       var92 := '';

       if factor_detail.FactorType='TariffTable' OR factor_detail.FactorType='ParameterTable' OR factor_detail.FactorType='Const' THEN
        if factor_detail.FactorType='TariffTable' THEN
            tarSelectVal := 'b.table_code as tablename,b.key1,b.key2,b.key3,b.key4,b.key5,b.key6,b.key7,b.key8,b.key9,b.MULT1, b.MULT2, b.MULT3, b.MULT4, b.MULT5, b.MULT6';
            tarTableVal := 'pricing_tables';
            tarCondVal := 'table_code';
        ELSIF factor_detail.FactorType='ParameterTable' THEN
            tarSelectVal := 'b.param_name  as tablename,b.key1,b.key2,'''' key3,'''' key4,'''' key5,'''' key6,'''' key7,'''' key8,'''' key9,cast(b.desc1 as decimal(11,5)) MULT1, cast(b.desc1 as decimal(11,5)) MULT2, cast(b.desc1 as decimal(11,5)) MULT3, cast(b.desc1 as decimal(11,5)) MULT4, cast(b.desc1 as decimal(11,5)) MULT5, cast(b.desc1 as decimal(11,5)) MULT6';
            tarTableVal := 'pricing_parameters';
            tarCondVal := 'param_name';
        END IF;

        if factor_detail.factorname <> OldFactorName THEN
            var1 := getVariableDetail(factor_detail.varIable1,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var2 := getVariableDetail(factor_detail.varIable2,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment ,p_kasaTipi,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var3 := getVariableDetail(factor_detail.varIable3,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment, p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var4 := getVariableDetail(factor_detail.varIable4,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment, p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var5 := getVariableDetail(factor_detail.varIable5,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var6 := getVariableDetail(factor_detail.varIable6,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var7 := getVariableDetail(factor_detail.varIable7,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var8 := getVariableDetail(factor_detail.varIable8,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var9 := getVariableDetail(factor_detail.varIable9,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var11 := getVariableDetail(factor_detail.ParameterVariable11,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var12 := getVariableDetail(factor_detail.ParameterVariable12,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var21 := getVariableDetail(factor_detail.ParameterVariable21,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu , trafikkademesi, commercialScore, kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var22 := getVariableDetail(factor_detail.ParameterVariable22,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var31 := getVariableDetail(factor_detail.ParameterVariable31,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma , ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var32 := getVariableDetail(factor_detail.ParameterVariable32,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var41 := getVariableDetail(factor_detail.ParameterVariable41,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma , ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var42 := getVariableDetail(factor_detail.ParameterVariable42,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var51 := getVariableDetail(factor_detail.ParameterVariable51,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var52 := getVariableDetail(factor_detail.ParameterVariable52,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore, kiymetKazanma , ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var61 := getVariableDetail(factor_detail.ParameterVariable61,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var62 := getVariableDetail(factor_detail.ParameterVariable62,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var71 := getVariableDetail(factor_detail.ParameterVariable71,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var72 := getVariableDetail(factor_detail.ParameterVariable72,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var81 := getVariableDetail(factor_detail.ParameterVariable81,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var82 := getVariableDetail(factor_detail.ParameterVariable82,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var91 := getVariableDetail(factor_detail.ParameterVariable91,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);
            var92 := getVariableDetail(factor_detail.ParameterVariable92,kullanImseklI,kullanImtarzI ,aracyasI ,plakaIlkodu ,tramerIl ,tramerIlce ,yenIlemeyenIIskod ,sIgortalIyas ,aracbedelI ,yakIttIpI ,medenIdurum ,cocukdegIskenI ,kIsmIHasarSayIsI ,sIgortalılıksuresI ,cInsIyet ,hasarsIzlIkkademesI ,markarIskgrubu ,camhasarsayIsI ,pakettIpI ,yenIlemecamIndIrImI ,fIlosegment ,guncelbedel ,sIgortalIskor ,aracskor ,surprIm ,ozelIndIrIm ,kullanImtIpI ,yurtdIsIay ,markakodu, yeniaracbedel, meslek, markatipkodu, trafikkademesi, commercialScore , kiymetKazanma, ilkAracYasi, plaka100502, ozelTuzel,ticariFaktor,P_WHP,p_aracsegment,p_kasaTipi ,cammuafiyetIstisnasi, p_cocukSayisi, p_hasarSayisi, oncekiTrafikKademesi,hatliMi , gecikmeSurprimi , yenilemeYili , trfFrekans,p_trafikKayitliAracSayisi, p_aracSayisiKimlik,p_yasayanOtoUrun,p_teenCocuk,p_ErkekTeenCocuk,p_pertarac, productNoo, p_aracyerliyabanci, p_garaj, p_resmidaire, p_servis, p_muafiyet, p_anlasmaliServis, p_parcaTuru, p_servisTuru, p_surucuInd, channel, araccoklugu, acenteCarpan, aracYasGrubu, kontrol1, kontrol2, kontrol3, kontrol4, s8000, s8060, kontrol5, eurocar_segment, eurocar_kasatipi, eurocar_sanziman, NBRENEWAL2, markaTipGrup, ililcegrup, birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_aracBedelGrubu, p_ortalamaHasarTutar1, p_ortalamaHasarTutar2, p_ortalamaHasarTutar3, p_sonUcYilHasarSayisi, p_bifurcationSegment, p_bifurcationSubSegment);

IF factor_detail.factorname='Özel İndirim' THEN
  var1:=REPLACE(var1,',','.');
END IF;

if factor_detail.FactorType='Const' THEN
    if OldFactorName = '0' then
        -- f_sql := 'select round(exp(sum(ln(nvl(t.mult1,1)))),6) m1, round(exp(sum(ln(nvl(t.mult2,1)))),6) m2, round(exp(sum(ln(nvl(t.mult3,1)))),6) m3, round(exp(sum(ln(nvl(t.mult4,1)))),6) m4, round(exp(sum(ln(nvl(t.mult5,1)))),6) m5, round(exp(sum(ln(nvl(t.mult6,1)))),6) m6, (round(exp(sum(ln(nvl(t.mult1,1)))),6) + round(exp(sum(ln(nvl(t.mult2,1)))),6) + round(exp(sum(ln(nvl(t.mult3,1)))),6) + round(exp(sum(ln(nvl(t.mult4,1)))),6) + round(exp(sum(ln(nvl(t.mult5,1)))),6) + round(exp(sum(ln(nvl(t.mult6,1)))),6))*'||aracbedeli||'/1000 prim from    (';
        f_sql := f_sql || 'SELECT * FROM (SELECT '''||factor_detail.factorname||''' tablename,''Sabit'' key1,''Sabit'' key2,''Sabit'' key3,''Sabit'' key4,''Sabit'' key5,''Sabit'' key6,''Sabit'' key7,''Sabit'' key8,''Sabit'' key9,'||var1||' mult1,'||var1||' mult2,'||var1||' mult3,'||var1||' mult4,'||var1||' mult5,'||var1||' mult6 from dual';
    else
        f_sql := f_sql || ' UNION ALL SELECT * FROM (SELECT '''||factor_detail.factorname||''' tablename,''Sabit'' key1,''Sabit'' key2,''Sabit'' key3,''Sabit'' key4,''Sabit'' key5,''Sabit'' key6,''Sabit'' key7,''Sabit'' key8,''Sabit'' key9,'||var1||' mult1,'||var1||' mult2,'||var1||' mult3,'||var1||' mult4,'||var1||' mult5,'||var1||' mult6 from dual';
    end if;
ELSE
            if OldFactorName = '0' then
               -- f_sql := 'select round(exp(sum(ln(nvl(t.mult1,1)))),6) m1, round(exp(sum(ln(nvl(t.mult2,1)))),6) m2, round(exp(sum(ln(nvl(t.mult3,1)))),6) m3, round(exp(sum(ln(nvl(t.mult4,1)))),6) m4, round(exp(sum(ln(nvl(t.mult5,1)))),6) m5, round(exp(sum(ln(nvl(t.mult6,1)))),6) m5, (round(exp(sum(ln(nvl(t.mult1,1)))),6) + round(exp(sum(ln(nvl(t.mult2,1)))),6) + round(exp(sum(ln(nvl(t.mult3,1)))),6) + round(exp(sum(ln(nvl(t.mult4,1)))),6) + round(exp(sum(ln(nvl(t.mult5,1)))),6) + round(exp(sum(ln(nvl(t.mult6,1)))),6))*'||aracbedeli||'/1000 prim from    (';

             f_sql := f_sql || 'SELECT * FROM (SELECT ' || tarSelectVal || ' FROM ' || tarTableVal || ' b WHERE b.' || tarCondVal || '=''' || factor_detail.TableName || '''';
                if factor_detail.condition1 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable1,factor_detail.DataType1,factor_detail.Operator1,var1,factor_detail.condition1,factor_detail.targetvalue1,factor_detail.parametername1,factor_detail.parametercolumnname11,factor_detail.parameteroperator11,var11,factor_detail.parametercolumnname12,factor_detail.parameteroperator12,var12);
--                    d1 := var1; else d1 := 'Default';
                END IF;
                if factor_detail.condition2 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable2,factor_detail.DataType2,factor_detail.Operator2,var2,factor_detail.condition2,factor_detail.targetvalue2,factor_detail.parametername2,factor_detail.parametercolumnname21,factor_detail.parameteroperator21,var21,factor_detail.parametercolumnname22,factor_detail.parameteroperator22,var22);
--                    d2 := var1; else d2 := 'Default';
                END IF;
                if factor_detail.condition3 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable3,factor_detail.DataType3,factor_detail.Operator3,var3,factor_detail.condition3,factor_detail.targetvalue3,factor_detail.parametername3,factor_detail.parametercolumnname31,factor_detail.parameteroperator31,var31,factor_detail.parametercolumnname32,factor_detail.parameteroperator32,var32);
--                    d3 := var1; else d3 := 'Default';
                END IF;
                if factor_detail.condition4 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable4,factor_detail.DataType4,factor_detail.Operator4,var4,factor_detail.condition4,factor_detail.targetvalue4,factor_detail.parametername4,factor_detail.parametercolumnname41,factor_detail.parameteroperator41,var41,factor_detail.parametercolumnname42,factor_detail.parameteroperator42,var42);
--                    d4 := var1; else d4 := 'Default';
                END IF;
                if factor_detail.condition5 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable5,factor_detail.DataType5,factor_detail.Operator5,var5,factor_detail.condition5,factor_detail.targetvalue5,factor_detail.parametername5,factor_detail.parametercolumnname51,factor_detail.parameteroperator51,var51,factor_detail.parametercolumnname52,factor_detail.parameteroperator52,var52);
--                    d5 := var1; else d5 := 'Default';
                END IF;
                if factor_detail.condition6 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable6,factor_detail.DataType6,factor_detail.Operator6,var6,factor_detail.condition6,factor_detail.targetvalue6,factor_detail.parametername6,factor_detail.parametercolumnname61,factor_detail.parameteroperator61,var61,factor_detail.parametercolumnname62,factor_detail.parameteroperator62,var62);
--                    d6 := var1||'-Default'; else d6 := 'Default';
                END IF;
                if factor_detail.condition7 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable7,factor_detail.DataType7,factor_detail.Operator7,var7,factor_detail.condition7,factor_detail.targetvalue7,factor_detail.parametername7,factor_detail.parametercolumnname71,factor_detail.parameteroperator71,var71,factor_detail.parametercolumnname72,factor_detail.parameteroperator72,var72);
--                    d6 := var1||'-Default'; else d6 := 'Default';
                END IF;
                if factor_detail.condition8 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable8,factor_detail.DataType8,factor_detail.Operator8,var8,factor_detail.condition8,factor_detail.targetvalue8,factor_detail.parametername8,factor_detail.parametercolumnname81,factor_detail.parameteroperator81,var81,factor_detail.parametercolumnname82,factor_detail.parameteroperator82,var82);
--                    d6 := var1||'-Default'; else d6 := 'Default';
                END IF;
                if factor_detail.condition9 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable9,factor_detail.DataType9,factor_detail.Operator9,var9,factor_detail.condition9,factor_detail.targetvalue9,factor_detail.parametername9,factor_detail.parametercolumnname91,factor_detail.parameteroperator91,var91,factor_detail.parametercolumnname92,factor_detail.parameteroperator92,var92);
--                    d6 := var1||'-Default'; else d6 := 'Default';
                END IF;
            else
                f_sql := f_sql || ' UNION ALL SELECT * FROM (SELECT ' || tarSelectVal || ' FROM ' || tarTableVal || ' b WHERE b.' || tarCondVal || '=''' || factor_detail.TableName || '''';
                if factor_detail.condition1 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable1,factor_detail.DataType1,factor_detail.Operator1,var1,factor_detail.condition1,factor_detail.targetvalue1,factor_detail.parametername1,factor_detail.parametercolumnname11,factor_detail.parameteroperator11,var11,factor_detail.parametercolumnname12,factor_detail.parameteroperator12,var12);
--                    d1 := d1||'-'||var1;
                END IF;
                if factor_detail.condition2 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable2,factor_detail.DataType2,factor_detail.Operator2,var2,factor_detail.condition2,factor_detail.targetvalue2,factor_detail.parametername2,factor_detail.parametercolumnname21,factor_detail.parameteroperator21,var21,factor_detail.parametercolumnname22,factor_detail.parameteroperator22,var22);
--                    d2 := d2||'-'||var2;
                END IF;
                if factor_detail.condition3 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable3,factor_detail.DataType3,factor_detail.Operator3,var3,factor_detail.condition3,factor_detail.targetvalue3,factor_detail.parametername3,factor_detail.parametercolumnname31,factor_detail.parameteroperator31,var31,factor_detail.parametercolumnname32,factor_detail.parameteroperator32,var32);
--                    d3 := d3||'-'||var3;
                END IF;
                if factor_detail.condition4 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable4,factor_detail.DataType4,factor_detail.Operator4,var4,factor_detail.condition4,factor_detail.targetvalue4,factor_detail.parametername4,factor_detail.parametercolumnname41,factor_detail.parameteroperator41,var41,factor_detail.parametercolumnname42,factor_detail.parameteroperator42,var42);
--                    d4 := d4||'-'||var4;
                END IF;
                if factor_detail.condition5 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable5,factor_detail.DataType5,factor_detail.Operator5,var5,factor_detail.condition5,factor_detail.targetvalue5,factor_detail.parametername5,factor_detail.parametercolumnname51,factor_detail.parameteroperator51,var51,factor_detail.parametercolumnname52,factor_detail.parameteroperator52,var52);
--                    d5 := d5||'-'||var5;
                END IF;
                if factor_detail.condition6 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable6,factor_detail.DataType6,factor_detail.Operator6,var6,factor_detail.condition6,factor_detail.targetvalue6,factor_detail.parametername6,factor_detail.parametercolumnname61,factor_detail.parameteroperator61,var61,factor_detail.parametercolumnname62,factor_detail.parameteroperator62,var62);
--                    d6 := d6||'-'||var6;
                END IF;
                if factor_detail.condition7 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable7,factor_detail.DataType7,factor_detail.Operator7,var7,factor_detail.condition7,factor_detail.targetvalue7,factor_detail.parametername7,factor_detail.parametercolumnname71,factor_detail.parameteroperator71,var71,factor_detail.parametercolumnname72,factor_detail.parameteroperator72,var72);
--                    d6 := d6||'-'||var6;
                END IF;
                if factor_detail.condition8 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable8,factor_detail.DataType8,factor_detail.Operator8,var8,factor_detail.condition8,factor_detail.targetvalue8,factor_detail.parametername8,factor_detail.parametercolumnname81,factor_detail.parameteroperator81,var81,factor_detail.parametercolumnname82,factor_detail.parameteroperator82,var82);
--                    d6 := d6||'-'||var6;
                END IF;
                if factor_detail.condition9 is not null THEN
                    f_sql := getTariffSqlDetail (f_sql,factor_detail.variable9,factor_detail.DataType9,factor_detail.Operator9,var9,factor_detail.condition9,factor_detail.targetvalue9,factor_detail.parametername9,factor_detail.parametercolumnname91,factor_detail.parameteroperator91,var91,factor_detail.parametercolumnname92,factor_detail.parameteroperator92,var92);
--                    d6 := d6||'-'||var6;
                END IF;
            end if;
          if factor_detail.ordertype='MaxDate' THEN
            f_sql := f_sql || ' and b.valid_date=(select max(a.valid_date) from ' || tarTableVal || ' a where a.' || tarCondVal || '=''' || factor_detail.TableName || ''' and a.valid_date is not null and a.valid_date<=''' || TariffDate || ''')';
          else
            f_sql := f_sql || ' and b.valid_date=(select max(a.valid_date) from ' || tarTableVal || ' a where a.' || tarCondVal || '=''' || factor_detail.TableName || ''' and a.valid_date is not null and a.valid_date<=''' || TariffDate || ''')';
          END IF;
          /*
          factor_detail.TableName
select 'Yurt Dışı' table_code, 'Default' key1, 'Default' key2, 'Default' key3, 'Default' key4, 'Default' key5, 'Default' key6, 1 MULT1,1 MULT2,1 MULT3,1 MULT4,1 MULT5,1 MULT6 from dual)
where rownum=1

          */
END IF;
d1 := 'Default'; d2:='Default'; d3:='Default'; d4:='Default'; d5:='Default'; d6:='Default'; d7:='Default'; d8:='Default'; d9:='Default';
f_sql := f_sql || ' UNION ALL select '''||factor_detail.TableName||''' table_code, '''||d1||''' key1, '''||d2||''' key2, '''||d3||''' key3, '''||d4||''' key4, '''||d5||''' key5, '''||d6||''' key6, '''||d7||''' key7, '''||d8||''' key8, '''||d9||''' key9, 1 MULT1,1 MULT2,1 MULT3,1 MULT4,1 MULT5,1 MULT6 from dual) where rownum=1';
          OldFactorName := factor_detail.factorname;
        end if;
       END IF;
       END LOOP;

     --  f_sql := f_sql || ' ) t';


       RETURN f_sql;
    END getTariffDetay;

    /* Trafik Sigortalı Skor */
    FUNCTION getTrafikSigortaliSkor (
      p_PricingId in NUMBER,
      p_xml_value in CLOB,
      p_kimlikNo in VARCHAR2,
      p_tariffDate in DATE,
      p_aracTarifeGrupKodu in VARCHAR2,
      p_hasarsizlikKademesi in NUMBER
    )
    RETURN NUMBER AS
    s_SigortaliSkor NUMBER(11,5);
    s_Kademe_FX_Faktoru NUMBER(5,2);
    s_MHS_Faktoru NUMBER(5,2);
    s_AKPS NUMBER(5,2);
    s_Frekans NUMBER(11,5);
    s_AynıDonemMaxHasarSayisi NUMBER(11,5);
    s_PoliceYilSayisi NUMBER(3,0);
    s_ToplamHasarSayisi NUMBER(3,0);
    s_HasarYilSayisi NUMBER(3,0);
    s_KPS NUMBER(11,5);
    s_AHS NUMBER(11,5);
    s_AHS_BaslangicTarihi DATE;
    s_AHS_BitisTarihi DATE;
    s_HasarYil NUMBER(5,2);
    s_Fx_Ust_Limit NUMBER(5,2);
    s_Mhs_BaslangicTarihi DATE;
    s_Mhs_BitisTarihi DATE;
    s_policeSuresiBasinaHasSay NUMBER(3);
    s_policeSuresiBasinaHasSayYil NUMBER(3);
    s_year_sum NUMBER(5,2);
    s_year_list VARCHAR2(4000);
    s_AkpsKontrolOrani NUMBER(5,2);
    s_AracTipKontrol NUMBER(3,0);
    v_error_msg VARCHAR2(4000);
    s_cache number;
    s_sql CLOB;
    ss_sql CLOB;
    s_Fonk_Beg_Time VARCHAR2(30);
    s_Fonk_End_Time VARCHAR2(30);
    s_hasarsizlikKademesi_Admitted NUMBER(3,0);
    s_KPS_Admitted NUMBER(11,5);
    s_Mhs_Kademe_Admitted NUMBER(3,0);
    s_PoliceYilSayisi_Admitted NUMBER(3,0);
    s_Fx_Max_Key2 NUMBER(11,5);
    s_Fx_Max_Key3 NUMBER(11,5);
    s_Mhs_Max_Key1 NUMBER(11,5);
    s_Mhs_Min_Key1 NUMBER(11,5);
    s_AHS_Max_Key1 NUMBER(11,5);
    s_AHS_Max_Key2 NUMBER(11,5);
    s_AKPS_Max_Key1 NUMBER(11,5);
    s_AKPS_Max_Key2 NUMBER(11,5);
    s_KPS_Max NUMBER(11,5);
    BEGIN

    s_Fonk_Beg_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');

    IF p_hasarsizlikKademesi < 1 THEN s_hasarsizlikKademesi_Admitted := 1; ELSIF p_hasarsizlikKademesi > 7 THEN s_hasarsizlikKademesi_Admitted := 7; ELSE s_hasarsizlikKademesi_Admitted := p_hasarsizlikKademesi; END IF;

    s_sql := 'select * from table(getTariff.getTrafikSigortaliSkor(''PRICE ID'',''Sorgu Sonucu CLOB'','''|| p_kimlikNo ||''','''||p_tariffDate||''','''||p_aracTarifeGrupKodu||''','''||s_hasarsizlikKademesi_Admitted||'''))';
    ss_sql := s_sql;
    select count(0) into s_cache from pricing_traff_insuredscore_log p where p.systemdate = to_char(sysdate,'DD/MM/YYYY') and cast(p.s_sql as varchar2(1000))=to_char(ss_sql);
    --s_cache:=0;

    if s_cache=0 then

        -------------------------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------------------------
        /* FX */

        /*---------- Poliçe Min Yıl ----------*/
        select ceil(round((sysdate - to_date(replace(substr(policebaslamatarihi,0,10),'-',''),'YYYY/MM/DD'))/365 , 2)) into s_PoliceYilSayisi  from
        (
            select z.policebaslamatarihi from
            (
                select v.*
                 from
                 (
                  select
                  distinct to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, y.policeNo ,y.yenilemeno ,y.policeEkino ,y.policeEkiTuru ,
                  case when y.policeEkiTuru in(8,9) then 1 else 0 end iptalmi,
                  case when y.policeEkiTuru in(3) then 1 else 0 end mebiptalmi,
                  y.policeBaslamaTarihi ,y.policeBitisTarihi ,y.policeEkiBaslamaTarihi,
                  y.aracMarkaKodu ,y.aracTarifeGrupKodu ,y.aracTipKodu ,y.kullanimSekli ,y.modelYili ,y.plakaIlKodu ,y.plakaNo
                  from
                  (
                       select 'gecmisPoliceler', x1.*
                               from
                                  (select xmltype(p_xml_value) data from dual) t,
                                  --(select xmltype(txt) data from test where idx = 5) t,
                                  XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/gecmisPoliceler'   PASSING t.data
                                              COLUMNS
                                                policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                                yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                                policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                                policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                                policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                                policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                                policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                                policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                                aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                                aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                                aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                                kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                                modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                                plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                                plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                            ) x1
                      UNION ALL
                       select 'yururPoliceler',x2.*
                               from
                                   (select xmltype(p_xml_value) data from dual) t,
                                   --(select xmltype(txt) data from test where idx = 5) t,
                                   XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/yururPoliceler'   PASSING t.data
                                              COLUMNS
                                                policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                                yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                                policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                                policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                                policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                                policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                                policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                                policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                                aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                                aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                                aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                                kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                                modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                                plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                                plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                            ) x2
                  ) y
                 ) v where v.mebiptalmi != 1
             ) z
             group by z.policebaslamatarihi
             order by z.policebaslamatarihi
         ) where rownum=1;
        /*---------- Poliçe Min Yıl ----------*/


        /*---------- Poliçe Hasar Sayısı ----------*/
        select count(*) into s_ToplamHasarSayisi from
            (select xmltype(p_xml_value) data from dual) t,
            --(select xmltype(txt) data from test where idx = 5) t,
            XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/policeninHasarlari'   PASSING t.data
                                  COLUMNS
                                    hasarDosyaDurumKod VARCHAR2(3) PATH 'hasarDosyaDurumKod',
                                    hasarDosyaNo VARCHAR2(20) PATH 'hasarDosyaNo',
                                    hasarTarih VARCHAR2(30) PATH 'hasarTarih'
                               ) z
        where (z.hasarDosyaDurumKod is null or z.hasarDosyaDurumKod not in ('3','4'));
        /*---------- Poliçe Hasar Sayısı ----------*/


        /*---------- Poliçe Hasarlari Min Yıl ----------*/
        IF s_ToplamHasarSayisi <> 0 THEN
            select ceil(round((sysdate - to_date(replace(substr(hasarTarih,0,10),'-',''),'YYYY/MM/DD'))/365 , 2)) into s_HasarYilSayisi from
            (
              select z.hasarTarih from
                      (select xmltype(p_xml_value) data from dual) t,
                      --(select xmltype(txt) data from test where idx = 5) t,
                      XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/policeninHasarlari'   PASSING t.data
                                              COLUMNS
                                                hasarDosyaDurumKod VARCHAR2(3) PATH 'hasarDosyaDurumKod',
                                                hasarDosyaNo VARCHAR2(20) PATH 'hasarDosyaNo',
                                                hasarTarih VARCHAR2(30) PATH 'hasarTarih'
                                           ) z
                     where (z.hasarDosyaDurumKod is null or z.hasarDosyaDurumKod not in ('3','4'))
                     group by z.hasarTarih
                     order by z.hasarTarih
            ) y  where rownum=1;
        ELSE
            s_HasarYilSayisi := 0;
        END IF;
        /*---------- Poliçe Hasarlari Min Yıl ----------*/


        /*-------------------- KPS --------------------*/
        select sum(kazanilmispolice) into s_KPS
        from
        (
            select
                v.*,
                round(nvl(case when v.iptalmi=1 then to_date(substr(v.policeekibaslamatarihi,1,10),'YYYY-MM-DD') - to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD')
                                        else case when to_date(substr(v.policebitistarihi,1,10),'YYYY-MM-DD')>system_date then system_date-to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD')
                                        else to_date(substr(v.policebitistarihi,1,10),'YYYY-MM-DD')-to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD') end
                                        end,0)/365,2) kazanilmispolice
            from
            (
                select
                distinct to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, y.policeNo ,y.yenilemeno ,y.policeEkino ,y.policeEkiTuru ,
                case when y.policeEkiTuru in(8,9) then 1 else 0 end iptalmi,
                case when y.policeEkiTuru in(3) then 1 else 0 end mebiptalmi,
                y.policeBaslamaTarihi ,y.policeBitisTarihi ,y.policeEkiBaslamaTarihi,
                y.aracMarkaKodu ,y.aracTarifeGrupKodu ,y.aracTipKodu ,y.kullanimSekli ,y.modelYili ,y.plakaIlKodu ,y.plakaNo
                from
                (
                     select 'gecmisPoliceler', x1.*
                             from
                                (select xmltype(p_xml_value) data from dual) t,
                                --(select  xmltype(txt) data from test where idx = 5) t,
                                XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/gecmisPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                          ) x1
                    UNION ALL
                     select 'yururPoliceler',x2.*
                             from
                                 (select xmltype(p_xml_value) data from dual) t,
                                 --(select  xmltype(txt) data from test where idx = 5) t,
                                 XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/yururPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                          ) x2
                ) y
            ) v where v.mebiptalmi != 1
        ) s;
        /*-------------------- KPS --------------------*/


        /*-------------------- AHS --------------------*/
        select max(to_number(aa.key1)) , max(to_number(aa.key2)) into s_AHS_Max_Key1, s_AHS_Max_Key2 from pricing_tables aa where aa.table_code='Trfk Sigortali Agirlik Faktor' and aa.valid_Date <= to_char(sysdate,'DD/MM/YYYY');

        s_AHS:=0;
        IF s_HasarYilSayisi <> 0 THEN
            FOR i IN 0..s_HasarYilSayisi LOOP
               s_AHS_BaslangicTarihi:= to_date(sysdate - (i+1)*365, 'DD/MM/YYYY');
               s_AHS_BitisTarihi:= to_date(sysdate - i*365 , 'DD/MM/YYYY') ;

               select NVL(sum(z.result),0) into s_HasarYil from
               (
                   select
                      sayi * (select mult1 from pricing_tables b where b.table_code='Trfk Sigortali Agirlik Faktor'
                                                and b.key1 <= (case when i < s_AHS_Max_Key2 then i else s_AHS_Max_Key1 end)
                                                and b.key2 >= (case when i < s_AHS_Max_Key2 then i+1 else s_AHS_Max_Key2 end)
                                                and b.valid_date =(select max(aa.valid_Date) from pricing_tables aa where aa.table_code='Trfk Sigortali Agirlik Faktor'
                                                                                                                              and aa.key1 <= (case when i < s_AHS_Max_Key2 then i else s_AHS_Max_Key1 end)
                                                                                                                              and aa.key2 >= (case when i < s_AHS_Max_Key2 then i+1 else s_AHS_Max_Key2 end)
                                                                                                                              and aa.valid_Date <= to_char(sysdate,'DD/MM/YYYY'))) as result
                   from
                   (
                       select count(*) as sayi
                       from
                       (
                           select
                                v.hasarTarih, v.hasarDosyaNo
                           from
                           ( select distinct z.hasarTarih, z.hasarDosyaNo
                                   from
                                    (select xmltype(p_xml_value) data from dual) t,
                                    --(select xmltype(txt) data from test where idx = 5) t,
                                    XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/policeninHasarlari'   PASSING t.data
                                                            COLUMNS
                                                              hasarDosyaDurumKod VARCHAR2(3) PATH 'hasarDosyaDurumKod',
                                                              hasarDosyaNo VARCHAR2(20) PATH 'hasarDosyaNo',
                                                              hasarTarih VARCHAR2(30) PATH 'hasarTarih'
                                                          ) z
                                   where (z.hasarDosyaDurumKod is null or z.hasarDosyaDurumKod not in ('3','4'))
                           ) v
                       ) y
                       group by y.hasarTarih, y.hasarDosyaNo
                       having to_char(to_date(substr(y.hasarTarih,1,10),'YYYY-MM-DD'),'YYYY-MM-DD') > to_char(s_AHS_BaslangicTarihi,'YYYY-MM-DD')
                               and to_char(to_date(substr(y.hasarTarih,1,10),'YYYY-MM-DD'),'YYYY-MM-DD') <= to_char(s_AHS_BitisTarihi,'YYYY-MM-DD')
                   )
               ) z;

               s_AHS := s_AHS + s_HasarYil;

            END LOOP;
        END IF;
        /*-------------------- AHS --------------------*/


        s_Frekans:= s_AHS/s_KPS;

        select max(to_number(aa.key5)) into s_KPS_Max from pricing_tables aa where aa.table_code='Trfk Sigortali Fx' and aa.key6=s_hasarsizlikKademesi_Admitted and aa.key1=p_aracTarifeGrupKodu and aa.valid_Date<=to_char(sysdate,'DD/MM/YYYY');
        IF s_KPS > s_KPS_Max THEN s_KPS_Admitted := s_KPS_Max; ELSE s_KPS_Admitted := s_KPS; END IF;

        select max(to_number(aa.key2)), max(to_number(aa.key3)) into s_Fx_Max_Key2 , s_Fx_Max_Key3 from pricing_tables aa where aa.table_code='Trfk Sigortali Fx' and aa.key6=s_hasarsizlikKademesi_Admitted
                                                                                                                                     and aa.key1=p_aracTarifeGrupKodu
                                                                                                                                     and aa.key4<=s_KPS_Admitted and aa.key5>=s_KPS_Admitted
                                                                                                                                     and aa.valid_Date<=to_char(sysdate,'DD/MM/YYYY');

        select count(0) into s_Kademe_FX_Faktoru from pricing_tables b
                    where b.table_code='Trfk Sigortali Fx' and b.key6 = s_hasarsizlikKademesi_Admitted and b.key1 = p_aracTarifeGrupKodu and key4 <= s_KPS_Admitted and key5 >= s_KPS_Admitted
                        and b.key2 = round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key2 end),2)
                        and b.key3 = round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key3 end),2)
                        and b.valid_date=(select max(aa.valid_Date) from pricing_tables aa where aa.table_code='Trfk Sigortali Fx' and aa.key6 = s_hasarsizlikKademesi_Admitted and aa.key1 = p_aracTarifeGrupKodu
                                                                                                      and aa.key4<=s_KPS_Admitted and aa.key5>=s_KPS_Admitted
                                                                                                      and aa.key2 = round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key2 end),2)
                                                                                                      and aa.key3 = round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key3 end),2)
                                                                                                      and aa.valid_Date<=to_char(sysdate,'DD/MM/YYYY'));
        IF s_Kademe_FX_Faktoru = 1 THEN
            select CAST(b.Mult1 as NUMBER(5,2)) into s_Kademe_FX_Faktoru from pricing_tables b
                    where b.table_code='Trfk Sigortali Fx' and b.key6 = s_hasarsizlikKademesi_Admitted and b.key1 = p_aracTarifeGrupKodu and key4 <= s_KPS_Admitted and key5 >= s_KPS_Admitted
                        and b.key2 = round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key2 end),2)
                        and b.key3 = round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key3 end),2)
                        and b.valid_date=(select max(aa.valid_Date) from pricing_tables aa where aa.table_code='Trfk Sigortali Fx' and aa.key6=s_hasarsizlikKademesi_Admitted and aa.key1=p_aracTarifeGrupKodu
                                                                                                      and aa.key4<=s_KPS_Admitted and aa.key5>=s_KPS_Admitted
                                                                                                      and aa.key2 = round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key2 end),2)
                                                                                                      and aa.key3 = round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key3 end),2)
                                                                                                      and aa.valid_Date<=to_char(sysdate,'DD/MM/YYYY'));
        ELSE
            select CAST(b.Mult1 as NUMBER(5,2)) into s_Kademe_FX_Faktoru from pricing_tables b
                   where b.table_code='Trfk Sigortali Fx' and b.key6 = s_hasarsizlikKademesi_Admitted and b.key1 = p_aracTarifeGrupKodu and key4 <= s_KPS_Admitted and key5 >= s_KPS_Admitted
                        and b.key2 <= round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key2 end),2)
                        and b.key3 >= round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key3 end),2)
                        and b.valid_date=(select max(aa.valid_Date) from pricing_tables aa where aa.table_code='Trfk Sigortali Fx' and aa.key6=s_hasarsizlikKademesi_Admitted and aa.key1=p_aracTarifeGrupKodu
                                                                                                      and aa.key4<=s_KPS_Admitted and aa.key5>=s_KPS_Admitted
                                                                                                      and aa.key2 <= round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key2 end),2)
                                                                                                      and aa.key3 >= round((case when s_Frekans*100 <= s_Fx_Max_Key3 then s_Frekans*100 else s_Fx_Max_Key3 end),2)
                                                                                                      and aa.valid_Date<=to_char(sysdate,'DD/MM/YYYY'));
        END IF;


        /* Hasar Sayısı için <= 1 ise Faktör 1,35'den büyük olamaz. */
        select CAST(desc1 as NUMBER(5,2)) into s_Fx_Ust_Limit from pricing_parameters where param_name = 'Trafik Sigortali Fx Ust Limit'
                            and valid_date = (select max(t.valid_Date) from pricing_parameters t where t.param_name = 'Trafik Sigortali Fx Ust Limit' and t.valid_Date<=to_char(sysdate,'DD/MM/YYYY'));

        IF (s_ToplamHasarSayisi <= 1) and s_Kademe_FX_Faktoru > s_Fx_Ust_Limit THEN s_Kademe_FX_Faktoru := s_Fx_Ust_Limit; END IF;
        /* Hasar Sayısı için <= 1 ise Faktör 1,35'den büyük olamaz. */


        -------------------------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------------------------
        /* MHS */

        s_policeSuresiBasinaHasSay:=0;
        IF s_HasarYilSayisi <> 0 THEN
            FOR i IN 0..s_HasarYilSayisi LOOP
                s_Mhs_BaslangicTarihi:= to_date(sysdate - (i+1)*365 , 'DD/MM/YYYY');
                s_Mhs_BitisTarihi:= to_date(sysdate - i*365 , 'DD/MM/YYYY');

                select NVL(count(*),0) into s_policeSuresiBasinaHasSayYil
                from
                ( select distinct z.hasarTarih, z.hasarDosyaNo
                        from
                         (select xmltype(p_xml_value) data from dual) t,
                         --(select xmltype(txt) data from test where idx = 5) t,
                         XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/policeninHasarlari'   PASSING t.data
                                                 COLUMNS
                                                   hasarDosyaDurumKod VARCHAR2(3) PATH 'hasarDosyaDurumKod',
                                                   hasarDosyaNo VARCHAR2(20) PATH 'hasarDosyaNo',
                                                   hasarTarih VARCHAR2(30) PATH 'hasarTarih'
                                               ) z
                        where (z.hasarDosyaDurumKod is null or z.hasarDosyaDurumKod not in ('3','4'))
                        group by z.hasarTarih, z.hasarDosyaNo
                        having to_char(to_date(substr(z.hasarTarih,1,10),'YYYY-MM-DD'),'YYYY-MM-DD') > to_char(s_Mhs_BaslangicTarihi,'YYYY-MM-DD')
                            and to_char(to_date(substr(z.hasarTarih,1,10),'YYYY-MM-DD'),'YYYY-MM-DD') <= to_char(s_Mhs_BitisTarihi,'YYYY-MM-DD')
                ) v;

                IF (s_policeSuresiBasinaHasSayYil is null OR s_policeSuresiBasinaHasSayYil<0) then s_policeSuresiBasinaHasSayYil:=0;  END IF;

                s_policeSuresiBasinaHasSay:= (case when s_policeSuresiBasinaHasSayYil > s_policeSuresiBasinaHasSay then s_policeSuresiBasinaHasSayYil else s_policeSuresiBasinaHasSay  end);

            END LOOP;
        END IF;
        s_AynıDonemMaxHasarSayisi := s_policeSuresiBasinaHasSay;


        select max(to_number(aa.key1)) , min(to_number(aa.key1)) into s_Mhs_Max_Key1, s_Mhs_Min_Key1 from pricing_tables aa  where aa.table_code='Trfk Sigortali Don. Bas. Hasar' and aa.valid_Date <= to_char(sysdate,'DD/MM/YYYY');

        IF s_hasarsizlikKademesi_Admitted < s_Mhs_Min_Key1 THEN s_Mhs_Kademe_Admitted := s_Mhs_Min_Key1; ELSIF s_hasarsizlikKademesi_Admitted > s_Mhs_Max_Key1 THEN s_Mhs_Kademe_Admitted := s_Mhs_Max_Key1;
        ELSE s_Mhs_Kademe_Admitted := s_hasarsizlikKademesi_Admitted; END IF;

        select CAST(b.Mult1 as NUMBER(5,2)) into s_MHS_Faktoru from pricing_tables b where b.table_code='Trfk Sigortali Don. Bas. Hasar' and b.key1=s_Mhs_Kademe_Admitted
                                                                                                and b.key2 <= s_AynıDonemMaxHasarSayisi and b.key3 > s_AynıDonemMaxHasarSayisi
                                                                                                and b.valid_date=(select max(aa.valid_Date) from pricing_tables aa
                                                                                                                        where aa.table_code='Trfk Sigortali Don. Bas. Hasar' and b.key1=s_Mhs_Kademe_Admitted
                                                                                                                              and aa.key2 <= s_AynıDonemMaxHasarSayisi
                                                                                                                              and aa.key3 > s_AynıDonemMaxHasarSayisi
                                                                                                                              and aa.valid_Date <= to_char(sysdate,'DD/MM/YYYY'));

        -------------------------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------------------------
        /* AKPS */

        select max(to_number(aa.key1)) , max(to_number(aa.key2)) into s_AKPS_Max_Key1, s_AKPS_Max_Key2 from pricing_tables aa where aa.table_code='Trfk Sigortali Agirlik Faktoru' and aa.valid_Date <= to_char(sysdate,'DD/MM/YYYY');

        IF s_PoliceYilSayisi < 10 THEN s_PoliceYilSayisi_Admitted := 10; ELSE s_PoliceYilSayisi_Admitted := s_PoliceYilSayisi; END IF;

        s_AKPS:=0;

        FOR i IN 0..s_PoliceYilSayisi LOOP

           select SUM(s_year) into s_year_sum from
           (
               select
                       ROUND(
                       ((CASE WHEN (to_date(to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY') between to_date(SYSDATE-((i+1)*365), 'DD/MM/YYYY') AND to_date(SYSDATE-(i*365), 'DD/MM/YYYY')) OR (to_date(to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY') between to_date(SYSDATE-((i+1)*365), 'DD/MM/YYYY') AND to_date(SYSDATE-(i*365), 'DD/MM/YYYY'))
                             THEN (CASE WHEN (to_date(to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY') between to_date(SYSDATE-((i+1)*365), 'DD/MM/YYYY') AND to_date(SYSDATE-(i*365), 'DD/MM/YYYY')) AND (to_date(to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY') between to_date(SYSDATE-((i+1)*365), 'DD/MM/YYYY') AND to_date(SYSDATE-(i*365), 'DD/MM/YYYY'))
                                           THEN to_date(to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY') - to_date(to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY')
                                        ELSE
                                           (CASE WHEN to_date(to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY') < to_date(SYSDATE-(i*365), 'DD/MM/YYYY') THEN to_date(to_date(substr(z.policeBitisTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY') ELSE to_date(SYSDATE-(i*365), 'DD/MM/YYYY') END) -
                                           (CASE WHEN to_date(to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY') > to_date(SYSDATE-((i+1)*365), 'DD/MM/YYYY') THEN to_date(to_date(substr(z.policeBaslamaTarihi,1,10),'YYYY-MM-DD'), 'DD/MM/YYYY') ELSE to_date(SYSDATE-((i+1)*365), 'DD/MM/YYYY') END)
                                   END)
                             ELSE 0
                       END)/365)
                       * (select TO_NUMBER(a.mult1) from pricing_tables a where a.TABLE_CODE='Trfk Sigortali Agirlik Faktoru' and a.KEY1 = (CASE WHEN i<s_AKPS_Max_Key2 THEN i ELSE s_AKPS_Max_Key1 END)
                                                                                and a.KEY2 = (CASE WHEN i<s_AKPS_Max_Key2 THEN i+1 ELSE s_AKPS_Max_Key2 END) AND
                                                                                a.VALID_DATE = (select MAX(VALID_DATE) from pricing_tables b where b.TABLE_CODE = a.TABLE_CODE
                                                                                                                                     and b.KEY1 = (CASE WHEN i<s_AKPS_Max_Key2 THEN i ELSE s_AKPS_Max_Key1 END)
                                                                                                                                     and b.KEY2 = (CASE WHEN i<s_AKPS_Max_Key2 THEN i+1 ELSE s_AKPS_Max_Key2 END)
                                                                                                                                     and b.valid_Date <= to_char(sysdate,'DD/MM/YYYY')))
                       , 2) AS s_year
               from
               (
                    select y.policeNo,y.yenilemeno,y.policeEkino, y.policeBaslamaTarihi,y.policeEkiBaslamaTarihi,
                    (case when y.iptalmi=1 then y.policeEkiBaslamaTarihi else y.policeBitisTarihi end) as policeBitisTarihi, y.iptalmi,y.mebiptalmi
                    from
                    (SELECT to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, x3.policeNo ,x3.yenilemeno ,x3.policeEkino ,x3.policeEkiTuru ,
                         case when x3.policeEkiTuru in(8,9) then 1 else 0 end iptalmi,
                         case when x3.policeEkiTuru in(3) then 1 else 0 end mebiptalmi,
                         x3.policeBaslamaTarihi , x3.policeBitisTarihi , x3.policeEkiBaslamaTarihi
                        FROM
                        (
                              select 'gecmisPoliceler', x1.*
                                      from
                                         (select xmltype(p_xml_value) data from dual) t,
                                         --(select  xmltype(txt) data from test where idx = 5) t,
                                         XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/gecmisPoliceler'      PASSING t.data
                                                     COLUMNS
                                                       policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                                       yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                                       policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                                       policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                                       policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                                       policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                                       policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                                       policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                                       aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                                       aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                                       aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                                       kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                                       modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                                       plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                                       plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                                   ) x1
                                 UNION ALL
                                  select 'yururPoliceler',x2.*
                                          from
                                              (select xmltype(p_xml_value) data from dual) t,
                                              --(select  xmltype(txt) data from test where idx = 5) t,
                                              XMLTABLE ('trafikPoliceSorguKimlikSorgu/trafikPoliceSorguKimlikNo/yururPoliceler'      PASSING t.data
                                                         COLUMNS
                                                           policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                                           yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                                           policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                                           policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                                           policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                                           policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                                           policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                                           policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                                           aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                                           aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                                           aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                                           kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                                           modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                                           plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                                           plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                                       ) x2
                         ) x3
                     ) y where y.mebiptalmi <> 1
               ) z
           ) s;

           s_AKPS:= s_AKPS + s_year_sum;
           s_year_list:= s_year_list || to_char(i+1) || '. yıl=' || to_char(s_year_sum) || ' /// ';

        END LOOP;

        -------------------------------------------------------------------------------------------------------------------------------
        -------------------------------------------------------------------------------------------------------------------------------

        s_SigortaliSkor:= s_Kademe_FX_Faktoru * s_MHS_Faktoru;

        select count(0) into s_AracTipKontrol from pricing_tables where table_code ='Trfk Sigortali Arac Kodu' and KEY1=TO_NUMBER(p_aracTarifeGrupKodu);
        IF s_AracTipKontrol=0 AND s_SigortaliSkor < 1 THEN s_SigortaliSkor := 1; END IF;


        select to_number(desc1) into s_AkpsKontrolOrani from pricing_parameters a where a.param_name='Trafik Sigortali Akps Kontrol Orani'
                    and a.valid_date=(select max(b.valid_Date) from pricing_parameters b where b.param_name='Trafik Sigortali Akps Kontrol Orani' and b.valid_Date<=to_char(sysdate,'DD/MM/YYYY'));

        IF s_Akps <= s_AkpsKontrolOrani and s_SigortaliSkor < 1 THEN s_SigortaliSkor:= 1; END IF;

        s_Fonk_End_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');

        addTrafficInsuredScoreLog(p_PricingId, p_kimlikNo, to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), p_xml_value, p_tariffDate, p_aracTarifeGrupKodu, s_hasarsizlikKademesi_Admitted,
                            s_SigortaliSkor , s_Kademe_FX_Faktoru , s_MHS_Faktoru , s_AKPS , s_Frekans , s_AynıDonemMaxHasarSayisi , s_PoliceYilSayisi , s_ToplamHasarSayisi , s_HasarYilSayisi,
                            s_KPS , s_AHS , s_Fx_Ust_Limit , s_policeSuresiBasinaHasSay , s_year_list , s_AkpsKontrolOrani , s_AracTipKontrol , '' , s_cache , s_sql , s_Fonk_Beg_Time,
                            s_Fonk_End_Time , s_KPS_Admitted , s_Mhs_Kademe_Admitted , s_PoliceYilSayisi_Admitted);
    else
        addTrafficInsuredScoreLogCache(p_PricingId, p_xml_value, s_sql);
        select p.s_sigortaliskor into s_SigortaliSkor from pricing_traff_insuredscore_log p where p.systemdate = to_char(sysdate,'DD/MM/YYYY')
                                                                                                --and cast(substr(p.p_xml_value,1,4000) as varchar2(4000)) = cast(p_xml_value as varchar2(4000))
                                                                                                and cast(p.s_sql as varchar2(1000))=to_char(ss_sql) and rownum = 1;
    end if;

    RETURN s_SigortaliSkor;

    EXCEPTION WHEN OTHERS THEN
       v_error_msg :=   'ERROR: ' || substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       s_SigortaliSkor:= 1;
       s_Fonk_End_Time := to_char(systimestamp,'DD/MM/YYYY HH24:MI:SS:FF4');
       addTrafficInsuredScoreLog(p_PricingId, p_kimlikNo, to_char(sysdate,'DD/MM/YYYY'), to_char(sysdate,'HH:MI:SS'), p_xml_value, p_tariffDate, p_aracTarifeGrupKodu, s_hasarsizlikKademesi_Admitted,
                                s_SigortaliSkor , s_Kademe_FX_Faktoru , s_MHS_Faktoru , s_AKPS , s_Frekans , s_AynıDonemMaxHasarSayisi , s_PoliceYilSayisi , s_ToplamHasarSayisi , s_HasarYilSayisi,
                                s_KPS , s_AHS , s_Fx_Ust_Limit , s_policeSuresiBasinaHasSay , s_year_list , s_AkpsKontrolOrani , s_AracTipKontrol , v_error_msg , s_cache , s_sql , s_Fonk_Beg_Time,
                                s_Fonk_End_Time , s_KPS_Admitted , s_Mhs_Kademe_Admitted , s_PoliceYilSayisi_Admitted);
       return s_SigortaliSkor;
    end getTrafikSigortaliSkor;



    PROCEDURE addTrafficInsuredScoreLog (
        p_PricingId NUMBER,
        p_kimlikNo VARCHAR2,
        systemDate VARCHAR2,
        systemTime VARCHAR2,
        p_xml_value CLOB,
        p_tariffDate DATE,
        p_aracTarifeGrupKodu VARCHAR2,
        p_hasarsizlikKademesi NUMBER,
        s_SigortaliSkor NUMBER,
        s_Kademe_FX_Faktoru NUMBER,
        s_MHS_Faktoru NUMBER,
        s_AKPS NUMBER,
        s_Frekans NUMBER,
        s_AynıDonemMaxHasarSayisi NUMBER,
        s_PoliceYilSayisi NUMBER,
        s_ToplamHasarSayisi NUMBER,
        s_HasarYilSayisi NUMBER,
        s_KPS NUMBER,
        s_AHS NUMBER,
        s_Fx_Ust_Limit NUMBER,
        s_policeSuresiBasinaHasSay NUMBER,
        s_year_list VARCHAR2,
        s_AkpsKontrolOrani NUMBER,
        s_AracTipKontrol NUMBER,
        v_error_msg VARCHAR2,
        s_cache NUMBER,
        s_sql CLOB,
        s_Fonk_Beg_Time VARCHAR2,
        s_Fonk_End_Time VARCHAR2,
        s_KPS_Admitted NUMBER,
        s_Mhs_Kademe_Admitted NUMBER,
        s_PoliceYilSayisi_Admitted NUMBER
        ) is PRAGMA AUTONOMOUS_TRANSACTION;
    begin
        insert into pricing_traff_insuredscore_log
        values(p_PricingId, p_kimlikno, systemDate, systemTime, p_xml_value, p_tariffDate, p_aracTarifeGrupKodu, p_hasarsizlikKademesi, s_SigortaliSkor,
                s_Kademe_FX_Faktoru, s_MHS_Faktoru, s_AKPS, s_Frekans, s_AynıDonemMaxHasarSayisi, s_PoliceYilSayisi, s_ToplamHasarSayisi, s_HasarYilSayisi,
                s_KPS, s_AHS, s_Fx_Ust_Limit, s_policeSuresiBasinaHasSay, s_year_list, s_AkpsKontrolOrani, s_AracTipKontrol, v_error_msg, s_cache, s_sql,
                s_Fonk_Beg_Time, s_Fonk_End_Time, s_KPS_Admitted, s_Mhs_Kademe_Admitted, s_PoliceYilSayisi_Admitted);
        commit;
    end;

    PROCEDURE addTrafficInsuredScoreLogCache (
        ss_PriceId NUMBER,
        ss_xml_value CLOB,
        ss_sql CLOB)
        is PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        insert into pricing_traff_insuredscore_log select ss_PriceId, p.p_kimlikno, p.systemDate, p.systemTime, p.p_xml_value, p.p_tariffDate, p.p_aracTarifeGrupKodu, p.p_hasarsizlikKademesi,
                                                              p.s_SigortaliSkor, p.s_Kademe_FX_Faktoru, p.s_MHS_Faktoru, p.s_AKPS, p.s_Frekans, p.s_AynıDonemMaxHasarSayisi, p.s_PoliceYilSayisi,
                                                              p.s_ToplamHasarSayisi, p.s_HasarYilSayisi, p.s_KPS, p.s_AHS, p.s_Fx_Ust_Limit, p.s_policeSuresiBasinaHasSay, p.s_year_list, p.s_AkpsKontrolOrani,
                                                              p.s_AracTipKontrol, p.v_error_msg, '1', p.s_sql, p.s_Fonk_Beg_Time, p.s_Fonk_End_Time, p.s_KPS_Admitted, p.s_Mhs_Kademe_Admitted,
                                                              p.s_PoliceYilSayisi_Admitted
                                                              from pricing_traff_insuredscore_log p where p.systemdate = to_char(sysdate,'DD/MM/YYYY')
                                                                                                           --and cast(substr(replace(replace(p.p_xml_value,CHR(10),''),CHR(13),''),1,4000) as varchar2(4000)) = cast(substr(replace(replace(ss_xml_value,CHR(10),''),CHR(13),''),1,4000) as varchar2(4000))
                                                                                                           and cast(p.s_sql as varchar2(1000))=to_char(ss_sql)
                                                                                                           and rownum = 1;
        commit;
    END;

    PROCEDURE addInsuredScoreLog (
        s_PricingId NUMBER,
        kimlikno VARCHAR2,
        systemDate VARCHAR2,
        systemTime VARCHAR2,
        p_xml_value CLOB,
        p_tariffDate DATE,
        p_aracTarifeGrupKodu VARCHAR2,
        p_hasarsizlikKademesi NUMBER,
        s_sigortaliskor       NUMBER,
        s_fx                  NUMBER,
        s_mhs                 NUMBER,
        s_akps                NUMBER,
        s_fonk1               NUMBER,
        s_fonk2               NUMBER,
        s_kazanilmispolice    NUMBER,
        s_skoratabihasarlar   NUMBER,
        s_rucusuzhasarlar     NUMBER,
        s_yururpoliceler      NUMBER,
        s_camhasarsayisi      NUMBER,
        s_mintutarhasarsayisi NUMBER,
        s_hasarsayisi         NUMBER,
        s_year1               NUMBER,
        s_year2               NUMBER,
        s_year3               NUMBER,
        s_year4               NUMBER,
        s_year5               NUMBER,
        s_sigarackontrol      NUMBER,
        s_minimumhasartutari  NUMBER,
        s_AkpsKontrolOrani    NUMBER,
        v_errm                VARCHAR2, p_sql CLOB) is PRAGMA AUTONOMOUS_TRANSACTION;
    begin
        insert into pricing_insuredscore_log
        values(s_PricingId, kimlikno, systemDate ,systemTime , p_xml_value , p_tariffDate , p_aracTarifeGrupKodu , p_hasarsizlikKademesi , s_sigortaliskor, s_fx, s_mhs, s_akps, s_fonk1, s_fonk2,
                s_kazanilmispolice, s_skoratabihasarlar, s_rucusuzhasarlar, s_yururpoliceler, s_camhasarsayisi, s_mintutarhasarsayisi, s_hasarsayisi, s_year1, s_year2, s_year3, s_year4, s_year5,
                s_sigarackontrol, s_minimumhasartutari, s_AkpsKontrolOrani, v_errm, p_sql );
        commit;
    end;

    PROCEDURE addInsuredScoreLogCache (
        s_PriceId NUMBER,
        s_xml_value CLOB,
        s_sql CLOB)
        is PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        insert into pricing_insuredscore_log select s_PriceId, p.KIMLIKNO, p.SYSTEMDATE, p.SYSTEMTIME, p.P_XML_VALUE, p.P_TARIFFDATE, p.P_ARACTARIFEGRUPKODU, p.P_HASARSIZLIKKADEMESI, p.S_SIGORTALISKOR,
                                                         p.S_FX, p.S_MHS, p.S_AKPS, p.S_FONK1, p.S_FONK2, p.S_KAZANILMISPOLICE, p.S_SKORATABIHASARLAR, p.S_RUCUSUZHASARLAR, p.S_YURURPOLICELER,
                                                         p.S_CAMHASARSAYISI, p.S_MINTUTARHASARSAYISI, p.S_HASARSAYISI, p.S_YEAR1, p.S_YEAR2, p.S_YEAR3, p.S_YEAR4, p.S_YEAR5, p.S_SIGARACKONTROL,
                                                         p.S_MINIMUMHASARTUTARI, p.S_AKPSKONTROLORANI, p.V_ERRM, p.P_SQL
                                                         from pricing_insuredscore_log p where p.systemdate = to_char(sysdate,'DD/MM/YYYY')
                                                                                                    --and cast(substr(replace(replace(p.p_xml_value,CHR(10),''),CHR(13),''),1,4000) as varchar2(4000)) = cast(substr(replace(replace(s_xml_value,CHR(10),''),CHR(13),''),1,4000) as varchar2(4000))
                                                                                                    and cast(p.p_sql as varchar2(1000))=to_char(s_sql)
                                                                                                    and rownum = 1;
        commit;
    END;

    PROCEDURE addAracSkorLog (p_HasarslkIndrm VARCHAR2,p_PolBasTarh VARCHAR2, p_TesclTarh VARCHAR2,p_TrafkCksTarh VARCHAR2, p_ModelYl VARCHAR2, p_Plaka VARCHAR2,v_PolBasFarkPreBts VARCHAR2,v_aracSifirKmMi VARCHAR2,v_geciciPlakaMi VARCHAR2, yenilemeMi VARCHAR2,v_asbisRuhsatVarMi VARCHAR2,v_yeniSatinAlinmisMi VARCHAR2,v_surekliSigortaliMi VARCHAR2, v_sigortasizliksuresi VARCHAR2,p_PrePolBtsTarh  VARCHAR2,AP VARCHAR2,APP VARCHAR2,v_sigortaKaydiVarMi VARCHAR2,s_PricingId NUMBER, s_key VARCHAR2,
        p_sql CLOB,
        v_errm VARCHAR2) is PRAGMA AUTONOMOUS_TRANSACTION;
    begin

    INSERT INTO aracskor_detay
VALUES(p_HasarslkIndrm,p_PolBasTarh,p_TesclTarh,p_TrafkCksTarh,p_ModelYl,p_Plaka,v_PolBasFarkPreBts,v_aracSifirKmMi,v_geciciPlakaMi,yenilemeMi,v_asbisRuhsatVarMi,v_yeniSatinAlinmisMi,v_surekliSigortaliMi,v_sigortasizliksuresi,AP,APP,p_PrePolBtsTarh,v_sigortaKaydiVarMi,s_PricingId,s_key,to_char(sysdate,'DD/MM/YYYY'),p_sql,v_errm);
  commit;
    end;

    PROCEDURE addAracSkorLogCache (
        s_PricingId NUMBER,
        s_sql CLOB) is PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        insert into aracskor_detay select p.P_HASARSLKINDRM, p.P_POLBASTARH, p.P_TESCLTARH, p.P_TRAFKCKSTARH, p.P_MODELYL, p.P_PLAKA, p.V_POLBASFARKPREBTS, p.V_ARACSIFIRKMMI, p.V_GECICIPLAKAMI,
                                                       p.YENILEMEMI, p.V_ASBISRUHSATVARMI, p.V_YENISATINALINMISMI, p.V_SUREKLISIGORTALIMI, p.V_SIGORTASIZLIKSURESI, p.ARACPROFILI, p.SKOR, p.P_PREPOLBTSTARH,
                                                       p.V_SIGORTAKAYDIVARMI, s_PricingId, p.KEY, p.SYSTEMDATE , p.p_sql, p.v_errm from aracskor_detay p
                                                       where p.systemdate = to_char(sysdate,'DD/MM/YYYY') and cast(p.p_sql as varchar2(1000))=cast(to_char(s_sql) as varchar2(1000)) and rownum = 1;
        commit;
    END;

 FUNCTION getMaxYetkiliIndirimi(productNo varchar2,TariffDate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,tescilTarihi varchar2,trafigeCikisTarihi varchar2,referansPoliceBilgileri varchar2,kullanimSekli varchar2,model varchar2,markaTipKodu varchar2,hasarsizlikKademesi varchar2,yakitTipi varchar2,aracBedeli varchar2,kasaBedeli varchar2,tasinanEmtiaBedeli varchar2,tasinanEmtiaCinsi varchar2,sesGoruntuCihaziBedeli varchar2,digerAksesuarBedeli varchar2,yurtDisiTeminatiSuresi varchar2,trafikKademesi varchar2,paketTipi varchar2,kullanimTipi varchar2,OzelIndirim number,surprim number,meslek varchar2, kullanimTarzi varchar2, kiymetKazanma varchar2, sigortaliliksuresi number, kismihasarsayisi varchar2, camhasarsayisi varchar2, minimumFiyatKorunsunMu varchar2, minimumPrimKorunsunMu varchar2, acente varchar2, kullaniciAdi varchar2, referancePriceId varchar2, camMuafiyetIstisnasi varchar2, yenilemePrimKontroluCalissinMi varchar2, immSorumlulukTeminatLimiti varchar2, fkSigortaliTeminatLimiti varchar2, fkKoltukTeminatLimiti varchar2, maneviTazminatLimiti varchar2, koltukSayisi varchar2, YolYardimAlternatifTeminat varchar2)
        RETURN number
        IS
        clob_sbmValues CLOB;
        clob_sasiSorgu CLOB;
        clob_egmSorgu CLOB;
        clob_tcknAracSorgu CLOB;
        clob_trafikPoliceSorguKimlik CLOB;
        s_PricingId NUMBER;
        p_kullanimtarzi VARCHAR2(2);
        p_egmprm VARCHAR2(50);
        p_egmresult VARCHAR2(100);
        p_egmkaydivarmi VARCHAR2(1):='H';
        p_kullanimsekli VARCHAR2(20);
        p_result VARCHAR2(10);
        p_plakailkod VARCHAR2(3);
        v_errm CLOB;
        s_key varchar2(4000);
        p_kaskoReferansSorgu VARCHAR2(50);
        p_eskiPolSirketKodu VARCHAR2(3);
        p_eskiPolAcenteNo VARCHAR2(20);
        p_eskiPolPoliceNo VARCHAR2(50);
        p_eskiPolYenilemeNo VARCHAR2(3);
        p_kaskoReferansKullanimTarzi VARCHAR2(3);
        p_kismiHasarSayisi1 varchar2(10);
        p_camHasarSayisi1 varchar2(10);
        p_kismiHasarSayisi2 varchar2(10);
        p_camHasarSayisi2 varchar2(10);
        p_kismiHasarSayisi3 varchar2(10);
        p_camHasarSayisi3 varchar2(10);
        p_kskDonemselHasarSayisi varchar2(100);
        birYilOncekiHasar varchar2(2);
        ikiYilOncekiHasar varchar2(2);
        ucYilOncekiHasar varchar2(2);
        p_agirHasar1 varchar2(1);
        p_agirHasar2 varchar2(1);
        p_agirHasar3 varchar2(1);
        p_maxindirim number(11,2);
        p_hasarsizlikKademesi number(2);
        p_yenilemeyeniiskod varchar2(3);
        clob_tcknPlakaSorgu CLOB;
        winsuretanimliindirim number(11,2);
        kullaniciGrubu varchar2(100);
        p_cachekey varchar2(2000);
        cachepriceid number(15);
        p_plakano varchar2(10);
        p_ilaveIndirimKullan varchar2(1);
        maxDiscount number(11,2);
        p_ortalamaHasarTutari1 number(11,2);
        p_ortalamaHasarTutari2 number(11,2);
        p_ortalamaHasarTutari3 number(11,2);
        NBRENEWAL2 VARCHAR2(15);
        eurocar_segment varchar2(30);
        eurocar_kasatipi varchar2(30);
        eurocar_sanziman varchar2(30);
        clob_tcknSorgu CLOB;
        clob_adresSorgu CLOB;
        ililcegrupkontrol number(5);
        cnt99 number(5);
        p_ililcegrup varchar2(50);
        p_ilceAd varchar2(20);
        p_ilAd varchar2(20);
        p_markatipkodu VARCHAR2(10);
    BEGIN

            p_maxindirim := 0;
            p_plakailkod:='000';
            p_ilaveIndirimKullan := 'H';
            if  plakaIlKodu is not NULL   then  p_plakailkod :=SUBSTR(p_plakailkod||trim(plakaIlKodu),-3); end if;
            p_plakano := trim(plakaNo);

        p_cachekey := productNo||'-'||kimlikNo ||'-'||p_plakailkod||'-'||p_plakaNo||'-'||hasarsizlikKademesi||'-'||kullaniciAdi||'-'||acente;

        select count(0) into cachepriceid from tnswin.pricing_ncd_log a where a.system_date=to_char(sysdate,'DD/MM/YYYY') and a.cachekey=p_cachekey;

        if cachepriceid = 0 then

            select seq_pricing_id.nextval into s_PricingId from dual;
            /*
            if (asbisNo is null or asbisNo='') then p_egmprm:=tescilSeriKod;
            else p_egmprm:=asbisNo;
            end if;
            */

            if length(kimlikNo)=11 then
                if tescilSeriNo is null then
                    select GETTARIFFTOSBM(kimlikNo, p_plakailkod, p_plakaNo, NULL, asbisNo, sasiNo, '123', 'KSK', tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
                else
                    select GETTARIFFTOSBM(kimlikNo, p_plakailkod, p_plakaNo, tescilSeriKod, tescilSeriNo, sasiNo, '123', 'KSK' , tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
                end if;
                    clob_tcknAracSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceByTckSorgu');
                    clob_tcknPlakaSorgu := getSbmDetails(clob_sbmValues, 'ovmKaskoPoliceByKimlikPlakaSorgu');
                    clob_sasiSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceBySasiSorgu');

                if substr(kimlikNo,1,1)='9' THEN
                    clob_tcknSorgu := getSbmDetails(clob_sbmValues, 'yabanciKimlikSorgu');
                    clob_adresSorgu := getSbmDetails(clob_sbmValues, 'yabanciAdresSorgu');
                else
                    clob_tcknSorgu := getSbmDetails(clob_sbmValues, 'tcknSorgu');
                    clob_adresSorgu := getSbmDetails(clob_sbmValues, 'adresSorgu');
                end if;

        if markaTipKodu is NULL or markaTipKodu = '0' then p_markatipkodu := removeElement(getSbmDetails(clob_sasiSorgu, 'aracMarkaKodu'), 'aracMarkaKodu')||removeElement(getSbmDetails(clob_sasiSorgu, 'aracTipKodu'), 'aracTipKodu');
                                                     else p_markatipkodu := markaTipKodu; end if;
        if length(p_markatipkodu)<7 then p_markatipkodu := substr('00'||p_markatipkodu,-6); end if;


                    p_yenilemeyeniiskod := getYenilemeYeniIsKod(tariffDate, clob_tcknPlakaSorgu,sasiNo, p_plakaNo, kimlikno);
                    if p_yenilemeyeniiskod is NULL or p_yenilemeyeniiskod = '0' then p_yenilemeyeniiskod := '99'; end if;

                    if p_yenilemeyeniiskod in ('051','51') THEN
                        NBRENEWAL2 := 'YENILEME';
                    elsif p_yenilemeyeniiskod='99' THEN
/*                        if p_aracyasi = 0 then
                            NBRENEWAL2 := 'SIFIRKMARAC';
                        else*/
                            NBRENEWAL2 := 'YENIIS';
/*                        end if;*/
                    else
                        NBRENEWAL2 := 'TRANSFER';
                    end if;

                    if p_yenilemeyeniiskod != '051' and p_yenilemeyeniiskod != '51' then p_yenilemeyeniiskod := '99'; ELSE p_yenilemeyeniiskod := '051'; end if;

                    p_kskDonemselHasarSayisi := getKSKDonemselHasarSayisi(kimlikNo,p_plakaIlKod,p_plakaNo,clob_tcknAracSorgu,455, 0);

                    SELECT nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 1)),0) col1,
                           nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 2)),0) col2,
                           nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 3)),0) col3 into p_kismiHasarSayisi1, p_agirHasar1, p_ortalamaHasarTutari1 FROM dual;

                    p_kskDonemselHasarSayisi := getKSKDonemselHasarSayisi(kimlikNo,p_plakaIlKod,p_plakaNo,clob_tcknAracSorgu,910,455);

                    SELECT nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 1)),0) col1,
                           nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 2)),0) col2,
                           nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 3)),0) col3 into p_kismiHasarSayisi2, p_agirHasar2, p_ortalamaHasarTutari2 FROM dual;

                    p_kskDonemselHasarSayisi := getKSKDonemselHasarSayisi(kimlikNo,p_plakaIlKod,p_plakaNo,clob_tcknAracSorgu,1365,910);

                    SELECT nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 1)),0) col1,
                           nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 2)),0) col2,
                           nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 3)),0) col3 into p_kismiHasarSayisi3, p_agirHasar3, p_ortalamaHasarTutari3 FROM dual;


                     if p_agirHasar1 != '0' then
                         birYilOncekiHasar := '3';
                     else
                         birYilOncekiHasar := coalesce(p_kismiHasarSayisi1,'0');
                     end if;
                     if p_agirHasar2 != '0' then
                         ikiYilOncekiHasar := '3';
                     else
                         ikiYilOncekiHasar := coalesce(p_kismiHasarSayisi2,'0');
                     end if;
                     if p_agirHasar3 != '0' then
                         ucYilOncekiHasar := '3';
                     else
                         ucYilOncekiHasar := coalesce(p_kismiHasarSayisi3,'0');
                     end if;
                     if birYilOncekiHasar>4 then birYilOncekiHasar := '4'; end if;
                     if ikiYilOncekiHasar>4 then ikiYilOncekiHasar := '4'; end if;
                     if ucYilOncekiHasar>4 then ucYilOncekiHasar := '4'; end if;
                     select user_group_no into kullaniciGrubu from tnswin.t000kulmas where user_name=kullaniciAdi;

                    p_hasarsizlikKademesi := nvl(hasarsizlikKademesi,0);






if trunc(sysdate)<'02/02/2021' then
                    if p_yenilemeyeniiskod != '051' then -- TNS yenilemesi de?il
                        if p_hasarsizlikKademesi >= 1 then
                            if birYilOncekiHasar = 0 then
                                if birYilOncekiHasar + ikiYilOncekiHasar + ucYilOncekiHasar <=1 then
                                    p_maxindirim := 20;
                                    p_ilaveIndirimKullan := 'E';
                                end if;
                            end if;
                        end if;
                    else -- TNS yenilemesi
                        if birYilOncekiHasar = 0 then
                            p_maxindirim := 15;
                            p_ilaveIndirimKullan := 'E';
                        end if;
                    end if;
ELSE
                    if p_yenilemeyeniiskod != '051' then -- TNS yenilemesi de?il
                        if p_hasarsizlikKademesi >= 2 then
--                            if birYilOncekiHasar = 0 then
                              if NBRENEWAL2 = 'TRANSFER' then
                                if (birYilOncekiHasar + ikiYilOncekiHasar + ucYilOncekiHasar) <=1 then
                                    if (p_ortalamaHasarTutari1 + p_ortalamaHasarTutari2 + p_ortalamaHasarTutari3) between 1000 and 10000 or (p_ortalamaHasarTutari1 + p_ortalamaHasarTutari2 + p_ortalamaHasarTutari3) = 0 then
                                        p_maxindirim := 20;
                                        p_ilaveIndirimKullan := 'H';
                                    end if;
                                end if;
                              end if;
--                            end if;
                        end if;
                    else -- TNS yenilemesi
                        if birYilOncekiHasar = 0 then
                            p_maxindirim := 15;
                            p_ilaveIndirimKullan := 'E';
                        end if;
                    end if;
end if;
                 /*   if kullaniciGrubu = 'GENTEKM' or kullaniciGrubu = 'ICANADOLUB' or kullaniciGrubu = 'MARMARA_BL' or kullaniciGrubu = 'ANTALYA_BL' or kullaniciGrubu = 'GNYDGANDBL' or kullaniciGrubu = 'KONYA_BL'  or kullaniciGrubu = 'GM PAZARLM' or kullaniciGrubu = 'EGEBOLGE' or kullaniciGrubu = 'BURSABOLGE' then
                        p_maxindirim := p_maxindirim + 5;
                    end if;*/
            end if;
                    select max(nvl(d1,0)) into winsuretanimliindirim from tnswin.t001c002u5555 bb where trim(bb.k1)=productNo and (trim(bb.k2)=kullaniciAdi or trim(bb.k2)='99999') and gecer_tarih=(select max(bbb.gecer_tarih) from tnswin.t001c002u5555 bbb where bbb.k1=bb.k1 and bbb.k2=bb.k2 and bbb.gecer_tarih<=tariffDate);
                    if winsuretanimliindirim is null then winsuretanimliindirim := 0; end if;
                    if p_maxindirim is null then p_maxindirim := 0; end if;

                    if p_ilaveIndirimKullan = 'E' then p_maxindirim := p_maxindirim + winsuretanimliindirim; end if;

if p_ilaveIndirimKullan = 'E' then
                    if p_maxindirim > 20 then
                        p_maxindirim := 20;
                    end if;
else
                    if p_maxindirim > 20 then
                        p_maxindirim := 20;
                    end if;
end if;
                    if p_maxindirim < 5 then
                        p_maxindirim := 5;
                    end if;

                    if p_maxindirim = 20 then
                        select count(0) into maxDiscount from tnswin.pricing_tables bb where bb.key1=acente and bb.table_code = 'KSK-MAX YETKILI INDIRIM' and bb.valid_date=(select max(bbb.valid_date) from tnswin.pricing_tables bbb where bbb.key1=bb.key1 and bbb.valid_Date<=tariffDate);
                        if maxDiscount > 0 then
                            select bb.mult1 into maxDiscount from tnswin.pricing_tables bb where bb.key1=acente and bb.table_code = 'KSK-MAX YETKILI INDIRIM' and bb.valid_date=(select max(bbb.valid_date) from tnswin.pricing_tables bbb where bbb.key1=bb.key1 and bbb.valid_Date<=tariffDate);
                            p_maxindirim := maxDiscount;
                        end if;
                    end if;

/* Yeni Segment indirimleri */
                    if NBRENEWAL2 = 'TRANSFER' and length(kimlikNo) = 11 and p_maxindirim = 20 then


        p_ilceAd := UPPER(removeElement(getSbmDetails(clob_adresSorgu, 'ilceAd'), 'ilceAd'));
        p_ilAd := UPPER(removeElement(getSbmDetails(clob_adresSorgu, 'ilAd'), 'ilAd'));

        p_ilceAd := trim(replace(replace(replace(replace(replace(replace(p_ilceAd,'Ğ','G'),'Ü','U'),'Ş','S'),'İ','I'),'Ö','O'),'Ç','C'));
        p_ilAd := trim(replace(replace(replace(replace(replace(replace(p_ilAd,'Ğ','G'),'Ü','U'),'Ş','S'),'İ','I'),'Ö','O'),'Ç','C'));

        -- Bazı durumlarda SBM'den AFYONKARAHİSAR şeklinde veri gelmesi sebebiyle eklendi. 26/08/2019
        if p_ilAd like 'AFYONKARA%' then p_ilAd := 'AFYON KARAHISAR'; end if;


                                /* Eurocar bilgileri */
                               SELECT   count(0) into cnt99
                                                FROM   pricing_parameters b
                                               WHERE   b.param_name = 'KSK-ARAC BİLGİ'
                                               and b.key1=p_markatipkodu AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-ARAC BİLGİ'
                                                                        AND a.valid_date IS NOT NULL
                                                                        AND a.valid_date <= TariffDate);
                                if cnt99 > 0 then
                                    SELECT   max(b.desc1), max(b.desc2), max(b.desc3) into eurocar_segment, eurocar_kasatipi, eurocar_sanziman
                                                FROM   pricing_parameters b
                                               WHERE   b.param_name = 'KSK-ARAC BİLGİ'
                                               and b.key1=p_markatipkodu AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-ARAC BİLGİ'
                                                                        AND a.valid_date IS NOT NULL
                                                                        AND a.valid_date <= TariffDate)
                                               AND ROWNUM=1;
                                end if;
                                /* *************** */

                    /* İl İlçe Grup Tespiti */
                    SELECT   count(0) into cnt99
                        FROM   pricing_parameters b
                       WHERE   b.param_name = 'IL ILCE GRUP'
                       and b.key1=p_ilAd||'-'||p_ilceAd AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'IL ILCE GRUP'
                                                AND a.valid_date IS NOT NULL
                                                AND a.valid_date <= TariffDate);
                    if cnt99 > 0 then
                        SELECT   max(b.desc1) into p_ililcegrup
                                    FROM   pricing_parameters b
                                   WHERE   b.param_name = 'IL ILCE GRUP'
                                   and b.key1=p_ilAd||'-'||p_ilceAd AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'IL ILCE GRUP'
                                                            AND a.valid_date IS NOT NULL
                                                            AND a.valid_date <= TariffDate);
                    else
                            p_ililcegrup := p_ilAd||'-DIGER';
                    end if;
                    /* ***************** */

                    /* İndirim uygulanabilir İL İlçe Grup Kontrolü */
                            SELECT   count(0) into ililcegrupkontrol
                                    FROM   pricing_parameters b
                                   WHERE   b.param_name = 'KSK-MAXIND-IL ILCE GRUP'
                                   and b.key1=p_ililcegrup AND b.valid_date =(SELECT   MAX (a.valid_date) FROM   pricing_parameters a WHERE       a.param_name = 'KSK-MAXIND-IL ILCE GRUP'
                                                            AND a.valid_date IS NOT NULL
                                                            AND a.valid_date <= TariffDate);
                    /* ******************************************* */

                    /* Karar Ağacı */
                    if eurocar_segment='LCV' then
                        p_maxindirim := 5;
                    end if;
                    if eurocar_segment='B-small' and eurocar_kasatipi='HB' then
                        p_maxindirim := 5;
                    end if;
                    if eurocar_segment='B-small' and eurocar_kasatipi='HB' and (birYilOncekiHasar + ikiYilOncekiHasar + ucYilOncekiHasar)=0 then
                        p_maxindirim := 5;
                    end if;
                    if eurocar_segment='B-small' and eurocar_kasatipi='Sedan' then
                        p_maxindirim := 5;
                    end if;
                    if eurocar_segment='B-small' and eurocar_kasatipi='Sedan' and (birYilOncekiHasar + ikiYilOncekiHasar + ucYilOncekiHasar)=0 then
                        p_maxindirim := 5;
                    end if;

                    if eurocar_segment='C-medium' and eurocar_kasatipi='Sedan' then
                        p_maxindirim := p_maxindirim;
                    end if;
                    if eurocar_segment='C-medium' and eurocar_kasatipi='Sedan' and (birYilOncekiHasar + ikiYilOncekiHasar + ucYilOncekiHasar)=0 then
                        p_maxindirim := p_maxindirim;
                    end if;
                    if eurocar_segment='C-medium' and eurocar_kasatipi='Sedan' and (birYilOncekiHasar + ikiYilOncekiHasar + ucYilOncekiHasar)=0 and ililcegrupkontrol>0 then
                        p_maxindirim := p_maxindirim;
                    end if;


      end if;



/* ************************ */

                    addYetkiliIndLog(s_PricingId,birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_maxindirim, p_yenilemeyeniiskod, kullaniciAdi, p_cachekey);
        else
            select max(a.price_id) into cachepriceid from tnswin.pricing_ncd_log a where a.system_date=to_char(sysdate,'DD/MM/YYYY') and a.cachekey=p_cachekey;
            s_PricingId := cachepriceid;
        end if;

        RETURN s_PricingId;

        EXCEPTION WHEN OTHERS THEN
--        v_errm := SUBSTR(SQLERRM, 1, 4000);
        v_errm :=   substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
        addTariffLog(NULL,tariffdate,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,s_PricingId,'TARIFF1',v_errm,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,  NULL, NULL, 'Tariff1', '999999', '0', '0', '0', '0', '0', NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,NULL,NULL ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, null, null, null, null, null, null,null, null, null, null, null, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
        RETURN -1;
    END getMaxYetkiliIndirimi;



    FUNCTION getTariff1(islemTipi number, tariffdate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,
                        tescilTarihi varchar2,trafigeCikisTarihi varchar2,hasarsizlikKademesi varchar2,kullanimTarzi varchar2,modelyili varchar2,yenilememi varchar2,referansPoliceBilgileri varchar2)
        RETURN number
        IS
        clob_sbmValues CLOB;
        clob_sasiSorgu CLOB;
        clob_egmSorgu CLOB;
        clob_tcknAracSorgu CLOB;
        clob_trafikPoliceSorguKimlik CLOB;
        s_PricingId NUMBER;
        p_kullanimtarzi VARCHAR2(2);
        p_egmprm VARCHAR2(50);
        p_egmresult VARCHAR2(100);
        p_egmkaydivarmi VARCHAR2(1):='H';
        p_kullanimsekli VARCHAR2(20);
        p_result VARCHAR2(10);
        p_plakailkod VARCHAR2(3);
        v_errm CLOB;
        s_key varchar2(4000);
        p_kaskoReferansSorgu VARCHAR2(50);
        p_eskiPolSirketKodu VARCHAR2(10);
        p_eskiPolAcenteNo VARCHAR2(50);
        p_eskiPolPoliceNo VARCHAR2(50);
        p_eskiPolYenilemeNo VARCHAR2(10);
        p_kaskoReferansKullanimTarzi VARCHAR2(3);
        p_kismiHasarSayisi1 varchar2(10);
        p_camHasarSayisi1 varchar2(10);
        p_kismiHasarSayisi2 varchar2(10);
        p_camHasarSayisi2 varchar2(10);
        p_kismiHasarSayisi3 varchar2(10);
        p_camHasarSayisi3 varchar2(10);
        p_kskDonemselHasarSayisi varchar2(100);
        birYilOncekiHasar varchar2(2);
        ikiYilOncekiHasar varchar2(2);
        ucYilOncekiHasar varchar2(2);
        p_agirHasar1 varchar2(1);
        p_agirHasar2 varchar2(1);
        p_agirHasar3 varchar2(1);
        p_maxindirim number(11,2);
        p_commercialScoreId number(15);

    BEGIN

        select seq_pricing_id.nextval into s_PricingId from dual;
        /*
        if (asbisNo is null or asbisNo='') then p_egmprm:=tescilSeriKod;
        else p_egmprm:=asbisNo;
        end if;
        */
        p_plakailkod:='000';
        if  plakaIlKodu is not NULL   then  p_plakailkod :=SUBSTR(p_plakailkod||trim(plakaIlKodu),-3); end if;

        IF islemTipi = 1 or islemTipi = 2 or islemTipi = 9 THEN
            if tescilSeriNo is null then
                select GETTARIFFTOSBM(kimlikNo, p_plakailkod, plakaNo, NULL, asbisNo, sasiNo, '123', 'KSK', tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
            else
                select GETTARIFFTOSBM(kimlikNo, p_plakailkod, plakaNo, tescilSeriKod, tescilSeriNo, sasiNo, '123', 'KSK' , tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
            end if;
        --ELSIF islemTipi = 4 THEN
            --select GETTARIFFTOSBM(kimlikNo, p_plakailkod, plakaNo, tescilSeriKod, tescilSeriNo, sasiNo, '123', 'TRF', tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
        END IF;


        if islemTipi = 1 THEN /* Araç Skor */
            s_key := p_egmkaydivarmi||','||yenilememi||','||hasarsizlikKademesi||','||to_date(tariffdate,'DD/MM/YYYY')||','||tescilTarihi||','||trafigeCikisTarihi||','||modelyili||','||plakaNo;
            clob_sasiSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceBySasiSorgu');
            clob_egmSorgu := getSbmDetails(clob_sbmValues, 'tescilBilgiSorgu');
            p_egmresult := removeElement(getSbmDetails(clob_egmSorgu, 'isSuccessfull'), 'isSuccessfull');
            if UPPER(trim(p_egmresult))='TRUE'  THEN p_egmkaydivarmi:='E'; end if;
            p_result := GETARACSKOR(clob_sasiSorgu,p_egmkaydivarmi,yenilememi,hasarsizlikKademesi,to_date(tariffdate,'DD/MM/YYYY'),tescilTarihi,trafigeCikisTarihi,modelyili,plakaNo,s_PricingId);
        ELSIF islemTipi = 2 THEN /* Kasko Sigortalı Skor */
            clob_tcknAracSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceByTckSorgu');
            p_result := getSigortaliSkor (s_PricingId, clob_tcknAracSorgu, kimlikNo, tariffdate, kullanimtarzi, to_number(hasarsizlikkademesi));
        /*ELSIF islemTipi = 4 THEN --Trafik Sigortalı Skor
            clob_trafikPoliceSorguKimlik := getSbmDetails(clob_sbmValues, 'trafikPoliceSorguKimlikSorgu');
            p_result := getTrafikSigortaliSkor (s_PricingId, clob_trafikPoliceSorguKimlik, kimlikNo, tariffdate, kullanimtarzi, to_number(hasarsizlikkademesi));*/
        ELSIF islemTipi = 4 THEN /* Kasko Referans Poliçe */
            p_kaskoReferansSorgu := getKaskoReferansPolice(s_PricingId,kimlikNo,p_plakailkod,plakaNo);
        ELSIF islemTipi = 5 THEN /* Kasko Hasarsızlık */
            if referansPoliceBilgileri is not null then
                SELECT REGEXP_SUBSTR(referansPoliceBilgileri, '[^-]+', 1, 1) col1,
                   REGEXP_SUBSTR(referansPoliceBilgileri, '[^-]+', 1, 2) col2,
                   REGEXP_SUBSTR(referansPoliceBilgileri, '[^-]+', 1, 3) col3,
                   REGEXP_SUBSTR(referansPoliceBilgileri, '[^-]+', 1, 4) col4
                   into p_eskiPolSirketKodu, p_eskiPolAcenteNo, p_eskiPolPoliceNo, p_eskiPolYenilemeNo FROM dual;
            end if;

--            if p_eskiPolSirketKodu is not null and p_eskiPolAcenteNo is not null and p_eskiPolPoliceNo is not null and p_eskiPolYenilemeNo is not null then
                 p_result := getKaskoHasarsizlik(s_PricingId, kimlikNo, p_eskiPolSirketKodu, p_eskiPolAcenteNo, p_eskiPolPoliceNo, p_eskiPolYenilemeNo);
--            end if;
        ELSIF islemTipi = 6 THEN /* Tüzel Skor */
           IF length(trim(kimlikNo)) = 10 THEN
                select packgcommercialscore.getcommercialscoreprocWeb(kimlikNo,to_char(sysdate,'DD/MM/YYYY'),to_char(sysdate,'HH24:MI'), null, null, tariffdate) into p_commercialScoreId from dual;
                s_PricingId := p_commercialScoreId;
            END IF;

        ELSIF islemTipi = 9 THEN

                clob_tcknAracSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceByTckSorgu');
                p_kskDonemselHasarSayisi := getKSKDonemselHasarSayisi(kimlikNo,p_plakaIlKod,plakaNo,clob_tcknAracSorgu,455, 0);

                SELECT nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 1)),0) col1,
                       nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 2)),0) col2 into p_kismiHasarSayisi1, p_agirHasar1 FROM dual;

                p_kskDonemselHasarSayisi := getKSKDonemselHasarSayisi(kimlikNo,p_plakaIlKod,plakaNo,clob_tcknAracSorgu,910,455);

                SELECT nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 1)),0) col1,
                       nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 2)),0) col2 into p_kismiHasarSayisi2, p_agirHasar2 FROM dual;

                p_kskDonemselHasarSayisi := getKSKDonemselHasarSayisi(kimlikNo,p_plakaIlKod,plakaNo,clob_tcknAracSorgu,1365,910);

                SELECT nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 1)),0) col1,
                       nvl(TO_NUMBER(REGEXP_SUBSTR(p_kskDonemselHasarSayisi, '[^-]+', 1, 2)),0) col2 into p_kismiHasarSayisi3, p_agirHasar3 FROM dual;


                 if p_agirHasar1 != '0' then
                     birYilOncekiHasar := '3';
                 else
                     birYilOncekiHasar := coalesce(p_kismiHasarSayisi1,'0');
                 end if;
                 if p_agirHasar2 != '0' then
                     ikiYilOncekiHasar := '3';
                 else
                     ikiYilOncekiHasar := coalesce(p_kismiHasarSayisi2,'0');
                 end if;
                 if p_agirHasar3 != '0' then
                     ucYilOncekiHasar := '3';
                 else
                     ucYilOncekiHasar := coalesce(p_kismiHasarSayisi3,'0');
                 end if;
                 if birYilOncekiHasar>4 then birYilOncekiHasar := '4'; end if;
                 if ikiYilOncekiHasar>4 then ikiYilOncekiHasar := '4'; end if;
                 if ucYilOncekiHasar>4 then ucYilOncekiHasar := '4'; end if;

                p_maxindirim := 10;

                addYetkiliIndLog(s_PricingId,birYilOncekiHasar, ikiYilOncekiHasar, ucYilOncekiHasar, p_maxindirim, null, null, null);
        ELSE
            v_errm := 'İşlem tipi tanımlı değil!';
            addTariffLog(NULL,tariffdate,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,s_PricingId,'TARIFF1',v_errm,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,  NULL, NULL, 'Tariff1', '999999', '0', '0', '0', '0', '0', NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,NULL,NULL ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, null, null, null, null, null, null,null, null, null, null, null, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
            return -1;
        end IF;

        RETURN s_PricingId;
        EXCEPTION WHEN OTHERS THEN
        v_errm := SUBSTR(SQLERRM, 1, 4000);
        addTariffLog(NULL,tariffdate,NULL,NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,s_PricingId,'TARIFF1',v_errm,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,  NULL, NULL, 'Tariff1', '999999', '0', '0', '0', '0', '0', NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL ,NULL,NULL ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, null, null, null, null, null, null,null, null, null, null, null, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
        RETURN -1;
    END getTariff1;

/*
    procedure gettariffcursor is PRAGMA AUTONOMOUS_TRANSACTION;
    islemTipi number;
    pp varchar2(100);
cursor a is

    select POLICY_NO, RENEWAL_NO, POL_BEGIN_DATE, TC_KIMLIKNO, SIGORTALI_SKOR, ARAC_TIP_KODU, KASKO_NCD from sigortaliskor_temp2;
    --select pol_begin_date,POLICY_NO,RENEWAL_NO, TC_KIMLIKNO ,SASI_NO ,RUHSAT_BELGE_KOD ,RUHSAT_BELGE_NO ,TESCIL_TARIHI ,TRAFIGE_CIKIS_TARIHI ,ARAC_TIP_KODU ,KASKO_NCD, MODELYILI,YENILEMEMI,PLAKAILKOD,PLAKANO from aracskor;

    c a%rowtype;

Begin
  open a;
  loop
    fetch a
      into c;

       --select getTariff1(0, c.pol_begin_date,c.TC_KIMLIKNO, c.SASI_NO ,c.RUHSAT_BELGE_KOD ,c.RUHSAT_BELGE_NO,c.PLAKAILKOD,c.PLAKANO,'', c.TESCIL_TARIHI, c.TRAFIGE_CIKIS_TARIHI,c.KASKO_NCD , c.arac_tip_kodu, c.modelyili,c.YENILEMEMI)
       select getTariff1(1, c.POL_BEGIN_DATE,c.TC_KIMLIKNO, '' ,'' ,'','','','', '','',c.KASKO_NCD,c.arac_tip_kodu , '', '')
       into pp from dual;
        --UPDATE aracskor set yeni_arac_skor=pp where POLICY_NO=c.POLICY_NO and RENEWAL_NO=c.RENEWAL_NO and TC_KIMLIKNO =c.TC_KIMLIKNO;
          UPDATE sigortaliskor_temp2 set yeni_sigortali_skor=pp where POLICY_NO=c.POLICY_NO and RENEWAL_NO=c.RENEWAL_NO and TC_KIMLIKNO =c.TC_KIMLIKNO;
   commit;

 exit when a%NOTFOUND;
  end loop;
  close a;
  commit;
end;*/





/*
    FUNCTION getFiloKontrol(kimlikno varchar2)
        RETURN VARCHAR2
        IS
        clob_sbmValues CLOB;
        clob_sasiSorgu CLOB;
        clob_tcknAracSorgu CLOB;
        p_kullanimtarzi VARCHAR2(2);
        p_kontrol NUMBER(5);
        p_result VARCHAR2(10);
    BEGIN

        select count(0) into p_kontrol from t001c002u100081 where k1=kimlikno;
        if p_kontrol=0 then
            select count(0) into p_kontrol from t001c002u100081 where k2=kimlikno;
            if p_kontrol=0 then
                p_result := 'Yok';
            else
                select a.d1 into p_result from t001c002u100081 a where a.k2=kimlikno and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100081 b where b.k1=a.k1 and b.k2=a.k2);
            end if;
        else
            select a.d1 into p_kontrol from t001c002u100081 a where a.k1=kimlikno and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u100081 b where b.k1=a.k1 and b.k2=a.k2);
        end if;
        RETURN p_result;
        EXCEPTION WHEN OTHERS THEN
        RETURN SUBSTR(SQLERRM, 1, 10);
    END getFiloKontrol;
*/

    FUNCTION getPlaka100502 (
      productNo in varchar2,
      tariffDate in varchar2,
      kullanimSekli in varchar2,
      plakaIlKodu in varchar2,
      plakaNo in varchar2
    )
    RETURN VARCHAR2 AS
     s_plakafaktor VARCHAR2(8);
     s_plaka1 VARCHAR2(10);
     s_plaka2 VARCHAR2(10);
    BEGIN
        select t.plaka, t.plaka1 into s_plaka1, s_plaka2
        from
        (select case when substr(plakaNo,2,1 ) in ('0','1','2','3','4','5','6','7','8','9') then substr(plakaNo,1,1 )
                    when substr(plakaNo,3,1 ) in ('0','1','2','3','4','5','6','7','8','9') then substr(plakaNo,1,2 )
                    when substr(plakaNo,4,1 ) in ('0','1','2','3','4','5','6','7','8','9') then substr(plakaNo,1,3 )
               else plakaNo end plaka,
               case when substr(plakaNo,2,1 ) in ('0','1','2','3','4','5','6','7','8','9') then substr(plakaNo,2 )
                    when substr(plakaNo,3,1 ) in ('0','1','2','3','4','5','6','7','8','9') then substr(plakaNo,3 )
                    when substr(plakaNo,4,1 ) in ('0','1','2','3','4','5','6','7','8','9') then substr(plakaNo,4 )
               else plakaNo end plaka1
        from dual) t;

        IF LENGTH(TRIM(S_PLAKA1))=1 THEN
                select mult1 into s_plakafaktor from pricing_tables b where b.table_code='plaka100502' and b.key1=productNo and b.key2=TO_NUMBER(kullanimSekli) and b.key3=to_number(plakaIlKodu)
                                    and (b.key4 = s_plaka1)
                                    and (b.key5='0' or b.key5<=plakaNo)
                                    and (b.key6='0' or b.key6>=plakaNo)
                                    and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='plaka100502');
        ELSIF LENGTH(TRIM(S_PLAKA1))=2 THEN
                select mult1 into s_plakafaktor from pricing_tables b where b.table_code='plaka100502' and b.key1=productNo and b.key2=TO_NUMBER(kullanimSekli) and b.key3=to_number(plakaIlKodu)
                                    and (b.key4 = substr(s_plaka1,1,1)||'X' or b.key4 = substr(s_plaka1,1,2))
                                    and (b.key5='0' or b.key5<=plakaNo)
                                    and (b.key6='0' or b.key6>=plakaNo)
                                    and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='plaka100502');

        ELSIF LENGTH(TRIM(S_PLAKA1))=3 THEN
                select mult1 into s_plakafaktor from pricing_tables b where b.table_code='plaka100502' and b.key1=productNo and b.key2=TO_NUMBER(kullanimSekli) and b.key3=to_number(plakaIlKodu)
                                    and (b.key4 = substr(s_plaka1,1,1)||'X' or b.key4 = substr(s_plaka1,1,2)||'X' or b.key4=s_plaka1)
                                    and (b.key5='0' or b.key5<=plakaNo)
                                    and (b.key6='0' or b.key6>=plakaNo)
                                    and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='plaka100502');

        ELSIF LENGTH(TRIM(S_PLAKA1))=4 THEN
                select mult1 into s_plakafaktor from pricing_tables b where b.table_code='plaka100502' and b.key1=productNo and b.key2=TO_NUMBER(kullanimSekli) and b.key3=to_number(plakaIlKodu)
                                    and (b.key4 = substr(s_plaka1,1,1)||'X' or b.key4 = substr(s_plaka1,1,2)||'X' or b.key4 = substr(s_plaka1,1,3)||'X' or b.key4=s_plaka1)
                                    and (b.key5='0' or b.key5<=plakaNo)
                                    and (b.key6='0' or b.key6>=plakaNo)
                                    and b.valid_date=(select max(a.valid_date) from pricing_tables a where a.table_code='plaka100502');

        END IF;
        IF s_plakafaktor is null then s_plakafaktor := '1'; end if;
        return s_plakafaktor;
    EXCEPTION WHEN OTHERS THEN
        return '1';
    END getPlaka100502;


    FUNCTION fncgeciciplaka (plk IN VARCHAR2)
        RETURN number
    IS
    sonuc number;
    cnt number;
    BEGIN

    sonuc:=0;
    --SELECT COUNT(*) INTO cnt from  t001c002u69 where  UPPER(TRIM(k2))=UPPER(plk);

         if (cnt>0) THEN sonuc:=1; end if;

        RETURN sonuc;

        EXCEPTION
        WHEN VALUE_ERROR THEN
        RETURN 0;


    END;

    FUNCTION fncTrafikKayitliAracSayisi (kimlikNo IN VARCHAR2)
        RETURN number
    IS
    sonuc number;
    cnt number;
    BEGIN

    sonuc:=0;
    select count(distinct answer) into sonuc
            from t001polmas m, t001psrcvp c, t008unsmas u
                                            where m.firm_code=2
                                            and m.company_code=2
                                            and ((m.policy_is_cancelled!='1' and m.policy_status='O' and m.beg_date<=to_char(sysdate,'DD/MM/YYYY') and m.end_date>=to_char(sysdate,'DD/MM/YYYY')) or (m.policy_status='T' and m.prop_valid_beg_date<=to_char(sysdate,'DD/MM/YYYY') and m.prop_valid_end_date>=to_char(sysdate,'DD/MM/YYYY')))
                                            and m.insured_firm_code=u.firm_code
                                            and m.insured_unit_type=u.unit_type
                                            and m.insured_no=u.unit_no
                                            and m.firm_code=c.firm_code
                                            and m.company_code=c.company_code
                                            and m.product_no=c.product_no
                                            and m.policy_no=c.policy_no
                                            and m.renewal_no=c.renewal_no
                                            and m.endors_no=c.endors_no
                                            and c.question_code=10011 -- şasi no
                                            and m.product_no in(101,102)
                                            and u.tax_no=kimlikNo;
        if sonuc>200 then sonuc:=200; end if;

        RETURN sonuc;

        EXCEPTION
        WHEN VALUE_ERROR THEN
        RETURN 199;


    END;


    FUNCTION getYasayanOtoUrun (kimlikNo IN VARCHAR2, sasiNo in VARCHAR2, tariffDate date)
        RETURN varchar2
    IS
    sonuc varchar2(1);
    cnt number;
    BEGIN

    sonuc:='H';
    if length(kimlikNo)=11 then
        if substr(kimlikNo,1,1)!='9' then
            select count(0) into cnt from t001polmas pmas, t008unsmas umas, t001psrcvp cvp where pmas.firm_code=2
                                                                        and pmas.company_code=2
                                                                        and umas.firm_code=2
                                                                        and pmas.product_no in (100,101,102)
                                                                        and pmas.insured_firm_code=umas.firm_code
                                                                        and pmas.insured_unit_type=umas.unit_type
                                                                        and pmas.insured_no=umas.unit_no
                                                                        and umas.citizenship_number=kimlikno
                                                                        and pmas.firm_code=cvp.FIRM_CODE
                                                                        and pmas.company_code=cvp.COMPANY_CODE
                                                                        and pmas.product_no=cvp.product_no
                                                                        and pmas.policy_no=cvp.POLICY_NO
                                                                        and pmas.renewal_no=cvp.renewal_no
                                                                        and pmas.endors_no=cvp.endors_no
                                                                        and cvp.question_code=10011
                                                                        and cvp.answer!=sasiNo
                                                                        and pmas.policy_status='O'
                                                                        and pmas.cancellation_date = '31/12/2029'
                                                                        and pmas.endors_no=0
                                                                        and pmas.pol_end_date>=to_char(tariffDate,'DD/MM/YYYY')
                                                                        and pmas.pol_beg_date<=to_char(tariffDate-30,'DD/MM/YYYY');
        else
                    select count(0) into cnt from t001polmas pmas, t008unsmas umas, t001psrcvp cvp where pmas.firm_code=2
                                                                        and pmas.company_code=2
                                                                        and umas.firm_code=2
                                                                        and pmas.product_no in (100,101,102)
                                                                        and pmas.insured_firm_code=umas.firm_code
                                                                        and pmas.insured_unit_type=umas.unit_type
                                                                        and pmas.insured_no=umas.unit_no
                                                                        and umas.foreign_citizenship_number=kimlikno
                                                                        and pmas.firm_code=cvp.FIRM_CODE
                                                                        and pmas.company_code=cvp.COMPANY_CODE
                                                                        and pmas.product_no=cvp.product_no
                                                                        and pmas.policy_no=cvp.POLICY_NO
                                                                        and pmas.renewal_no=cvp.renewal_no
                                                                        and pmas.endors_no=cvp.endors_no
                                                                        and cvp.question_code=10011
                                                                        and cvp.answer!=sasiNo
                                                                        and pmas.policy_status='O'
                                                                        and pmas.cancellation_date = '31/12/2029'
                                                                        and pmas.endors_no=0
                                                                        and pmas.pol_end_date>=to_char(tariffDate,'DD/MM/YYYY')
                                                                        and pmas.pol_beg_date<=to_char(tariffDate-30,'DD/MM/YYYY');
        end if;
        else
                select count(0) into cnt from t001polmas pmas, t008unsmas umas, t001psrcvp cvp where pmas.firm_code=2
                                                                    and pmas.company_code=2
                                                                    and umas.firm_code=2
                                                                    and pmas.product_no in (100,101,102)
                                                                        and pmas.insured_firm_code=umas.firm_code
                                                                        and pmas.insured_unit_type=umas.unit_type
                                                                        and pmas.insured_no=umas.unit_no
                                                                    and umas.tax_no=kimlikno
                                                                        and pmas.firm_code=cvp.FIRM_CODE
                                                                        and pmas.company_code=cvp.COMPANY_CODE
                                                                        and pmas.product_no=cvp.product_no
                                                                        and pmas.policy_no=cvp.POLICY_NO
                                                                        and pmas.renewal_no=cvp.renewal_no
                                                                        and pmas.endors_no=cvp.endors_no
                                                                        and cvp.question_code=10011
                                                                        and cvp.answer!=sasiNo
                                                                    and pmas.policy_status='O'
                                                                    and pmas.cancellation_date = '31/12/2029'
                                                                    and pmas.endors_no=0
                                                                    and pmas.pol_end_date>=to_char(tariffDate,'DD/MM/YYYY')
                                                                    and pmas.pol_beg_date<=to_char(tariffDate-30,'DD/MM/YYYY');
        end if;

        if cnt>0 then sonuc:='E'; end if;


        RETURN sonuc;

        EXCEPTION
        WHEN OTHERS THEN
        RETURN 'H';


    END;

    FUNCTION getPertHasar (sbmSorgu IN CLOB)
        RETURN varchar2
    IS
    sonuc varchar2(1);
    cnt1 number;
    cnt2 number;
    cnt3 number;
    BEGIN

    sonuc:='H';
--        select count(0) into cnt1 from t001c002u50 where k1=plaka;
--        select count(0) into cnt2 from t001c002u50 where k2=motorNo;
--        select count(0) into cnt3 from t001c002u50 where k3=sasiNo;
--        if cnt1+cnt2+cnt3>0 then sonuc:='E'; end if;

        SELECT count(0) into cnt1
                  FROM
                         XMLTABLE (
                             '/kaskoPoliceSonucTypeList/kaskoPoliceSonucType/hasarList'
                                 PASSING xmltype(getsbmdetails (sbmSorgu,
                                                                                       'kaskoPoliceSonucTypeList'))
                                 COLUMNS hasartipi VARCHAR2 (4) PATH 'kaskoHasarTipi',
                                         rucuOrani VARCHAR2 (4) PATH 'rucuOrani') sorgu where sorgu.hasartipi='3' and rucuorani!='100';
        if cnt1>0 then sonuc:='E'; end if;
        RETURN sonuc;

        EXCEPTION
        WHEN OTHERS THEN
        RETURN 'H';


    END;

        FUNCTION fncOfacKontrol (sbmSorgu IN CLOB, kimlikNo VARCHAR2, operationType varchar2)
        RETURN number
    IS
    sonuc VARCHAR2(500);
    cnt number;
    BEGIN
    /* OperationType
        1: SBM TCKN VKN sorgu
        2: SBM TeklifIslemId sorgu
    */
    cnt := 0;
    sonuc:='';
    if operationType = '1' then
        if (length(kimlikno)=10) then
                SELECT replace(vknsorgu.soyadi||vknsorgu.adi,' ','') into sonuc
                              FROM
                                     XMLTABLE (
                                         '/vknSorgu'
                                             PASSING xmltype(getsbmdetails (sbmSorgu,
                                                                                           'vknSorgu'))
                                             COLUMNS adi VARCHAR2 (50) PATH 'vknBilgisiType/ad',
                                                     soyadi VARCHAR2 (50) PATH 'vknBilgisiType/soyad') vknSorgu;
        else
            if substr(kimlikNo,1,1) != 9 then
                SELECT   replace(tcknsorgu.adi||tcknsorgu.soyadi,' ','') into sonuc
                                                  FROM
                                                         XMLTABLE (
                                                             '/tcknSorgu'
                                                                 PASSING xmltype(getsbmdetails (sbmSorgu,'tcknSorgu'))
                                                                 COLUMNS adi VARCHAR2 (50) PATH 'kisiBilgisiType/adi',
                                                                         soyadi VARCHAR2 (50) PATH 'kisiBilgisiType/soyadi') tcknsorgu;
            else
                SELECT   replace(ytcknsorgu.adi||ytcknsorgu.soyadi,' ','')  into sonuc
                                    FROM
                                           XMLTABLE (
                                               '/yabanciKimlikSorgu'
                                                   PASSING xmltype(getsbmdetails (sbmSorgu,'yabanciKimlikSorgu'))
                                                   COLUMNS adi VARCHAR2 (50) PATH 'yabanciKisiBilgisiType/adi',
                                                           soyadi VARCHAR2 (50) PATH 'yabanciKisiBilgisiType/soyadi') ytcknsorgu;
            end if;
        end if;
    else
         SELECT   replace(tcknsorgu.adi||tcknsorgu.soyadi,' ','') into sonuc
                                   FROM
                                          XMLTABLE (
                                              '/trafikTeklifDataSorguOutput'
                                                  PASSING xmltype(sbmSorgu)
                                                  COLUMNS adi VARCHAR2 (50) PATH 'sigortaliBilgileri/adUnvan',
                                                          soyadi VARCHAR2 (50) PATH 'sigortaliBilgileri/soyad') tcknsorgu;
    end if;
    select count(0) into cnt from t001c002u500 where replace(k1,' ','')=sonuc;
        RETURN cnt;

        EXCEPTION
        WHEN VALUE_ERROR THEN
        RETURN 0;


    END;

    FUNCTION getTeenCocuk (
      value in CLOB,
      teklifBaslangicTarihi in DATE
    )
    RETURN VARCHAR2 AS
     s_CocukDegiskeni VARCHAR2(4);
     s_CocukAdet NUMBER;
    BEGIN
    s_CocukDegiskeni := 'H';
    select sum(aralik1) into s_CocukAdet
    from
    (select case when b.yas>=16 and b.yas<=24 then 1 else 0 end aralik1
    from
    (SELECT round(cast(cast(to_char(teklifBaslangicTarihi, 'YYYY') as number(4))-cast(to_char(to_date(substr(x.dogumtarihi,1,10),'YYYY-MM-DD'),'YYYY') as number(4)) AS NUMBER),0) yas
        FROM (select xmltype(value) data from dual) t,
        XMLTABLE ('/aileSorgu/kisiBilgisiTypeList/kisiBilgisiType'      PASSING t.data
                COLUMNS yakinlik VARCHAR2(30) PATH 'yakinlik',
                dogumTarihi VARCHAR2(30) PATH 'dogumTarihi'
                ) x where x.yakinlik in('Kızı') or x.yakinlik like 'Oğlu') b) c;
    if s_CocukAdet>0 then s_CocukDegiskeni:='E'; else s_CocukDegiskeni:='H'; end if;
        return s_CocukDegiskeni;
    EXCEPTION WHEN OTHERS THEN
        return 'H';
    END getTeenCocuk;

    FUNCTION getErkekTeenCocuk (
      value in CLOB,
      teklifBaslangicTarihi in DATE
    )
    RETURN VARCHAR2 AS
     s_CocukDegiskeni VARCHAR2(4);
     s_CocukAdet NUMBER;
    BEGIN
    s_CocukDegiskeni := 'H';
    select sum(aralik1) into s_CocukAdet
    from
    (select case when b.yas>=16 and b.yas<=24 then 1 else 0 end aralik1
    from
    (SELECT round(cast(cast(to_char(teklifBaslangicTarihi, 'YYYY') as number(4))-cast(to_char(to_date(substr(x.dogumtarihi,1,10),'YYYY-MM-DD'),'YYYY') as number(4)) AS NUMBER),0) yas
        FROM (select xmltype(value) data from dual) t,
        XMLTABLE ('/aileSorgu/kisiBilgisiTypeList/kisiBilgisiType'      PASSING t.data
                COLUMNS yakinlik VARCHAR2(30) PATH 'yakinlik',
                dogumTarihi VARCHAR2(30) PATH 'dogumTarihi'
                ) x where x.yakinlik like 'Oğlu') b) c;
    if s_CocukAdet>0 then s_CocukDegiskeni:='E'; else s_CocukDegiskeni:='H'; end if;
        return s_CocukDegiskeni;
    EXCEPTION WHEN OTHERS THEN
        return 'H';
    END getErkekTeenCocuk;

    PROCEDURE getTrfTariffSBM (ssql varchar2, RESULT out refCursorxx) is PRAGMA AUTONOMOUS_TRANSACTION;
    v_errm varchar2(4000);
    psql varchar2(4000);
    rec srecordx;
    begin
        psql := 'alter session set nls_numeric_characters=''.,''';
        execute immediate psql;
--        psql := replace(ssql,'''','''''');
        psql := ssql;
--        execute immediate psql into RESULT;
        open RESULT for psql;
    end;

    PROCEDURE getTrfTariffSBMCache (ssql varchar2, cacheKey varchar2, RESULT out refCursorxx) is PRAGMA AUTONOMOUS_TRANSACTION;
    v_errm varchar2(4000);
    psql varchar2(4000);
    p_cache number;
    p_cachepriceid number;
    rec srecordx;
    begin
    p_cache := 0;
    psql := 'alter session set nls_numeric_characters=''.,''';
    execute immediate psql;
    select count(0) into p_cache from pricing_tariff_log where cache_key=cacheKey and status='1' and (to_char(to_date(system_date,'DD/MM/YYYY'),'MM/YYYY')=to_char(sysdate,'MM/YYYY') or (to_char(sysdate,'DD')<4 and (to_date('01/'||to_char(sysdate,'MM/YYYY'))-1)=to_date(system_date,'DD/MM/YYYY') ));
    if p_cache > 0 then
        select max(price_id) into p_cachepriceid                              from pricing_tariff_log where cache_key=cacheKey and status='1' and (to_char(to_date(system_date,'DD/MM/YYYY'),'MM/YYYY')=to_char(sysdate,'MM/YYYY') or (to_char(sysdate,'DD')<4 and (to_date('01/'||to_char(sysdate,'MM/YYYY'))-1)=to_date(system_date,'DD/MM/YYYY') ));
        psql := 'select price_id PRICEID, m1 M1,m2 M2,m3 M3,m4 M4,m5 M5,m6 M6,(m1*112/100) PRIM from pricing_tariff_log where price_id=' || p_cachepriceid;
    else
        psql := ssql;
    end if;
    open RESULT for psql;
    end;


    FUNCTION getTariffKsk(productNo varchar2,TariffDate date,kimlikNo varchar2,sasiNo varchar2,tescilSeriKod varchar2,tescilSeriNo varchar2,plakailkodu varchar2,plakaNo varchar2,asbisNo varchar2,tescilTarihi varchar2,trafigeCikisTarihi varchar2,referansPoliceBilgileri varchar2,kullanimSekli varchar2,model varchar2,markaTipKodu varchar2,hasarsizlikKademesi varchar2,yakitTipi varchar2,aracBedeli varchar2,kasaBedeli varchar2,tasinanEmtiaBedeli varchar2,tasinanEmtiaCinsi varchar2,sesGoruntuCihaziBedeli varchar2,digerAksesuarBedeli varchar2,yurtDisiTeminatiSuresi varchar2,trafikKademesi varchar2,paketTipi varchar2,kullanimTipi varchar2,OzelIndirim number,surprim number,meslek varchar2, kullanimTarzi varchar2, kiymetKazanma varchar2, sigortaliliksuresi number, kismihasarsayisi varchar2, camhasarsayisi varchar2, minimumFiyatKorunsunMu varchar2, minimumPrimKorunsunMu varchar2, acente varchar2, kullaniciAdi varchar2, referancePriceId varchar2, camMuafiyetIstisnasi varchar2, yenilemePrimKontroluCalissinMi varchar2, immSorumlulukTeminatLimiti varchar2, fkSigortaliTeminatLimiti varchar2, fkKoltukTeminatLimiti varchar2, maneviTazminatLimiti varchar2, koltukSayisi varchar2, YolYardimAlternatifTeminat varchar2, garaj varchar2, resmidaire varchar2, servis varchar2, muafiyet varchar2, anlasmaliServis varchar2, parcaTuru varchar2, servisTuru varchar2, surucu1 varchar2, surucu2 varchar2, channel varchar2, araccoklugu varchar2)
        RETURN stablex
        PIPELINED IS
        rec            srecordx;
        v_sql CLOB;
        t_sql CLOB;
        auth VARCHAR2(4000);
        clob_sbmValues CLOB;
        clob_aileSorgu CLOB;
        clob_sasiSorgu CLOB;
        clob_tcknSorgu CLOB;
        clob_adresSorgu CLOB;
        clob_tcknAracSorgu CLOB;
        clob_tcknPlakaSorgu CLOB;
        clob_egmSorgu CLOB;
        p_cocukdegiskeni VARCHAR2(5);
        p_aracyasi VARCHAR2(10);
        p_sigortaliyas VARCHAR2(10);
        p_aracskor VARCHAR2(10);
        p_kullanimsekli VARCHAR2(20);
        p_kullanimtarzi100501 VARCHAR2(2);
        p_kullanimtarzi VARCHAR2(2);
        p_kullanimTipiCap VARCHAR2(1);
        p_cinsiyeti VARCHAR(5);
        p_medenihali VARCHAR2(25);
        p_tramerIl VARCHAR2(3);
        p_tramerilce VARCHAR2(7);
        p_sigortaliskor NUMBER;
        p_otor_sigortaliskor NUMBER;
        p_systemdate VARCHAR2(10);
        p_systemtime VARCHAR2(25);
        s_PricingId NUMBER;
        p_yakittipi VARCHAR2(15);
        v_errm CLOB;
        p_markatipkodu VARCHAR2(10);
        p_markakodu VARCHAR2(10);
        z_sql CLOB;
        d1_sql CLOB;
        d2_sql CLOB;
        p_meslek varchar2(20);
        p_yeniaracbedel NUMBER(15);
        p_aracbedeli NUMBER(15);
        p_filosegment VARCHAR2(3);
        p_markariskgrubu VARCHAR2(3);
        p_yenilemeyeniiskod VARCHAR2(3);
        p_kismihasarsayisi NUMBER;
        p_sigortaliliksuresi NUMBER;
        p_camhasarsayisi NUMBER;
        p_sql CLOB;
        p_model NUMBER(4);
        p_minimumprim NUMBER(11,2);
        p_minimumfiyat NUMBER(11,5);
        p_egmkaydivarmi VARCHAR2(1);
        p_yenilemeMi VARCHAR2(1);
        p_kasabedeli NUMBER(11,2);
        p_digerAksesuarBedeli NUMBER(11,2);
        p_yenilemeCapIndirimi NUMBER;
        p_guncelbedel VARCHAR2(1);
        p_ilkAracBedeli NUMBER(15);
        p_commercialScore VARCHAR2(10);
        p_commercialScoreId NUMBER(20);
        p_hasarsizlikOran VARCHAR2(10);
        p_ilkAracYas VARCHAR2(10);
        p_ozelIndirim NUMBER(11,5);
        p_surprim NUMBER(11,5);
        p_plakaIlKodu VARCHAR2(3);
        p_gecmisHasarSayisi VARCHAR2(5);
        p_gecmisHasarsizlikIndirimi VARCHAR2(5);
        p_gecmisPoliceFiyat NUMBER(11,5);
        p_yenilemeCapMin VARCHAR2(15);
        p_yenilemeCapMax VARCHAR2(15);
        p_yenilemeCap VARCHAR(15);
        p_yenilemeFloor VARCHAR(15);
        p_plaka100502 NUMBER;
        p_filoSegmentD VARCHAR2(10);
        p_filoSegmentSql CLOB;
        p_ozelTuzel VARCHAR2(1);
        p_ticariFaktor NUMBER;
        p_minimumFiyatKorunsunMu VARCHAR2(1);
        p_agirlik VARCHAR2(5);
        p_beygirGucu VARCHAR2(5);
        p_whp varchar2(5);
        p_aracSegment varchar2(7);
        p_kasaTipi varchar(30);
        p_cache number;
        p_capPolice varchar2(30);
        p_tcknSorguKontrol varchar2(1);
        s_key varchar2(4000);
        p_tariffDate Date;
        refproductNo varchar2(50);
refTariffdate varchar2(50);
refkimlikNo varchar2(50);
refsasiNo varchar2(50);
reftescilSeriKod varchar2(50);
reftescilSeriNo varchar2(50);
refplakailkodu varchar2(50);
refplakaNo varchar2(50);
refasbisNo varchar2(50);
reftescilTarihi varchar2(50);
reftrafigeCikisTarihi varchar2(50);
refreferansPoliceBilgileri varchar2(50);
refkullanimSekli varchar2(50);
refmodel varchar2(50);
refmarkaTipKodu varchar2(50);
refhasarsizlikKademesi varchar2(50);
refyakitTipi varchar2(50);
refaracBedeli varchar2(50);
refkasaBedeli varchar2(50);
reftasinanEmtiaBedeli varchar2(50);
reftasinanEmtiaCinsi varchar2(50);
refsesGoruntuCihaziBedeli varchar2(50);
refdigerAksesuarBedeli varchar2(50);
refyurtDisiTeminatiSuresi varchar2(50);
reftrafikKademesi varchar2(50);
refpaketTipi varchar2(50);
refkullanimTipi varchar2(50);
refOzelIndirim varchar2(50);
refsurprim varchar2(50);
refmeslek varchar2(50);
refkullanimTarzi varchar2(50);
refkiymetKazanma varchar2(50);
refsigortaliliksuresi varchar2(50);
refkismihasarsayisi varchar2(50);
refcamhasarsayisi varchar2(50);
refminimumFiyatKorunsunMu varchar2(50);
refminimumPrimKorunsunMu varchar2(50);
refacente varchar2(50);
refkullaniciAdi varchar2(50);
refreferancePriceId varchar2(50);
checkRef varchar2(1);
refp_cocukdegiskeni varchar2(50);
refp_sigortaliyas varchar2(50);
refp_aracyasi varchar2(50);
refp_aracskor varchar2(50);
refp_sigortaliskor varchar2(50);
refp_yakittipi varchar2(50);
refp_commercialScore varchar2(50);
refp_medenihali varchar2(50);
refp_yenilemeyeniiskod varchar2(50);
checkReferansId number;
p_kiymetKazanma varchar2(5);
p_kskGenelBilgi varchar2(100);
p_ksk_sigortalilikSuresi NUMBER(11,2);
p_ksk_camHasarSayisi NUMBER;
p_ksk_kismiHasarSayisi NUMBER;
p_hasarsizlikKademesi varchar2(5);
p_eskiPolSirketKodu varchar2(3);
p_eskiPolAcenteNo varchar2(10);
p_eskiPolPoliceNo varchar2(30);
p_eskiPolYenilemeNo varchar2(2);
p_kaskoReferansSorgu varchar2(200);
p_kaskoReferansKullanimTarzi varchar2(2);
p_kaskoRefPlakaIlKodu varchar2(3);
p_yasayanOtoUrun varchar2(2);
p_pertarac varchar2(2);
p_teenCocuk varchar2(2);
p_ErkekTeenCocuk varchar2(2);
p_cache_key varchar2(2000);
p_immPrim NUMBER;
p_fkSigortaliPrim NUMBER;
p_fkPrim NUMBER;
p_sesGoruntuCihaziFiyat NUMBER;
p_tasinanEmteaFiyat NUMBER;
p_koltukSayisi varchar2(3);
p_hukuksalKorumaPrim NUMBER;
p_miniOnarimPrim NUMBER;
p_yanlisAkaryakitPrim NUMBER;
p_yolYardimPrim NUMBER;
p_kskHasarSayisi varchar2(100);
p_Otor_camHasarSayisi NUMBER;
p_Otor_kismiHasarSayisi NUMBER;
p_ililcekontrol NUMBER;
p_aracyerliyabanci varchar2(5);
p_garaj varchar2(5);
p_resmidaire varchar2(5);
p_servis varchar2(5);
p_muafiyet varchar2(5);
p_anlasmaliServis varchar2(5);
p_parcaTuru varchar2(5);
p_servisTuru varchar2(5);
p_surucu1 varchar2(5);
p_surucu2 varchar2(5);
p_surucuInd varchar2(5);
p_debugmode varchar2(1);
p_acenteCarpan NUMBER;
c50036 number;
c50011 number;
c5028 varchar2(3);
c50041 number;
c50071 number;
c50111 number;
c5571 number;
c5071 number;
s8000 varchar2(5);
s8060 varchar2(5);
c5269 number;
c5270 number;
c5264 number;
ssql varchar2(4000);
c50300 number;
c1360 number;
c577 number;
maxdate5015 date;
t5015k1 varchar2(3);
t5015k2 varchar2(7);
--p_tasinanEmteaPrim NUMBER;

    BEGIN
    /*
    Kullanım Tarzı  S5000
    Kullanım Tipi   S5001
    Kullanım Şekli  S5066
    */
    p_debugmode:='0';
/* yenileme cap indirim yapısı tasarlanmalı. Cap ve floor aynı tabloda (Winsure) */
    p_sql := 'select * from table(getTariff.getTariffMain('''||productNo||''','''||Tariffdate ||''','''||kimlikNo ||''','''||sasiNo ||''','''||tescilSeriKod ||''','''||
    tescilSeriNo ||''','''||plakailkodu ||''','''||plakaNo ||''','''||asbisNo ||''','''||tescilTarihi ||''','''||trafigeCikisTarihi ||''','''||
    referansPoliceBilgileri ||''','''||kullanimSekli ||''','''||model ||''','''||markaTipKodu ||''','''||hasarsizlikKademesi ||''','''||yakitTipi ||''','''||
    aracBedeli ||''','''||kasaBedeli ||''','''||tasinanEmtiaBedeli ||''','''||tasinanEmtiaCinsi ||''','''||sesGoruntuCihaziBedeli ||''','''||
    digerAksesuarBedeli ||''','''||yurtDisiTeminatiSuresi ||''','''||trafikKademesi ||''','''||paketTipi ||''','''||kullanimTipi ||''','''||
    OzelIndirim ||''','''||surprim ||''','''||meslek||''','''||kullanimTarzi||''','''||kiymetKazanma||''','''||sigortaliliksuresi||''','''||
    kismihasarsayisi||''','''||camhasarsayisi||''','''||minimumFiyatKorunsunMu||''','''||minimumPrimKorunsunMu ||''','''||acente||''','''||kullaniciAdi||''','''||
    referancePriceId||''','''||camMuafiyetIstisnasi||''','''||yenilemePrimKontroluCalissinMi    ||''','''||immSorumlulukTeminatLimiti ||''','''||
    fkSigortaliTeminatLimiti||''','''||fkKoltukTeminatLimiti||''','''||maneviTazminatLimiti||''','''||koltukSayisi||''','''||YolYardimAlternatifTeminat||''','''||
    garaj||''','''||resmidaire||''','''||servis||''','''||muafiyet||''','''||anlasmaliservis||''','''||parcaTuru||''','''||servisTuru||''','''||surucu1||''','''||
    surucu2||''','''||channel||''','''||araccoklugu||'''))';

if p_debugmode='1' then addlog ('','1', ''); end if;

     if tescilSeriNo is null then
         select GETTARIFFTOSBM(kimlikNo, p_plakaIlKodu, plakaNo, NULL, asbisNo, sasiNo, '123', 'KSK', tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
     else
         select GETTARIFFTOSBM(kimlikNo, p_plakaIlKodu, plakaNo, tescilSeriKod, tescilSeriNo, sasiNo, '123', 'KSK', tescilTarihi, trafigeCikisTarihi, '', '', '', '', '', '', '') into clob_sbmValues from dual;
     end if;
if p_debugmode='1' then addlog ('','2', ''); end if;
        clob_aileSorgu := getSbmDetails(clob_sbmValues, 'aileSorgu');
        clob_sasiSorgu := getSbmDetails(clob_sbmValues, 'ovmkaskoPoliceBySasiSorgu');
        if length(kimlikNo) = 11 and substr(kimlikNo,1,1)='9' THEN
            clob_tcknSorgu := getSbmDetails(clob_sbmValues, 'yabanciKimlikSorgu');
            clob_adresSorgu := getSbmDetails(clob_sbmValues, 'yabanciAdresSorgu');
        else
            clob_tcknSorgu := getSbmDetails(clob_sbmValues, 'tcknSorgu');
            clob_adresSorgu := getSbmDetails(clob_sbmValues, 'adresSorgu');
        end if;

        if length(removeElement(getSbmDetails(clob_adresSorgu, 'ilceKod'), 'ilceKod')) < 8 THEN
            p_tramerilce := removeElement(getSbmDetails(clob_adresSorgu, 'ilceKod'), 'ilceKod');
            p_tramerIl := removeElement(getSbmDetails(clob_adresSorgu, 'ilKod'), 'ilKod');
        end if;
if p_debugmode='1' then addlog ('','3', ''); end if;

    p_surucu1 := surucu1;
    p_surucu2 := surucu2;

    p_surucuInd := '0';
    if trim(p_surucu1) is not null then
        if trim(p_surucu2) is not null then
            p_surucuInd := '2';
        else
            p_surucuInd := '1';
        end if;
    end if;

    p_parcaTuru := parcaTuru;
    p_servisTuru := servisTuru;
    p_anlasmaliServis := anlasmaliServis;
    p_muafiyet := muafiyet;
    p_servis := servis;
    p_resmidaire := resmidaire;
    p_garaj := garaj;
    p_ozelIndirim := (100 - OzelIndirim)/100;
    p_surprim := (100+surprim)/100;
    p_tariffDate := TariffDate;
    p_cache_key := 'KSK'||','||kimlikNo||','||sasiNo;

--    p_sigortalilikSuresi := cast(to_number('0'||sigortaliliksuresi) as varchar2);
    select seq_pricing_id.nextval into s_PricingId from dual;
    p_systemdate := to_char(SYSDATE,'DD/MM/YYYY');
    p_systemtime := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF');

if p_debugmode='1' then addlog ('','4', ''); end if;
    -- c50036
    if ((channel='30043') and ((kullanimTarzi='10') or ((kullanimTarzi='7') and (kullanimTipi=' 4') or (kullanimTipi=' 3') or (kullanimTipi=' 2') or (kullanimTipi=' 1')))) then
        c50036 := 1;
    end if;
if p_debugmode='1' then addlog ('','5', ''); end if;
    -- c5571
    if to_char(sysdate,'YYYY')-model<0 then
        c5571 := 0;
    elsif to_char(sysdate,'YYYY')-model>25 then
        c5571 := 25;
    else
        c5571 := to_char(sysdate,'YYYY')-model;
    end if;
if p_debugmode='1' then addlog ('','6', ''); end if;
    -- c50011
    if c50036 = 1 then
        if c5571 >13 then c50011:=13;
        else c50011 := c5571;
        end if;
    else
        if kullanimTarzi = '1' then
           if c5571 > 20 then c50011 := 20;
           else
            c50011 := c5571;
           end if;
        end if;
    end if;
if p_debugmode='1' then addlog ('','7', ''); end if;
    -- c5028
    c5028 := 'D' || cast(cast(hasarsizlikKademesi as number) + 1 as varchar2);
if p_debugmode='1' then addlog ('','8', ''); end if;
    -- c50041
    if (((channel='30037') or (channel='30045')) and (((kullanimTarzi='7') and ( kullanimTipi='1')) or ((kullanimTarzi='7') and (kullanimTipi=' 4')))) then
        c50041 := 1;
    end if;
if p_debugmode='1' then addlog ('','9', ''); end if;
    -- c50071
    if kullanimSekli='4' then
        c50071 := '14';
    elsif kullanimTarzi='7' and kullanimTipi='2' then
        c50071 := '12';
    elsif kullanimTarzi='7' and kullanimTipi='4' then
        c50071 := '13';
    else
        c50071 := kullanimTarzi;
    end if;
if p_debugmode='1' then addlog ('','10', ''); end if;
    -- c50111
    --((@S5066='4')|(@S5066='5')|(@S5000$' 1'))?'1':(@B[5005;@X2031S5073]?@B[5005;@X2031S5073;1]:'6')
    if ((kullanimSekli='4') or (kullanimSekli='5') or (kullanimTarzi = '1')) then
        c50111 := '1';
    else
        --:(@B[5005;@X2031S5073]?@B[5005;@X2031S5073;1]:'6')
        select count(0) into c50111 from t001c002u5005 a where a.k1=markaTipKodu and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u5005 b);
        if c50111 =0 then
            c50111 := 6;
        else
            select a.d1 into c50111 from t001c002u5005 a where a.k1=markaTipKodu and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u5005 b);
        end if;
    end if;
if p_debugmode='1' then addlog ('','11', ''); end if;
    -- c5264
    c5264 := p_tramerIl;

    -- c5270
    -- ((@B[5015;@C5264,@C5272,@C5571;1]/1000)*((@X1000S5000=6)?1.10:.90))*(((@C1630=30511)&(@B[15;#PREDEGV33]))?0.75:0.75)
    select max(b.gecer_tarih) into maxdate5015 from t001c002u5015 b;
    t5015k1:=substr(c5264||'  ',1,3);
    t5015k2:=substr(markaTipKodu||'   ',1,7);
    select count(0) into c5270 from t001c002u5015 a where a.k1=t5015k1 and a.k2=t5015k2 and a.k3=c5571 and a.gecer_tarih=maxdate5015;
    if c5270 > 0 then
        select a.d1 into c5270 from t001c002u5015 a where a.k1=t5015k1 and a.k2=t5015k2 and a.k3=c5571 and a.gecer_tarih=maxdate5015;
        if kullanimTarzi = '6' then
            c5270 := c5270 * 1.1;
        else
            c5270 := c5270 * 0.9;
        end if;
    end if;
if p_debugmode='1' then addlog ('','12', 'select count(0) into c5270 from t001c002u5015 a where a.k1='||c5264||' and a.k2='||markaTipKodu||' and a.k3='||c5571||' and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u5015 b)'); end if;

    -- c5269
    -- ((@B[5015;@C5264,@C5272,@C5571;1]/1000)*((@X1000S5000=6)?1.10:.90))*(((@C1630=30511)&(@B[15;#PREDEGV33]))?0.75:0.75)
    select count(0) into c5269 from t001c002u5015 a where a.k1=t5015k1 and a.k2=t5015k2 and a.k3=c5571 and a.gecer_tarih=maxdate5015;

if p_debugmode='1' then addlog ('','13', ''); end if;
    -- s8000 - s8060
    select count(0) into s8000 from t001c002u551 a where a.k1=markaTipKodu and a.k2=model and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u551 b);
    if s8000 <> '0' then
        if kullanimTarzi = '1' then
            select a.d11, a.d12 into s8000, s8060 from t001c002u551 a where a.k1=markaTipKodu and a.k2=model and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u551 b);
        elsif kullanimTarzi = '6' then
            select a.d11, a.d12 into s8000, s8060 from t001c002u551 a where a.k1=markaTipKodu and a.k2=model and a.d1=kullanimTarzi and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u551 b);
        else
            s8000 := '1';
            s8060 := '1';
        end if;
    else
        s8000 := '1';
        s8060 := '1';
    end if;
if p_debugmode='1' then addlog ('','14', ''); end if;
    -- Baz Fiyat
    if c50036 = 1 then
        ssql := 'select ' || c5028 || ' from t001c002u5010 a where a.k1=''' || c50011 || ''' and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u5010 b)';
        execute immediate ssql into rec;
if p_debugmode='1' then addlog ('','15', ''); end if;
    else
        if c50041 = 1 then
--            @B[5080;#PGV3,#PGV17,@C50071,@C50111,@C50011;1]/1000
            ssql := 'select '||s_PricingId||', a.d1, 0,0,0,0,0,0 from t001c002u5080 a where a.k1=''' || productNo || ''' and trim(a.k2)='''|| channel || ''' and trim(a.k3)='''||c50071||''' and trim(a.k4)='''||c50111||''' and trim(a.k5)='''||c50011||''' and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u5080 b)';
            execute immediate ssql into rec;
if p_debugmode='1' then addlog ('','16', ''); end if;
        else
            --(((#PREDEGV90='O')&(@X1000S5000=1)|(@X1000S5000=6))?((@C5571>10)?(((@B[50011;#PGV3,@X1000S5000,@X1000S5001,@X1000S8000,@X1000S8060,@C5571;1])*2)/1000)
            if ((length(kimlikNo)=11) and (kullanimTarzi='1') or (kullanimTarzi='6')) then
                if c5571 > 10 then
--                    ((@C5571>10)?(((@B[50011;#PGV3,@X1000S5000,@X1000S5001,@X1000S8000,@X1000S8060,@C5571;1])*2)/1000)
                    ssql := 'select '||s_PricingId||', a.d1*2, 0,0,0,0,0,0 from t001c002u50011 a where trim(a.k1)=''' || productNo || ''' and trim(a.k2)='''|| kullanimTarzi || ''' and trim(a.k3)='''||kullanimTipi||''' and a.k4='''||s8000||''' and a.k5='''||s8060||''' and a.k6='''||c5571||''' and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u50011 b)';
                    execute immediate ssql into rec;
if p_debugmode='1' then addlog ('','17', ''); end if;
                else
                    -- :((@C5269)?@C5270:((@B[50011;#PGV3,@X1000S5000,@X1000S5001,@X1000S8000,@X1000S8060,@C5571;1])/1000)))
                    if c5269 > 0 then
                        ssql := 'select '||s_PricingId||', a.d1, 0,0,0,0,0,0 from t001c002u5015 a where trim(a.k1)='''||c5264||''' and trim(a.k2)='''||markaTipKodu||''' and trim(a.k3)='''||c5571||''' and a.gecer_tarih='''||maxdate5015||'''';
                        execute immediate ssql into rec;
if p_debugmode='1' then addlog ('','18', ''); end if;
                    else
                        ssql := 'select '||s_PricingId||', a.d1, 0,0,0,0,0,0 from t001c002u50011 a where a.k1=''' || productNo || ''' and trim(a.k2)='''|| kullanimTarzi || ''' and trim(a.k3)='''||kullanimTipi||''' and trim(a.k4)='''||s8000||''' and trim(a.k5)='''||s8060||''' and trim(a.k6)='''||c5571||''' and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u50011 b)';
                        execute immediate ssql into rec;
if p_debugmode='1' then addlog ('','19', ''); end if;
                    end if;
                end if;
            else
            -- :(((#PREDEGV90='T')&(@X1000S5000=1))?((@C5571>10)?(((@B[50012;#PGV3,@X1000S5000,@X1000S5001,@X1000S8000,@X1000S8060,@C5571;1])*2)/1000)
                if (length(kimlikNo)<11) and (kullanimTarzi='1') then
                    if c5571 > 10 then
    --                    (((@B[50012;#PGV3,@X1000S5000,@X1000S5001,@X1000S8000,@X1000S8060,@C5571;1])*2)/1000)
                        ssql := 'select '||s_PricingId||', a.d1*2, 0,0,0,0,0,0 from t001c002u50012 a where trim(a.k1)=''' || productNo || ''' and trim(a.k2)='''|| kullanimTarzi || ''' and trim(a.k3)='''||kullanimTipi||''' and trim(a.k4)='''||s8000||''' and trim(a.k5)='''||s8060||''' and trim(a.k6)='''||c5571||''' and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u50012 b)';
                        execute immediate ssql into rec;
if p_debugmode='1' then addlog ('','20', ''); end if;
                    else
                        --:((@B[50012;#PGV3,@X1000S5000,@X1000S5001,@X1000S8000,@X1000S8060,@C5571;1])/1000))
                        ssql := 'select '||s_PricingId||', a.d1, 0,0,0,0,0,0 from t001c002u50012 a where trim(a.k1)=''' || productNo || ''' and trim(a.k2)='''|| kullanimTarzi || ''' and trim(a.k3)='''||kullanimTipi||''' and trim(a.k4)='''||s8000||''' and trim(a.k5)='''||s8060||''' and trim(a.k6)='''||c5571||''' and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u50012 b)';
                        execute immediate ssql into rec;
if p_debugmode='1' then addlog ('','21', ''); end if;
                    end if;
                else
                    --:(@B[5001;#PGV3,@C50071,@C50111,@C50011;1]/1000))))
                    ssql := 'select '||s_PricingId||', a.d1, 0,0,0,0,0,0 from t001c002u5001 a where trim(a.k1)=''' || productNo || ''' and trim(a.k2)='''|| c50071 || ''' and trim(a.k3)='''||c50111||''' and trim(a.k4)='''||c50011||''' and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u5001 b)';
                    execute immediate ssql into rec;
if p_debugmode='1' then addlog ('','22', ''); end if;
                end if;
            end if;
        end if;
    end if;
if p_debugmode='1' then addlog ('','23', ''); end if;
        -- 50300
        if ((channel=30043) and ((kullanimTarzi='10') or ((kullanimTarzi='7') and (kullanimTipi='4')))) then
            c50300 := 1;
        elsif (((kullanimTarzi='3') or (kullanimTarzi='4') or (kullanimTarzi='5') or (kullanimTarzi='7') or (kullanimTarzi='8') or (kullanimTarzi='9') or (kullanimTarzi='10'))) then
            c50300 := 1.25;
        else
            c50300 := 1;
        end if;
if p_debugmode='1' then addlog ('','24', ''); end if;
        -- 1360
--        (#PGV17~'')?1.25:((#PGV17~'30458')?0.75:((#PGV17~'30531')?0.90:((#PGV17~'30267')?1.75:((#PGV17~'30422')?2.0:((#PGV17~'30175-20024-30452-30171-30464-30386-30265-30233')?1.5:1)))))
        if channel = '30458' then
            c1360 := 0.75;
        elsif channel = '30531' then
            c1360 := 0.9;
        elsif channel = '30267' then
            c1360 := 1.75;
        elsif channel = '30422' then
            c1360 := 2;
        elsif channel in('30175','20024','30452','30171','30464','30386','30265','30233') then
            c1360 := 1.5;
        else
            c1360 := 1;
        end if;
if p_debugmode='1' then addlog ('','25', ''); end if;
        -- 577
        if kullanimTarzi in('1','6') and length(kimlikNo) = 11 then
            select count(0) into c577 from t001c002u29 a where a.k1='O' and a.k2=kullanimTarzi and a.k3=hasarsizlikKademesi and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u29 b);
            if c577 > 0 then
                select a.d1 into c577 from t001c002u29 a where a.k1='O' and a.k2=kullanimTarzi and a.k3=hasarsizlikKademesi and a.gecer_tarih=(select max(b.gecer_tarih) from t001c002u29 b);
            else
                c577 := 1;
            end if;
        end if;
if p_debugmode='1' then addlog ('','26', ''); end if;
        rec.m1 := rec.m1 * c50300 * c1360 * c577;
if p_debugmode='1' then addlog ('','27', ''); end if;
            addTariffLog(productNo,p_tariffdate,kimlikNo,sasiNo,tescilSeriKod,tescilSeriNo,plakailkodu,plakaNo,asbisNo, tescilTarihi,trafigeCikisTarihi,s_PricingId,'TARIFF','',d2_sql,p_cocukdegiskeni,p_sigortaliyas,p_aracyasi,p_kullanimtarzi,p_kullanimsekli,p_aracskor,p_cinsiyeti,p_medenihali,p_tramerilce,p_sigortaliskor,p_systemdate,p_systemtime,p_yakittipi,p_markakodu,p_aracbedeli,p_filosegment,p_markariskgrubu,p_yenilemeyeniiskod,  p_kismihasarsayisi,  p_sigortaliliksuresi, p_camhasarsayisi, 'SBM', rec.m1, rec.m2, rec.m3, rec.m4, rec.m5, rec.m6, p_sql,p_markatipkodu,p_minimumfiyat,p_minimumprim,p_meslek,p_ilkAracBedeli,p_kasabedeli,p_digerAksesuarBedeli,sesGoruntuCihaziBedeli,p_commercialScore,p_kiymetKazanma,p_ilkAracYas,p_commercialScoreId,p_gecmisHasarSayisi ,p_gecmisHasarsizlikIndirimi,p_gecmisPoliceFiyat ,p_yenilemeCapMin,p_yenilemeCapMax,clob_sbmValues,p_yenilemeFloor,p_yenilemeCap,P_WHP,acente,kullaniciAdi,p_hasarsizlikKademesi,OzelIndirim, surprim, p_capPolice, referancePriceId, NULL,NULL,NULL,NULL,NULL,auth, p_cache_key, '1', p_immPrim, p_fkPrim , p_fkSigortaliPrim , p_tasinanEmteaFiyat, p_sesGoruntuCihaziFiyat, p_hukuksalKorumaPrim, p_miniOnarimPrim, p_yanlisAkaryakitPrim, p_yolYardimPrim, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);

    PIPE ROW (rec);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
         --v_errm := SUBSTR(SQLERRM, 1, 4000);
         v_errm :=   substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
         addTariffLog(productNo,p_tariffdate,kimlikNo,sasiNo,tescilSeriKod,tescilSeriNo,plakailkodu,plakaNo,asbisNo, tescilTarihi,trafigeCikisTarihi,s_PricingId,'TARIFF',v_errm,v_sql,p_cocukdegiskeni,p_sigortaliyas,p_aracyasi,p_kullanimtarzi,p_kullanimsekli,p_aracskor,p_cinsiyeti,p_medenihali,p_tramerilce,p_sigortaliskor,p_systemdate,p_systemtime,p_yakittipi, p_markakodu,p_aracbedeli,p_filosegment,p_markariskgrubu,p_yenilemeyeniiskod,  p_kismihasarsayisi,  p_sigortaliliksuresi,  p_camhasarsayisi, 'SBM', 99,99,99,99,99,99,p_sql,p_markatipkodu,p_minimumfiyat,p_minimumprim,p_meslek,p_ilkAracBedeli,p_kasabedeli,p_digerAksesuarBedeli,sesGoruntuCihaziBedeli,p_commercialScore,p_kiymetKazanma,p_ilkAracYas,p_commercialScoreId,p_gecmisHasarSayisi ,p_gecmisHasarsizlikIndirimi,p_gecmisPoliceFiyat ,p_yenilemeCapMin,p_yenilemeCapMax,clob_sbmValues,p_yenilemeFloor,p_yenilemeCap,P_WHP,acente,kullaniciAdi,p_hasarsizlikKademesi,OzelIndirim, surprim, p_capPolice, referancePriceId,NULL,NULL,NULL,NULL,NULL,NULL, p_cache_key, '0',p_immPrim , p_fkPrim , p_fkSigortaliPrim , p_tasinanEmteaFiyat, p_sesGoruntuCihaziFiyat, p_hukuksalKorumaPrim, p_miniOnarimPrim, p_yanlisAkaryakitPrim, p_yolYardimPrim, null, null, null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null/*m19*/);
         RETURN;
    END getTariffKsk;
    FUNCTION getTRFReferans (p_xml_value in CLOB)
    RETURN VARCHAR2 AS
    s_Result VARCHAR2(100);
    v_errm VARCHAR2(4000);
    BEGIN

    select x.belgeNo||'|'||x.belgeSiraNo||'|'||x.belgeTarih||'|'||x.RefAcenteKod||'|'||x.refPoliceno||'|'||x.refsirketKodu||'|'||x.refyenilemeNo||'|'||x.uygulanmasiGerekenGecikmeSurprimYuzde
    ||'|'||x.uygulanmasiGerekenIndirimYuzde||'|'||x.uygulanmasiGerekenSurprimYuzde||'|'||x.uygulanmasiGerekenTarifeBasamakKodu||'|'||x.uygulanmisGecikmeSurprimYuzde
    ||'|'||x.uygulanmisIlPlakaIndirimYuzde||'|'||x.uygulanmisIndirimYuzde||'|'||x.uygulanmisSurprimYuzde||'|'||x.uygulanmisTarifeBasamakKodu into s_Result
                                            from
                                            (select  price_id, to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, xmltype(tnswin.gettariff.getSbmDetails(ssbm,'ovmtrafikPoliceHasarBelgeBilgileri')) data from tnswin.pricing_Tariff_log where price_type='TRF_TARIFF') t,
                                                XMLTABLE ('/ovmtrafikPoliceHasarBelgeBilgileri/kazaHasarBelgeBilgileri'      PASSING t.data
                                                           COLUMNS
                                                             belgeNo VARCHAR2(100) PATH 'belgeNo',
                                                             belgeSiraNo VARCHAR2(100) PATH 'belgeSiraNo',
                                                             belgeTarih VARCHAR2(100) PATH 'belgeTarih',
                                                             RefAcenteKod VARCHAR2(100) PATH 'oncekiPoliceAnahtari/acenteKod',
                                                             refPoliceno VARCHAR2(100) PATH 'oncekiPoliceAnahtari/policeNo',
                                                             refsirketKodu VARCHAR2(100) PATH 'oncekiPoliceAnahtari/sirketKodu',
                                                             refyenilemeNo VARCHAR2(100) PATH 'oncekiPoliceAnahtari/yenilemeNo',
                                                             uygulanmasiGerekenGecikmeSurprimYuzde VARCHAR2(100) PATH 'uygulanmasiGerekenGecikmeSurprimYuzde',
                                                             uygulanmasiGerekenIndirimYuzde VARCHAR2(100) PATH 'uygulanmasiGerekenIndirimYuzde',
                                                             uygulanmasiGerekenSurprimYuzde VARCHAR2(100) PATH 'uygulanmasiGerekenSurprimYuzde',
                                                             uygulanmasiGerekenTarifeBasamakKodu VARCHAR2(100) PATH 'uygulanmasiGerekenTarifeBasamakKodu',
                                                             uygulanmisGecikmeSurprimYuzde VARCHAR2(100) PATH 'uygulanmisGecikmeSurprimYuzde',
                                                             uygulanmisIlPlakaIndirimYuzde VARCHAR2(100) PATH 'uygulanmisIlPlakaIndirimYuzde',
                                                             uygulanmisIndirimYuzde VARCHAR2(100) PATH 'uygulanmisIndirimYuzde',
                                                             uygulanmisSurprimYuzde VARCHAR2(100) PATH 'uygulanmisSurprimYuzde',
                                                             uygulanmisTarifeBasamakKodu VARCHAR2(100) PATH 'uygulanmisTarifeBasamakKodu'
                                                         ) x;


    RETURN s_Result;

    EXCEPTION WHEN OTHERS THEN
       v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
       return s_Result;
    end getTRFReferans;


    FUNCTION getTRFSigortalilikSuresiNew (
      p_xml_value in CLOB
    )
    RETURN VARCHAR2 AS
    s_sigortalilikSuresi NUMBER(11,2);
    s_ilkSigortalanmaTarihi VARCHAR2(10);
    s_hasarSayisi  NUMBER(11);
    s_beklenenSigortalilikSuresi NUMBER(11,2);
    v_errm VARCHAR2(4000);
    v_errm2 VARCHAR2(4000);
    BEGIN
      
    
--insertXMLtoTable(p_xml_value);


select z.*, round((sysdate-ilksigortalanmatarihi)/365,2) beklenensigortaliliksuresi into s_sigortalilikSuresi, s_ilkSigortalanmaTarihi, s_hasarSayisi, s_beklenenSigortalilikSuresi
from

(    select NVL(sum(sigortalilikSuresi),0) s_sigortalilikSuresi,
    min(to_date(NVL(substr(policebaslamatarihi,1,10),sysdate),'YYYY-MM-DD')) ilkSigortalanmatarihi,

--    system_date-min(to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD')) beklenensigortaliliksuresi,
    sum(hasarsayisi)
        from
        (
            select
                v.*,
                round(nvl(case when v.iptalmi=1 then to_date(substr(v.policeekibaslamatarihi,1,10),'YYYY-MM-DD') - to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD')
                                        else case when to_date(substr(v.policebitistarihi,1,10),'YYYY-MM-DD')>system_date then system_date-to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD')
                                        else to_date(substr(v.policebitistarihi,1,10),'YYYY-MM-DD')-to_date(substr(v.policebaslamatarihi,1,10),'YYYY-MM-DD') end
                                        end,0)/365,2) sigortalilikSuresi
            from
            (
                select
                distinct to_date(to_char(sysdate,'DD/MM/YYYY')) system_date, y.policeNo ,y.yenilemeno ,y.policeEkino ,y.policeEkiTuru ,
                case when y.policeEkiTuru in(8,9,13) then 1 else 0 end iptalmi,
                case when y.policeEkiTuru in(3) then 1 else 0 end mebiptalmi,
                y.policeBaslamaTarihi ,y.policeBitisTarihi ,y.policeEkiBaslamaTarihi,
                y.aracMarkaKodu ,y.aracTarifeGrupKodu ,y.aracTipKodu ,y.kullanimSekli ,y.modelYili ,y.plakaIlKodu ,y.plakaNo,
--                x3.sirketkodu, x3.acentekod, x3.hasardosyadurumkod, x3.hasardosyano, x3.hasarilkodu, x3.hasarilcekodu, x3.hasartarih, x3.hasaryapansigortalimi, x3.ihbartarih
                nvl(x3.hasarsayisi,0) hasarsayisi
                from
                (
                     select 'gecmisPoliceler', x1.*
                             from
                                (select xmltype(p_xml_value) data from dual) t,
                                --(select  xmltype(txt) data from test where idx = 10) t,
                                XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/gecmisPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                          ) x1
                    UNION ALL
                     select 'yururPoliceler',x2.*
                             from
                                 (select xmltype(p_xml_value) data from dual) t,
                                 --(select  xmltype(txt) data from test where idx = 10) t,
                                 XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/yururPoliceler'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              policeEkino VARCHAR2(3) PATH 'policeEkiNo',
                                              policeEkiTuru VARCHAR2(3) PATH 'policeEkiTuru',
                                              policeBaslamaTarihi VARCHAR2(30) PATH 'tarihBilgileri/baslangicTarihi',
                                              policeBitisTarihi varchar2(30) PATH 'tarihBilgileri/bitisTarihi',
                                              policeEkiBaslamaTarihi varchar2(30) PATH 'tarihBilgileri/ekBaslangicTarihi',
                                              policeEkiBitisTarihi varchar2(30) PATH 'tarihBilgileri/ekBitisTarihi',
                                              aracMarkaKodu varchar2(4) PATH 'aracTemelBilgileri/marka/kod',
                                              aracTarifeGrupKodu varchar2(4) PATH 'aracTemelBilgileri/aracTarifeGrupKod',
                                              aracTipKodu varchar2(4) PATH 'aracTemelBilgileri/tip/kod',
                                              kullanimSekli varchar2(4) PATH 'aracTemelBilgileri/kullanimSekli',
                                              modelYili varchar2(4) PATH 'aracTemelBilgileri/modelYili',
                                              plakaIlKodu varchar2(4) PATH 'aracTemelBilgileri/plaka/ilKodu',
                                              plakaNo varchar2(10) PATH 'aracTemelBilgileri/plaka/no'
                                          ) x2
                ) y left join (                     select x2.policeno, x2.yenilemeno, count(distinct x2.hasardosyano) hasarsayisi
                             from
                                 (select xmltype(p_xml_value) data from dual) t,
                                 --(select  xmltype(txt) data from test where idx = 10) t,
                                 XMLTABLE ('/ovmtrafikPoliceSorguSasiKimlikSorgu/trafikPoliceSorguSasiKimlikNo/policeninHasarlari'   PASSING t.data
                                            COLUMNS
                                              policeNo VARCHAR2(30) PATH 'policeAnahtari/policeNo',
                                              yenilemeno VARCHAR2(3) PATH 'policeAnahtari/yenilemeNo',
                                              sirketKodu VARCHAR2(3) PATH 'policeAnahtari/sirketKodu',
                                              acenteKod VARCHAR2(3) PATH 'policeAnahtari/acenteKod',
                                              hasarDosyaDurumKod VARCHAR2(30) PATH 'hasarDosyaDurumKod',
                                              hasarDosyaNo varchar2(30) PATH 'hasarDosyaNo',
                                              hasarIlKodu varchar2(30) PATH 'hasarIlKodu',
                                              hasarIlceKodu varchar2(30) PATH 'hasarIlceKodu',
                                              hasarTarih varchar2(4) PATH 'hasarTarih',
                                              hasarYapanSigortalimi varchar2(5) PATH 'hasarYapanSigortalimi',
                                              ihbarTarih varchar2(4) PATH 'ihbarTarih'
                                          ) x2 group by x2.policeno, x2.yenilemeno) x3 on y.policeNo=x3.policeno  and y.yenilemeno=x3.yenilemeno
            ) v where v.mebiptalmi != 1 and to_date(substr(policebaslamatarihi,1,10),'YYYY-MM-DD') >= trunc(sysdate-(365*5)-5)
        ) s) z;

    RETURN s_sigortalilikSuresi||'-'||s_beklenenSigortalilikSuresi||'-'||s_hasarSayisi;

    EXCEPTION WHEN OTHERS THEN
       v_errm := substr(SUBSTR(SQLERRM, 1, 2000) || '  ERROR_STACK: ' || DBMS_UTILITY.FORMAT_ERROR_STACK || '  ERROR_BACKTRACE: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,1,4000) ;
--       insert into tnswin.tarife_hata(sys_date, hata) values(sysdate,v_errm);
       addlog ('999','',v_errm);
                     
       --select decode(nvl(s_CommercialScor,1),0,1,nvl(s_CommercialScor,1)) into s_CommercialScor99 from dual;
       --addpricinglog ('SigortalıSkor',s_poolNo, s_Fx, s_Gls, s_Ngls, s_Severity, s_OrtalamaBedel, s_CommercialScor99, s_MinScor, s_MaxScor, s_PricingId,  p_taxNo,  p_kullanimSekli,  p_aracBedeli,  p_hasarsizlikKademesi,  p_hasarsizlikIndirimOrani,  p_tarifePrimi, s_KazanilmisPolice, s_RucusuzHasarlar, s_yururPoliceler, s_camHasarSayisi, p_tarih, p_saat,  p_kullanici,  p_acenteKodu, s_hasarsizlikFaktor, s_cachePriceId, v_errm);
       return 0;

    end getTRFSigortalilikSuresiNew;

END;




/*
    (select max(to_number(ab.key3)) from pricing_tables ab where ab.table_code = b.table_code and ab.key1=b.key1 and ab.key2=b.key2 and ab.valid_date=b.valid_date)
*/
/
