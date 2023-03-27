var domain = "http://127.0.0.1/verifixs-backend";
if (location.href.includes(".com")) {
  if (location.protocol != "https:") {
    location.protocol = "https:";
  }

  if (location.href.includes("verifixs.com")) {
    domain = "https://back-system.verifixs.com"; /** live server */
  }
}
domain = "https://back-system.verifixs.com";

const states = {
  baseURL: domain,
  diligences: [],
  diligenceDetails: {},
  client: {},
  actifs: [],
  diligenceTypes: [],
  provinces: [
    { id: 1, title: "Kinshasa", villes: ["Kinshasa"] },
    {
      id: 2,
      title: "Kongo-central",
      villes: ["Matadi", "Boma", "Mbanza-Ngungu"],
    },
    { id: 3, title: "Maï-Ndombe", villes: ["Inongo"] },
    { id: 4, title: "Equateur", villes: ["Mbandaka"] },
    { id: 5, title: "Sud-Ubangi", villes: ["Gemena", "Zongo"] },
    { id: 6, title: "Nord-Ubangi", villes: ["Gbadolite"] },
    { id: 7, title: "Mongala", villes: ["Lisala", "Bumba"] },
    { id: 8, title: "Bas-Uele", villes: ["Buta"] },
    { id: 9, title: "Haut-Uele", villes: ["Isiro"] },
    { id: 10, title: "Ituri", villes: ["Bunia"] },
    { id: 11, title: "Kwilu", villes: ["Bandundu", "Kikwit"] },
    { id: 12, title: "Kwango", villes: ["Kenge"] },
    { id: 13, title: "Tshuapa", villes: ["Boende"] },
    { id: 14, title: "Tshopo", villes: ["Kisangani"] },
    { id: 15, title: "Sankuru", villes: ["Lusambo"] },
    { id: 16, title: "Kasaï", villes: ["Tshikapa"] },
    { id: 17, title: "Kasaï Oriental", villes: ["Mbuji-Mayi"] },
    { id: 18, title: "Kasaï Central", villes: ["Kananga"] },
    {
      id: 19,
      title: "Lomami",
      villes: ["Kabinda", "Mwene-Ditu", "Gandajika"],
    },
    { id: 20, title: "Nord Kivu", villes: ["Goma", "Butembo", "Beni"] },
    { id: 21, title: "Sud Kivu", villes: ["Bukavu", "Uvira", "Baraka"] },
    { id: 22, title: "Maniema", villes: ["Kindu"] },
    { id: 23, title: "Tanganyika", villes: ["Kalemie"] },
    {
      id: 24,
      title: "Haut-Katanga",
      villes: ["Lubumbashi", "Likasi", "Kipushi"],
    },
    { id: 25, title: "Lualaba", villes: ["Kolwezi"] },
    { id: 26, title: "Haut-Lomami", villes: ["Kamina"] },
  ],
};

export default states;
