package br.ufjf.pgcc.eseco.domain.service.core;

import br.ufjf.pgcc.eseco.domain.dao.core.CountryDAO;
import br.ufjf.pgcc.eseco.domain.model.core.Country;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class CountryService {

    private final CountryDAO countryDAO;

    @Autowired
    public CountryService(CountryDAO countryDao) {
        this.countryDAO = countryDao;
    }

    @Transactional
    public Country saveOrUpdate(Country country) throws Exception {
        if (country.getId() == 0 || find(country.getId()) == null) {
            return countryDAO.add(country);
        } else {
            return countryDAO.update(country);
        }
    }

    @Transactional
    public Country registerNewCountry(Country country) throws Exception {

        country = countryDAO.add(country);

        return country;
    }

    @Transactional
    public void delete(Country country) throws Exception {
        countryDAO.delete(country);
    }

    public Country find(int countryId) {
        return countryDAO.find(countryId);
    }

    public List<Country> findAll() {
        return countryDAO.findAll();
    }

    public Country findByNameOrCode(String name) {
        if (name != null) {
            Map<String, String> map = new HashMap<>();
            map.put("name", name);

            List<Country> findBy = countryDAO.findBy(map);
            if (findBy.size() <= 0) {
                map = new HashMap<>();
                map.put("code", name);
                findBy = countryDAO.findBy(map);
            }
            return findBy.size() > 0 ? findBy.get(0) : null;
        }
        return null;

    }

    @Transactional
    public void populateCountries() {
        if (countryDAO.findAll().isEmpty()) {
            try {
                countryDAO.add(new Country("Afghanistan", "AF"));
                countryDAO.add(new Country("AlandIslands", "AX"));
                countryDAO.add(new Country("Albania", "AL"));
                countryDAO.add(new Country("Algeria", "DZ"));
                countryDAO.add(new Country("AmericanSamoa", "AS"));
                countryDAO.add(new Country("Andorra", "AD"));
                countryDAO.add(new Country("Angola", "AO"));
                countryDAO.add(new Country("Anguilla", "AI"));
                countryDAO.add(new Country("Antarctica", "AQ"));
                countryDAO.add(new Country("AntiguaandBarbuda", "AG"));
                countryDAO.add(new Country("Argentina", "AR"));
                countryDAO.add(new Country("Armenia", "AM"));
                countryDAO.add(new Country("Aruba", "AW"));
                countryDAO.add(new Country("Australia", "AU"));
                countryDAO.add(new Country("Austria", "AT"));
                countryDAO.add(new Country("Azerbaijan", "AZ"));
                countryDAO.add(new Country("Bahamas", "BS"));
                countryDAO.add(new Country("Bahrain", "BH"));
                countryDAO.add(new Country("Bangladesh", "BD"));
                countryDAO.add(new Country("Barbados", "BB"));
                countryDAO.add(new Country("Belarus", "BY"));
                countryDAO.add(new Country("Belgium", "BE"));
                countryDAO.add(new Country("Belize", "BZ"));
                countryDAO.add(new Country("Benin", "BJ"));
                countryDAO.add(new Country("Bermuda", "BM"));
                countryDAO.add(new Country("Bhutan", "BT"));
                countryDAO.add(new Country("Bolivia", "BO"));
                countryDAO.add(new Country("BosniaandHerzegovina", "BA"));
                countryDAO.add(new Country("Botswana", "BW"));
                countryDAO.add(new Country("BouvetIsland", "BV"));
                countryDAO.add(new Country("Brazil", "BR"));
                countryDAO.add(new Country("BritishVirginIslands", "VG"));
                countryDAO.add(new Country("BritishIndianOceanTerritory", "IO"));
                countryDAO.add(new Country("BruneiDarussalam", "BN"));
                countryDAO.add(new Country("Bulgaria", "BG"));
                countryDAO.add(new Country("BurkinaFaso", "BF"));
                countryDAO.add(new Country("Burundi", "BI"));
                countryDAO.add(new Country("Cambodia", "KH"));
                countryDAO.add(new Country("Cameroon", "CM"));
                countryDAO.add(new Country("Canada", "CA"));
                countryDAO.add(new Country("CapeVerde", "CV"));
                countryDAO.add(new Country("CaymanIslands", "KY"));
                countryDAO.add(new Country("CentralAfricanRepublic", "CF"));
                countryDAO.add(new Country("Chad", "TD"));
                countryDAO.add(new Country("Chile", "CL"));
                countryDAO.add(new Country("China", "CN"));
                countryDAO.add(new Country("HongKong,SARChina", "HK"));
                countryDAO.add(new Country("Macao,SARChina", "MO"));
                countryDAO.add(new Country("ChristmasIsland", "CX"));
                countryDAO.add(new Country("Cocos(Keeling)Islands", "CC"));
                countryDAO.add(new Country("Colombia", "CO"));
                countryDAO.add(new Country("Comoros", "KM"));
                countryDAO.add(new Country("Congo (Brazzaville)", "CG"));
                countryDAO.add(new Country("Congo,(Kinshasa)", "CD"));
                countryDAO.add(new Country("CookIslands", "CK"));
                countryDAO.add(new Country("CostaRica", "CR"));
                countryDAO.add(new Country("Côted'Ivoire", "CI"));
                countryDAO.add(new Country("Croatia", "HR"));
                countryDAO.add(new Country("Cuba", "CU"));
                countryDAO.add(new Country("Cyprus", "CY"));
                countryDAO.add(new Country("CzechRepublic", "CZ"));
                countryDAO.add(new Country("Denmark", "DK"));
                countryDAO.add(new Country("Djibouti", "DJ"));
                countryDAO.add(new Country("Dominica", "DM"));
                countryDAO.add(new Country("DominicanRepublic", "DO"));
                countryDAO.add(new Country("Ecuador", "EC"));
                countryDAO.add(new Country("Egypt", "EG"));
                countryDAO.add(new Country("ElSalvador", "SV"));
                countryDAO.add(new Country("EquatorialGuinea", "GQ"));
                countryDAO.add(new Country("Eritrea", "ER"));
                countryDAO.add(new Country("Estonia", "EE"));
                countryDAO.add(new Country("Ethiopia", "ET"));
                countryDAO.add(new Country("FalklandIslands(Malvinas)", "FK"));
                countryDAO.add(new Country("FaroeIslands", "FO"));
                countryDAO.add(new Country("Fiji", "FJ"));
                countryDAO.add(new Country("Finland", "FI"));
                countryDAO.add(new Country("France", "FR"));
                countryDAO.add(new Country("FrenchGuiana", "GF"));
                countryDAO.add(new Country("FrenchPolynesia", "PF"));
                countryDAO.add(new Country("FrenchSouthernTerritories", "TF"));
                countryDAO.add(new Country("Gabon", "GA"));
                countryDAO.add(new Country("Gambia", "GM"));
                countryDAO.add(new Country("Georgia", "GE"));
                countryDAO.add(new Country("Germany", "DE"));
                countryDAO.add(new Country("Ghana", "GH"));
                countryDAO.add(new Country("Gibraltar", "GI"));
                countryDAO.add(new Country("Greece", "GR"));
                countryDAO.add(new Country("Greenland", "GL"));
                countryDAO.add(new Country("Grenada", "GD"));
                countryDAO.add(new Country("Guadeloupe", "GP"));
                countryDAO.add(new Country("Guam", "GU"));
                countryDAO.add(new Country("Guatemala", "GT"));
                countryDAO.add(new Country("Guernsey", "GG"));
                countryDAO.add(new Country("Guinea", "GN"));
                countryDAO.add(new Country("Guinea-Bissau", "GW"));
                countryDAO.add(new Country("Guyana", "GY"));
                countryDAO.add(new Country("Haiti", "HT"));
                countryDAO.add(new Country("HeardandMcdonaldIslands", "HM"));
                countryDAO.add(new Country("HolySee (VaticanCityState)", "VA"));
                countryDAO.add(new Country("Honduras", "HN"));
                countryDAO.add(new Country("Hungary", "HU"));
                countryDAO.add(new Country("Iceland", "IS"));
                countryDAO.add(new Country("India", "IN"));
                countryDAO.add(new Country("Indonesia", "ID"));
                countryDAO.add(new Country("Iran,IslamicRepublicof", "IR"));
                countryDAO.add(new Country("Iraq", "IQ"));
                countryDAO.add(new Country("Ireland", "IE"));
                countryDAO.add(new Country("IsleofMan", "IM"));
                countryDAO.add(new Country("Israel", "IL"));
                countryDAO.add(new Country("Italy", "IT"));
                countryDAO.add(new Country("Jamaica", "JM"));
                countryDAO.add(new Country("Japan", "JP"));
                countryDAO.add(new Country("Jersey", "JE"));
                countryDAO.add(new Country("Jordan", "JO"));
                countryDAO.add(new Country("Kazakhstan", "KZ"));
                countryDAO.add(new Country("Kenya", "KE"));
                countryDAO.add(new Country("Kiribati", "KI"));
                countryDAO.add(new Country("Korea (North)", "KP"));
                countryDAO.add(new Country("Korea (South)", "KR"));
                countryDAO.add(new Country("Kuwait", "KW"));
                countryDAO.add(new Country("Kyrgyzstan", "KG"));
                countryDAO.add(new Country("LaoPDR", "LA"));
                countryDAO.add(new Country("Latvia", "LV"));
                countryDAO.add(new Country("Lebanon", "LB"));
                countryDAO.add(new Country("Lesotho", "LS"));
                countryDAO.add(new Country("Liberia", "LR"));
                countryDAO.add(new Country("Libya", "LY"));
                countryDAO.add(new Country("Liechtenstein", "LI"));
                countryDAO.add(new Country("Lithuania", "LT"));
                countryDAO.add(new Country("Luxembourg", "LU"));
                countryDAO.add(new Country("Macedonia,Republicof", "MK"));
                countryDAO.add(new Country("Madagascar", "MG"));
                countryDAO.add(new Country("Malawi", "MW"));
                countryDAO.add(new Country("Malaysia", "MY"));
                countryDAO.add(new Country("Maldives", "MV"));
                countryDAO.add(new Country("Mali", "ML"));
                countryDAO.add(new Country("Malta", "MT"));
                countryDAO.add(new Country("MarshallIslands", "MH"));
                countryDAO.add(new Country("Martinique", "MQ"));
                countryDAO.add(new Country("Mauritania", "MR"));
                countryDAO.add(new Country("Mauritius", "MU"));
                countryDAO.add(new Country("Mayotte", "YT"));
                countryDAO.add(new Country("Mexico", "MX"));
                countryDAO.add(new Country("Micronesia,FederatedStatesof", "FM"));
                countryDAO.add(new Country("Moldova", "MD"));
                countryDAO.add(new Country("Monaco", "MC"));
                countryDAO.add(new Country("Mongolia", "MN"));
                countryDAO.add(new Country("Montenegro", "ME"));
                countryDAO.add(new Country("Montserrat", "MS"));
                countryDAO.add(new Country("Morocco", "MA"));
                countryDAO.add(new Country("Mozambique", "MZ"));
                countryDAO.add(new Country("Myanmar", "MM"));
                countryDAO.add(new Country("Namibia", "NA"));
                countryDAO.add(new Country("Nauru", "NR"));
                countryDAO.add(new Country("Nepal", "NP"));
                countryDAO.add(new Country("Netherlands", "NL"));
                countryDAO.add(new Country("NetherlandsAntilles", "AN"));
                countryDAO.add(new Country("NewCaledonia", "NC"));
                countryDAO.add(new Country("NewZealand", "NZ"));
                countryDAO.add(new Country("Nicaragua", "NI"));
                countryDAO.add(new Country("Niger", "NE"));
                countryDAO.add(new Country("Nigeria", "NG"));
                countryDAO.add(new Country("Niue", "NU"));
                countryDAO.add(new Country("NorfolkIsland", "NF"));
                countryDAO.add(new Country("NorthernMarianaIslands", "MP"));
                countryDAO.add(new Country("Norway", "NO"));
                countryDAO.add(new Country("Oman", "OM"));
                countryDAO.add(new Country("Pakistan", "PK"));
                countryDAO.add(new Country("Palau", "PW"));
                countryDAO.add(new Country("PalestinianTerritory", "PS"));
                countryDAO.add(new Country("Panama", "PA"));
                countryDAO.add(new Country("PapuaNewGuinea", "PG"));
                countryDAO.add(new Country("Paraguay", "PY"));
                countryDAO.add(new Country("Peru", "PE"));
                countryDAO.add(new Country("Philippines", "PH"));
                countryDAO.add(new Country("Pitcairn", "PN"));
                countryDAO.add(new Country("Poland", "PL"));
                countryDAO.add(new Country("Portugal", "PT"));
                countryDAO.add(new Country("PuertoRico", "PR"));
                countryDAO.add(new Country("Qatar", "QA"));
                countryDAO.add(new Country("Réunion", "RE"));
                countryDAO.add(new Country("Romania", "RO"));
                countryDAO.add(new Country("RussianFederation", "RU"));
                countryDAO.add(new Country("Rwanda", "RW"));
                countryDAO.add(new Country("Saint-Barthélemy", "BL"));
                countryDAO.add(new Country("SaintHelena", "SH"));
                countryDAO.add(new Country("SaintKittsandNevis", "KN"));
                countryDAO.add(new Country("SaintLucia", "LC"));
                countryDAO.add(new Country("Saint-Martin(Frenchpart)", "MF"));
                countryDAO.add(new Country("SaintPierreandMiquelon", "PM"));
                countryDAO.add(new Country("SaintVincentandGrenadines", "VC"));
                countryDAO.add(new Country("Samoa", "WS"));
                countryDAO.add(new Country("SanMarino", "SM"));
                countryDAO.add(new Country("SaoTomeandPrincipe", "ST"));
                countryDAO.add(new Country("SaudiArabia", "SA"));
                countryDAO.add(new Country("Senegal", "SN"));
                countryDAO.add(new Country("Serbia", "RS"));
                countryDAO.add(new Country("Seychelles", "SC"));
                countryDAO.add(new Country("SierraLeone", "SL"));
                countryDAO.add(new Country("Singapore", "SG"));
                countryDAO.add(new Country("Slovakia", "SK"));
                countryDAO.add(new Country("Slovenia", "SI"));
                countryDAO.add(new Country("SolomonIslands", "SB"));
                countryDAO.add(new Country("Somalia", "SO"));
                countryDAO.add(new Country("SouthAfrica", "ZA"));
                countryDAO.add(new Country("SouthGeorgiaandtheSouthSandwichIslands", "GS"));
                countryDAO.add(new Country("SouthSudan", "SS"));
                countryDAO.add(new Country("Spain", "ES"));
                countryDAO.add(new Country("SriLanka", "LK"));
                countryDAO.add(new Country("Sudan", "SD"));
                countryDAO.add(new Country("Suriname", "SR"));
                countryDAO.add(new Country("SvalbardandJanMayenIslands", "SJ"));
                countryDAO.add(new Country("Swaziland", "SZ"));
                countryDAO.add(new Country("Sweden", "SE"));
                countryDAO.add(new Country("Switzerland", "CH"));
                countryDAO.add(new Country("SyrianArabRepublic (Syria)", "SY"));
                countryDAO.add(new Country("Taiwan,RepublicofChina", "TW"));
                countryDAO.add(new Country("Tajikistan", "TJ"));
                countryDAO.add(new Country("Tanzania,UnitedRepublicof", "TZ"));
                countryDAO.add(new Country("Thailand", "TH"));
                countryDAO.add(new Country("Timor-Leste", "TL"));
                countryDAO.add(new Country("Togo", "TG"));
                countryDAO.add(new Country("Tokelau", "TK"));
                countryDAO.add(new Country("Tonga", "TO"));
                countryDAO.add(new Country("TrinidadandTobago", "TT"));
                countryDAO.add(new Country("Tunisia", "TN"));
                countryDAO.add(new Country("Turkey", "TR"));
                countryDAO.add(new Country("Turkmenistan", "TM"));
                countryDAO.add(new Country("TurksandCaicosIslands", "TC"));
                countryDAO.add(new Country("Tuvalu", "TV"));
                countryDAO.add(new Country("Uganda", "UG"));
                countryDAO.add(new Country("Ukraine", "UA"));
                countryDAO.add(new Country("UnitedArabEmirates", "AE"));
                countryDAO.add(new Country("UnitedKingdom", "GB"));
                countryDAO.add(new Country("UnitedStatesofAmerica", "US"));
                countryDAO.add(new Country("USMinorOutlyingIslands", "UM"));
                countryDAO.add(new Country("Uruguay", "UY"));
                countryDAO.add(new Country("Uzbekistan", "UZ"));
                countryDAO.add(new Country("Vanuatu", "VU"));
                countryDAO.add(new Country("Venezuela (BolivarianRepublic)", "VE"));
                countryDAO.add(new Country("VietNam", "VN"));
                countryDAO.add(new Country("VirginIslands,US", "VI"));
                countryDAO.add(new Country("WallisandFutunaIslands", "WF"));
                countryDAO.add(new Country("WesternSahara", "EH"));
                countryDAO.add(new Country("Yemen", "YE"));
                countryDAO.add(new Country("Zambia", "ZM"));
                countryDAO.add(new Country("Zimbabwe", "ZW"));
            } catch (Exception ex) {
                Logger.getLogger(CountryService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
