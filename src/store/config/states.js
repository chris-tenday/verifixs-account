var domain = "http://127.0.0.1/verifixs-backend-new";
if (location.href.includes(".com"))
{
  if (location.protocol != "https:")
  {
    location.protocol = "https:";
  }


  if (location.href.includes("verifixs.com"))
  {
    domain = "https://back-system.verifixs.com"; /** live server */
  }
}


const states = {
  baseURL: domain,
  diligences: [],
  diligenceDetails: {},
  client: {},
  actifs: [],
  diligenceTypes: [],
  provinces: [
    { id: 1, title: "Kinshasa", villes: ["Kinshasa"] },
    { id: 2, title: "Kongo-central", villes: ["Matadi", "Boma", "Mbanza-Ngungu","Kasangulu","Kimvula","Lukula","Luozi","Madimba","Mbanza-Ngungu","Moanda","Seke-Banza","Songololo","Tshela"],},
    { id: 3, title: "Maï-Ndombe", villes: ["Inongo", "Bolobo", "Kiri","Kutu","Kwamouth","Mushie","Oshwe","Yumbi"] },
    { id: 4, title: "Equateur", villes: ["Mbandaka","Basankusu","Bikoro","Bolomba","Bomongo","Ingende","Lukolela","Mankanza"] },
    { id: 5, title: "Sud-Ubangi", villes: ["Gemena", "Zongo", "Budjala","Kungu","Libenge"] },
    { id: 6, title: "Nord-Ubangi", villes: ["Gbadolite", "Bosobolo","Businga","Mobayi-Mbongo","Yakoma"] },
    { id: 7, title: "Mongala", villes: ["Lisala", "Bumba","Bongandanga"] },
    { id: 8, title: "Bas-Uele", villes: ["Buta", 	'Aketi','Ango','Bambesa','Bondo','Poko' ] },
    { id: 9, title: "Haut-Uele", villes: ["Isiro","Dungu", "Faradje","Niangara","Rungu","Wamba","Watsa"] },
    { id: 10, title: "Ituri", villes: ["Bunia","Aru","Djugu","Irumu","Mahagi","Mambasa"] },
    { id: 11, title: "Kwilu", villes: ["Bandundu", "Kikwit", "Bagata","Bulungu","Gungu","Idiofa","Masi-Manimba"] },
    { id: 12, title: "Kwango", villes: ["Kenge","Feshi","Kahemba","Kasongo-Lunda","Kenge","Popokabaka"] },
    { id: 13, title: "Tshuapa", villes: ["Boende", "Befale","Bokungu","Djolu","Ikela","Monkoto"] },
    { id: 14, title: "Tshopo", villes: ["Kisangani", "Bafwasende","Banalia","Basoko","Isangi","Opala","Ubundu","Yahuma"] },
    { id: 15, title: "Sankuru", villes: ["Lusambo", "Kole","Lodja","Lomela","Lubefu"] },
    { id: 16, title: "Kasaï", villes: ["Tshikapa","Luebo","Kamonia","Ilebo","Mweka","Dekese"] },
    { id: 17, title: "Kasaï Oriental", villes: ["Mbuji-Mayi","Kabeya-Kamwanga","Katanda","Lupatapata","Miabi","Tshilenge"] },
    { id: 18, title: "Kasaï Central", villes: ["Kananga","Dibaya","Luiza","Kazumba","Demba","Dimbelenge"] },
    { id: 19, title: "Lomami",villes: ["Kabinda", "Mwene-Ditu", "Ngandajika","Kamiji","Lubao","Luilu",],},
    { id: 20, title: "Nord Kivu", villes: ["Goma", "Butembo", "Beni","Lubero","Masisi",	"Rutshuru","Walikale","Nyiragongo"] },
    { id: 21, title: "Sud Kivu", villes: ["Bukavu", "Uvira", "Baraka", "Fizi","Idjwi","Kabare","Kalehe","Mwenga","Shabunda","Walungu"] },
    { id: 22, title: "Maniema", villes: ["Kindu","Kabambare","Kailo","Kasongo","Kibombo","Lubutu","Pangi","Punia"] },
    { id: 23, title: "Tanganyika", villes: ["Kalemie","Kabalo","Kongolo","Manono","Moba","Nyunzu"] },
    { id: 24, title: "Haut-Katanga", villes: ["Lubumbashi", "Likasi", "Kipushi","Kambove","Kasenga","Kipushi","Mitwaba","Pweto","Sakania"],},
    { id: 25, title: "Lualaba", villes: ["Kolwezi","Dilolo","Kapanga","Mutshatsha","Sandoa","Lubudi"] },
    { id: 26, title: "Haut-Lomami", villes: ["Kamina","Bukama","Kabongo","Kamina","Kaniama","Malemba-Nkulu"] },
  ],
};

export default states;
